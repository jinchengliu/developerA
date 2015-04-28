//
//  AddCreditCardViewController.h
//  MiniPay
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddFinishDelegate <NSObject>

-(IBAction)refreshData:(id)sender;

@end
@interface AddCreditCardViewController : YMTradeBaseController<UITextFieldDelegate>
{
    id<AddFinishDelegate> delegate;
}
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(nonatomic,assign) id<AddFinishDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UITextField *textField2;
@property (strong, nonatomic) IBOutlet UILabel *banknamelable;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolbar;
- (IBAction)selectButton:(id)sender;
- (IBAction)cleanButton:(id)sender;
-(IBAction)hideKeyBoard:(id)sender;
- (IBAction)okButton:(id)sender;
@end
