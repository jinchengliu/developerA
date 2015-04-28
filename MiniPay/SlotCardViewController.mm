  //
//  SlotCardViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//刷卡页面
#import "SlotCardViewController.h"
#import "GDataXMLNode.h"
#import "AESUtil.h"
#import "ValueUtils.h"
#import "SwipeAnimationView.h"
#import "SignaturViewController.h"
#import "TradeResultViewController.h"
#import "NormalQuestionViewController.h"

@interface SlotCardViewController ()

@end

@implementation SlotCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self setpageTitle:@"刷卡"];
        //self.navigationItem.title=@"刷卡";
       // self.navigationController.navigationBar.te
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    moneyStr=[[NSMutableString alloc] initWithString:@"￥"];
    
    
    _moneyTextView.delegate=self;
    _locationManager = [[CLLocationManager alloc] init];

    _locationManager.delegate = self;
    //    设置位置精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //    距离过滤，表示在地图上每隔100更新一次定位
    _locationManager.distanceFilter = 100;
    //    启动位置管理器，进行定位服务
    [_locationManager startUpdatingLocation];
   // [self showWaiting:@"正在获取位置信息，请稍后……"];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (_startPoint == nil) {
        _startPoint=newLocation;
    }
//    longitude=[NSString stringWithFormat:@"%g\u00B0",newLocation.coordinate.longitude];
//    latitude=[NSString stringWithFormat:@"%g\u00B0",newLocation.coordinate.latitude];
    _dataManager.longitude=[NSString stringWithFormat:@"%g\u00B0",newLocation.coordinate.longitude];
    _dataManager.latitude=[NSString stringWithFormat:@"%g\u00B0",newLocation.coordinate.latitude];
   // [self hideAllView];
}



//当设备无法定位当前我位置时候调用此方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // [self hideAllView];
//    NSString *errorType = (error.code == kCLErrorDenied)?@"Access Denied" : @"Unknown Error";
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting Location"
//                                                    message:errorType
//                                                   delegate:nil
//                                          cancelButtonTitle:@"oKay"
//                                          otherButtonTitles: nil];
//    [alert show];

    _dataManager.longitude=@"";
    _dataManager.latitude=@"";
   

    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //弹出UIDatePicker 代码
    
    return NO;
    
}


//点击数字
-(IBAction)numberClick:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    //小数点
    if(btn.tag==-1){
        NSRange range=[moneyStr rangeOfString:@"."];
        
        if(![moneyStr isEqualToString:@"￥"] && range.length==0){
            [moneyStr appendString:@"."];
        }
     }else if(btn.tag==-2){  //回退操作
        
        if(![moneyStr isEqualToString:@"￥"]){
            [moneyStr setString:[moneyStr substringWithRange:NSMakeRange(0, moneyStr.length-1)]];
        }
        
    }else{
        
        NSRange range=[moneyStr rangeOfString:@"."];
        
        if(![moneyStr isEqualToString:@"￥0"] && !(range.length>0 && range.location==moneyStr.length-3)){
            [moneyStr appendFormat:@"%d",btn.tag];
        }
    }
    
    [_moneyTextView setText:moneyStr];
    
    
}

