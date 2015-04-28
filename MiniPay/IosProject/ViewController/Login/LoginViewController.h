//
//  LoginViewController.h
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "ForgetPwdViewController.h"
#import "UINavigationBar+CustomNavImage.h"
#import "UITableView+DataSourceBlocks.h"
@class TableViewWithBlock;


@interface LoginViewController : YMViewController<UITextFieldDelegate>{
    
    RootViewController *rootViewController;
      BOOL isOpened;
      NSString *versionNum;
}

-(IBAction)switchAction:(id)sender;
-(IBAction)hideKeyBoard:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *openButton;
@property (retain, nonatomic) IBOutlet UITextField *inputTextField;
@property (retain, nonatomic) IBOutlet TableViewWithBlock *tb;
- (IBAction)changeOpenStatus:(id)sender;

@property BOOL IsdispaySwitch;

-(IBAction)loginBtn:(id)sender;
-(IBAction)goToForgetPwd:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *loginBtn;
@property (unsafe_unretained, nonatomic) IBOutlet UISwitch *switchButton;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lable;
 

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *userNameTextView;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *passwordTextView;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *getPwdBtn;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *zhuceBtn;

@end
