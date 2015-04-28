//
//  MyaccountViewController.h
//  MiniPay
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MxMovingPlaceholderTextField.h"
#import "ACNavBarDrawer.h"
@interface MyaccountViewController : YMViewController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource,UIActionSheetDelegate,UIPickerViewDataSource,ACNavBarDrawerDelegate>
{

 NSArray *pickerArray;
}
@property (weak, nonatomic) IBOutlet UILabel *myzcLable;
@property (weak, nonatomic) IBOutlet UILabel *myyeLable;
@property (weak, nonatomic) IBOutlet UIButton *ptbuton;
-(IBAction)tixianBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolbar;
@property (strong, nonatomic) IBOutlet UIPickerView *selectPicker;
@property (strong, nonatomic) IBOutlet MxMovingPlaceholderTextField *mxMovingPlaceholderTextField;

- (IBAction)selectButton:(id)sender;
- (IBAction)cleanButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *openbtn;

- (IBAction)hiddenKeyboard:(id)sender;
@property (strong, nonatomic) NSString *cardno;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *bankname;
@property (strong, nonatomic) NSString *merchantNameLabel;

@property (strong, nonatomic) IBOutlet UIImageView *mainView;
@property (strong, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UILabel *cardnoLable;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *shanghulable;

@property (weak, nonatomic) IBOutlet UILabel *nameLable2;

@property (weak, nonatomic) IBOutlet UILabel *banknameLable;

@property (weak, nonatomic) IBOutlet UILabel *ksnLable;

@property (weak, nonatomic) IBOutlet UILabel *cardnoLable1;

@property (weak, nonatomic) IBOutlet UILabel *nameLable1;

@property (weak, nonatomic) IBOutlet UILabel *banknameLable1;

@property (weak, nonatomic) IBOutlet UILabel *ksnLable1;
- (IBAction)OnClick1:(UIButton *)sender;

@end
