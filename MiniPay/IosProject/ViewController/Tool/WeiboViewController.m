//
//  WeiboViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//官方微博
#import "WeiboViewController.h"

@interface WeiboViewController ()

@end

@implementation WeiboViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setpageTitle:@"官方微博"];
    //self.title=@"官方微博";
    if([DataManager sharedDataManager].postype_Vison!=wfb)
    {
        NSString *url=[[DataManager sharedDataManager].seetingdict objectForKey:@"weibodenglu"];
        [self loadWebView:url UIWebView:self.webView];

    }
    else
    [self loadWebView:WEIBO_URL UIWebView:self.webView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
