//
//  KoulvCell.h
//  MiniPay
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KoulvCell : UITableViewCell
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lable;
-(void)setData:(NSString*)str;
@end
