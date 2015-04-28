//
//  TixianViewController.m
//  MiniPay
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "TixianViewController.h"

@interface TixianViewController ()

@end

@implementation TixianViewController
@synthesize Ispttixian, gohomeBlock=_gohomeBlock;;
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
    _jierField.delegate=self;
    _pwdField.delegate=self;
    _jierlabel.text=_jine;
    if(Ispttixian)
    {
        
        [self setpageTitle:@"普通提现"];
        _jierField.placeholder=@"请输入提现金额（T+1到账）";
        _tishiLabel.text=@"单日最低提现不得低于100，最高不得高于100000";
    }
    else
    {
         //self.title=@"快速提现";
        [self setpageTitle:@"快速提现"];
        _jierField.placeholder=@"请输入提现金额（T+0到账）";
        _tishiLabel.text=@"单日最低提现不得低于100，最高不得高于10000";

    }
    // Do any additional setup after loading the view from its nib.
}


-(void)tixian
{
    NSString *errMsg = nil;
    //    if ([CommonUtil strNilOrEmpty:_jierField.text])
    //    {
    //        errMsg = @"请输入金额！";
    //        [_jierField becomeFirstResponder];
    //
    //    }
    if ([_jine intValue]<100)
    {
        errMsg = @"普通提现金额不能低于100！";
        [_jierField becomeFirstResponder];
        
    }
    
   else
       if (!Ispttixian&&[_jine intValue]>10000)
    {
        errMsg = @"快速提现金额不能超过1万！";
        [_jierField becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:_pwdField.text])
    {
        errMsg = @"请输入登录密码!";
        [_pwdField becomeFirstResponder];
        
    }
    if(![CommonUtil strNilOrEmpty:errMsg])
        [self showAlert:errMsg];
    else
    {
        [self showWaiting:@""];
        
        NSMutableArray *array=[[NSMutableArray alloc] init];
        NSString *phonerNumber=[_dataManager GetObjectWithNSUserDefaults:PHONENUMBER];
        [array addObject:@"TRANCODE"];
        [array addObject:MERCHANT_INFO_CMD_199025];
        [array addObject:@"PHONENUMBER"];
        [array addObject:phonerNumber];
        
        [array addObject:@"PAYAMT"];
        [array addObject:_jine];
        
        if(Ispttixian)
        {
            [array addObject:@"PAYTYPE"];
            [array addObject:@"2"];
        }
        else
        {
            [array addObject:@"PAYTYPE"];
            [array addObject:@"1"];
            
        }
        
        [array addObject:@"PASSWORD"];
        [array addObject:_pwdField.text];
        
        [array addObject:@"PAYDATE"];
        [array addObject:[ValueUtils getNowDateTime]];
        
        [array addObject:@"PACKAGEMAC"];
        [array addObject:[ValueUtils md5UpStr:[CommonUtil createXml:array]]];
        
        NSString *params=[CommonUtil createXml:array];
        
        _controlCentral.requestController=self;
        [_controlCentral requestDataWithJYM:MERCHANT_INFO_CMD_199025
                                 parameters:params
                         isShowErrorMessage:TRADE_URL_TYPE
                                 completion:^(id result, NSError *requestError, NSError *parserError) {
                                     
                                     [self hideWaiting];
                                     if (result)
                                     {
                                         [self.navigationController popViewControllerAnimated:YES];
                                         if(_gohomeBlock)
                                             _gohomeBlock();
                                         
                                         
                                     }
                                 }];
    }


}

- (IBAction)sumbit:(id)sender
{
    
    //for(int i=0;i<=10;i++)
        [ self tixian];
}

//当用户按下return键或者按回车键，keyboard消失

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    [self hiddenKeyboard];
    
    return YES;
}


-(void)hiddenKeyboard{
    
    //self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [_jierField resignFirstResponder];
    [_pwdField resignFirstResponder];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
