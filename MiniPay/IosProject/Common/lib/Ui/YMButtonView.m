//
//  YMImageView.m
//  YM
//
//  Created by chen wang on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "YMButtonView.h"
#import "YMRequest.h"
#import "AppDelegate.h"

@implementation YMButtonView
@synthesize delegate;



- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
}

- (void)setImageUrl:(NSString *)url {
    //DLog(@"%@", url);
    if ([url isEqual:[NSNull null]] || url.length == 0) {
        if ([delegate respondsToSelector:@selector(noImage)]) {
            [self setImage:[delegate noImage] forState:UIControlStateNormal];
            if ([delegate respondsToSelector:@selector(didFailedLoadImage:)]) {
                [delegate didFailedLoadImage:self];
            }
        }
        return;
    }
            
    //photoRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[HTTP_PICTURE_SERVER stringByAppendingString:url]]];
    //[photoRequest setDownloadCache:[AppDelegate instance].downloadCache];
    [photoRequest setSecondsToCache:86400];
    [photoRequest setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy ];
    photoRequest.delegate = self;
    [photoRequest startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSData *data = request.responseData;
    if (data) {
        UIImage *image = [UIImage imageWithData:data]; 
        if (image) {
            
            //self.newsdata.appIcon=image;
            self.alpha=0.5;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.1];
            [UIView setAnimationDelegate:self];
            //[UIView setAnimationDidStopSelector:@selector(firstUpEnd)];
            self.alpha=1.0;
            [self setImage:image forState:UIControlStateNormal];
            [UIView commitAnimations];
            
        
            if ([delegate respondsToSelector:@selector(didFinishLoadImage:)]) {
                [delegate didFinishLoadImage:self];
            }
        } else {
            if ([delegate respondsToSelector:@selector(noImage)]) {
                [self setImage:[delegate noImage] forState:UIControlStateNormal];
                
            }
            if ([delegate respondsToSelector:@selector(didFailedLoadImage:)]) {
                [delegate didFailedLoadImage:self];
            }
        }
    } else{
        if ([delegate respondsToSelector:@selector(noImage)]) {
            [self setImage:[delegate noImage] forState:UIControlStateNormal];
        }
        [delegate didFailedLoadImage:self];
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    if ([delegate respondsToSelector:@selector(didFailedLoadImage:)]) {
        [delegate didFailedLoadImage:self];
    }
    
    if ([delegate respondsToSelector:@selector(noImage)]) {
       [self setImage:[delegate noImage] forState:UIControlStateNormal]; 
        
    }
    
}



@end
