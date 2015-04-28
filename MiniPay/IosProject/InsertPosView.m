//
//  InsertPosView.m
//  MiniPay
//
//  Created by allen on 13-12-24.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "InsertPosView.h"

@implementation InsertPosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    
    
    [_closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
}


-(void)closeView{
    
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
