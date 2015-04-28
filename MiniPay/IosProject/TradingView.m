//
//  TradingView.m
//  MiniPay
//
//  Created by allen on 13-12-21.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "TradingView.h"

@implementation TradingView
@synthesize ivCoverA=_ivCoverA;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    
    
    [self loadAnimationStart];
    
}

//开始动画
-(void)loadAnimationStart
{
    
    [UIView animateWithDuration:3 animations:^{
        self.ivCoverA.alpha=1;
    } completion:^(BOOL finished) {
        self.ivCoverA.alpha=0.1;
        [self loadAnimationStart];
        
              }];
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
