//
//  MobilePhoneRechargeViewController.h
//  MiniPay
//
//  Created by apple on 14-5-16.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACNavBarDrawer.h"
#import <AddressBookUI/AddressBookUI.h>
@interface MobilePhoneRechargeViewController:YMTradeBaseController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource,UIActionSheetDelegate,UIPickerViewDataSource,ABPeoplePickerNavigationControllerDelegate,ACNavBarDrawerDelegate>
{
    NSString *tradeMoney;
    NSArray *pickerArray;
}

- (IBAction)okButton:(id)sender;
-(IBAction)hideKeyBoard:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolbar;
@property (strong, nonatomic) IBOutlet UIPickerView *selectPicker;
- (IBAction)selectButton:(id)sender;
- (IBAction)cleanButton:(id)sender;

- (IBAction)selectMoblephone:(id)sender;

@end
