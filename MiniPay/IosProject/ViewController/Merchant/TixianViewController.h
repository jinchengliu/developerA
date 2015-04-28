//
//  TixianViewController.h
//  MiniPay
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GohomeBlock)();
@interface TixianViewController : YMViewController<UITextFieldDelegate>
@property BOOL Ispttixian;
@property (weak, nonatomic) IBOutlet UITextField *jierField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UILabel *tishiLabel;
@property (weak, nonatomic) IBOutlet UILabel *jierlabel;
@property (strong, nonatomic) NSString *jine;
-(IBAction)sumbit:(id)sender;
@property (nonatomic,retain)GohomeBlock gohomeBlock;
@end
