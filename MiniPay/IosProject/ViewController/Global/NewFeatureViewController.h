//
//  NewFeatureViewController.h
//  CQRCBank_iPhone
//
//  Created by Channing.Hu on 13-4-3.
//  Copyright (c) 2013年 magic-point. All rights reserved.
//首次登陆的欢迎页面

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "LoginViewController.h"

@interface NewFeatureViewController : YMViewController<UIScrollViewDelegate, UIScrollViewDelegate>
{
    UIScrollView *pages;
    RootViewController *rootViewController;
    UIPageControl *pageControl;
    LoginViewController *loginViewController;
}


@end
