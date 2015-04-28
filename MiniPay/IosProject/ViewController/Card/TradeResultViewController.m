//
//  TradeResultViewController.m
//  MiniPay
//
//  Created by allen on 13-12-16.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "TradeResultViewController.h"
#import "SendMsgViewController.h"
@interface TradeResultViewController ()
{
    SendMsgViewController*sendMsgViewController;
}

@end

@implementation TradeResultViewController
@synthesize Trademoney=_Trademoney;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)addNavigationLeftButton {
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 10, 20);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"nav_back"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(goToHome)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
}


-(void)goToHome{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


-(IBAction)okbutn:(id)sender
{

    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否向持卡人发送电子小票？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发送", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex!=alertView.cancelButtonIndex){
        
        [self sendmsg];
        
    }
    else
    {
     [self backBtn:NULL];
    }
}

-(void)sendmsg
{

    sendMsgViewController = [[SendMsgViewController alloc] initWithNibName:@"SendMsgViewController" bundle:nil];
    // pwdAllertViewController.lableNo.text=maskedPAN;
    sendMsgViewController.hidViewBlock=^(void){
        [sendMsgViewController.view removeFromSuperview];
        sendMsgViewController=nil;
    };
    sendMsgViewController.okBlock=^(NSString*str)
    {
        [self hideAllView];
        [self showWaiting:@""];
        //[self showTrading];
        [sendMsgViewController.view removeFromSuperview];
        sendMsgViewController=nil;
        
        
        NSMutableArray *array=[[NSMutableArray alloc] init];
        
        [array addObject:@"TRANCODE"];
        [array addObject:FLOW_CMD_199037];
        [array addObject:@"PHONENUMBER"];
        [array addObject:str];
        
        //        [array addObject:@"MERCID"];
        //        [array addObject:str];
        
        
        [array addObject:@"LOGNO"];
        [array addObject:_logno];
        
        NSString *paramXml=[CommonUtil createXml:array];
        NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
        
        [array addObject:@"PACKAGEMAC"];
        [array addObject:PACKAGEMAC];
        
        NSString *params=[CommonUtil createXml:array];
        
        _controlCentral.requestController=self;
        [_controlCentral requestDataWithJYM:FLOW_CMD_199037
                                 parameters:params
                         isShowErrorMessage:TRADE_URL_TYPE
                                 completion:^(id result, NSError *requestError, NSError *parserError) {
                                     
                                     [self hideWaiting];
                                     if (result)
                                     {
                                         [self.navigationController popToRootViewControllerAnimated:YES];
                                         
                                         
                                         [self showAlert:@"短信发送成功！"];
                                         //[self parseXml:rootElement];
                                         
                                     }
                                 }];
        
        
        
        
    };
    //   // [self presentViewController:pwdAllertViewController animated:YES completion:nil];
    [sendMsgViewController showControllerByAddSubView:self animated:NO];


}

//返回刷卡界面
-(IBAction)backBtn:(id)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(_type==1)
    {
       [self setpageTitle:@"交易结果"];
      // self.title=@"交易结果";
       [self.moneyLabel setText:[NSString stringWithFormat:@"交易金额：￥%@",_Trademoney]];
    }
    else
    {
        self.title=@"撤销结果";
        [self.moneyLabel setText:[NSString stringWithFormat:@"撤销金额：￥%@",_Trademoney]];
    
    }
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self addNavigationLeftButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
