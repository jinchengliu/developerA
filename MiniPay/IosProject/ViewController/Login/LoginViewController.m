//
//  LoginViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "LoginViewController.h"
#import "GDataXMLNode.h"
#import "RootViewController.h"
#import "CommonUtil.h"
#import <QuartzCore/QuartzCore.h>
#import "SelectionCell.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "NewAccountViewController.h"

//#import "SignaturViewController.h"


#define cyhloginbj [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:218.0/255.0 alpha:1.0]
#define xftloginbj [UIColor colorWithRed:239.0/255.0 green:220.0/255.0 blue:226.0/255.0 alpha:1.0]
#define hfloginbj [UIColor colorWithRed:148.0/255.0 green:168.0/255.0 blue:57.0/255.0 alpha:1.0]

#define cyhlognbtnbj [UIColor colorWithRed:234.0/255.0 green:83.0/255.0 blue:3.0/255.0 alpha:1.0]
@interface LoginViewController ()
{
}

@end

@implementation LoginViewController
@synthesize switchButton,IsdispaySwitch,lable;
@synthesize tb=_tb;
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
    
    _userNameTextView.text=[_dataManager GetObjectWithNSUserDefaults:PHONENUMBER];
    
    self.title=@"登陆";
    
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    _passwordTextView.delegate=self;
}


//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (IBAction)changeOpenStatus:(id)sender {
    
    if (isOpened) {
        
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"dropdown.png"];
            [_openButton setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=_tb.frame;
            
            frame.size.height=1;
            [_tb setFrame:frame];
            
        } completion:^(BOOL finished){
            
            isOpened=NO;
        }];
    }else{
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"dropup.png"];
            [_openButton setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=_tb.frame;
            
            frame.size.height=120;
            [_tb setFrame:frame];
        } completion:^(BOOL finished){
            
            isOpened=YES;
        }];
        
        
    }
    
}



//转向修改密码的页面
-(IBAction)goToForgetPwd:(id)sender{
    UINavigationController *nav;
    if(sender==self.getPwdBtn)
    {
    ForgetPwdViewController *forgetPwd=[[ForgetPwdViewController alloc] init];
     nav=[[UINavigationController alloc] initWithRootViewController:forgetPwd];
    }
    else{
        NewAccountViewController *newAccountViewController=[[NewAccountViewController alloc] init];
        nav=[[UINavigationController alloc] initWithRootViewController:newAccountViewController];

    
    }
    if(kSystemVersion>=7.0)
    {
        [nav.navigationBar setNavigationBarBackgroundImageName:kImage_NavigationBarBg7];
    }else{
        [nav.navigationBar setNavigationBarBackgroundImageName:kImage_NavigationBarBg];
    }
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
    

    
}







-(IBAction)loginBtn:(id)sender{
    
    [CommonUtil tapAnimationWithView:(UIButton*)sender];
    
//        pwdAllertViewController = [[PwdAllertViewController alloc] initWithNibName:@"PwdAllertViewController" bundle:nil];
//    pwdAllertViewController.hidViewBlock=^(void){
//        [pwdAllertViewController.view removeFromSuperview];
//        pwdAllertViewController=nil;
//    };
//    pwdAllertViewController.okBlock=^(NSString*str)
//    {
//       
//    };
//   // [self presentViewController:pwdAllertViewController animated:YES completion:nil];
//    [pwdAllertViewController showControllerByAddSubView:self animated:NO];
//        return;
    

    
   //    UINavigationController *nav;
//    SignaturViewController *signaturViewController=[[SignaturViewController alloc] init];
//    nav=[[UINavigationController alloc] initWithRootViewController:signaturViewController];
//    
//    
//    
//    if(kSystemVersion>=7.0)
//    {
//        [nav.navigationBar setNavigationBarBackgroundImageName:kImage_NavigationBarBg7];
//    }else{
//        [nav.navigationBar setNavigationBarBackgroundImageName:kImage_NavigationBarBg];
//    }
//    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:nav animated:YES completion:nil];
//    
//    return;

    NSString *userName=self.userNameTextView.text;
    NSString *pwd=self.passwordTextView.text;
    
    if([userName isEqualToString:@""]){
        [self showAlert:@"请输入用户名"];
    }else if([pwd isEqualToString:@""]){
        [self showAlert:@"请输入密码"];
    }else{
        
        [self showWaiting:nil];
        
        NSMutableArray *array=[[NSMutableArray alloc] init];
        [array addObject:@"TRANCODE"];
        [array addObject:LOGIN_CMD_199002];
        [array addObject:@"PHONENUMBER"];
        [array addObject:userName];
        [array addObject:@"PASSWORD"];
        [array addObject:pwd];
        [array addObject:@"PCSIM"];
        [array addObject:@"获取不到"];
        NSString *paramXml=[CommonUtil createXml:array];
        NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
        [array addObject:@"PACKAGEMAC"];
        [array addObject:PACKAGEMAC];
        NSString *params=[CommonUtil createXml:array];
        _controlCentral.requestController=self;
        [_controlCentral requestDataWithJYM:LOGIN_CMD_199002
                                 parameters:params
                         isShowErrorMessage:NO_TRADE_URL_TYPE
                                 completion:^(id result, NSError *requestError, NSError *parserError) {
                                     
                                     [self hideWaiting];
                                     if (result)
                                     {
                                         GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                         [self parseXml:rootElement];
                                         
                                     }
                                 }];

        
        
        
    }
    
    
}

