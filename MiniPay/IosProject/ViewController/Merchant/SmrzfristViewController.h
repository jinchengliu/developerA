//
//  SmrzfristViewController.h
//  MiniPay
//
//  Created by apple on 14-5-9.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmrzfristViewController : YMTradeBaseController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>
{
    NSArray *pickerArray;
     BOOL isclean;
}
//@property NSMutableArray *accessoryList;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UITextField *textField2;
@property (strong, nonatomic) IBOutlet UITextField *textField3;
@property (strong, nonatomic) IBOutlet UITextField *textField4;
@property (strong, nonatomic) IBOutlet UITextField *textField5;
@property (strong, nonatomic) IBOutlet UIView *pickerview;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolbar;
@property (strong, nonatomic) IBOutlet UIPickerView *selectPicker;

@property (retain, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *id_cid;
@property (strong, nonatomic) NSString *mer_name;
@property (strong, nonatomic) NSString *jyfw;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *TermNO;
@property (strong, nonatomic) NSString *kaihu_name;
@property (strong, nonatomic) NSString *kaihu_address_p;
@property (strong, nonatomic) NSString *kaihu_address_s;
@property (strong, nonatomic) NSString *kaihu_addresscode;
@property (strong, nonatomic) NSString *bank_name;
@property (strong, nonatomic) NSString *bank_code;
@property (strong, nonatomic) NSString *bank_address;
@property (strong, nonatomic) NSString *card_NO;
@property (strong, nonatomic) NSString *bank_showname;

@property (strong, nonatomic) NSString *bank_NO;
@property BOOL Is_Edit;
-(IBAction)selectdivce:(id)sender;
- (IBAction)selectButton:(id)sender;
- (IBAction)cleanButton:(id)sender;
-(IBAction)hideKeyBoard:(id)sender;
-(IBAction)sumitButton:(id)sender;
@end
