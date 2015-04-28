//
//  FeeBackViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//意见反馈
#import "FeeBackViewController.h"

@interface FeeBackViewController ()

@end

@implementation FeeBackViewController

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
    [self setpageTitle:@"意见反馈"];
   // self.title=@"意见反馈";
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CustomTextView" owner:self options:nil];
    textView = [views objectAtIndex:0];
    textView.frame = CGRectMake(8,10, 302, 137);
    [self.view addSubview:textView];
    
    //textView.backgroundColor=[UIColor clearColor];
    
    textView.placeholder = @"请输入您的反馈意见";
    
    NSString *phonerNumber=[_dataManager GetObjectWithNSUserDefaults:PHONENUMBER];
    [self.phoneNumberText setText:phonerNumber];
}

-(IBAction)feeBack:(id)sender{
    
    if([textView.text length]==0){
        
        [self showAlert:@"请输入内容"];
        
    }else if(IsNilString(self.phoneNumberText.text)){
        [self showAlert:@"请输入手机号码"];
    }else if([self.phoneNumberText.text length]!=11){
        [self showAlert:@"请输入正确的手机号码"];
    }else{
        
        [self showWaiting:nil];
        NSString *content=textView.text;
        NSString *phoneNumber=self.phoneNumberText.text;
        
        NSMutableArray *array=[[NSMutableArray alloc] init];
        [array addObject:@"TRANCODE"];
        [array addObject:FEEBACK_CMD_199014];
        
        [array addObject:@"PHONENUMBER"];
        [array addObject:phoneNumber];
        
        [array addObject:@"REFINFO"];
        [array addObject:content];

        [array addObject:@"PACKAGEMAC"];
        [array addObject:[ValueUtils md5UpStr:[CommonUtil createXml:array]]];
        
        NSString *params=[CommonUtil createXml:array];
        
        _controlCentral.requestController=self;
        [_controlCentral requestDataWithJYM:FEEBACK_CMD_199014
                                 parameters:params
                         isShowErrorMessage:NO_TRADE_URL_TYPE
                                 completion:^(id result, NSError *requestError, NSError *parserError) {
                                     
                                     [self hideWaiting];
                                     if (result)
                                     {
                                         textView.text=@"";
                                         [self.phoneNumberText setText:@""];
                                         [self showAlert:@"提交成功"];
                                         
                                     }
                                 }];

        
        
    }
    
}

-(IBAction)hideKeyBord:(id)sender{
    
    [textView resignFirstResponder];

}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.phoneNumberText resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
