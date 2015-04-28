//
//  FlowViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//流水页面
#import "FlowViewController.h"
#import "FlowCell.h"
#import "GDataXMLNode.h"
#import "FlowdetailViewController.h"


@interface FlowViewController ()

@end

@implementation FlowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         [self setpageTitle:@"流水"];
       // self.title=@"流水";
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    _array=arr;
    [self.tableView setHidden:TRUE];
    //[self refreshData:nil];

//    switch ([DataManager sharedDataManager].postype_Vison) {
//        
//            
//        case cyh:
//            [_totalNumTextView setTextColor:cyhbj];
//            [_fMoneyTextView setTextColor:cyhbj];
//            [_bMoneyTextView setTextColor:cyhbj];
//          
//            
//            break;
//            
//        case xft:
//            [_totalNumTextView setTextColor:xftbj];
//            [_fMoneyTextView setTextColor:xftbj];
//            [_bMoneyTextView setTextColor:xftbj];
//            
//            break;
//            
//        case hf:
//            [_totalNumTextView setTextColor:hfbj];
//            [_fMoneyTextView setTextColor:hfbj];
//            [_bMoneyTextView setTextColor:hfbj];
//            
//            break;
//            
//            
//        default:
//            break;
//    }
    
    
}

-(void)cellDidBtn:(int)indexRow type:(int)type{
    
    currentModel=[reversedArray objectAtIndex:indexRow];
    tmpMoney=[NSString stringWithFormat:@"%d",[currentModel.TXNAMT intValue]];
    
    if(type==0){  //交易详情
        rowIndex=indexRow;
        
        FlowdetailViewController *flowdetailViewController=[[FlowdetailViewController alloc] init];
         flowdetailViewController.hidesBottomBarWhenPushed=YES;
        flowdetailViewController.logoNo=currentModel.LOGNO;
        
        [self.navigationController pushViewController:flowdetailViewController animated:YES];

        
    }else if(type==1){  //撤销交易
        rowIndex=indexRow;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定撤销该交易吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag=1;
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag==1){
        if(buttonIndex!=alertView.cancelButtonIndex){
            
            [self checkIsSign];
        }
    }else if(alertView.tag==2){
       
        //转向签名页面
        SignatureViewController *signature=[[SignatureViewController alloc] init];
        signature.logno=currentModel.LOGNO;
        signature.type=2;   //代表交易
        double mon=[tmpMoney doubleValue]/100;
        signature.money=[NSString stringWithFormat:@"%.2f",mon];

        signature.hidesBottomBarWhenPushed=YES;
        signature.delegate=self;
        [self.navigationController pushViewController:signature animated:YES];

        
    }
    
}

//撤销成功返回重新刷新
-(void)didFinishTrade:(BOOL)isSucess{
    
    [self refreshData:nil];
}


//Qpos刷卡
-(void)qPosSwipCard{
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    tradeMoney=currentModel.TXNAMT;
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",CANCEL_TRADE_CMD_199006,tradeMoney,tseqno,nowTime,nowDate,psamHex];
    
    DLog(@"Qpos mac加密前======%@",macMeta);
    [[ZftQiposLib getInstance] doTradeEx:tmpMoney andType:1 andRandom:nil andextraString:macMeta andTimesOut:60];
    
}

//Qpos刷卡
-(void)d180SwipCard{
    
    //[self showTrading];
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    tradeMoney=currentModel.TXNAMT;

    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",CANCEL_TRADE_CMD_199006,tradeMoney,tseqno,nowTime,nowDate,psamHex];
    op = [[MPosOperation alloc] initWithType:OPER_GET_MAC withName:@"getmac" withArgNum:1 withArgs:[[NSArray alloc] initWithObjects:macMeta, nil] withDelegate:mPosOperationDelegate];
      [opq addOperation:op];
    
}


//发送刷卡请求
-(void)finishSwipCard{
    
    [self showTrading];
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    tradeMoney=currentModel.TXNAMT;
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",CANCEL_TRADE_CMD_199006,tradeMoney,tseqno,nowTime,nowDate,psamHex];
    
    DLog(@"mac加密前======%@",macMeta);
    
    //获取mac
    [self getMac:macMeta];


    
}


//交易请求
-(void)finishGetMac{
    
    
    [self hideAllView];
    [self showTrading];
  

    
    _paramArray=[ValueUtils createParam:currentModel.LOGNO phonerNumber:phonerNumber termialNo:termialNo cardNoInfo:cardNoInfo pinInfo:pinInfo tseqno:tseqno tradeMoney:tradeMoney pasamNo:pasamNo trackInfo:trackInfo nowDate:nowDate nowTime:nowTime mac:macEncrypt];

    
    NSString *paramXml=[CommonUtil createXml:_paramArray];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [_paramArray addObject:@"PACKAGEMAC"];
    [_paramArray addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:_paramArray];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:CANCEL_TRADE_CMD_199006
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideAllView];
                                 if (result)
                                 {
                                     
                                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"撤销成功，请签名" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                                     alert.tag=2;
                                     [alert show];
                                    
                        
                                 }
                             }];
    
    
    
}

