//
//  BMFlowCell.h
//  MiniPay
//
//  Created by apple on 14-7-26.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BMFlowModel;
@interface BMFlowCell : UITableViewCell
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLable;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLable1;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLable2;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLable3;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *coentLable;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *coentLable1;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *coentLable2;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *coentLable3;
-(void)setData:(BMFlowModel *)model index:(int)index flowType:(int)type;
@end
