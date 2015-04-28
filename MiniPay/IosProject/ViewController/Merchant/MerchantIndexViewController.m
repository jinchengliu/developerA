//
//  MerchantIndexViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//商户首页
#import "MerchantIndexViewController.h"
#import "ClearingListViewController.h"
#import "LimitViewController.h"
#import "NoticeCenterViewController.h"
#import "NormalQuestionViewController.h"
#import "MoreSettingViewController.h"
#import "ValueUtils.h"
#import "AESUtil.h"
#import "GDataXMLNode.h"
#import "Response_199009_Model.h"
#import "AboutView.h"
#import "MyaccountViewController.h"
#import "SmrzfristViewController.h"
#import "CreditCardPaymentsViewController.h"
@interface MerchantIndexViewController ()
{
     NSString *number;
   // MxMovingPlaceholderTextField *textField;
}

@end

@implementation MerchantIndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializations
        [self setpageTitle:@"商户"];
       // self.title=@"商户";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self.tableView setHidden:TRUE];
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    _array=arr;
    isLoadDate=FALSE;
    
    self.mainView.frame= CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, self.mainView.frame.size.width, 0);
    self.shouldDragRefresh=YES;
    [self showWaiting:nil];
   //  textField = [[MxMovingPlaceholderTextField alloc] initWithFrame:CGRectMake(74.0f, 26.0f, 124.0f, 26.0f)];
   // [self.view addSubview:textField];
    //获取商户信息
    [self getMerchantInfo];
     [self setstatus:[_dataManager.ShanghuStus intValue]];
  
    
}


-(void)setstatus:(int)stus
{
    
    switch (stus) {
        case 0:
            _statuslable.text=@"恭喜您已经是实名认证商户！终端已开通";
            break;
        case 1:
            _statuslable.text=@"抱歉当前商户已关闭！";
            break;
            
        case 2:
            _statuslable.text=@"恭喜您已经是实名认证商户！";
            break;
        case 3:
            
            _statuslable.text=@"实名认证被驳回，请您重新提交资料";
            break;
        case 4:
            _statuslable.text=@"终端被冻结，请联系客服！";
            break;
        case 5:
            _statuslable.text=@"实名认证正在审核，请稍候再试";
            break;
        case 6:
            _statuslable.text=@"您尚未进行认证，请尽快提交实名资料";
            break;
            
        case 7:
            _statuslable.text=@"您尚未进行认证，请尽快提交实名资料";
            break;
            
            
        default:
            break;
    }
    
    
}


-(void)startAnimationIfNeeded{
    //取消、停止所有的动画
    [self.merchantNameLabel.layer removeAllAnimations];
    CGSize textSize = [self.merchantNameLabel.text sizeWithFont:self.merchantNameLabel.font];
    CGRect lframe = self.merchantNameLabel.frame;
    lframe.size.width = textSize.width;
    
    const float oriWidth = 94;
    if (textSize.width > oriWidth) {
        float offset = textSize.width - oriWidth;
        [UIView animateWithDuration:3.0
                              delay:0
                            options:UIViewAnimationOptionRepeat //动画重复的主开关
         |UIViewAnimationOptionAutoreverse //动画重复自动反向，需要和上面这个一起用
         |UIViewAnimationOptionTransitionFlipFromLeft //动画的时间曲线，滚动字幕线性比较合理
                         animations:^{
                             self.merchantNameLabel.transform = CGAffineTransformMakeTranslation(-offset, 0);
                             self.merchantNameLabel.frame = lframe;
                         }
                         completion:^(BOOL finished) {
                             
                         }
         ];
    }
}



-(IBAction)refreshData:(id)sender{
    
    [self showWaiting:nil];
    //获取商户信息
    [self getMerchantInfo];
    
}


