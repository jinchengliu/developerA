//
//  ForgetPwdViewController.h
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ForgetPwdViewController : YMViewController<UITextFieldDelegate>{
    
    NSString *oldPwd;
    
}
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *phoneTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *checkCodeTextField;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *checkCodeBtoon;
@property (nonatomic, retain) NSTimer                 *timeCounter;

-(IBAction)getCheckCode:(id)sender;

-(IBAction)nextBtn:(id)sender;

-(IBAction)hideKeyBoard:(id)sender;

@end
