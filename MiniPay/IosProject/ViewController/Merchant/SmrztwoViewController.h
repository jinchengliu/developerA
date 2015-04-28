//
//  SmrztwoViewController.h
//  MiniPay
//
//  Created by apple on 14-5-9.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSLocateView;
@interface SmrztwoViewController : YMTableViewController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource,UIActionSheetDelegate,UIPickerViewDataSource>
{
    NSArray *provinces;
    NSArray	*cities;
    // NSArray	*cities1;
    NSString *pcode;
    NSString *citycode;
    NSArray *pickerArray;
    BOOL isclean;
    UITextField *usertextfield;
    NSString*bankId;
    NSString*bankNO;
    NSString*citybankId;
    NSString*provincename;
    NSString*cityname;
    TSLocateView *locateView;
}

//
//@property(nonatomic,strong) NSMutableArray *array;
//@property(nonatomic,strong) NSMutableArray *array1;
//@property(nonatomic,strong) NSMutableArray *array2;
//@property(nonatomic,strong) NSMutableArray *array3;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UITextField *textField2;
@property (strong, nonatomic) IBOutlet UITextField *textField3;
@property (strong, nonatomic) IBOutlet UITextField *textField4;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolbar;
@property (strong, nonatomic) IBOutlet UIPickerView *selectPicker;
- (IBAction)selectButton:(id)sender;
- (IBAction)cleanButton:(id)sender;
-(IBAction)hideKeyBoard:(id)sender;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *shanghuname;
@property (strong, nonatomic) NSString *jyfw;
@property (strong, nonatomic) NSString *jydz;
@property (strong, nonatomic) NSString *xlh;

@property (strong, nonatomic) IBOutlet UIButton *btn;

@property (strong, nonatomic) NSString *kaihu_name;
@property (strong, nonatomic) NSString *kaihu_address_p;
@property (strong, nonatomic) NSString *kaihu_address_s;
@property (strong, nonatomic) NSString *kaihu_addresscode;
@property (strong, nonatomic) NSString *bank_name;
@property (strong, nonatomic) NSString *bank_code;
@property (strong, nonatomic) NSString *bank_address;
@property (strong, nonatomic) NSString *card_NO;
@property (strong, nonatomic) NSString *bank_showname;

@property (strong, nonatomic) NSString *bank_No;
@property BOOL Is_Edit;
-(IBAction)hideKeyBoard:(id)sender;
-(IBAction)sumitButton:(id)sender;
@end