//获取商户信息
-(void)getMerchantInfo
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    NSString *phonerNumber=[_dataManager GetObjectWithNSUserDefaults:PHONENUMBER];
    [array addObject:@"TRANCODE"];
    [array addObject:MERCHANT_INFO_CMD_199011];
    [array addObject:@"PHONENUMBER"];
    [array addObject:phonerNumber];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:[ValueUtils md5UpStr:[CommonUtil createXml:array]]];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:MERCHANT_INFO_CMD_199011
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
    
    GDataXMLElement *mernamElement = [[rootElement elementsForName:@"MERNAM"] objectAtIndex:0];
    GDataXMLElement *carNoElement = [[rootElement elementsForName:@"ACTNO"] objectAtIndex:0];
    GDataXMLElement *accountElement = [[rootElement elementsForName:@"ACTNAM"] objectAtIndex:0];
    GDataXMLElement *backElement = [[rootElement elementsForName:@"OPNBNK"] objectAtIndex:0];
    GDataXMLElement *STATUS = [[rootElement elementsForName:@"STATUS"] objectAtIndex:0];
    status=[STATUS stringValue];
    
    _mxMovingPlaceholderTextField.placeholder =[mernamElement stringValue];
    //_mxMovingPlaceholderTextField.text=@"ssssssffffffffffssssffffffssssssssssssssddfffff";
    //[_merchantNameLabel setText:@"ssssssffffffffffssssffffffssssssssssssssddfffff"];
    [_merchantNameLabel setText:[mernamElement stringValue]];
    [_carNoLabel setText:[carNoElement stringValue]];
    [_accountLabel setText:[accountElement stringValue]];
    [_accountLabel1 setText:[accountElement stringValue]];

    [_bankLabel setText:[backElement stringValue]];
    [self.tableView setHidden:FALSE];
    [self.tableView reloadData];
    [self refreshComplete];
    [_mxMovingPlaceholderTextField startMoving];
     _dataManager.ShanghuStus=[STATUS stringValue];
     [self setstatus:[status intValue]];
   // [self startAnimationIfNeeded];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if([DataManager sharedDataManager].postype_Vison!=hf)
    return 5;
    else
    return 6; 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if([DataManager sharedDataManager].postype_Vison==hf)
     {
         if(indexPath.row==0||indexPath.row==4)
             return 60.0;
     }
    else
    {
    if(indexPath.row==0||indexPath.row==4)
        return 75.0;
    }
    if(indexPath.row==1)
    {
    
        return 84.0;
    }
//    else if(indexPath.row==2||indexPath.row==3)
//    {
//        return 58.0f;
//    }
    else
        return 60.0;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    
        
        if(indexPath.row==0){
            _smrzCell.backgroundView=middleBgView6;
            _smrzCell.selectedBackgroundView=botomBgSelView;
            if([status isEqualToString:@"6"]||[status isEqualToString:@"3"])
            {
                
                UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(177, 23, 45, 21)];
                lable.text=@"[请认证]";
                lable.font= [UIFont systemFontOfSize:10];
                lable.textColor=[UIColor redColor];
                [_smrzCell addSubview:lable];
                
            }
            return _smrzCell;

            
         }else if(indexPath.row==1){
            
             return _myaccountCell;
           
        }
//         else if(indexPath.row==2){
//             
//             
//             return _fifthCell;
//
//         }
         else if(indexPath.row==2){
            
            return _servenCell;

        }
      if([DataManager sharedDataManager].postype_Vison==hf)
      {
          if(indexPath.row==3){
              return _skCell;

              
          }
          else if(indexPath.row==4){
              return _sixthCell;
              
          }else if(indexPath.row==5){
              return _nineCell;
          }
          
          
       }
    else
    {
         if(indexPath.row==3){
            return _sixthCell;
            
        }else if(indexPath.row==4){
            return _nineCell;
        }
    
    }
    
    
//        }else if(indexPath.row==6){
//            _nineCell.backgroundView=botomBgView;
//            _nineCell.selectedBackgroundView=botomBgSelView;
//            return _nineCell;
//            
//        }
        return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if(indexPath.row==1){  //我的账户
        MyaccountViewController *myac=[[MyaccountViewController alloc] init];
        myac.hidesBottomBarWhenPushed=YES;
        myac.cardno=_carNoLabel.text;
        myac.name=_accountLabel.text;
        myac.bankname=_bankLabel.text;
        myac.merchantNameLabel=_merchantNameLabel.text;
        [self.navigationController pushViewController:myac animated:YES];
    }
    else  if(indexPath.row==0){  //实名认证
//       // status=@"6";
//        if([status isEqualToString:@"0"])
//        {
//         [self showAlert:@"您的账户已开通，无需再实名认证"];
//        }
//        else if([status isEqualToString:@"1"])
//        {
//         [self showAlert:@"您的账户已关闭，不能再实名认证"];
//        }
//        else if([status isEqualToString:@"2"])
//        {
//         [self showAlert:@"审核已通过，无需再实名认证"];
//        }
////        else if([status isEqualToString:@"3"])
////        {
////            [self showAlert:@"审核未通过，不能再实名认证"];
////        }
//        else if([status isEqualToString:@"5"])
//        {
//            [self showAlert:@"正在审核中，不能再实名认证"];
//        }
//        
//        else if([status isEqualToString:@"6"]||[status isEqualToString:@"3"])
//        {
//            SmrzfristViewController *smrzfristViewController=[[SmrzfristViewController alloc] init];
//             smrzfristViewController.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:smrzfristViewController animated:YES];
//        }
        
        
        [self showWaiting:nil];
        //获取商户信息
        [self getMerInfo];
    }
