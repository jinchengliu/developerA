//
//  ViewFactory.m
//  CQRCBank_iPhone
//
//  Created by ScofieldCai on 12-11-11.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import "ViewFactory.h"

// use code create View
@implementation ViewFactory


+ (UIImageView *)newImageViewWithFrame:(CGRect)frame
                             imageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

+(UILabel *)newLabelWithFrame:(CGRect)frame
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
                     fontSize:(CGFloat)fontSize
{
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textColor = textColor;
    if (fontSize != 0) {
        label.font = [UIFont systemFontOfSize:fontSize];
        label.minimumFontSize = fontSize;
    }else{
        label.minimumFontSize = [UIFont systemFontSize];
    }
    
    return label;
}

+(UIButton *)newEmptyButtonWithFrame:(CGRect)frame
                       clickedAction:(SEL)clickedAction
                              target:(id)target
{
    UIButton *emptyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    emptyBtn.frame = frame;
    [emptyBtn setBackgroundColor:[UIColor clearColor]];
    if (target) {
        [emptyBtn addTarget:target
                     action:clickedAction
           forControlEvents:UIControlEventTouchUpInside];
    }
    return emptyBtn;
}

+(UIButton *)newButtonWithFrame:(CGRect)frame
                          image:(UIImage *)image
                  clickedAction:(SEL)clickedAction
                         target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:image forState:UIControlStateNormal];
    if (target) {
        [btn addTarget:target
                action:clickedAction
      forControlEvents:UIControlEventTouchUpInside];
    }

    return btn;
}


+(UIButton *)newButtonWithFrame:(CGRect)frame
                           text:(NSString *)text
                imageNameNormal:(NSString *)imageNameNormal
             imageNameHighlight:(NSString *)imageNameHighlight
                  clickedAction:(SEL)clickedAction
                         target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imageNameNormal] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imageNameHighlight] forState:UIControlStateSelected];
    [btn addTarget:target action:clickedAction forControlEvents:UIControlEventTouchUpInside];

    return btn;
}

#pragma mark - NavBar

+(UIBarButtonItem *)newUIBarItemButtonWithFrame:(CGRect)frame
                                      imageName:(NSString *)imageName
                                  clickedAction:(SEL)clickedAction
                                         target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:target action:clickedAction forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+(UILabel *)newNavLabelWithFrame:(CGRect)frame
                            text:(NSString *)text
                       textColor:(UIColor *)textColor
{
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.font = [UIFont boldSystemFontOfSize:18.f];
    label.textColor = textColor;
    label.textAlignment = UITextAlignmentCenter;
    return label;
}

#pragma mark - 

+(UIButton *)newDetailDisclosureButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, 27.0, 40.0);
    btn.frame = frame;	// match the button's size with the image size
    UIImage *image = [UIImage imageNamed:@"detailDisclosure.png"] ;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    return btn;
}
@end
