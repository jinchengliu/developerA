//
//  SetPwdViewController.h
//  MiniPay
//
//  Created by apple on 14-6-3.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPwdViewController : YMViewController<UITextFieldDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *textField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *textField1;
-(IBAction)okbtn:(id)sender;
@property(retain,nonatomic) NSString *phone;
@end
