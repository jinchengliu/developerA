//
//  YMButtonView.h
//  Ccc
//
//  Created by apple on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"




@class YMButtonView;
@protocol YMButtonViewDelegate <NSObject>

@optional
- (UIImage *)noImage;
- (UIImage *)loadingImage;
- (void)didFinishLoadImage:(YMButtonView *)imageView;
- (void)didFailedLoadImage:(YMButtonView *)imageView;

@end
@interface YMButtonView : UIButton <ASIHTTPRequestDelegate> {
    ASIHTTPRequest *photoRequest;
}
@property (nonatomic, assign) id<YMButtonViewDelegate> delegate;


- (void)setImageUrl:(NSString *)url;

@end