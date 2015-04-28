//
//  MoreSettingViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//更多设置
#import "MoreSettingViewController.h"
#import "ModifyPwdViewController.h"
#import "AboutUsViewController.h"
#import "FeeBackListViewController.h"
#import "AboutView.h"

@interface MoreSettingViewController ()

@end

@implementation MoreSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setpageTitle:@"更多设置"];
    //self.title=@"更多设置";
    //self.tableView.tableHeaderView=_topView;
    self.tableView.tableFooterView=_bottomView;
    // Do any additional setup after loading the view from its nib.
}


-(IBAction)logOut:(id)sender{
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex!=alertView.cancelButtonIndex){
        
        _dataManager.isLogin=FALSE;
//        [_dataManager RemoveObjectWithNSUserDefaults:PHONENUMBER];
//        [_dataManager RemoveObjectWithNSUserDefaults:MERSNM];
        [self performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.6];

    }
}


- (void)gotoLogin
{
    
    exit(1);
    
//    loginViewController=[[LoginViewController alloc] initWithNibName:Nil bundle:nil];
//    
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    [UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:0.3];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(finishedFading)];
//    self.view.alpha = 0.0;
//	[UIView commitAnimations];
//    
//    [[self systemWindow] insertSubview:loginViewController.view belowSubview:self.view];
}

- (void)finishedFading
{
   
    [self systemWindow].rootViewController = loginViewController;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    static NSString * CellIdentifier = @"MoreSettingCell";
    
    UITableViewCell *cell = (UITableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(indexPath.row==0){
        cell.textLabel.text=@"修改密码";
    }else if(indexPath.row==1){
         if([DataManager sharedDataManager].postype_Vison!=wfb)
         {
             cell.textLabel.text=[NSString stringWithFormat:@"关于%@",[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenuTitle]];
         }
        else
            cell.textLabel.text=@"关于微付宝";
        
    }else{
        cell.textLabel.text=@"意见反馈";
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor=[UIColor whiteColor];
    UIView *view=[[UIView alloc] initWithFrame:cell.frame];
    
    
//    switch (_dataManager.postype_Vison) {
//        case wfb:
//            view.backgroundColor=cellBgColor;
//            break;
//            
//        case cyh:
//           view.backgroundColor=cyhbj;
//            break;
//            
//        case xft:
//            view.backgroundColor=xftbj;
//
//            
//            break;
//        case hf:
//            view.backgroundColor=hfbj;
//            
//            
//            break;
//            
//            
//        default:
//            break;
//    }

        cell.selectedBackgroundView=view;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
        ModifyPwdViewController *modifyPwd=[[ModifyPwdViewController alloc] init];
        modifyPwd.hidesBottomBarWhenPushed=YES;

        [self.navigationController pushViewController:modifyPwd animated:YES];
        
    }else if(indexPath.row==1){
        
     //if([DataManager sharedDataManager].postype_Vison!=wfb)
        {
         AboutView *aboutUs1=[[AboutView alloc] init];
            aboutUs1.hidesBottomBarWhenPushed=YES;

         [self.navigationController pushViewController:aboutUs1 animated:YES];
        }
//        else
//        {
//        
//            AboutUsViewController *aboutUs=[[AboutUsViewController alloc] init];
//            [self.navigationController pushViewController:aboutUs animated:YES];
//
//        }
        
    }else{
        FeeBackViewController *feeBack=[[FeeBackViewController alloc] init];
        feeBack.hidesBottomBarWhenPushed=YES;

        [self.navigationController pushViewController:feeBack animated:YES];
        
    }


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
