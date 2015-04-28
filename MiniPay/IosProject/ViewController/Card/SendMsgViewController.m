//
//  SendMsgViewController.m
//  MiniPay
//
//  Created by apple on 14-5-13.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "SendMsgViewController.h"

@interface SendMsgViewController ()

@end

@implementation SendMsgViewController

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
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)hideview:(id)sender{
    
    if(_hidViewBlock)
        _hidViewBlock();
}


-(IBAction)hideKeyBoard:(id)sender{
    
    [self.textField resignFirstResponder];
}
#pragma mark //controller 展示方式
-(void)showControllerByAddSubView:(UIViewController *)vc animated:(BOOL)animated
{
    if(![self.view isDescendantOfView:vc.view])
    {
        [vc.view addSubview:self.view];
    }
    
    if(animated)
    {
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:vc.view cache:YES];
        
        [UIView commitAnimations];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"5.0"] == NSOrderedAscending)
    {
        [self viewWillAppear:YES];
    }
    
}

-(IBAction)okbtn:(id)sender
{
    
    if(_okBlock)
        _okBlock(_textField.text);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
