//
//  KoulvCell.m
//  MiniPay
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "KoulvCell.h"
#import "KouLvModel.h"


@interface KoulvCell ()

@end

@implementation KoulvCell

@synthesize lable=_lable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setData:(NSString*)str{
    _lable.text=str;
    
}

@end