//      else  if(indexPath.row==2){  //临时调额
//            LimitViewController *limit=[[LimitViewController alloc] init];
//           limit.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:limit animated:YES];
//        }

    
        else if(indexPath.row==2){  //常见问题
            
            NormalQuestionViewController *question=[[NormalQuestionViewController alloc] init];
              question.url_type=cjwt;
            [self.navigationController pushViewController:question animated:YES];
            
        }
    
    if([DataManager sharedDataManager].postype_Vison==hf)
    {
        if(indexPath.row==3){
            CreditCardPaymentsViewController *skCreditCardPaymentsViewController=[[CreditCardPaymentsViewController alloc]initWithNibName:@"ShouKuanCreditCardPaymentsViewController" bundle:nil];
            skCreditCardPaymentsViewController.hidesBottomBarWhenPushed=YES;
            skCreditCardPaymentsViewController.type=NO;
            [self.navigationController pushViewController:skCreditCardPaymentsViewController animated:YES];

        }
    
       else if(indexPath.row==4){  //通知中心
            
            NoticeCenterViewController *notice=[[NoticeCenterViewController alloc] init];
            notice.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:notice animated:YES];
        }
        
            else if(indexPath.row==5){  //更多设置
                MoreSettingViewController *moreSetting=[[MoreSettingViewController alloc] init];
                moreSetting.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:moreSetting animated:YES];
            }
    }
    else
    {
    
        if(indexPath.row==3){  //通知中心
            
            NoticeCenterViewController *notice=[[NoticeCenterViewController alloc] init];
            notice.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:notice animated:YES];
        }
        
        else if(indexPath.row==4){  //更多设置
            MoreSettingViewController *moreSetting=[[MoreSettingViewController alloc] init];
            moreSetting.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:moreSetting animated:YES];
        }
    
    }
//        else if(indexPath.row==7){  //联系客服
//           
//            if([DataManager sharedDataManager].postype_Vison!=wfb)
//            {
//                NSString *str=[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenutellphone];
//                
//                NSMutableString *phonenumber= [[NSMutableString alloc]initWithString:str];
//                NSRange range = NSMakeRange(0, [phonenumber length]);
//                [phonenumber replaceOccurrencesOfString:@"-" withString:@"" options:NSCaseInsensitiveSearch range:range];
//              number=phonenumber;
//            }
//            else
//                number=SERVICE_PHONE;
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"联系客服" message:[NSString stringWithFormat:@"确定拨打%@",number] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
//            }
        
 }

-(void)viewWillAppear:(BOOL)animated{

//   [self refreshData:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex!=alertView.cancelButtonIndex){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]];
    }
}



