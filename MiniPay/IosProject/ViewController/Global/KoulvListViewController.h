//
//  KoulvListViewController.h
//  MiniPay
//
//  Created by apple on 14-6-30.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "KouLvModel.h"
@class KouLvModel;
typedef void(^HidViewBlock)();
typedef void(^TabviewSelectBlock)(KouLvModel*model);

@interface KoulvListViewController : YMTableViewController<UITableViewDataSource,UITableViewDelegate>
{

     NSArray* koulvdArray;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil title:(NSString *)title;
@property (strong, nonatomic) IBOutlet UIView *bjview;
@property (strong, nonatomic) IBOutlet UILabel *title_lable;
@property(nonatomic,strong) NSMutableArray *array;
@property (nonatomic,retain)HidViewBlock hidViewBlock;
@property (nonatomic,retain)TabviewSelectBlock tabviewSelectBlock;
-(void)reloadData:(NSArray*)arry;
-(IBAction)hideview:(id)sender;
-(void)showControllerByAddSubView:(UIViewController *)vc animated:(BOOL)animated;

@end
