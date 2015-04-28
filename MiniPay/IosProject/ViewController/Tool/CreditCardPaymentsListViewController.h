//
//  CreditCardPaymentsListViewController.h
//  MiniPay
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCreditCardCell.h"
#import "AddCreditCardViewController.h"
#import "CreditCardCell.h"
@interface CreditCardPaymentsListViewController : YMTradeBaseController<AddCellDelagate,AddFinishDelegate,CreditCardDelagate>
{
     NSArray* creditCardArray;
}
@property BOOL ishavecreditCar;
@property(nonatomic,strong) NSMutableArray *array;
@end
