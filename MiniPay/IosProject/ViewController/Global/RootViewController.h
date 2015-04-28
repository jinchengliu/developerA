//
//  RootViewController.h
//  CQRCBank_iPhone
//
//  Created by magicmac on 12-12-13.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//  系统根控制器

#import <UIKit/UIKit.h>
#import "SlotCardViewController.h"
#import "FlowViewController.h"
#import "MerchantIndexViewController.h"
#import "ToolIndexViewController.h"

@interface RootViewController : UITabBarController<UITabBarControllerDelegate>


@property (strong, nonatomic) UIImageView *tabBarBackgroundImageView;

@property (strong, nonatomic) UINavigationController *cardNavigationController;

@property (strong, nonatomic) UINavigationController *flowNavigationController;

@property (strong, nonatomic) UINavigationController *merchantNavigationController;

@property (strong, nonatomic) UINavigationController *toolNavigationController;

-(int)getTabSelectedIndex;

- (void)loadRootViewController;

#pragma mark - // 改变 tabbar 的按钮图片
- (void)changeTabbarSelectImageWithIndex:(int)index;

@end
