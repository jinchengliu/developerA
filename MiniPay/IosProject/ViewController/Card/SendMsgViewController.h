//
//  SendMsgViewController.h
//  MiniPay
//
//  Created by apple on 14-5-13.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HidViewBlock)();
typedef void(^OkBlock)(NSString*str);
@interface SendMsgViewController : UIViewController
@property (nonatomic,retain)HidViewBlock hidViewBlock;
@property (nonatomic,retain)OkBlock okBlock;
-(IBAction)hideview:(id)sender;
-(IBAction)okbtn:(id)sender;
-(void)showControllerByAddSubView:(UIViewController *)vc animated:(BOOL)animated;
-(IBAction)hideKeyBoard:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end
