//
//  BMFlowerViewController.m
//  MiniPay
//
//  Created by apple on 14-7-26.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "BMFlowerViewController.h"
#import "GDataXMLNode.h"
#import "BMFlowModel.h"
#import "BMFlowCell.h"
@interface BMFlowerViewController ()
{
    NSString*jyma;
}

@end

@implementation BMFlowerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switch (_bm_Type) {
        case 0:
            [self setpageTitle:@"转账记录"];
            jyma=FLOW_CMD_199040;
            //[_coentLable3 setText:[NSString stringWithFormat:@"转账%@",TXNSTS]];
            break;
        case 1:
             [self setpageTitle:@"还款记录"];
             jyma=FLOW_CMD_199040;
            //[_coentLable3 setText:[NSString stringWithFormat:@"还款%@",TXNSTS]];
            break;
        case 2:
             [self setpageTitle:@"充值记录"];
             jyma=FLOW_CMD_199040;
            //[_coentLable3 setText:[NSString stringWithFormat:@"充值%@",TXNSTS]];
            break;
        case 3:
            [self setpageTitle:@"提现记录"];
             jyma=FLOW_CMD_199041;
            //[_coentLable3 setText:[NSString stringWithFormat:@"充值%@",TXNSTS]];
            break;
            
        default:
            break;
    }

    
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    _array=arr;
    [self.tableView setHidden:TRUE];
     [self refreshData:nil];
    // Do any additional setup after loading the view from its nib.
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
        for(BMFlowModel  *model in _array)
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

//-(void)viewWillAppear:(BOOL)animated{
//    
//    [self refreshData:nil];
//}


//刷新数据
-(IBAction)refreshData:(id)sender{
    
    [self showWaiting:@"请稍后…"];
    [self getFlowList];
    
}

-(void)getFlowList
{

    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
   
    [array addObject:@"TRANCODE"];
  
    [array addObject:jyma];
    [array addObject:@"PHONENUMBER"];
    [array addObject:phonerNumber];
    if(_bm_Type!=3)
    {
      switch (_bm_Type) {
         case 0:
            [array addObject:@"TXNTYP"];
            [array addObject:@"T"];
            break;
        case 1:
            [array addObject:@"TXNTYP"];
            [array addObject:@"C"];
            break;
        case 2:
            [array addObject:@"TXNTYP"];
            [array addObject:@"P"];
            break;
            
        default:
            break;
      }
    }
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:jyma
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
     [_array removeAllObjects];
    NSArray *trandetail = [trandetailsElement elementsForName:@"TRANDETAIL"];
  //  [_array removeAllObjects];
    
    double rmb=0.0;
    
    for (GDataXMLElement *user in trandetail) {
        
        BMFlowModel *model=[[BMFlowModel alloc] init];
        if(_bm_Type==3)
        {
          GDataXMLElement *sYSDATElement1 = [[user elementsForName:@"CREATEDATETIME"] objectAtIndex:0];
              [model setSYSDAT:[sYSDATElement1 stringValue]];
           
            GDataXMLElement *cRDNOElement = [[user elementsForName:@"FEEAMT"] objectAtIndex:0];
            [model setCRDNO:[@"0"isEqualToString:[cRDNOElement stringValue]]?@"普通提现":@"快速提现"];
            
            GDataXMLElement *tXNAMTElement = [[user elementsForName:@"PAYAMT"] objectAtIndex:0];
            [model setTXNAMT:[tXNAMTElement stringValue]];
            
            GDataXMLElement *tXNCDElement = [[user elementsForName:@"FEEAMT"] objectAtIndex:0];
            [model setTXNSTS:[tXNCDElement stringValue]];

            

        }
        
        else{
            GDataXMLElement *sYSDATElement = [[user elementsForName:@"SYSDAT"] objectAtIndex:0];
            
            [model setSYSDAT:[sYSDATElement stringValue]];
            
            
            
            GDataXMLElement *tXNCDElement = [[user elementsForName:@"TXNSTS"] objectAtIndex:0];
            [model setTXNSTS:[tXNCDElement stringValue]];
            
            GDataXMLElement *tXNAMTElement = [[user elementsForName:@"ACTUALAMT"] objectAtIndex:0];
            [model setTXNAMT:[tXNAMTElement stringValue]];
            
            GDataXMLElement *cRDNOElement = [[user elementsForName:@"CRDNO"] objectAtIndex:0];
            [model setCRDNO:[cRDNOElement stringValue]];
        
        }
        
       
        
       
        [_array addObject:model];
    }
     reversedArray = _array;
    //reversedArray = [[_array reverseObjectEnumerator] allObjects];
//    NSString *money=[NSString stringWithFormat:@"%.2f",rmb/100];
//    NSArray *sMoney=[money componentsSeparatedByString:@"."];
//    [_fMoneyTextView setText:[NSString stringWithFormat:@"￥%@",[sMoney objectAtIndex:0]]];
//    [_bMoneyTextView setText:[NSString stringWithFormat:@".%@",[sMoney objectAtIndex:1]]];
//    [_totalNumTextView setText:[NSString stringWithFormat:@"%d",[_array count]]];
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
    
    static NSString * CellIdentifier = @"BMFlowCell";
    
    UITableViewCell *cell = (UITableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil)
    {
        NSArray *views=[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:nil options:nil];
        cell=[views objectAtIndex:0];
       // [(BMFlowCell *)cell setShow];
    }
    
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    BMFlowModel *model=[reversedArray objectAtIndex:indexPath.row];
   // ((BMFlowCell *)cell).delegate=self;
    [(BMFlowCell *)cell setData:model index:indexPath.row flowType:_bm_Type];
    
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
