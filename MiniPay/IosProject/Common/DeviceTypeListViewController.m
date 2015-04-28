//
//  DeviceTypeListViewController.m
//  MiniPay
//
//  Created by apple on 14-7-29.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "DeviceTypeListViewController.h"
#import "DeviceTypeListViewCell.h"
#import "divceModel.h"

@interface DeviceTypeListViewController ()
{
    NSArray * scorearry;
    NSString*devicetypeid;
    NSMutableArray* arrayAllThoseIndexPathes;


}

@end

@implementation DeviceTypeListViewController
@synthesize okBlock=_okBlock;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil resorearry:(NSMutableArray*)arry
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        scorearry=arry;//[[arry reverseObjectEnumerator] allObjects];
       //scorearry= [[NSArray alloc] initWithObjects:arry,nil];
       // scorearry =arry;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setpageTitle:@"设备选择"];
    //AllMenuItems=[self loadsetarry];
    devicetypeid=[_dataManager GetObjectWithNSUserDefaults:@"devicelist"];
    arrayAllThoseIndexPathes=[[NSMutableArray alloc]init];
   // AllMenuItems=_array;
    //[_dataManager SetObjectWithNSUserDefaults:phoneNumber forUsername:@"devicelist"];
    // Do any additional setup after loading the view from its nib.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
     return [scorearry count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104.f;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{

    static NSString * CellIdentifier = @"DeviceTypeListViewCell";
    [arrayAllThoseIndexPathes addObject:indexPath];
    UITableViewCell *cell = (UITableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil)
    {
        NSArray *views=[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:nil options:nil];
        cell=[views objectAtIndex:0];
        // [(BMFlowCell *)cell setShow];
    }
    
  //  NSDictionary * itemdict=[_AllMenuItems objectAtIndex:indexPath.row];
    divceModel *model=[scorearry objectAtIndex:indexPath.row];

   // ((DeviceTypeListViewCell *)cell).delegate=self;
    [(DeviceTypeListViewCell *)cell setData:model.PICTURE andtitle:model.TXNCD andsavedevice:[devicetypeid isEqualToString:model.TRMMODNO]];
    
    return cell;

   // tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int row = [indexPath row];
    DeviceTypeListViewCell * cell;
    
    for(int i = 0; i<arrayAllThoseIndexPathes.count; i++)
    {
        if(i!=row)
        {
        cell=(DeviceTypeListViewCell*)[tableView cellForRowAtIndexPath:[arrayAllThoseIndexPathes objectAtIndex:i]];
             [cell setIsSelected:NO];
        }
    
    }
  
    cell = (DeviceTypeListViewCell*)[tableView cellForRowAtIndexPath:indexPath];

    //NSDictionary * dictMenuItem = [AllMenuItems objectAtIndex:row];
   //  NSDictionary * itemdict=[_AllMenuItems objectAtIndex:indexPath.row];
     divceModel *model=[scorearry objectAtIndex:indexPath.row];
   // devicetypeid=[itemdict objectForKey:@"TRMMODNO"];
    devicetypeid=model.TRMMODNO;
  //  [_dataManager GetObjectWithNSUserDefaults:@"devicelist"];
  //  NSString * menuId = [dictMenuItem objectForKey:kUdMenuId];
    
    if([cell getIsSelected]) {
        [cell setIsSelected:NO];
       // [itemsKeyOfSelected setObject:@"NO" forKey:menuId];
    }
    else {
        [cell setIsSelected:YES];
       // [itemsKeyOfSelected setObject:@"YES" forKey:menuId];
    }
    
}

-(void)cancelClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 10, 20);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"nav_back"]
                          forState:UIControlStateNormal];
    
    [leftButton addTarget:self
                   action:@selector(cancelClick)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightButton.frame = CGRectMake(0, 0, 50, 20);
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
   // rightButton.titleLabel.textColor=[UIColor whiteColor];
   
//    [rightButton setBackgroundImage:[UIImage imageNamed:@"ic_menu_save"]
//                           forState:UIControlStateNormal];
    
    [rightButton addTarget:self
                    action:@selector(savedivce)
          forControlEvents:UIControlEventTouchUpInside];
    
    item = [[UIBarButtonItem alloc]
            initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item;

}

-(void)savedivce
{
    [_dataManager SetObjectWithNSUserDefaults:devicetypeid forUsername:@"devicelist"];
    
    if([devicetypeid isEqualToString:@"VPOS"])
    {
        _dataManager.device_Type=Vpos;
    }
    else if([devicetypeid isEqualToString:@"支付通-QPOS"])
    {
        _dataManager.device_Type=Qpos;
    }
    else if([devicetypeid isEqualToString:@"QPOS3.0"])
    {
        _dataManager.device_Type=Qpos_blue;
    }
    
    else if([devicetypeid isEqualToString:@"D180蓝牙POS"])
    {
        _dataManager.device_Type=D180;
    }
    
    

//    else if([devicetypeid isEqualToString:@"XPOS"])
//    {
//        _dataManager.device_Type=XPOS;
//    }
    if(_okBlock)
        _okBlock(devicetypeid);
    [self cancelClick];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
