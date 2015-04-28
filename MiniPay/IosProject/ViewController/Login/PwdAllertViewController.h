//
//  PwdAllertViewController.h
//  MiniPay
//
//  Created by apple on 14-5-12.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFFNumericKeyboard.h"
typedef void(^HidViewBlock)();
typedef void(^OkBlock)(NSString*str);
@interface PwdAllertViewController : YMViewController<AFFNumericKeyboardDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *view_pwd;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *lableNo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil cardNo:(NSString *)cardno;

-(void)showControllerByAddSubView:(UIViewController *)vc animated:(BOOL)animated;
@property (nonatomic,retain)HidViewBlock hidViewBlock;
@property (nonatomic,retain)OkBlock okBlock;
-(IBAction)hideKeyBoard:(id)sender;
-(IBAction)hideview:(id)sender;
-(IBAction)okbtn:(id)sender;
@end
