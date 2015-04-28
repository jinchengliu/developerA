//
//  KoulvListViewController.m
//  MiniPay
//
//  Created by apple on 14-6-30.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "KoulvListViewController.h"
#import "KouLvModel.h"
#import "GDataXMLNode.h"
#import "KoulvCell.h"
@interface KoulvListViewController ()
{
    NSString *title_lab;
}

@end

@implementation KoulvListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil title:(NSString *)title
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        title_lab=title;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    KouLvModel *model=[[KouLvModel alloc] init];
//    _array=[[NSMutableArray alloc] init];
//    [self.tableView setHidden:TRUE];
//    [model setUPLMT:@"aa"];
//    [model setIDFID:@"111"];
//    [model setFEERAT:@"fffff"];
//    [_array addObject: model];
      koulvdArray=_array;
     _title_lable.text=title_lab;
    
    _bjview.layer.cornerRadius = 5;
    _bjview.layer.masksToBounds = YES;
    
  //  [self getTermKoulv];
    // Do any additional setup after loading the view from its nib.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  koulvdArray.count;
    //return showString.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellInfo = @"CellInfo";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellInfo];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellInfo];
//    }
//    KouLvModel *model=[koulvdArray objectAtIndex:indexPath.row];
//    cell.textLabel.text=model.IDFCHANNEL;
   //  NSArray *array = [NSArray arrayWithObjects:@"string", nil];
//    cell.textLabel.text =[NSString stringWithFormat:@"%@%%(%@)",model.FEERAT,model.UPLMT.intValue>0?model.UPLMT:@"无封顶"];
    
    static NSString * CellIdentifier = @"KoulvCell";
    UITableViewCell *cell = (UITableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil)
    {
        NSArray *views=[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:nil options:nil];
        cell=[views objectAtIndex:0];
    }
    
    
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    KouLvModel *model=[koulvdArray objectAtIndex:indexPath.row];
    [(KoulvCell *)cell setData:model.IDFCHANNEL];

    
    
    return cell;
}

-(void)reloadData:(NSArray*)arry
{
    koulvdArray=arry;
    [self.tableView reloadData];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     KouLvModel *model=[koulvdArray objectAtIndex:indexPath.row];
    
    if(_tabviewSelectBlock)
        _tabviewSelectBlock(model);
}

-(IBAction)hideview:(id)sender{
    
    if(_hidViewBlock)
        _hidViewBlock();
}


#pragma mark //controller 展示方式
-(void)showControllerByAddSubView:(UIViewController *)vc animated:(BOOL)animated
{
    if(![self.view isDescendantOfView:vc.view])
    {
        [vc.view addSubview:self.view];
    }
    
    if(animated)
    {
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:vc.view cache:YES];
        
        [UIView commitAnimations];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"5.0"] == NSOrderedAscending)
    {
        [self viewWillAppear:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
