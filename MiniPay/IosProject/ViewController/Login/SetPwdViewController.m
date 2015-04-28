//
//  SetPwdViewController.m
//  MiniPay
//
//  Created by apple on 14-6-3.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "SetPwdViewController.h"

@interface SetPwdViewController ()

@end

@implementation SetPwdViewController

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
    [self setpageTitle:@"修改密码"];
   // self.title=@"修改密码";
    _textField.delegate=self;
    _textField1.delegate=self;
    // Do any additional setup after loading the view from its nib.
}
-(void)okbtn:(id)sender
{
 if(IsNilString(_textField.text)){
    [self showAlert:@"请输入新密码"];
 }else if(_textField.text.length<6){
    [self showAlert:@"请输入高于6位新密码"];
 }else if(IsNilString(_textField1.text)){
    [self showAlert:@"请输入确认密码"];
 }else if(![_textField.text isEqualToString:_textField1.text]){
    [self showAlert:@"两次输入密码不一致"];
 }else{
     
     [_httpManager showHudProgress];
     
     NSMutableArray *array=[[NSMutableArray alloc] init];
     
     [array addObject:@"TRANCODE"];
     [array addObject:BEGIN_MODIFYPWD_CMD_199004];
    
     [array addObject:@"phoneNumber"];
     [array addObject:_phone];
     [array addObject:@"PASSWORDNEW"];
     [array addObject:_textField.text];
     
     [array addObject:@"PASSWORDNEW"];
     [array addObject:_textField1.text];
     
     
     NSString *paramXml=[CommonUtil createXml:array];
     NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
     
     [array addObject:@"PACKAGEMAC"];
     [array addObject:PACKAGEMAC];
     
     NSString *params=[CommonUtil createXml:array];
     
     _controlCentral.requestController=self;
     [_controlCentral requestDataWithJYM:BEGIN_MODIFYPWD_CMD_199004
                              parameters:params
                      isShowErrorMessage:NO_TRADE_URL_TYPE
                              completion:^(id result, NSError *requestError, NSError *parserError) {
                                  [_httpManager hideHudProgress];
                                  [self hideWaiting];
                                  if (result)
                                  {
                                     
                                       [self dismissViewControllerAnimated:YES completion:nil];                                  }
                              }];

     
  }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [self hiddenKeyboard];
    
    return YES;
}


-(void)hiddenKeyboard{
    
    [_textField resignFirstResponder];
    [_textField1 resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
