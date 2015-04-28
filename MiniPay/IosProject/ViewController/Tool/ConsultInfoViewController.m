//
//  ConsultInfoViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//参考信息
#import "ConsultInfoViewController.h"

@interface ConsultInfoViewController ()

@end

@implementation ConsultInfoViewController

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
    //self.title=@"参考信息";
    [self setpageTitle:@"参考信息"];
    [self loadWebView:[NSString stringWithFormat:@"%@%@",NO_TRADE_BASE_URL,CONSULTINFO_URL] UIWebView:self.webView];
}

//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showWaiting:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideWaiting];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
