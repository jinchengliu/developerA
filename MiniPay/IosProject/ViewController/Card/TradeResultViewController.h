//
//  TradeResultViewController.h
//  MiniPay
//
//  Created by allen on 13-12-16.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeResultViewController : YMTradeBaseController{
    
    
}
@property (weak, nonatomic) IBOutlet UIImageView *resultImg;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property(nonatomic,assign) int type;
-(IBAction)backBtn:(id)sender;

-(IBAction)okbutn:(id)sender;

@property(nonatomic,nonatomic) NSString *Trademoney;
@property(nonatomic,nonatomic) NSString *logno;

@end
