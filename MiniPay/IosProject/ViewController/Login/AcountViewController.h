//
//  AcountViewController.h
//  MiniPay
//
//  Created by apple on 14-4-1.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDTakeController.h"
@interface AcountViewController : YMTableViewController<UIActionSheetDelegate,UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource,FDTakeDelegate>
{
    NSArray *pickerArray;
    NSMutableArray* reversedArray;
    int keyboardHeight;
    BOOL keyboardIsShowing;
    NSString *imagestr;
    NSString*sfzurl;
    NSString*grjzurl;
    NSString*yhkurl;
    NSString*type;
    NSString*phonenunber;
    NSString*pwd;
    NSString*chkecode;
    UIImage *newImage;

    
}

@property FDTakeController *takeController;
-(IBAction)showSheet:(id)sender;
- (id)initWithphonenumberandcheckcode:(NSString *)phonnumber checkcode:(NSString *)code andpwd:(NSString*)pwd1;
- (IBAction)selectButton:(id)sender;
- (IBAction)cleanButton:(id)sender;

- (IBAction)sumitButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *pickerview;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolbar;
- (IBAction)takePhotoOrChooseFromLibrary:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *sfzbtn;
@property (strong, nonatomic) IBOutlet UIButton *grjzbtn;
@property (strong, nonatomic) IBOutlet UIButton *yhkbtn;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UITextField *textField2;
@property (strong, nonatomic) IBOutlet UITextField *textField3;
@property (strong, nonatomic) IBOutlet UITextField *textField4;
@property (strong, nonatomic) IBOutlet UITextField *textField5;
@property (strong, nonatomic) IBOutlet UITextField *textField6;
@property (strong, nonatomic) IBOutlet UITextField *textField7;
@property (strong, nonatomic) IBOutlet UIPickerView *selectPicker;
-(IBAction)hideKeyBoard:(id)sender;

@property (strong, nonatomic) IBOutlet UITableViewCell *bankCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *bankCell1;
@property (strong, nonatomic) IBOutlet UITableViewCell *bankCell2;
@property (strong, nonatomic) IBOutlet UITableViewCell *bankCell3;
@property (strong, nonatomic) IBOutlet UITableViewCell *bankCell4;
@property (strong, nonatomic) IBOutlet UITableViewCell *bankCell5;
@property (strong, nonatomic) IBOutlet UITableViewCell *bankCell6;
@property (strong, nonatomic) IBOutlet UITableViewCell *bankCell7;


@end
