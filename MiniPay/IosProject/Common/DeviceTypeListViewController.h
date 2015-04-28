//
//  DeviceTypeListViewController.h
//  MiniPay
//
//  Created by apple on 14-7-29.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^OkBlock)(NSString*str);
@interface DeviceTypeListViewController : YMTableViewController
{
// NSArray * AllMenuItems;

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil resorearry:(NSMutableArray*)arry;
@property (strong,retain)OkBlock okBlock;

//@property(nonatomic,strong) NSMutableArray *array;

@end
