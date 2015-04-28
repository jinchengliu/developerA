//
//  SwipeAnimationView.h
//  MiniPay
//
//  Created by allen on 13-12-21.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StopBlock)();
//刷卡动画
@interface SwipeAnimationView : UIView{
    
    
    
}
@property (nonatomic,retain)StopBlock stopBlock;
@property (weak, nonatomic) IBOutlet UIImageView *ivCoverA;
-(IBAction)onClose:(id)sender;

@end
