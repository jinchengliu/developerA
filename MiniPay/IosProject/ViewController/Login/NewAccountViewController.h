//
//  NewAccountViewController.h
//  MiniPay
//
//  Created by apple on 14-4-1.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+CustomNavImage.h"
@interface NewAccountViewController : YMViewController<UITextFieldDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *phoneTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *checkCodeTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *pwdTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *pwdaginTextField;
@property(nonatomic,strong)IBOutlet UIButton * btnRemberName;
-(IBAction)hideKeyBoard:(id)sender;
-(IBAction)getCheckCode:(id)sender;
-(IBAction)nextBtn:(id)sender;
@property (nonatomic, retain) NSTimer                 *timeCounter;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *checkCodeBtoon;
-(IBAction)onRemberName:(id)sender;
@end
