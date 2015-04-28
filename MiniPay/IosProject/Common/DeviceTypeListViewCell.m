//
//  DeviceTypeListViewCell.m
//  MiniPay
//
//  Created by apple on 14-7-29.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "DeviceTypeListViewCell.h"
#import "UIImageView+WebCache.h"

@interface DeviceTypeListViewCell ()
{
 BOOL    isSelected;
}

@end

@implementation DeviceTypeListViewCell
//@synthesize lbSubTitle,ivImage,ivSelected;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setIsSelected:(BOOL)selected
{
    isSelected = selected;
    if(isSelected) {
        _ivSelected.highlighted = NO;
    }
    else {
        _ivSelected.highlighted = YES;
    }
}

-(BOOL)getIsSelected
{
    return isSelected;
}
-(void)setData:(NSString *)imgpth andtitle:(NSString*)title andsavedevice:(BOOL)isdevice{
    
    NSURL *url = [NSURL URLWithString:[imgpth stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [_ivImage setImageWithURL:url];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *image = [[UIImage alloc] initWithData:data];
//    
//    [ _ivImage setImage:image];
    _lbSubTitle.text = title;
    [self setIsSelected:isdevice];
}
@end
