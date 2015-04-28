//
//  KakazhuanzhangViewController.h
//  MiniPay
//
//  Created by apple on 14-5-27.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACNavBarDrawer.h"
@interface KakazhuanzhangViewController:YMTradeBaseController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource,ACNavBarDrawerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UITextField *textField2;
@property (strong, nonatomic) IBOutlet UITextField *textField3;
@property (strong, nonatomic) IBOutlet UITextField *textField4;
@property (strong, nonatomic) IBOutlet UITextField *textField5;
@property (strong, nonatomic) IBOutlet UITextField *textField6;
@property (strong, nonatomic) IBOutlet UIPickerView *selectPicker;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolbar;
-(IBAction)hideKeyBoard:(id)sender;
- (IBAction)selectButton:(id)sender;
- (IBAction)cleanButton:(id)sender;
- (IBAction)okButton:(id)sender;


@end
