//
//  CreditCardCell.h
//  MiniPay
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CreditCardDelagate<NSObject>

-(void)deletecreditcrd:(int)indexRow;

@end
@interface CreditCardCell : UITableViewCell
{
     id<CreditCardDelagate> delegate;
}
@property (weak, nonatomic) id<CreditCardDelagate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *banknameLable;
@property (weak, nonatomic) IBOutlet UILabel *cardNOLable;
@property (weak, nonatomic) IBOutlet UIImageView *cardimage;
@property (weak, nonatomic) IBOutlet UIButton *deletebtn;
-(IBAction)DeleteCreditCardBtn:(id)sender;

@end
