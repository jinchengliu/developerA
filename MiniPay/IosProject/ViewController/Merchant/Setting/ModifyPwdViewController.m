//
//  ModifyPwdViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//修改密码
#import "ModifyPwdViewController.h"
#import "GDataXMLNode.h"

@interface ModifyPwdViewController ()

@end

@implementation ModifyPwdViewController

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
    self.tableView.tableFooterView=_topView;
    //是来自忘记密码
    if(_isForgetPwd){
        _oldTextView.text=_password;
        [_oldTextView setEnabled:FALSE];
        phone=_phoneNumber;
        
    }else{
        phone=[_dataManager GetObjectWithNSUserDefaults:PHONENUMBER];
    }
   
}

-(IBAction)btnClick:(id)sender{
    
    if(IsNilString(_oldTextView.text) && !_isForgetPwd){
        [self showAlert:@"请输入当前密码"];
    }else if(IsNilString(_ortherTextView.text)){
        [self showAlert:@"请输入新密码"];
    }else if(_ortherTextView.text.length<6){
        [self showAlert:@"请输入高于6位新密码"];
    }else if(IsNilString(_confirmPwdTextView.text)){
        [self showAlert:@"请输入确认密码"];
    }else if(![_ortherTextView.text isEqualToString:_confirmPwdTextView.text]){
        [self showAlert:@"两次输入密码不一致"];
    }else{
        [_httpManager showHudProgress];
        
        NSMutableArray *array=[[NSMutableArray alloc] init];
        
        [array addObject:@"TRANCODE"];
        [array addObject:MODIFYPWD_CMD_199003];
        [array addObject:@"PHONENUMBER"];
        [array addObject:phone];
        
        [array addObject:@"PASSWORD"];
        [array addObject:_oldTextView.text];

        [array addObject:@"PASSWORDNEW"];
        [array addObject:_ortherTextView.text];

        
        NSString *paramXml=[CommonUtil createXml:array];
        NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
        
        [array addObject:@"PACKAGEMAC"];
        [array addObject:PACKAGEMAC];
        
        NSString *params=[CommonUtil createXml:array];
        
         _controlCentral.requestController=self;
        [_controlCentral requestDataWithJYM:MODIFYPWD_CMD_199003
                                 parameters:params
                         isShowErrorMessage:NO_TRADE_URL_TYPE
                                 completion:^(id result, NSError *requestError, NSError *parserError) {
                                      [_httpManager hideHudProgress];
                                     [self hideWaiting];
                                     if (result)
                                     {
                                         [_oldTextView setText:@""];
                                         [_ortherTextView setText:@""];
                                         [_confirmPwdTextView setText:@""];
                                         [self showAlert:@"密码修改成功"];
                                          [self.navigationController popViewControllerAnimated:YES];
                                     }
                                 }];

    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
   
    [self hiddenKeyboard];

    return YES;
}




-(void)hiddenKeyboard{
    
    [_oldTextView resignFirstResponder];
    [_ortherTextView resignFirstResponder];
    [_confirmPwdTextView resignFirstResponder];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        return 73.f;
    }else if(indexPath.row==1){
        return 116.f;
    }else if(indexPath.row==2){
        return 80.f;
    }
    return 44.f;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    if(indexPath.row==0){
        return self.oldPwdCell;
    }else if(indexPath.row==1){
        return self.ortherPwdCell;
    }else{
        return self.confirmPwdCell;
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