//点击刷卡按钮
-(IBAction)slotCard:(id)sender{
    iDFID=@"";
    NSString *moneyVal=_moneyTextView.text;
    
    if([moneyVal isEqualToString:@"￥"]){
        [self showAlert:@"请输入支付金额!"];
    }else{
       // 转向签名页面
//        SignaturViewController *result=[[SignaturViewController alloc] init];
//        result.type=false;
//        result.logno=@"011";
//        result.hidesBottomBarWhenPushed=YES;
//        result.money=@"1000000000";
//        
//        [self.navigationController pushViewController:result animated:YES];
//        return;
        
        NSMutableString *money=[NSMutableString stringWithFormat:@"%@",moneyVal];
        [money replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
        NSRange range=[money rangeOfString:@"."];
        if(range.length==0){
            [money appendString:@".00"];
        }
        tmpMoney=[NSString stringWithFormat:@"%d",(int)([money floatValue]*100)];
        NSMutableString *tmp=[[NSMutableString alloc] init];
        //若不够12位前面补0
        for(int i=0;i<(12-[tmpMoney length]);i++){
            [tmp appendString:@"0"];
        }
        [tmp appendString:tmpMoney];
        tradeMoney=tmp;
        tmpMoney1=tradeMoney;
        
       // NSString *stu=_dataManager.ShanghuStus;
      if(![_dataManager.ShanghuStus isEqualToString:@"0"]||_dataManager.device_Type==NOpos)
      {
          [self hideAllView];
       if(_dataManager.device_Type==NOpos)
       {
        
        [self showAlert:@"该商户未进行实名认证，或机器已解绑！!"];
        
       }
      else
        {
        
            [self showAlert:@"该商户正在审核，或审核未通过！"];
        
        }
          return;
      }
        
    // [qpos setLister:self];
       

        //验证是否签到
       [self getTermKoulv];
        //[self checkIsSign];
        
    }
    
}



//Qpos刷卡
-(void)qPosSwipCard{
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",SWIPE_CARD_CMD_199005,tradeMoney,tseqno,nowTime,nowDate,psamHex];
    DLog(@"Qpos mac加密前======%@",macMeta);
     [[ZftQiposLib getInstance] doTradeEx:tmpMoney andType:1 andRandom:nil andextraString:macMeta andTimesOut:60];
    
}

//D180刷卡
-(void)d180SwipCard{
    
    //[self showTrading];

    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",SWIPE_CARD_CMD_199005,tradeMoney,tseqno,nowTime,nowDate,psamHex];
    op = [[MPosOperation alloc] initWithType:OPER_GET_MAC withName:@"getmac" withArgNum:1 withArgs:[[NSArray alloc] initWithObjects:macMeta, nil] withDelegate:mPosOperationDelegate];
      [opq addOperation:op];
     _D180identify=4;
    
}


//Bpos刷卡
-(void)BposSwipCard{
    
    //[self showTrading];
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",SWIPE_CARD_CMD_199005,tradeMoney,tseqno,nowTime,nowDate,psamHex];
        NSMutableDictionary *encryptOptionDict = [NSMutableDictionary dictionary];
    [encryptOptionDict setObject:[NSNumber numberWithInt:EncryptionMethod_MAC_METHOD_2] forKey:@"encryptionMethod"];
    [encryptOptionDict setObject:[NSNumber numberWithInt:EncryptionKeySource_BY_SERVER_8_BYTES_WORKING_KEY] forKey:@"encryptionKeySource"];
    [encryptOptionDict setObject:[NSNumber numberWithInt:EncryptionPaddingMethod_ZERO_PADDING] forKey:@"encryptionPaddingMethod"];
    [encryptOptionDict setObject:[mackey_All substringWithRange:NSMakeRange(0, mackey_All.length-8)] forKey:@"encWorkingKey"];
    [encryptOptionDict setObject:[[mackey_All substringWithRange:NSMakeRange(mackey_All.length-8, 8)] substringWithRange:NSMakeRange(0, 6)] forKey:@"kcvOfWorkingKey"];
    [encryptOptionDict setObject:[NSNumber numberWithInt:8] forKey:@"macLength"];
    [encryptOptionDict setObject:macMeta forKey:@"data"];
    NSLog(@"encryptOptionDict: %@", encryptOptionDict);
    [[CSwiperController sharedController] encryptDataWithSettings:[NSDictionary dictionaryWithDictionary:encryptOptionDict]];
    _Bposidentify=1;
    
    
}





//刷卡成功，执行请求
-(void)finishSwipCard{
    
    [self showTrading];
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",SWIPE_CARD_CMD_199005,tradeMoney,tseqno,nowTime,nowDate,psamHex];
    DLog(@"Qpos mac加密前======%@",macMeta);

    //计算mac
    [self getMac:macMeta];
    

}

//getMac成功
-(void)finishGetMac{
    
    [self hideAllView];
   
    //转向签名页面
    SignaturViewController *signature=[[SignaturViewController alloc] init];
    signature.finshcaedBlock=^(NSString *imgstr)
    {
        
        [self RequestTrade:imgstr];
        
    };
    // signature.logno=logno;
    signature.type=1;   //代表交易
    double mon=[tmpMoney doubleValue]/100;
    signature.money=[NSString stringWithFormat:@"%.2f",mon];
    signature.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:signature animated:YES];
    
   // [self RequestTrade:@""];
    
}


