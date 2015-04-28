//
//  AppDelegate.m
//  IosProject
//
//  Created by apple on 13-7-29.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "SlotCardViewController.h"
#import "FlowViewController.h"
#import "MerchantIndexViewController.h"
#import "ToolIndexViewController.h"
#import "AESUtil.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import "UINavigationBar+CustomNavImage.h"
#import "FeeBackViewController.h"
#import "APService.h"


@implementation AppDelegate

-(void)regestpush:(NSDictionary*)launchOptions
{
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
    
    [self.window makeKeyAndVisible];
    
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    [APService setupWithOption:launchOptions];
    
    //[APService setTags:[NSSet setWithObjects:@"tag1", @"tag2", @"tag3", nil] alias:@"别名"];
    
    [APService setTags:[NSSet setWithObjects:@"tag4",@"tag5",@"tag6",nil] alias:@"别名" callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //向微信注册
    switch ([DataManager sharedDataManager].postype_Vison) {
        case wfb:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:0];
            // [WXApi registerApp:cyhwEIXINKey];
            
            
            break;
            
        case cyh:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:1];
           // [WXApi registerApp:cyhwEIXINKey];

            
            break;
        case xft:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:2];
            //  [WXApi registerApp:cyhwEIXINKey];
            
            break;
        case hf:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:3];
            //  [WXApi registerApp:cyhwEIXINKey];
            break;
        case hfb:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:4];
            //  [WXApi registerApp:cyhwEIXINKey];
            break;
        case mf:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:5];
            //  [WXApi registerApp:cyhwEIXINKey];
            
            
            break;
        case lxzf:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:6];
            //  [WXApi registerApp:cyhwEIXINKey];
            
            
            break;
        case nzf:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:7];
            
            
            break;
        case yf:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:8];
            
            
            break;
        case hxzf:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:9];
            
            
            break;
        case wbht:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:10];
            
            
            break;
        case hxsn:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:11];
            
            
            break;
        case ipos:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:12];
            
            
            break;
        case yft:
            [DataManager sharedDataManager].seetingdict = [[self loadsetarry] objectAtIndex:13];
            
            
            break;

        default:
            break;
    }
    
    if([DataManager sharedDataManager].postype_Vison!=wfb)
    {
        [WXApi registerApp:[[DataManager sharedDataManager].seetingdict objectForKey:@"wxappId"]];

    }
    else
    {
        [WXApi registerApp:wEIXINKey];

    }
    
    
    //向微博注册
    [WeiboSDK registerApp:kAppKey];

    LoadingViewController *loadingViewController = [[LoadingViewController alloc] initWithNibName:nil bundle:nil];
    loadingViewController.window=self.window;
    
    self.window.rootViewController = loadingViewController;
    [self.window makeKeyAndVisible];
     [self regestpush:launchOptions];
    return YES;
}

-(NSArray*)loadsetarry
{
    NSError * error = nil;
    NSString* menuConfigPath = [CommonUtil fileResourceDir:@"setting_menu.json"];
    NSString * menuData = [NSString stringWithContentsOfFile:menuConfigPath encoding:NSUTF8StringEncoding error:&error];
    
    // NSData *response = [NSURLConnection sendSynchronousRequest:menuData returningResponse:nil error:nil];
    NSData* data = [menuData dataUsingEncoding:NSUTF32LittleEndianStringEncoding];
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSArray *arry = [weatherDic objectForKey:@"messageinfo"];
    return  arry;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
      [application setApplicationIconBadgeNumber:0];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
    
}

-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    
}




- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
}

//avoid compile error for sdk under 7.0
#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}
#endif


#pragma mark -

- (void)networkDidSetup:(NSNotification *)notification {
    // [_infoLabel setText:@"已连接"];
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    //  [_infoLabel setText:@"未连接。。。"];
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    //  [_infoLabel setText:@"已注册"];
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    //  [_infoLabel setText:@"已登录"];
    NSLog(@"已登录");
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    //    [_infoLabel setText:[NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content]];
    
    //[dateFormatter release];
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}


@end
