//
//  ClearingListCell.m
//  MiniPay
//
//  Created by allen on 13-11-19.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "ClearingListCell.h"
#import "ValueUtils.h"

@implementation ClearingListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setData:(Response_199009_Model *)data{
    NSString *date=[NSString stringWithFormat:@"%@    %@",[ValueUtils formatDateString0:data.TXNSTRDT],[ValueUtils getWeekDay:data.TXNSTRDT]];
    [_dateLabel setText:date];
    [_inDateLabel setText:[ValueUtils formatDateString0:data.STLDT]];
    //[_stateLabel setText:@""];
    [_moneyLabel setText:[NSString stringWithFormat:@"￥%@",data.TOTTXNAMT]];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
