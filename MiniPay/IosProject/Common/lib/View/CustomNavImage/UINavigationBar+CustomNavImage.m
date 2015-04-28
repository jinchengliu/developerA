//
//  UINavigationBar+CustomNavImage.m
//  ShenhuaNews
//
//  Created by magicmac on 12-9-15.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#import "UINavigationBar+CustomNavImage.h"
// 导航栏图片存储的key
#define UserDefaults_NavImageNameKey             @"defaults_navName"



@implementation UINavigationBar (CustomNavImage)

/*
-(void)setNavigationBarBackgroundImage:(NavImageState)navImageState
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    switch (navImageState) {
        case NavImageStateFirstPage:
            [defaults setObject:ImageName_Nav_First forKey:UserDefaults_NavImageNameKey];
            break;
        case NavImageStateSecondPage:
            [defaults setObject:ImageName_Nav_Second forKey:UserDefaults_NavImageNameKey];
            break;
        case NavImageStateComments:
            [defaults setObject:ImageName_Nav_Comments forKey:UserDefaults_NavImageNameKey];
            break;
        case NavImageStateUserLogin:
            [defaults setObject:ImageName_Nav_UserLogin forKey:UserDefaults_NavImageNameKey];
            break;
        default:
            break;
    }
    [defaults synchronize];
    
    if (kSystemVersion >= 5.0 )
    {
        [self changeNavBarImage];
        
    }else {
        [self setNeedsDisplay];
    }
}
*/

-(void)setNavigationBarBackgroundImageName:(NSString *)navImageName {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:navImageName forKey:UserDefaults_NavImageNameKey];
    [defaults synchronize];
    
    if (kSystemVersion >= 5.0 )
    {
        [self changeNavBarImage];
        
    }else {
         
        [self setNeedsDisplay];
    }

}


-(void)drawRect:(CGRect)rect
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    UIImage * image = [UIImage imageNamed:[defaults objectForKey:UserDefaults_NavImageNameKey]];
    [image drawInRect:rect];
}

-(void)changeNavBarImage
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    UIImage * image = [UIImage imageNamed:[defaults objectForKey:UserDefaults_NavImageNameKey]];
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}


- (UIView *)addTitleView {
    UIView *titleView = [[UIView alloc] initWithFrame:self.bounds];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.tag = tag_NavTitleView;
    
    // logo
    UIImage *navLogoImage = [UIImage imageNamed:kImage_NavigationBarBanklogo];
    UIImageView *navlogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44.0, 44.0)];
    navlogoImageView.image = navLogoImage;
    navlogoImageView.backgroundColor =[UIColor clearColor];
    navlogoImageView.tag = tag_NavImageLogo;
    [titleView addSubview:navlogoImageView];
    
    // title label
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(navLogoImage.size.width, 0, 180.0, 44.0)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentLeft;
    label.tag = tag_NavTitleLabel;
    [titleView addSubview:label];
    
    [self addSubview:titleView];
    
    return titleView;
}

- (void)setNavigationBarTitle:(NSString *)title {
    UIView *titleView  = [self viewWithTag:tag_NavTitleView];
    if (!titleView) {
        titleView  = [self addTitleView];
    }
    UILabel *titleLabel = (UILabel *)[titleView viewWithTag:tag_NavTitleLabel];
    titleLabel.text = title;
    
    // logo 的 frame
    UIImageView *navlogoImageView = (UIImageView *)[titleView viewWithTag:tag_NavImageLogo];
    navlogoImageView.frame = CGRectMake(0, (44-26)/2.0, 26.0, 26.0);
    CGRect logoImageViewFrame = navlogoImageView.frame;
    
    // titleLabel 的frame
    CGSize textSize = [title sizeWithFont:[UIFont systemFontOfSize:20.0f]                                                                        					 constrainedToSize:CGSizeMake(180.0, 44.0)                                                                           						 lineBreakMode:UILineBreakModeWordWrap];
    CGRect titleLabelFrame = titleLabel.frame;
    titleLabelFrame.size = textSize;
    titleLabelFrame.origin.x = logoImageViewFrame.origin.x + logoImageViewFrame.size.width +10.0 ;
    titleLabelFrame.size.height = 44.0;
    titleLabel.frame = titleLabelFrame;
    
    CGRect titleViewFrame = titleView.frame;
    titleViewFrame.size.width = logoImageViewFrame.size.width + titleLabelFrame.size.width + 10.0;
    titleView.frame = titleViewFrame;
    
    titleView.center = CGPointMake(self.center.x, 44.0/2);
    
}

@end
