//
//  YMTradeBaseController.h
//  MiniPay
//
//  Created by allen on 13-12-16.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "vcom.h"
#import "ZftQiposLib.h"
#import "AESUtil.h"
#import "InsertPosView.h"
#import "CheckPosView.h"
#import "SwipeAnimationView.h"
#import "TradingView.h"
#import "MPosOperation.h"
#import "CSwiperController.h"
@interface YMTradeBaseController : YMTableViewController<CSwiperStateChangedListener,ZftQiPosDelegate,MPosOperationDelegate,CSwiperControllerDelegate>{
    
    vcom* m_vcom;
    NSString *pasamNo;
    NSString *termialNo;
    NSString *phonerNumber;
    NSString *tseqno;
    
    NSString *tmpMoney;
    NSString *tmpMoney1;
    NSString *trackInfo;
    NSString *cardNoInfo;
    NSString *pinInfo;
    
    NSString *macMeta;
    NSString *macEncrypt;
    int _identify;
    int _D180identify;
    int _Bposidentify;
 
    //Qpos支付对象
    //ZftQiposLib *qpos;
    
     MPosOperation *op;
    
    BOOL isQpos;
    InsertPosView *insertPosView;
    CheckPosView *checkPosView;
    SwipeAnimationView *swipeView;
    TradingView *tradeView;
    UIWindow * window;
    NSString *nowDate;
    NSString *nowTime;
    NSString *cmd;
    
     NSOperationQueue *opq;
    id mPosOperationDelegate;
    NSString *selectedBTMac;
    
    NSString *pinkey_All;
    NSString *mackey_All;
    NSString *deskey_All;
    
     NSString *iDFID;
     NSMutableArray *devicList;
//    NSString*latitude;
//    NSString*longitude;
}


@property NSMutableArray *accessoryList;
//签到成功
-(void)signureSuccess;

//刷卡结束
-(void)finishSwipCard;

//Qpos刷卡
-(void)qPosSwipCard;

-(void)doSigned;

-(void)doResult:(vcom_Result *)vs Status:(int)_status;

- (BOOL)hasHeadset;

//计算mac
-(void)getMac:(NSString *)mac;



-(void)finishGetMac;

//验证是否签到
-(void)checkIsSign;

//隐藏检测设备
-(void)hideCheckPos;

//隐藏刷卡
-(void)hideSwipCard;

//显示正在交易中
-(void)showTrading;

//隐藏正在交易中
-(void)hideTrading;

-(void)hideAllView;
-(void)getTermKoulv;

//获取终端号
-(void)getDeviceNO;


@end
