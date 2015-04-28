//
//  FeeBackViewController.h
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextView.h"

@interface FeeBackViewController : YMViewController<UITextFieldDelegate>{
    
    CustomTextView *textView;
}

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberText;

-(IBAction)feeBack:(id)sender;

-(IBAction)hideKeyBord:(id)sender;
@end
