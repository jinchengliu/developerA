//
//  UIBarButtonItem+CustomItem.m
//  Macalline
//
//  Created by chen wang on 12-4-26.
//  Copyright (c) 2012年 YoMi. All rights reserved.
//

#import "UIBarButtonItem+CustomItem.h"

@implementation UIBarButtonItem (CustomItem)

+ (id)backBarButtonItemWithTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *bgImage = [UIImage imageNamed:@"back_btn_normal.png"];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    //[button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont fontWithName:@"STHeitiSC-Medium" size:14];
    button.titleLabel.shadowColor = [UIColor blackColor];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    button.frame = CGRectMake(0, 0, bgImage.size.width, bgImage.size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

+ (id)normalBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *bgImage = [[UIImage imageNamed:@"btn_normal.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14];
    button.titleLabel.shadowColor = [UIColor blackColor];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    CGSize size = [title sizeWithFont:button.titleLabel.font];
    button.frame = CGRectMake(0, 0, size.width+16, bgImage.size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;    
}

+ (id)normalBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    UIImage *bgImage = [[UIImage imageNamed:@"Noram_item_bg.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    //    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    //    if (bgImage.size.width < image.size.width+16) {
    //        button.frame = CGRectMake(0, 0, image.size.width+16, bgImage.size.height);
    //    } else {
    //        button.frame = CGRectMake(0, 0, bgImage.size.width, bgImage.size.height);
    //    }
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

@end
