//
//  BMFlowerViewController.h
//  MiniPay
//
//  Created by apple on 14-7-26.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMFlowerViewController : YMTradeBaseController
{
  NSArray* reversedArray;
}
-(IBAction)findfordate:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *datetext;
-(IBAction)hideKeyBoard:(id)sender;
@property(nonatomic,strong) NSMutableArray *array1;
@property (nonatomic,assign) int bm_Type;
@property(nonatomic,strong) NSMutableArray *array;

@end
