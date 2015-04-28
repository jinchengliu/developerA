//
//  SwipeAnimationView.m
//  MiniPay
//
//  Created by allen on 13-12-21.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "SwipeAnimationView.h"

@implementation SwipeAnimationView
@synthesize  stopBlock=_stopBlock;
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
    
    [UIView animateWithDuration:2.5 animations:^{
       self.ivCoverA.frame=CGRectMake(202,  self.ivCoverA.frame.origin.y, self.ivCoverA.frame.size.width, self.ivCoverA.frame.size.height);
    } completion:^(BOOL finished) {
       
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(secStart) userInfo:nil repeats:NO];
    }];
}

-(void)secStart{
    
      self.ivCoverA.frame=CGRectMake(23,  self.ivCoverA.frame.origin.y, self.ivCoverA.frame.size.width, self.ivCoverA.frame.size.height);
    [self loadAnimationStart];
    
}


-(IBAction)onClose:(id)sender
{
    if(_stopBlock)
        _stopBlock();
    [self removeFromSuperview];
    
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