//解析xml
-(void)parseXml:(GDataXMLElement *)rootElement{
    
    GDataXMLElement *phoneElement = [[rootElement elementsForName:@"PHONENUMBER"] objectAtIndex:0];
    NSString *phoneNumber=[phoneElement stringValue];
    
    GDataXMLElement *mersnmElement = [[rootElement elementsForName:@"MERSNM"] objectAtIndex:0];
    NSString *mersnm=[mersnmElement stringValue];
    
    GDataXMLElement *TERMTYPE = [[rootElement elementsForName:@"TERMTYPE"] objectAtIndex:0];
    NSString *postype=[TERMTYPE stringValue];
    
    GDataXMLElement *termno = [[rootElement elementsForName:@"TERMNO"] objectAtIndex:0];
    NSString *kSN=[termno stringValue];
    _dataManager.TerminalSerialNumber=kSN;

    
    GDataXMLElement *STATUS = [[rootElement elementsForName:@"STATUS"] objectAtIndex:0];
    //NSString *stu=[STATUS stringValue];
    _dataManager.ShanghuStus=[STATUS stringValue];

    
    if([postype isEqualToString:@"VPOS"])
    {
        //devicetype = [NSString stringWithFormat:@"%d",Vpos];
        [CommonUtil savepostype:[NSString stringWithFormat:@"%d",Vpos]];
        _dataManager.device_Type=Vpos;
    
    }
    
   else if([postype isEqualToString:@"支付通-QPOS"])
    {
        //devicetype = [NSString stringWithFormat:@"%d",Vpos];
        [CommonUtil savepostype:[NSString stringWithFormat:@"%d",Qpos]];
        _dataManager.device_Type=Qpos;
        
    }
   else if([postype isEqualToString:@"QPOS3.0"])
   {
       //devicetype = [NSString stringWithFormat:@"%d",Vpos];
       [CommonUtil savepostype:[NSString stringWithFormat:@"%d",Qpos]];
       _dataManager.device_Type=Qpos_blue;
       
   }
    
   else if([postype isEqualToString:@"D180蓝牙POS"])
   {
       //devicetype = [NSString stringWithFormat:@"%d",Vpos];
       [CommonUtil savepostype:[NSString stringWithFormat:@"%d",D180]];
       _dataManager.device_Type=D180;
       
   }
    
   else if([postype isEqualToString:@"SKTPOS"])
   {
       [self showAlert:@"抱歉当前应用不支持该设备类型！"];
       return;
       //devicetype = [NSString stringWithFormat:@"%d",Vpos];
       [CommonUtil savepostype:[NSString stringWithFormat:@"%d",SKTPOS]];
       _dataManager.device_Type=SKTPOS;
       
   }
   else if([postype isEqualToString:@"BBPOS-刷卡头"])
   {
       
       [self showAlert:@"抱歉当前应用不支持该设备类型！"];
       return;
       //devicetype = [NSString stringWithFormat:@"%d",Vpos];
       [CommonUtil savepostype:[NSString stringWithFormat:@"%d",BPOS]];
       _dataManager.device_Type=BPOS;
       
   }
    else
    {
      _dataManager.device_Type=NOpos;
    }

    
    
    _dataManager.isLogin=TRUE;
    [_dataManager SetObjectWithNSUserDefaults:phoneNumber forUsername:PHONENUMBER];
    [_dataManager SetObjectWithNSUserDefaults:mersnm forUsername:MERSNM];
    
    rootViewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
    //转向root页面
    [self gotoRoot];
}

- (void)gotoRoot
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(finishedFading)];
    self.view.alpha = 0.0;
	[UIView commitAnimations];
    [[self systemWindow] insertSubview:rootViewController.view belowSubview:self.view];
}

-(IBAction)hideKeyBoard:(id)sender{
    
    [self hideKeyBorad];
}


-(void)hideKeyBorad{
    
    [self.userNameTextView resignFirstResponder];
    [self.passwordTextView resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self hideKeyBorad];
    
    return YES;
}

- (void)finishedFading
{
    
    [self systemWindow].rootViewController = rootViewController;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
