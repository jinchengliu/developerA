//
//  AppDelegate.h
//  IosProject
//
//  Created by apple on 13-7-29.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "LoadingViewController.h"
#import "WeiboSDK.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) LoginViewController *loginViewController;

@end
