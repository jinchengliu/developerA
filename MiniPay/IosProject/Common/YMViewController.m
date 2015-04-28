//
//  EDViewController.m
//  EDrivel
//
//  Created by chen wang on 11-11-19.
//  Copyright (c) 2011年 bonet365.com. All rights reserved.
//

#import "YMViewController.h"
#import "UIBarButtonItem+CustomItem.h"




@implementation YMViewController
@synthesize sendtitle;
@synthesize titleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
//    if ([self.view window] == nil)
//    {
//        // Add code to preserve data stored in the views that might be
//        // needed later.
//        // Add code to clean up other strong references to the view in
//        // the view hierarchy.
//        self.view = nil;
//    }
    
    // Release any cached data, images, etc that aren't in use.
}




//处理错误码
- (void)parserErrorCode:(NSNotification *)notification {
    
    
    if (notification.object != self) {
        return;
    }
    
    [self hideWaiting];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ErrorCode" ofType:@"plist"];
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSDictionary *dic=(NSDictionary *)notification.userInfo;
    
    //弹出错误消息
    NSString *error=[dic objectForKey:@"RSPCOD"];
     NSString * errorMsg=[dic objectForKey:@"RSPMSG"];
    if(IsNilString(errorMsg)){
         errorMsg=[dictionary objectForKey:error];
        if(IsNilString(errorMsg)){
                       errorMsg=@"操作失败";
             }
    }
//    if(IsNilString(errorMsg)){
//        errorMsg=[dic objectForKey:@"RSPMSG"];
//        if(IsNilString(errorMsg)){
//            errorMsg=@"操作失败";
//        }
//    }
    [self showAlert:errorMsg];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //解决ios7下导航栏遮挡问题
    if(kSystemVersion>=7.0){
        self.navigationController.navigationBar.translucent = NO;
        self.tabBarController.tabBar.translucent = NO;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parserErrorCode:) name:PARSE_ERROR object:nil];
    
    _dataManager = [DataManager sharedDataManager];
    _controlCentral = [ControlCentral sharedInstance];
    _httpManager = [HttpManager sharedHttpManager];
    
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backToRoot:(id)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)showSplash:(NSString *)text delegate:(id<MBProgressHUDDelegate>)delegate tag:(NSInteger)tag {
    [self showSplash:text detailText:nil delegate:delegate tag:tag];
}

- (void)showSplash:(NSString *)text detailText:(NSString *)detailText delegate:(id<MBProgressHUDDelegate>)delegate tag:(NSInteger)tag {
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.tag = tag;
    hud.delegate = delegate;
    hud.labelText = text;
    hud.detailsLabelText = detailText;
    //hud.mode = MBProgressHUDModeNone;
    [hud show:YES];  
    [hud hide:YES afterDelay:2];
}

- (void)showSplash:(NSString *)text {
    [self showSplash:text delegate:nil tag:0];
}

- (void)showSplash:(NSString *)text detailText:(NSString *)detailText {
    [self showSplash:text detailText:detailText delegate:nil tag:0];
}

- (void)hideSplash:(UIAlertView *)alertView {
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)showWaiting:(NSString *)text withView:(UIView *)view {
    hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide=YES;
    [self.view addSubview:hud];
    hud.labelText = text;
    [hud show:YES];    
}

- (void)showWaiting:(NSString *)text {
    text=IsNilString(text)?@"请稍后…":text;
    [self showWaiting:text withView:self.view];
}

- (void)hideWaiting {
    [hud hide:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.navigationController.viewControllers objectAtIndex:0] != self ) {
       
        [self addNavigationLeftButton];
    }
//    }else{
//        [self addNavigationLeftIcon];
//    }
    //[self addNavigationRightButton];
    [self initNavigationBar];
}

- (void)initNavigationBar
{
    
    
}

-(void)loadWebView:(NSString *)url UIWebView:(UIWebView *)webView{
    
    
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    for (UIView *subView in [webView subviews]) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView *shadowView in [subView subviews]) {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    shadowView.hidden = YES;
                }
            }
        }
    }
    
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:nsurl];
    [webView loadRequest:request];
    
}

