//
//  FeeBackListViewController.m
//  MiniPay
//
//  Created by allen on 13-11-19.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "FeeBackListViewController.h"

@interface FeeBackListViewController ()

@end

@implementation FeeBackListViewController

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
    self.title=@"意见反馈";
    [self loadWebView:[NSString stringWithFormat:[NSString stringWithFormat:@"%@%@",NO_TRADE_BASE_URL,FEE_BACK_URL],@"18321221882"] UIWebView:self.webView];
    
}


//转向意见反馈页面
//-(IBAction)goToFeeBack:(id)sender{
//    
//    FeeBackViewController *fee=[[FeeBackViewController alloc] init];
//    [self.navigationController pushViewController:fee animated:YES];
//    
//}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
