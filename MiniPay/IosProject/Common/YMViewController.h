//
//  EDViewController.h
//  EDrivel
//
//  Created by chen wang on 11-11-19.
//  Copyright (c) 2011年 bonet365.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "JKCustomAlert.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "DataManager.h"
#import "ViewFactory.h"
#import "ControlCentral.h"
#import "HttpManager.h"

#define k_tag_nav_bar_label 2222


@interface YMViewController : UIViewController<JKCustomAlertDelegate,UIActionSheetDelegate>{
    NSString *_string;   
    
    MBProgressHUD *hud;
    
    DataManager *_dataManager;
    
    ControlCentral *_controlCentral;
    HttpManager *_httpManager;
    
    id _targetWithShouldLogin;
    SEL _selectorWithShouldLogin;

}

@property(retain,nonatomic) NSString *sendtitle;
@property (strong, nonatomic) UILabel *titleLabel;





- (void)showWaiting:(NSString *)text;
- (void)showWaiting:(NSString *)text withView:(UIView *)view;
- (void)hideWaiting;

- (void)showSplash:(NSString *)text;
- (void)showSplash:(NSString *)text detailText:(NSString *)detailText;
- (void)showSplash:(NSString *)text delegate:(id<MBProgressHUDDelegate>)delegate tag:(NSInteger)tag;
- (void)showSplash:(NSString *)text detailText:(NSString *)detailText delegate:(id<MBProgressHUDDelegate>)delegate tag:(NSInteger)tag;


-(void)setpageTitle:(NSString *)title;
- (void)showAlert:(NSString *)text;

- (void)backAction:(id)sender;

- (void)backToRoot:(id)sender;

- (void)showHudWithTextOnly:(NSString *)text;

- (UIWindow *)systemWindow;

-(void)showImageAlert:(NSString *)title content:(NSString *)content type:(NSString *)type;

-(void)loadWebView:(NSString *)url UIWebView:(UIWebView *)webView;

@end
