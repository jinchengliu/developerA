//
//  AboutView.m
//  MiniPay
//
//  Created by apple on 14-1-9.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "AboutView.h"

#import <sys/sysctl.h>
@interface AboutView ()
{
    NSString*titlemsg;
}


@end

@implementation AboutView
@synthesize btn_phone=_btn_phone,labl_title=_labl_title,btn_url=_btn_url,btn_weibo=_btn_weibo;
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
    [self setpageTitle:[NSString stringWithFormat:@"关于%@",[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenuTitle]]];
    
   // self.title=[NSString stringWithFormat:@"关于%@",[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenuTitle]];
       _labl_title.text=[NSString stringWithFormat:@"%@－最专业安全的支付工具",[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenuTitle]];
  
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
     NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
   // NSString*appName =[infoDict objectForKey:@"CFBundleDisplayName"];
    
   
    _versionLable.text=[NSString stringWithFormat:@"版本:V%@",versionNum];

       [_btn_url setTitle:[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenuurl] forState:UIControlStateNormal];
       [_btn_phone setTitle:[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenutellphone] forState:UIControlStateNormal];
       [_btn_weibo setTitle:[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenuweibo] forState:UIControlStateNormal];
    _labl_title1.text=[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenuTitle];
    // Do any additional setup after loading the view from its nib.
   if([DataManager sharedDataManager].postype_Vison==yf)
   {
       titlemsg=@"走进翼付V时代";
      _title_lable.text=@"走进翼付V时代:";
       
   }
    else
    {
     titlemsg=@"打开微博";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)CallNumb:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"联系客服" message:[NSString stringWithFormat:@"确定拨打%@",[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenutellphone]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=1001;
    [alert show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex!=alertView.cancelButtonIndex){
        if(alertView.tag==1001)
        {
            
            NSString *str=[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenutellphone];
            
            NSMutableString *phonenumber= [[NSMutableString alloc]initWithString:str];
               NSRange range = NSMakeRange(0, [phonenumber length]);
             [phonenumber replaceOccurrencesOfString:@"-" withString:@"" options:NSCaseInsensitiveSearch range:range];
            [self callPhoneNumber: phonenumber];
            

        }
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",SERVICE_PHONE]]];
        else if(alertView.tag==1002)
        {
            UIApplication *app = [UIApplication sharedApplication];
            [app openURL:[NSURL URLWithString:[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenuurl]]];

        }
        else if(alertView.tag==1003)
        {
            UIApplication *app = [UIApplication sharedApplication];
            [app openURL:[NSURL URLWithString:[[DataManager sharedDataManager].seetingdict objectForKey:kSettingMenuweibo]]];
        }
    }
}

-(IBAction)OpenUrl:(id)sender
{
    //UIButton *btnTmp = (UIButton *)sender;

    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"打开官网" message:@"您确定打开官网"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=1002;
    [alert show];

}

-(IBAction)Openweibo:(id)sender
{
    //UIButton *btnTmp = (UIButton *)sender;
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:titlemsg message:[[NSString alloc] initWithFormat:@"您确定%@",titlemsg] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=1003;
    [alert show];
    
}

-(NSString *)machine {
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *name = malloc(size);
	sysctlbyname("hw.machine", name, &size, NULL, 0);
	NSString *machine = [NSString stringWithCString:name encoding:NSASCIIStringEncoding];
	free(name);
	return machine;
}

-(void)callPhoneNumber:(NSString*)phoneNumber
{
    NSString* machineMode = [self machine];
    if ([machineMode hasPrefix:@"iPhone"])
    {
        NSString *dialURL = [[NSString alloc] initWithFormat:@"tel://%@",phoneNumber];
        //  NSLog(@"dialBtnPressed  URL=%@",dialURL);
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:dialURL]];
        
    }
    else
    {
        [self performSelector:@selector(showdiog) withObject:nil afterDelay:0.3];

    }
}

-(void)showdiog
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备不支持电话功能!" delegate:Nil cancelButtonTitle:Nil otherButtonTitles:@"确定", nil];
    [alert show];
}

@end
