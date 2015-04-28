//
//  ForgetPwdViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "ModifyPwdViewController.h"
#import "GDataXMLNode.h"
#import "SetPwdViewController.h"

@interface ForgetPwdViewController ()
{
   int time;
}

@end

@implementation ForgetPwdViewController
@synthesize checkCodeBtoon;
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
   // self.title=@"修改密码";
      [self setpageTitle:@"修改密码"];
    
//    switch (_dataManager.postype_Vison) {
//            
//            
//        case cyh:
//            [self.checkCodeBtoon setTitleColor:cyhbj forState:UIControlStateNormal];
//            break;
//            
//        case xft:
//            [self.checkCodeBtoon setTitleColor:xftbj forState:UIControlStateNormal];
//            
//            break;
//            
//        case hf:
//            [self.checkCodeBtoon setTitleColor:hfbj forState:UIControlStateNormal];
//            
//            break;
//
//            
//        default:
//            break;
//    }

    

}

-(void)cancelClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//获取短信验证码
-(IBAction)getCheckCode:(id)sender{
    
    if(IsNilString(_phoneTextField.text)){
        [self showAlert:@"请输入手机号码"];
    }else if(_phoneTextField.text.length!=11){
        [self showAlert:@"请输入正确的手机号码"];
    }else{
        [self showWaiting:nil];
        [self sendCheckCode];
    }
    
}

//发送短信验证码
-(void)sendCheckCode
{
    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:@"TRANCODE"];
    [array addObject:FEEBACK_CMD_199016];
    
    [array addObject:@"PHONENUMBER"];
    [array addObject:_phoneTextField.text];
    
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:FEEBACK_CMD_199016
                             parameters:params
                     isShowErrorMessage:NO_TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 //[self hideWaiting];
                                 if (!result)
                                 {
                                     [self sendCheckCode1];
                                     return ;
                                 }
                                 else
                                 {
                                     [self hideWaiting];
                                     [self showAlert:@"该用户不存在！"];
                                 
                                 }
                             }];
    
}



//发送短信验证码
-(void)sendCheckCode1
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:@"TRANCODE"];
    [array addObject:SENDCODE_CMD_199018];
    
    [array addObject:@"PHONENUMBER"];
    [array addObject:_phoneTextField.text];
    
    [array addObject:@"TOPHONENUMBER"];
    [array addObject:_phoneTextField.text];
    
    [array addObject:@"TYPE"];
    [array addObject:SEND_MSG_TYPE_FORGETPWD];
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:SENDCODE_CMD_199018
                             parameters:params
                     isShowErrorMessage:NO_TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     [checkCodeBtoon setEnabled:NO];
                                     time=1;
                                     _timeCounter = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startCountBacnkGround) userInfo:nil repeats:YES];
                                     [self showSplash:@"发送成功，请输入收到的短信验证码"];
                                     
                                 }
                             }];
    
}
-(void)startCountBacnkGround
{
    
    
    [checkCodeBtoon setTitle:[NSString stringWithFormat:@"剩余%d秒",time]forState:UIControlStateNormal];
    
    
    if(time>=60)
    {
        if([_timeCounter isValid])
        {   [checkCodeBtoon setTitle:@"获取验证码"forState:UIControlStateNormal];
            [checkCodeBtoon setEnabled:YES];
            [_timeCounter invalidate];
        }
        
    }
    time++;
    
}

//下一步
-(IBAction)nextBtn:(id)sender{
    
    if(IsNilString(_checkCodeTextField.text)){
        [self showAlert:@"请输入短信验证码"];
    }else{
        [_httpManager showHudProgress];
        [self getNewPwd];
    }
    
}

//修改密码，获取原始密码
-(void)getNewPwd
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:@"TRANCODE"];
    [array addObject:BEGIN_MODIFYPWD_CMD_199019];
    
    [array addObject:@"PHONENUMBER"];
    [array addObject:_phoneTextField.text];
    
    [array addObject:@"CHECKCODE"];
    [array addObject:_checkCodeTextField.text];

    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:BEGIN_MODIFYPWD_CMD_199019
                             parameters:params
                     isShowErrorMessage:NO_TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [_httpManager hideHudProgress];
                                 if (result)
                                 {
//                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
//                                     GDataXMLElement *pwdElement = [[rootElement elementsForName:@"NEWPASSWD"] objectAtIndex:0];
//                                     oldPwd=[pwdElement stringValue];
//                                     //转向修改密码的页面
//                                     ModifyPwdViewController *modify=[[ModifyPwdViewController alloc] init];
//                                     modify.isForgetPwd=TRUE;
//                                     modify.password=oldPwd;
//                                     modify.phoneNumber=_phoneTextField.text;
                                     
                                     SetPwdViewController *setPwdViewController=[[SetPwdViewController alloc] init];
                                     setPwdViewController.phone=_phoneTextField.text;
                                     [self.navigationController pushViewController:setPwdViewController animated:YES];
                                     
                                     
                                 }
                             }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 10, 20);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"nav_back"]
                          forState:UIControlStateNormal];
    
    [leftButton addTarget:self
                   action:@selector(cancelClick)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
    
    
    
}


-(IBAction)hideKeyBoard:(id)sender{
    
    [self hiddenKeyboard];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [self hiddenKeyboard];
    
    return YES;
}


-(void)hiddenKeyboard{
    
    [_phoneTextField resignFirstResponder];
    [_checkCodeTextField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
