//
//  ToolIndexViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//工具首页
#import "ToolIndexViewController.h"
#import "SearchBlanceViewController.h"
#import "ConsultInfoViewController.h"
#import "WeiboViewController.h"
#import "VouchUsViewController.h"
#import "AESUtil.h"
#import "GDataXMLNode.h"
#import "CheckPosView.h"
#import "creditCardPaymentsViewController.h"
#import "MobilePhoneRechargeViewController.h"
#import "KakazhuanzhangViewController.h"
@interface ToolIndexViewController ()

@end

@implementation ToolIndexViewController
@synthesize array=_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setpageTitle:@"工具"];
        //self.title=@"工具";
    }
    return self;
}

-(IBAction)iconClick:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    switch (btn.tag) {
        case 1:{  //余额查询
            
            [self showAlert:@"此功能暂未开通！"];
            return;
            tmpMoney=@"";
            [self checkIsSign];
        }
        break;
        case 2:{
            ConsultInfoViewController *consult=[[ConsultInfoViewController alloc] init];
             consult.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:consult animated:YES];
        }
            break;
        case 3:{
            WeiboViewController *weibo=[[WeiboViewController alloc] init];
             weibo.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:weibo animated:YES];
        }
            break;
        case 4:
        {
//            CreditCardPaymentsViewController *creditCardPaymentsViewController=[[CreditCardPaymentsViewController alloc] init];
//            //creditCardPaymentsListViewController.ishavecreditCar=FALSE;
//            
//            creditCardPaymentsViewController.type=NO;
//            [self.navigationController pushViewController:creditCardPaymentsViewController animated:YES];
//            [self showAlert:@"此功能暂未开通！"];
//            return;
            KakazhuanzhangViewController *kakazhuanzhangViewController=[[KakazhuanzhangViewController alloc] init];
             kakazhuanzhangViewController.hidesBottomBarWhenPushed=YES;
            //creditCardPaymentsListViewController.ishavecreditCar=FALSE;
            
           
            [self.navigationController pushViewController:kakazhuanzhangViewController animated:YES];

        }
            break;
        case 5:
            [self showAlert:@"此功能暂未开通！"];
            
            
            break;
        case 6:
        {
            VouchUsViewController *vouchUsViewController=[[VouchUsViewController alloc] init];
            //creditCardPaymentsListViewController.ishavecreditCar=FALSE;
             vouchUsViewController.hidesBottomBarWhenPushed=YES;
           // creditCardPaymentsViewController.type=YES;
            [self.navigationController pushViewController:vouchUsViewController animated:YES];
        }
            
            
            break;
        case 7:
        {
           
//            [self showWaiting:@"请稍后…"];
//            [self sendhttp];
            CreditCardPaymentsViewController *creditCardPaymentsViewController=[[CreditCardPaymentsViewController alloc] init];
            //creditCardPaymentsListViewController.ishavecreditCar=FALSE;
         creditCardPaymentsViewController.hidesBottomBarWhenPushed=YES;
            creditCardPaymentsViewController.type=YES;
            [self.navigationController pushViewController:creditCardPaymentsViewController animated:YES];
           
        }
            break;
        case 8:
        {
            MobilePhoneRechargeViewController *mobilePhoneRechargeViewController=[[MobilePhoneRechargeViewController alloc] init];
             mobilePhoneRechargeViewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:mobilePhoneRechargeViewController animated:YES];
        }
            break;
        case 9:
            [self showAlert:@"此功能暂未开通！"];
        break;
            
        default:
            [self showAlert:@"此功能暂未开通！"];
           
            break;
    }
    
    
}

-(void)sendhttp
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRANCODE"];
    [array addObject:SIGNATURE_CMD_708012];
    
    [array addObject:@"SELLTEL_B"];
    [array addObject:phonerNumber];
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:SIGNATURE_CMD_708012
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
//                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
//                                     GDataXMLElement *pwdElement = [[rootElement elementsForName:@"RSPCOD"] objectAtIndex:0];
//                                     NSString*code=[pwdElement stringValue];
//                                     
//                                    
//                                     
//                                     if([code isEqualToString:@"000000"])
//                                     {
//                                      creditCardPaymentsListViewController.ishavecreditCar=true;
//                                     
//                                     }
//                                     else if([code isEqualToString:@"02000"])
//                                     {
//                                      creditCardPaymentsListViewController.ishavecreditCar=FALSE;
//                                     }
//                                     CreditCardPaymentsListViewController *creditCardPaymentsListViewController=[[CreditCardPaymentsListViewController alloc] init];
//                                     if(result!=NULL)
//                                     {
//                                         creditCardPaymentsListViewController.ishavecreditCar=true;
//
//                                     }
//                                     else
//                                     {
//                                         creditCardPaymentsListViewController.ishavecreditCar=FALSE;
//
//                                     }
//                                     [self.navigationController pushViewController:creditCardPaymentsListViewController animated:YES];
                                     
                                     
                                 }
                             }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}


//Qpos刷卡
-(void)qPosSwipCard{
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@",SEARCH_BLANCE_CMD_199007,tseqno,nowTime,nowDate,psamHex];
    
    
    DLog(@"Qpos mac加密前======%@",macMeta);
     [[ZftQiposLib getInstance] doTradeEx:tmpMoney andType:1 andRandom:nil andextraString:macMeta andTimesOut:60];
    
}



//发送刷卡请求，查询余额
-(void)finishSwipCard{
    
    [self showTrading];
    
    DLog(@"===========开始计算mac……");
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@",SEARCH_BLANCE_CMD_199007,tseqno,nowTime,nowDate,psamHex];
    
    //获取mac
    [self getMac:macMeta];
    
    
    
}

//交易请求
-(void)finishGetMac{
    
    if(isQpos){
        
        [self showTrading];
    }

    
    DLog(@"===========开始查询余额网络请求……");
    
    _array=[ValueUtils createParam:phonerNumber termialNo:termialNo cardNoInfo:cardNoInfo trackInfo:trackInfo pinInfo:pinInfo tseqno:tseqno pasamNo:pasamNo nowDate:nowDate nowTime:nowTime mac:macEncrypt];
    
    NSString *paramXml=[CommonUtil createXml:_array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [_array addObject:@"PACKAGEMAC"];
    [_array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:_array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:SEARCH_BLANCE_CMD_199007
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideTrading];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     [self parseBlanceXml:rootElement];
                                     
                                 }
                             }];
    
    
    
}

//解析xml
-(void)parseBlanceXml:(GDataXMLElement *)rootElement{
    
    GDataXMLElement *blanceElement = [[rootElement elementsForName:@"BALINF"] objectAtIndex:0];
    NSString *money=[blanceElement stringValue];
    NSString *blance=[NSString stringWithFormat:@"%.2f",(float)[money intValue]/100];
    
    SearchBlanceViewController *result=[[SearchBlanceViewController alloc] init];
    result.hidesBottomBarWhenPushed=YES;
    result.money=blance;
    [self.navigationController pushViewController:result animated:YES];
    
}



-(void)doResult:(vcom_Result *)vs Status:(int)_status{
    

    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self hideAllView];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
