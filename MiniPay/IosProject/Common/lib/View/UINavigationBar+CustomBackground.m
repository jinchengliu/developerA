//
//  UINavigationBar+CustomBackground.m
//  Weibo
//
//  Created by chen wang on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+CustomBackground.h"

@implementation UINavigationBar (CustomBackground)

- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"NavigationbarImage.png"] drawInRect:rect];
} 

@end
