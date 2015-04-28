//
//  UIBarButtonItem+CustomItem.h
//  Macalline
//
//  Created by chen wang on 12-4-26.
//  Copyright (c) 2012年 YoMi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CustomItem)

+ (id)backBarButtonItemWithTarget:(id)target action:(SEL)action;
+ (id)normalBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (id)normalBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

@end