-(void)addNavigationLeftIcon{
    
    if (self.tabBarController) {
        self.tabBarController.navigationItem.leftBarButtonItem = nil;
    }
    if (self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    UIImage *image=[UIImage imageNamed:@"nav_icon.png"];
    UIImageView *imageView=[[UIImageView alloc] initWithImage:image];
    imageView.frame=CGRectMake(0, 0, 64, 29);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithCustomView:imageView];
    if (self.tabBarController) {
        self.tabBarController.navigationItem.leftBarButtonItem = item;
    }else {
        self.navigationItem.leftBarButtonItem = item;
    }
    self.navigationItem.leftBarButtonItem = item;
    
    
    
}


-(void)setpageTitle:(NSString *)title
{

     if(kSystemVersion>=7.0)
     {
       UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
       [customLab setTextColor:[UIColor whiteColor]];
       [customLab setText:title];
        customLab.textAlignment = NSTextAlignmentCenter;
       customLab.font = [UIFont boldSystemFontOfSize:20];
        self.navigationItem.titleView = customLab;
     }
    else
    {
        self.navigationItem.title=title;
    }


}

- (void)addNavigationLeftButton {
    if (self.tabBarController) {
        self.tabBarController.navigationItem.leftBarButtonItem = nil;
    }
    if (self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 10, 20);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"nav_back"]
                          forState:UIControlStateNormal];
    
    [leftButton addTarget:self
                   action:@selector(navigationLeftButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithCustomView:leftButton];
    if (self.tabBarController) {
        self.tabBarController.navigationItem.leftBarButtonItem = item;
    }else {
        self.navigationItem.leftBarButtonItem = item;
    }
    self.navigationItem.leftBarButtonItem = item;
}


- (void)addNavigationRightButton {

    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    lable.textAlignment=UITextAlignmentRight;
    lable.textColor=[UIColor whiteColor];
    lable.font=[UIFont boldSystemFontOfSize:19];
    lable.text=self.title;
    lable.backgroundColor=[UIColor clearColor];
    lable.shadowColor = [UIColor grayColor];
    lable.shadowOffset = CGSizeMake(0, -1.0);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithCustomView:lable];
    if (self.tabBarController) {
        self.tabBarController.navigationItem.rightBarButtonItem = item;
    }else {
        self.navigationItem.rightBarButtonItem = item;
    }
    
    self.navigationItem.rightBarButtonItem = item;
    
    [self.navigationItem.titleView removeFromSuperview];
    
}



-(IBAction)navigationLeftButtonPressed:(id)sender{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)showHudWithTextOnly:(NSString *)text {
    UIWindow *window = [self systemWindow];
    MBProgressHUD *hudProgress = [MBProgressHUD showHUDAddedTo:window animated:YES];
	
	// Configure for text only and offset down
	hudProgress.mode = MBProgressHUDModeText;
    hudProgress.userInteractionEnabled = NO;
	hudProgress.detailsLabelText = text;
	hudProgress.margin = 10.f;
	hudProgress.yOffset = 150.f;
	hudProgress.removeFromSuperViewOnHide = YES;
	[window bringSubviewToFront:hudProgress];
	[hudProgress hide:YES afterDelay:2];
}

-(void)showImageAlert:(NSString *)title content:(NSString *)content type:(NSString *)type{
    
    JKCustomAlert *alert=[[JKCustomAlert alloc]initWithCustomer:title content:content btnType:type];
    [alert show];
}



- (void)showAlert:(NSString *)text {
    
     [self performSelector:@selector(showAlertTime:) withObject:text afterDelay:0.6];
    

}

-(void)showAlertTime:(NSString*)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    
    //  [self showAlert:msg];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - // 获取系统window
- (UIWindow *)systemWindow {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    return window;
}

- (void)addTitleLabel
{
    if (self.titleLabel == nil) {
        self.titleLabel = [ViewFactory newNavLabelWithFrame:CGRectMake(0, 12, 320, 20)
                                                       text:@""
                                                  textColor:[UIColor whiteColor]];
        self.titleLabel.tag = k_tag_nav_bar_label;
        [self.navigationController.navigationBar addSubview:self.titleLabel];
    }
    
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];//如果注册了通知的话。
    #if !__has_feature(objc_arc)
      [super dealloc];
    #endif
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
