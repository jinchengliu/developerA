//
//  ViewController.m
//  IosProject
//
//  Created by apple on 13-7-29.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "ViewController.h"
#import "AboveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    AboveView *aboveView=[[AboveView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrame.size.width, kScreenFrame.size.height)];
    [self.view addSubview:aboveView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
