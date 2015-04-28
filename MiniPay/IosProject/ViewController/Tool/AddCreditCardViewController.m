//
//  AddCreditCardViewController.m
//  MiniPay
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "AddCreditCardViewController.h"
#import "GDataXMLNode.h"
@interface AddCreditCardViewController ()

@end

@implementation AddCreditCardViewController
@synthesize delegate=_delegate;
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
    self.title=@"添加信用卡";
    self.textField.delegate=self;
    self.textField1.delegate=self;
    
    [self.doneToolbar setHidden:YES];
        self.textField2.delegate=self;
     self.textField2.inputAccessoryView = self.doneToolbar;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view from its nib.
}

- (void) textFieldDidChange:(UITextField *) TextField
{
    if(TextField.text.length==6)
    {
        [self sendhttp:TextField.text];
    
    }
}


-(void)sendhttp:(NSString*)str
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRANCODE"];
    [array addObject:SIGNATURE_CMD_708010];
    
    [array addObject:@"CRDCTT_B"];
    [array addObject:str];
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:SIGNATURE_CMD_708010
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     GDataXMLElement *ISSNAM = [[rootElement elementsForName:@"ISSNAM"] objectAtIndex:0];
                                     self.banknamelable.text=[ISSNAM stringValue];
                                     
                                 }
                             }];
    
}


-(IBAction)hideKeyBoard:(id)sender{
    
    [self hiddenKeyboard];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
    if(textField==self.textField2)
    {
       // self.datePicker shouldGroupAccessibilityChildren= YES;
    [self.doneToolbar setHidden:NO];
        self.textField2.inputView = self.datePicker;

    }
    
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 28 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    return YES;
}

- (IBAction)selectButton:(id)sender {
    [self.doneToolbar setHidden:YES];
    [self.textField2 endEditing:YES];
    NSDate *select = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     NSString *dateAndTime =  [dateFormatter stringFromDate:select];
    self.textField2.text=dateAndTime;
}

-(void)hiddenKeyboard{
    
    //self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField resignFirstResponder];
    
}

- (IBAction)cleanButton:(id)sender
{
    [self.doneToolbar setHidden:YES];
    
    [self.textField2 endEditing:YES];
    
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
     self.view.frame =CGRectMake(0, kSystemVersion>=7.0?63:0, self.view.frame.size.width, self.view.frame.size.height);
}

- (IBAction)okButton:(id)sender
{
    NSString *errMsg = nil;
    
    if ([CommonUtil strNilOrEmpty:self.textField.text])
    {
        errMsg = @"请输入信用卡卡号!";
        [self.textField becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField1.text])
    {
        errMsg = @"请输入持卡人姓名!";
        [self.textField1 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField2.text])
    {
        errMsg = @"请选择日期!";
        [self.textField2 becomeFirstResponder];
        
    }
    if(![CommonUtil strNilOrEmpty:errMsg])
        [self showAlert:errMsg];
    else
    {
    
         [self showWaiting:@"请稍后…"];
        NSMutableArray *array=[[NSMutableArray alloc] init];
        
        [array addObject:@"TRANCODE"];
        [array addObject:SIGNATURE_CMD_708011];
        
        [array addObject:@"SELLTEL_B"];
        [array addObject:phonerNumber];
        
        [array addObject:@"MER_AC_NO_B"];
        [array addObject:self.textField.text];
        
        
        [array addObject:@"MER_AC_NAME_B"];
        [array addObject:self.textField1.text];
        
        
        [array addObject:@"effective_date_B"];
        [array addObject:self.textField2.text];
        
        NSString *paramXml=[CommonUtil createXml:array];
        NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
        
        [array addObject:@"PACKAGEMAC"];
        [array addObject:PACKAGEMAC];
        
        NSString *params=[CommonUtil createXml:array];
        
        _controlCentral.requestController=self;
        [_controlCentral requestDataWithJYM:SIGNATURE_CMD_708011
                                 parameters:params
                         isShowErrorMessage:TRADE_URL_TYPE
                                 completion:^(id result, NSError *requestError, NSError *parserError) {
                                     
                                     [self hideWaiting];
                                     if (result)
                                     {
                                         if([_delegate respondsToSelector:@selector(refreshData:)]){
                                             [_delegate refreshData:nil];
                                             [self.navigationController popViewControllerAnimated:YES];

                                         }

                                         
                                     }
                                 }];
    
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
