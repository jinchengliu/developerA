//
//  NewFeatureViewController.m
//  CQRCBank_iPhone
//
//  Created by Channing.Hu on 13-4-3.
//  Copyright (c) 2013年 magic-point. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "DataManager.h"
#define IMGNUMBER 3

#define cyhanniubeijing [UIColor colorWithRed:234.0/255.0 green:83.0/255.0 blue:3.0/255.0 alpha:1.0]

@interface NewFeatureViewController ()

@end


@implementation NewFeatureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        pages = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, k_frame_base_width, k_frame_base_height)];
        pages.delegate = self;
        pages.bounces = NO;
        pages.showsHorizontalScrollIndicator = NO;
        pages.showsVerticalScrollIndicator = NO;
        pages.pagingEnabled = YES;
        pages.backgroundColor = [UIColor clearColor];
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(k_frame_base_width / 2 - 30, k_frame_base_height - 60, 60, 36)];
        pageControl.currentPage = 0;
        pageControl.numberOfPages = 5;
        [self.view addSubview:pages];
        //[self.view addSubview:pageControl];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    rootViewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
    loginViewController = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    UIImage *image;
    for(int i=0; i<=IMGNUMBER; i++) {
            image=[UIImage imageNamed:[NSString stringWithFormat:@"guide%d.jpg", i+1]];
        if(kIsIphone5){
            image=[UIImage imageNamed:[NSString stringWithFormat:@"guide%d-568h.jpg", i+1]];
        }
       
        UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
        CGRect rect = CGRectMake(0, 0, k_frame_base_width, image.size.height);
        rect.origin.x = k_frame_base_width * i;
        imgView.frame = rect;
        [pages addSubview:imgView];
    }
    pages.contentSize = CGSizeMake(k_frame_base_width * IMGNUMBER, image.size.height);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(k_frame_base_width * (IMGNUMBER-1)+116, k_frame_base_height-118, 106, 106);
    if(kIsIphone5){
        button.frame = CGRectMake(k_frame_base_width * (IMGNUMBER-1)+116, k_frame_base_height-160, 106, 106);
    }
    [button setTitle:@"进入体验" forState:UIControlStateNormal];
    button.titleLabel.textColor=[UIColor whiteColor];
    button.titleLabel.backgroundColor=[UIColor clearColor];
    button.titleLabel.font=[UIFont systemFontOfSize:14];
//    if([DataManager sharedDataManager].postype_Vison==cyh)
//    {
//        [button setBackgroundColor:cyhanniubeijing];
//    }
//    else
    {
     [button setBackgroundImage:[UIImage imageNamed:@"loginbutn.png"] forState:UIControlStateNormal];
     [button setBackgroundImage:[UIImage imageNamed:@"loginbutnpassed.png"] forState:UIControlStateHighlighted];
    }
    
    [button addTarget:self action:@selector(gotoLogin:) forControlEvents:UIControlEventTouchUpInside];
    [pages addSubview:button];
}

- (void)gotoLogin:(id)sender
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(finishedFading)];
    self.view.alpha = 0.0;
	[UIView commitAnimations];
    if(_dataManager.isLogin)
        [[self systemWindow] insertSubview:rootViewController.view belowSubview:self.view];
    else
        [[self systemWindow] insertSubview:loginViewController.view belowSubview:self.view];
}

- (void)finishedFading
{
    if(_dataManager.isLogin)
        [self systemWindow].rootViewController = rootViewController;
    else
        [self systemWindow].rootViewController = loginViewController;
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  //  pageControl.currentPage = scrollView.contentOffset.x / k_frame_base_width;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
