//
//  LoadingViewController.h
//  CQRCBank_iPhone
//
//  Created by magicmac on 12-12-13.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//  启动页面

// 加载动画
#import "RootViewController.h"
#import "NewFeatureViewController.h"
#import "LoginViewController.h"

@interface LoadingViewController : YMViewController <UIAlertViewDelegate>{
    // modified by yang.
    UIActivityIndicatorView *_baseActivityView;
    BOOL _showActivityIndicator;
    
    NSString *messageStr;
    
    UIAlertView *alert;
    
    NSString *versionNum;
    
    NSTimer *timer;
    //ControlCentral *_controlCentral;

    
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,assign) BOOL showActivityIndicator;

//@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic,retain) UIImageView *splashImageView;

@property (nonatomic,retain) NSString *lastReadTime;

@property (strong, nonatomic) RootViewController *rootViewController;

@end
