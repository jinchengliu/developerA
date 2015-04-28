//
//  CreditCardPaymentsViewController.h
//  MiniPay
//
//  Created by apple on 14-5-15.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACNavBarDrawer.h"
@interface CreditCardPaymentsViewController : ACBaseViewController<UITextFieldDelegate,ACNavBarDrawerDelegate,UIAlertViewDelegate>
{
   NSString *tradeMoney;
    // NSMutableArray *array;

}
@property BOOL type;
@property(nonatomic,strong)NSMutableArray *array;
- (IBAction)okButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UITextField *textField2;
-(IBAction)hideKeyBoard:(id)sender;
@end