-(void)doResult:(vcom_Result *)vs Status:(int)_status{
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self refreshData:nil];
}


//刷新数据
-(IBAction)refreshData:(id)sender{
    
    [self showWaiting:@"请稍后…"];
    [self getFlowList];
    
}

-(IBAction)findfordate:(id)sender
{
    [self.tableView setHidden:TRUE];
     [_datetext resignFirstResponder];
    _array1=[[NSMutableArray alloc]init];
    if(IsNilString(_datetext.text))
    {
     reversedArray=[[_array reverseObjectEnumerator] allObjects];
    }
    else
    {
      for(Response_199008_Model  *model in _array)
      {
          NSString *date=[model.SYSDAT substringWithRange:NSMakeRange(4,4)];
          NSRange range = [date  rangeOfString:_datetext.text];//
        
          if (range.length >0)//包含
          {
            [_array1 addObject:model];

          }
       }
         reversedArray=[[_array1 reverseObjectEnumerator] allObjects];
    }
     [self.tableView setHidden:NO];
     [self.tableView reloadData];
}

//获取流水信息
-(void)getFlowList
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRANCODE"];
    [array addObject:FLOW_CMD_199008];
    [array addObject:@"PHONENUMBER"];
    [array addObject:phonerNumber];
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];

    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:FLOW_CMD_199008
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     [self parseXml:rootElement];
                                 
                                 }
    }];
    
}


//解析xml
-(void)parseXml:(GDataXMLElement *)rootElement{
    
    GDataXMLElement *trandetailsElement = [[rootElement elementsForName:@"TRANDETAILS"] objectAtIndex:0];
    
    NSArray *trandetail = [trandetailsElement elementsForName:@"TRANDETAIL"];
    [_array removeAllObjects];
    
    double rmb=0.0;
    
    for (GDataXMLElement *user in trandetail) {
        
            Response_199008_Model *model=[[Response_199008_Model alloc] init];
        
            GDataXMLElement *sYSDATElement = [[user elementsForName:@"SYSDAT"] objectAtIndex:0];
            [model setSYSDAT:[sYSDATElement stringValue]];
        
            GDataXMLElement *mERNAMElement = [[user elementsForName:@"MERNAM"] objectAtIndex:0];
            [model setMERNAM:[mERNAMElement stringValue]];
        
            GDataXMLElement *lOGDATElement = [[user elementsForName:@"LOGDAT"] objectAtIndex:0];
            [model setLOGDAT:[lOGDATElement stringValue]];
        
            GDataXMLElement *lOGNOElement = [[user elementsForName:@"LOGNO"] objectAtIndex:0];
            [model setLOGNO:[lOGNOElement stringValue]];
        
            GDataXMLElement *tOTTXNCNTElement = [[user elementsForName:@"TXNCD"] objectAtIndex:0];
            [model setTXNCD:[tOTTXNCNTElement stringValue]];
        
            GDataXMLElement *tXNCDElement = [[user elementsForName:@"TXNSTS"] objectAtIndex:0];
            [model setTXNSTS:[tXNCDElement stringValue]];
        
            GDataXMLElement *tXNAMTElement = [[user elementsForName:@"TXNAMT"] objectAtIndex:0];
            [model setTXNAMT:[tXNAMTElement stringValue]];
        
            GDataXMLElement *cRDNOElement = [[user elementsForName:@"CRDNO"] objectAtIndex:0];
            [model setCRDNO:[cRDNOElement stringValue]];
        
          if([model.TXNCD isEqualToString:@"0200000000"])
           {
               rmb+=[model.TXNAMT doubleValue];
           }
            [_array addObject:model];
    }
    reversedArray = [[_array reverseObjectEnumerator] allObjects];
    NSString *money=[NSString stringWithFormat:@"%.2f",rmb/100];
    NSArray *sMoney=[money componentsSeparatedByString:@"."];
    [_fMoneyTextView setText:[NSString stringWithFormat:@"￥%@",[sMoney objectAtIndex:0]]];
    [_bMoneyTextView setText:[NSString stringWithFormat:@".%@",[sMoney objectAtIndex:1]]];
    [_totalNumTextView setText:[NSString stringWithFormat:@"%d",[_array count]]];
    [self.tableView setHidden:FALSE];
    [self.tableView reloadData];
    self.shouldDragRefresh=YES;
    [self refreshComplete];
    
}

-(IBAction)hideKeyBoard:(id)sender{
    
     [_datetext resignFirstResponder];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [reversedArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 136.f;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    static NSString * CellIdentifier = @"FlowCell";
    
    UITableViewCell *cell = (UITableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil)
    {
        NSArray *views=[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:nil options:nil];
        cell=[views objectAtIndex:0];
        [(FlowCell *)cell setShow];
    }
    
    Response_199008_Model *model=[reversedArray objectAtIndex:indexPath.row];
    ((FlowCell *)cell).delegate=self;
    [(FlowCell *)cell setData:model index:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
         [_datetext resignFirstResponder];
        
        
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