//获取商户信息
-(void)getMerInfo
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    NSString *phonerNumber=[_dataManager GetObjectWithNSUserDefaults:PHONENUMBER];
    [array addObject:@"TRANCODE"];
    [array addObject:MERCHANT_INFO_CMD_P77023];
    [array addObject:@"PHONENUMBER"];
    [array addObject:phonerNumber];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:[ValueUtils md5UpStr:[CommonUtil createXml:array]]];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:MERCHANT_INFO_CMD_P77023
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                // if (result)
                                 {
                                     
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     GDataXMLElement *MERCNAM = [[rootElement elementsForName:@"MERCNAM"] objectAtIndex:0];
                                     GDataXMLElement *ADDRESS = [[rootElement elementsForName:@"ADDRESS"] objectAtIndex:0];
                                     GDataXMLElement *POSADDRESS = [[rootElement elementsForName:@"POSADDRESS"] objectAtIndex:0];
                                     GDataXMLElement *ACTNAM = [[rootElement elementsForName:@"ACTNAM"] objectAtIndex:0];
                                     GDataXMLElement *OPNBNK = [[rootElement elementsForName:@"OPNBNK"] objectAtIndex:0];
                                     GDataXMLElement *OPNBNKNAM = [[rootElement elementsForName:@"OPNBNKNAM"] objectAtIndex:0];
                                     GDataXMLElement *BUSNAM = [[rootElement elementsForName:@"BUSNAM"] objectAtIndex:0];
                                     GDataXMLElement *AREA = [[rootElement elementsForName:@"AREA"] objectAtIndex:0];
                                     GDataXMLElement *PROCOD = [[rootElement elementsForName:@"PROCOD"] objectAtIndex:0];
                                     GDataXMLElement *TERMNO = [[rootElement elementsForName:@"TERMNO"] objectAtIndex:0];
                                     GDataXMLElement *BANKAREA = [[rootElement elementsForName:@"BANKAREA"] objectAtIndex:0];
                                     GDataXMLElement *CORPORATEIDENTITY = [[rootElement elementsForName:@"CORPORATEIDENTITY"] objectAtIndex:0];
                                     GDataXMLElement *SCOBUS = [[rootElement elementsForName:@"SCOBUS"] objectAtIndex:0];
                                     GDataXMLElement *BIGBANKCOD = [[rootElement elementsForName:@"BIGBANKCOD"] objectAtIndex:0];
                                     GDataXMLElement *BIGBANKNAM = [[rootElement elementsForName:@"BIGBANKNAM"] objectAtIndex:0];
                                     GDataXMLElement *ACTNO = [[rootElement elementsForName:@"ACTNO"] objectAtIndex:0];
                                     GDataXMLElement *PRONAM = [[rootElement elementsForName:@"PRONAM"] objectAtIndex:0];
                                     GDataXMLElement *AREANAM = [[rootElement elementsForName:@"AREANAM"] objectAtIndex:0];
                                     GDataXMLElement *BANKNO = [[rootElement elementsForName:@"BANKNO"] objectAtIndex:0];
                                     
                                       GDataXMLElement *SHOWBANKNAME = [[rootElement elementsForName:@"SHOWBANKNAME"] objectAtIndex:0];
                                     GDataXMLElement *STATUS = [[rootElement elementsForName:@"STATUS"] objectAtIndex:0];
                                     
                                     
                                     status=[STATUS stringValue];
                                     SmrzfristViewController *smrzfristViewController=[[SmrzfristViewController alloc] init];
                                     if([status isEqualToString:@"6"]||[status isEqualToString:@"3"]||[status isEqualToString:@"7"])
                                     {
                                         smrzfristViewController.Is_Edit=false;
                                     }
                                     
                                     else
                                     {
                                         smrzfristViewController.Is_Edit=true;
                                     }
                                     
                                     
                                     smrzfristViewController.name=[BUSNAM stringValue];
                                     smrzfristViewController.id_cid=[CORPORATEIDENTITY stringValue];
                                     smrzfristViewController.mer_name=[MERCNAM stringValue];
                                     smrzfristViewController.jyfw=[SCOBUS stringValue];
                                     smrzfristViewController.address=[ADDRESS stringValue];
                                     smrzfristViewController.TermNO=[TERMNO stringValue];
                                     smrzfristViewController.kaihu_name=[ACTNAM stringValue];
                                     smrzfristViewController.kaihu_address_p=[PRONAM stringValue];
                                     smrzfristViewController.kaihu_address_s=[AREANAM stringValue];
                                     smrzfristViewController.bank_name=[BIGBANKNAM stringValue];
                                     smrzfristViewController.bank_code=[BIGBANKCOD stringValue];
                                     smrzfristViewController.bank_address=[OPNBNKNAM stringValue];
                                     smrzfristViewController.card_NO=[ACTNO stringValue];
                                     smrzfristViewController.bank_NO=[BANKNO stringValue];
                                     
                                     smrzfristViewController.kaihu_addresscode=[BANKAREA stringValue];
                                       smrzfristViewController.bank_showname=[SHOWBANKNAME stringValue];
                                      smrzfristViewController.hidesBottomBarWhenPushed=YES;
                                     [self.navigationController pushViewController:smrzfristViewController animated:YES];
                                 }
                             }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
