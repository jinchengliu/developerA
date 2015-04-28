//
//  FlowCell.h
//  MiniPay
//
//  Created by allen on 13-11-18.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Response_199008_Model.h"

@protocol FlowCellDelagate <NSObject>

-(void)cellDidBtn:(int)indexRow type:(int)type;

@end

@interface FlowCell : UITableViewCell{
    
    id<FlowCellDelagate> delegate;
    
}
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *cardNoTextView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *moneyTextView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) id<FlowCellDelagate> delegate;


-(void)setData:(Response_199008_Model *)model index:(int)index;

-(void)setShow;


@end
