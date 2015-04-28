//
//  CheckPosView.m
//  MiniPay
//
//  Created by allen on 13-12-24.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "CheckPosView.h"

@implementation CheckPosView
@synthesize hidchenkviewBlock=_hidchenkviewBlock;
//@synthesize ivCoverA=_ivCoverA;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)awakeFromNib{
    
    
   // [self loadAnimationStart];
    
}

//开始动画
-(void)loadAnimationStart
{
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 2.0 ];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    [self.bgImgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
   
    [self performSelector:@selector(hidview) withObject:nil afterDelay:30];
}
-(void)hidview
{
  if(_hidchenkviewBlock&&_Is_show)
      _hidchenkviewBlock();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
