//
//  CheckPosView.h
//  MiniPay
//
//  Created by allen on 13-12-24.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HidchenkviewBlock)();

//检测刷卡器
@interface CheckPosView : UIView{
    
    
    
}
@property BOOL Is_show;
@property (nonatomic,retain)HidchenkviewBlock hidchenkviewBlock;
-(void)loadAnimationStart;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
//@property (weak, nonatomic) IBOutlet UIImageView *ivCoverA;

@end
