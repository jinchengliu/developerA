//
//  ViewFactory.h
//  CQRCBank_iPhone
//
//  Created by ScofieldCai on 12-11-11.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewFactory : NSObject

+ (UIImageView *)newImageViewWithFrame:(CGRect)frame
                             imageName:(NSString *)imageName;

+ (UILabel *)newLabelWithFrame:(CGRect)frame
                          text:(NSString *)text
                     textColor:(UIColor *)textColor
                      fontSize:(CGFloat)fontSize;

+(UIButton *)newButtonWithFrame:(CGRect)frame
                          image:(UIImage *)image
                  clickedAction:(SEL)clickedAction
                         target:(id)target;

+(UIButton *)newEmptyButtonWithFrame:(CGRect)frame
                       clickedAction:(SEL)clickedAction
                              target:(id)target;

+(UIButton *)newButtonWithFrame:(CGRect)frame
                           text:(NSString *)text
                imageNameNormal:(NSString *)imageNameNormal
             imageNameHighlight:(NSString *)imageNameHighlight
                  clickedAction:(SEL)clickedAction
                         target:(id)target;

#pragma mark - NavBar
+(UIBarButtonItem *)newUIBarItemButtonWithFrame:(CGRect)frame
                                      imageName:(NSString *)imageName
                                  clickedAction:(SEL)clickedAction
                                         target:(id)target;

+(UILabel *)newNavLabelWithFrame:(CGRect)frame
                            text:(NSString *)text
                       textColor:(UIColor *)textColor;

+(UIButton *)newDetailDisclosureButton;

@end
