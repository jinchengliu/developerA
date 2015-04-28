//
//  LoadingViewController.m
//  CQRCBank_iPhone
//
//  Created by magicmac on 12-12-13.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import "LoadingViewController.h"
#import "GDataXMLNode.h"

@interface LoadingViewController ()
{

    NSString *url;
    //UIAlertView *alert;
}

@end

@implementation LoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect appFrame=self.view.bounds;
	
    UIImage *defaultImage = [UIImage imageNamed:@"Default.png"];
    if (appFrame.size.height > 480) {
        defaultImage = [UIImage imageNamed:@"Default-568h.png"];
    }
    appFrame.size = defaultImage.size;

	UIImageView *imageView=[[UIImageView alloc] initWithImage:defaultImage];
	imageView.frame= appFrame;
    imageView.contentMode = UIViewContentModeScaleToFill;
    self.splashImageView = imageView;

	[self.view addSubview:self.splashImageView];
    
    //正在加载的label
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 385,k_frame_base_width, 30)];
    lable.font=[UIFont systemFontOfSize:17];
    lable.textAlignment=UITextAlignmentCenter;
    lable.backgroundColor = [UIColor clearColor];
    if (appFrame.size.height > 480) {
        CGRect frame=lable.frame;
        frame.origin.y=430;
        lable.frame=frame;
    }
    [self checkVersionUpDate];
    lable.text=@"请稍候，正在为您加载……";
    [self.view addSubview:lable];
    
//    NSString *aa=[AESUtil TripleDES:@"111111" encryptOrDecrypt:kCCEncrypt encryptOrDecryptKey:[ValueUtils md5UpStr:AES_PWD]];
//    NSString*bb=[AESUtil TripleDES:aa encryptOrDecrypt:kCCDecrypt encryptOrDecryptKey:[ValueUtils md5UpStr:AES_PWD]];
    self.showActivityIndicator = YES;
}


-(void)checkVersionUpDate
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    NSString*COMPANYNAME=@"";
    
    NSString*Version;
    switch ([DataManager sharedDataManager].postype_Vison) {
        case wfb:
           COMPANYNAME=@"wfb";
            Version=wfbVersion;
            break;
            
//        case cyh:
//            // _dataManager.seetingdict = [arry objectAtIndex:0];
//            COMPANYNAME=@"cyh";
//           
//            Version=cyhVersion;
//            
//            break;
//        case hfb:
//            // _dataManager.seetingdict = [arry objectAtIndex:0];
//            COMPANYNAME=@"hfb";
//            
//            Version=hfbVersion;
//            
//            break;
//            
//        case xft:
//            COMPANYNAME=@"xbt";
//              Version=xbtVersion;
//
//            // _dataManager.seetingdict = [arry objectAtIndex:1];
//            
//            break;
//            
//        case hf:
//            COMPANYNAME=@"hf";
//            Version=hfVersion;
//
//            break;
//        case lxzf:
//            COMPANYNAME=@"lxzf";
//            Version=lxzfVersion;
//            
//            break;
//        case mf:
//            COMPANYNAME=@"mf";
//            Version=mfVersion;
//            
//            break;
//        case wbht:
//            COMPANYNAME=@"wbht";
//            Version=wbhtVersion;
//            
//            break;
//        case hxsn:
//        COMPANYNAME=@"hxns";
//        Version=hxsnVersion;
//        
//        break;
//        case ipos:
//        COMPANYNAME=@"ipos";
//        Version=iposnVersion;
//        
//        break;


        
        default:
        {
          NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
           NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
            NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
          //NSString*appName =[infoDict objectForKey:@"CFBundleDisplayName"];
            NSString *str=[identifier substringWithRange:NSMakeRange(8,[identifier length]-8)];
            COMPANYNAME=[str substringWithRange:NSMakeRange(0, [str length]-4)];
            Version=versionNum;
        }
            break;
    }
    
    [array addObject:@"TRANCODE"];
    [array addObject:FLOW_CMD_199015];
    [array addObject:@"PHONETYPE"];
    [array addObject:@"IOS"];
    [array addObject:@"COMPANYNAME"];
    [array addObject:COMPANYNAME];
    [array addObject:@"VERSIONCODE"];
    [array addObject:Version];
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    //创建xml字符串
    NSString *params=[CommonUtil createXml:array];
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:FLOW_CMD_199015
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     GDataXMLElement *DOWNLOADURL = [[rootElement elementsForName:@"DOWNLOADURL"] objectAtIndex:0];
                                     GDataXMLElement *VERSIONNUM = [[rootElement elementsForName:@"VERSIONNUM"] objectAtIndex:0];
                                     GDataXMLElement *STATE = [[rootElement elementsForName:@"STATE"] objectAtIndex:0];
                                     url=[DOWNLOADURL stringValue];
                                     if([[STATE stringValue]isEqualToString:@"0"])
                                     {
                                     
                                        alert=[[UIAlertView alloc] initWithTitle:@"更新提示" message:[NSString stringWithFormat:@"当前最新版本为%@是否更新",[VERSIONNUM stringValue]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                         [alert show];
                                    }
                                    else if([[STATE stringValue]isEqualToString:@"1"])
                                     {
                                        alert=[[UIAlertView alloc] initWithTitle:@"更新提示" message:[NSString stringWithFormat:@"当前最新版本为%@请更新",[VERSIONNUM stringValue]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                                         [alert show];
                                     }
                                    else{

                                        [self didFinishedLoading];
                                    }
                                 }
                                 else{
                                     [self didFinishedLoading];
                                      return ;
                                 }
                                 return ;
                             }];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex!=alertView.cancelButtonIndex){
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:url]];
          exit(1);
    }
    else
    {
        [self didFinishedLoading];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didFinishedLoading{
    
    self.showActivityIndicator = NO;
    
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    
    NSString *flag = [[DataManager sharedDataManager] GetObjectWithNSUserDefaults:versionNum];
    if([flag isEqualToString:@"0"]) {
         [[UIApplication sharedApplication] setStatusBarHidden:NO];
         //若已登陆
         if(_dataManager.isLogin){
             RootViewController *tabBarController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
             self.rootViewController = tabBarController;
             self.window.rootViewController = self.rootViewController;
         }else{
            LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
            self.window.rootViewController = loginViewController;
         }
    }
    else {
        [[DataManager sharedDataManager] SetObjectWithNSUserDefaults:@"0" forUsername:versionNum];
         NewFeatureViewController *feature = [[NewFeatureViewController alloc] init];
         self.window.rootViewController = feature;
    }
}


@end
