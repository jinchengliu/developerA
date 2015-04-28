//
//  NoticeCenterViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//通知中心
#import "NoticeCenterViewController.h"

@interface NoticeCenterViewController ()

@end

@implementation NoticeCenterViewController

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
    [self setpageTitle:@"通知中心"];
    //self.title=@"通知中心";
    [self loadWebView:[NSString stringWithFormat:@"%@%@",NO_TRADE_BASE_URL,NOTICE_CENTER_URL] UIWebView:self.webView];
   
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
