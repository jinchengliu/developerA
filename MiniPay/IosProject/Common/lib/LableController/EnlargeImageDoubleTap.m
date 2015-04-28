//
//  EnlargeImageDoubleTap.m
//  EnlargeImagedouble
//
//  Created by 东 王 on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EnlargeImageDoubleTap.h"

@implementation EnlargeImageDoubleTap

@synthesize parentview;
@synthesize imageBackground,imageBackView,maskView;


/*
 * SetScaleAndRotation 初始化图片
 * @parent UIView 父窗口
 */

- (void)setDoubleTap:(UIView*) parent
{
    parentview=parent;
    parentview.userInteractionEnabled=YES;
    self.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *doubleTapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapRecognize.numberOfTapsRequired = 1;
    [doubleTapRecognize setEnabled :YES];
    [doubleTapRecognize delaysTouchesBegan];
    [doubleTapRecognize cancelsTouchesInView];
    
    [self addGestureRecognizer:doubleTapRecognize];
    
}


#pragma UIGestureRecognizer Handles
/*
 * handleDoubleTap 双击图片弹出单独浏览图片层
 * recognizer 双击手势
 */
-(void) handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    if (imageBackView==nil) {
        frameRect = self.window.frame;
        imageBackView = [[UIView alloc]initWithFrame:CGRectMake(
                                                                (frameRect.size.width-203.333)/2,
                                                                (frameRect.size.height-223.333)/2-46,
                                                                self.image.size.width/6+60,
                                                                self.image.size.height/6+80)];
        imageBackView.backgroundColor = [UIColor grayColor];
        imageBackView.layer.cornerRadius = 10.0; //根据需要调整
        
        [[imageBackView layer] setShadowOffset:CGSizeMake(10, 10)];
        [[imageBackView layer] setShadowRadius:5];
        [[imageBackView layer] setShadowOpacity:0.7];
        [[imageBackView layer] setShadowColor:[UIColor blackColor].CGColor];
        
        maskView = [[UIView alloc]initWithFrame:frameRect];
        maskView.backgroundColor = [UIColor grayColor];
        maskView.alpha=0.7;
        
        UIImage *imagepic = self.image;
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(30, 40, self.image.size.width/6, self.image.size.height/6)];
        [view setImage:imagepic];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *closeimg = [UIImage imageNamed:@"closeImage.png"];
        btn.frame = CGRectMake(self.image.size.width/6,0, closeimg.size.width,closeimg.size.height);
        [btn setBackgroundImage:closeimg forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeImage:) forControlEvents:UIControlEventTouchUpInside];
        
        [imageBackView addSubview:view];
        [parentview addSubview:maskView];
        [parentview addSubview:imageBackView];
        [imageBackView addSubview:btn];
        [parentview bringSubviewToFront:imageBackView];
        
        [self fadeIn];
        
        
    }
}

/*
 * fadeIn 图片渐入动画
 */
-(void)fadeIn
{
    imageBackView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    imageBackView.alpha = 0;
    [UIView animateWithDuration:.55 animations:^{
        imageBackView.alpha = 1;
        imageBackView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

/*
 * fadeOut 图片逐渐消失动画
 */
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        imageBackView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        imageBackView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [imageBackView removeFromSuperview];
        }
    }];
}

/*
 * closeImage 关闭弹出图片层
 */
-(void)closeImage:(id)sender
{
    [self fadeOut];
    imageBackView=nil;
    [maskView removeFromSuperview];
    maskView=nil;
}

@end
