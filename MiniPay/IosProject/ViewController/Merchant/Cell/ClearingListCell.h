//
//  ClearingListCell.h
//  MiniPay
//
//  Created by allen on 13-11-19.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Response_199009_Model.h"

@interface ClearingListCell : UITableViewCell


@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dateLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *stateLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *inDateLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *moneyLabel;

-(void)setData:(Response_199009_Model *)data;

@end
