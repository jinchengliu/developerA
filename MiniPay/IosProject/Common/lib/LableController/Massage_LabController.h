//
//  Massage_LabController.h
//  CMBCDirectBank
//
//  Created by yitong on 13-10-8.
//  Copyright (c) 2013年 xuyunfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMBCBankBaseViewController;
typedef void(^CMBCMassage_LabBlock)(void);
@interface Massage_LabController : UIView
{
    //灰色背景
    UIView * bgView;
    //内容区视图
    UIView * contentView;
    //内容
   // UILabel * lbContent;
    
    //标题
    UILabel * lbTitle;
    UITextView *lbContent;
    
       CGSize contentSize;
}

@property (nonatomic, copy) CMBCMassage_LabBlock otherBlock;
+ (void)showWithTitle:(NSString *)title message:(NSString *)message otherBlock:(CMBCMassage_LabBlock)otherBlock prentView:(CMBCBankBaseViewController *)view;
          

@end
