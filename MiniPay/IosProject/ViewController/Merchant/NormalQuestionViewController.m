//
//  NormalQuestionViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//常见问题
#import "NormalQuestionViewController.h"

@interface NormalQuestionViewController ()
@end
@implementation NormalQuestionViewController

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
    switch (_url_type) {
        case zhuce:
            [self loadWebView:[NSString stringWithFormat:@"%@%@",NO_TRADE_BASE_URL,NOTICE_ZHUCE_URL] UIWebView:self.webView];
            [self setpageTitle:@"帮助"];
            break;
        case shuaka:
            [self loadWebView:[NSString stringWithFormat:[NSString stringWithFormat:@"%@%@",NO_TRADE_BASE_URL,NOTICE_SHUAKA_URL],phonerNumber] UIWebView:self.webView];
            [self setpageTitle:@"帮助"];
            
            break;
        case chongzhi:
            [self loadWebView:[NSString stringWithFormat:@"%@%@",NO_TRADE_BASE_URL,NOTICE_CHONGZHI_URL] UIWebView:self.webView];
            [self setpageTitle:@"帮助"];
            break;
        case xinyoongka:
            [self loadWebView:[NSString stringWithFormat:@"%@%@",NO_TRADE_BASE_URL,NOTICE_HUANGKUAN_URL] UIWebView:self.webView];
            [self setpageTitle:@"帮助"];
            
            break;
          case cjwt:
            [self loadWebView:[NSString stringWithFormat:@"%@%@",NO_TRADE_BASE_URL,NORMAL_QUESTION_URL] UIWebView:self.webView];
            [self setpageTitle:@"常见问题"];
            
            break;
        case zhuanzhang:
            [self loadWebView:[NSString stringWithFormat:@"%@%@",NO_TRADE_BASE_URL,NOTICE_ZHUANZHANG_URL] UIWebView:self.webView];
            [self setpageTitle:@"帮助"];
            
            break;
        case tixian:
            [self loadWebView:[NSString stringWithFormat:@"%@%@",NO_TRADE_BASE_URL,NOTICE_TIXIAN_URL] UIWebView:self.webView];
            [self setpageTitle:@"帮助"];
            
            break;
    }
    
   //    [self loadWebView:[NSString stringWithFormat:[NSString stringWithFormat:@"%@%@",NO_TRADE_BASE_URL,FEE_BACK_URL],@"18321221882"] UIWebView:self.webView];
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
