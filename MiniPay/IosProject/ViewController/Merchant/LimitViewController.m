//
//  LimitViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//临时调额
#import "LimitViewController.h"

@interface LimitViewController ()

@end

@implementation LimitViewController
@synthesize myLable;
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
    [self setpageTitle:@"临时调额"];
   // self.title=@"临时调额";
    if([DataManager sharedDataManager].postype_Vison!=wfb)
    {
         NSString *str=[[DataManager sharedDataManager].seetingdict objectForKey:@"lstp"];
         myLable.text=str;
    }
   
    
}


-(IBAction)btnClick:(id)sender{
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
