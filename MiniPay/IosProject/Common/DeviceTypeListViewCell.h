//
//  DeviceTypeListViewCell.h
//  MiniPay
//
//  Created by apple on 14-7-29.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceTypeListViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel * lbSubTitle;
@property(nonatomic,strong)IBOutlet UIImageView * ivImage;
@property(nonatomic,strong)IBOutlet UIImageView * ivSelected;
-(void)setData:(NSString *)imgpyh andtitle:(NSString*)title andsavedevice:(BOOL)isdevice;
-(void)setIsSelected:(BOOL)isSelected;
-(BOOL)getIsSelected;
@end
