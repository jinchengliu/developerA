//
//  AddCreditCardCell.h
//  MiniPay
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddCellDelagate<NSObject>

-(void)addCreditCard;

@end
@interface AddCreditCardCell : UITableViewCell
{
    id<AddCellDelagate> delegate;
}
@property (weak, nonatomic) id<AddCellDelagate> delegate;
-(IBAction)AddCreditCardBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addbtn;
@end