-(void)RequestTrade:(NSString *)imgstr
{
    
    [self hideAllView];
    [self showTrading];
    
    
    array=[ValueUtils createParam:trackInfo tradeMoney:tradeMoney pinInfo:pinInfo cardNoInfo:cardNoInfo cmd:SWIPE_CARD_CMD_199005 phonerNumber:phonerNumber termialNo:termialNo pasamNo:pasamNo tseqno:tseqno nowDate:nowDate nowTime:nowTime mac:macEncrypt CHECKX:_dataManager.latitude CHECKY:_dataManager.longitude ];
    
    DLog(@"====计算后的mac值===%@",macEncrypt);
    
    [array addObject:@"IDFID"];
    [array addObject:iDFID];
    
    [array addObject:@"ELESIGNA"];
    [array addObject:imgstr];
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:SWIPE_CARD_CMD_199005
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideAllView];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     [self parseTradeXml:rootElement];
                                     
                                 }
                                 else
                                 {
                                  [self.navigationController popViewControllerAnimated:YES];
                                 }
                             }];
    
}




//解析xml
-(void)parseTradeXml:(GDataXMLElement *)rootElement{
    
    GDataXMLElement *lognoElement = [[rootElement elementsForName:@"LOGNO"] objectAtIndex:0];
    NSString *logno=[lognoElement stringValue];
////
//    //转向签名页面
//    SignaturViewController *signature=[[SignaturViewController alloc] init];
//    signature.logno=logno;
//    signature.type=1;   //代表交易
//    double mon=[tmpMoney doubleValue]/100;
//    signature.money=[NSString stringWithFormat:@"%.2f",mon];
//    signature.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:signature animated:YES];
//

    
    double mon=[tmpMoney doubleValue]/100;
    
    TradeResultViewController *result=[[TradeResultViewController alloc] init];
    result.type=1;
    result.logno=logno;
    result.hidesBottomBarWhenPushed=YES;
    result.Trademoney=[NSString stringWithFormat:@"%.2f",mon];
    
    [self.navigationController pushViewController:result animated:YES];


    
    
}




//执行结果
-(void)doResult:(vcom_Result *)vs Status:(int)_status{
    
    
}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    NSRange range=NSMakeRange(1, [moneyStr length]-1);
    [moneyStr deleteCharactersInRange:range];
    [self.moneyTextView setText:moneyStr];
    
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.frame = CGRectMake(0, 0, 10, 20);
//    [leftButton setBackgroundImage:[UIImage imageNamed:@"nav_back"]
//                          forState:UIControlStateNormal];
//    
//    [leftButton addTarget:self
//                   action:@selector(cancelClick)
//         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item ;//= [[UIBarButtonItem alloc]
                            // initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightButton.frame = CGRectMake(0, 0, 20, 20);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"help"]
                           forState:UIControlStateNormal];
    
    [rightButton addTarget:self
                    action:@selector(help)
          forControlEvents:UIControlEventTouchUpInside];
    
    item = [[UIBarButtonItem alloc]
            initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item;
    
    
    
}
-(void)help
{
    
    NormalQuestionViewController *question=[[NormalQuestionViewController alloc] init];
    // question.hidesBottomBarWhenPushed=YES;
    question.url_type=shuaka;
    [self.navigationController pushViewController:question animated:YES];
    
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
