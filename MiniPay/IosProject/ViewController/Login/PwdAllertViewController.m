//
//  PwdAllertViewController.m
//  MiniPay
//
//  Created by apple on 14-5-12.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "PwdAllertViewController.h"

@interface PwdAllertViewController (){
    UIButton *doneButton;
    UIView *view;
    //UITextField * txt;
    NSString*CardNo;
}

@end

@implementation PwdAllertViewController
@synthesize hidViewBlock=_hidViewBlock,okBlock=_okBlock;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil cardNo:(NSString *)cardno
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CardNo=cardno;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lableNo.text=CardNo;
    _textField.delegate=self;
    
    // Do any additional setup after loading the view from its nib.
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

    if(_textField.text.length!=6)
    {
        [self showAlert:@"请输入6位数密码！"];
        self.textField.text=@"";
        [self.textField becomeFirstResponder];
        return;
    }
   
   else if(_okBlock)
    _okBlock(_textField.text);

}

- (void)textFieldChange:(UITextField *)textField
{
    
        if (textField.text.length > 7) {
            textField.text = [textField.text substringToIndex:6];
        }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // return NO to not change text
    //if(strlen([textField.text UTF8String]) >= 10 && range.length != 1)
    if (range.location>=6)
        return NO;
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    CGRect frame = textField.frame;
//    int offset = frame.origin.y + 32 - (_view_pwd.frame.size.height - 216.0);//键盘高度216
//    
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        _view_pwd.frame = CGRectMake(10.0f, -offset, _view_pwd.frame.size.width, _view_pwd.frame.size.height);
//    
//    [UIView commitAnimations];
    
    AFFNumericKeyboard *keyboard = [[AFFNumericKeyboard alloc] initWithFrame:CGRectMake(0, 200, 320, 216)];
    self.textField.inputView = keyboard;
//    [self.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    keyboard.delegate = self;
    return YES;
    
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
   // _view_pwd.frame =CGRectMake(10.0f, 0, _view_pwd.frame.size.width, _view_pwd.frame.size.height);
}

-(IBAction)hideKeyBoard:(id)sender{
    
    [self.textField resignFirstResponder];
}

-(IBAction)hideview:(id)sender{
    
    if(_hidViewBlock)
        _hidViewBlock();
}

-(void)changeKeyboardType
{
    [self.textField resignFirstResponder];
    self.textField.inputView = nil;
    [self.textField becomeFirstResponder];
}

-(void)numberKeyboardBackspace
{
    if (self.textField.text.length != 0)
    {
        self.textField.text = [self.textField.text substringToIndex:self.textField.text.length -1];
    }
}

-(void)numberKeyboardInput:(NSInteger)number
{
    self.textField.text = [self.textField.text stringByAppendingString:[NSString stringWithFormat:@"%d",number]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = doneButton.frame;
        rect.origin.y += 53*5;
        doneButton.frame = rect;
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
