//
//  UINavigationBar+CustomNavImage.h
//  ShenhuaNews
//
//  Created by magicmac on 12-9-15.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#import <UIKit/UIKit.h>

#define tag_NavTitleView 1000
#define tag_NavImageLogo 1001
#define tag_NavTitleLabel 1002

//typedef enum
//{
//    NavImageStateFirstPage = 0,
//    NavImageStateSecondPage,
//    NavImageStateComments,
//    NavImageStateUserLogin
//}NavImageState;

@interface UINavigationBar (CustomNavImage)

//-(void)setNavigationBarBackgroundImageState:(NavImageState)navImageState;


-(void)setNavigationBarBackgroundImageName:(NSString *)navImageName;

- (UIView *)addTitleView;
- (void)setNavigationBarTitle:(NSString *)title;


@end
