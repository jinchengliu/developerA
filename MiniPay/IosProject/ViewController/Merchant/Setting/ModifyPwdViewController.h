//
//  ModifyPwdViewController.h
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPwdViewController : YMTableViewController<UITextFieldDelegate>{
    
    NSString *phone;
    
}
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UITableViewCell *oldPwdCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *ortherPwdCell;

@property (strong, nonatomic) IBOutlet UITableViewCell *confirmPwdCell;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *oldTextView;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *ortherTextView;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *confirmPwdTextView;

@property (assign, nonatomic) BOOL isForgetPwd;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *password;

-(IBAction)btnClick:(id)sender;

@end
