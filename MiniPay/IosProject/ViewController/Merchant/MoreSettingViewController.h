//
//  MoreSettingViewController.h
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface MoreSettingViewController : YMTableViewController<UIAlertViewDelegate>{
    
    LoginViewController *loginViewController;
    
}
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;

-(IBAction)logOut:(id)sender;

@end
