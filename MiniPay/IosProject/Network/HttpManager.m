//
//  HttpManager.m
//  CQRCBank_iPhone
//
//  Created by magicmac on 12-11-15.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import "HttpManager.h"
#import "ValueUtils.h"
#import "AESUtil.h"


@implementation HttpManager

@synthesize isShowMBHud = _isShowMBHud;

HttpManager *sharedHttpManager = nil;
#pragma mark - 单一实例
+ (HttpManager *)sharedHttpManager
{
    @synchronized(self){  // 防止多线程同事访问
        if(sharedHttpManager == nil) {
            sharedHttpManager = [[HttpManager alloc] init];
        }
        return sharedHttpManager;
	}
}

- (id)init
{
	if((self = [super init])) {
        
        _isShowMBHud = YES;
        
	}
	
	return self;
}



- (void)showHudProgress {
    if (_isShowMBHud == NO) {
        return;
    }
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    
    if (_mbHud == nil) {
        _mbHud = [[MBProgressHUD alloc] initWithView:window];
        _mbHud.removeFromSuperViewOnHide = YES;
        [window addSubview:_mbHud];
        
        _mbHud.labelText = @"请稍候...";
        [_mbHud show:YES];
    }
    
	
}

- (void)hideHudProgress {
    if (_mbHud) {
        [_mbHud removeFromSuperview];
        _mbHud = nil;
    }
    
    if (_isShowMBHud==NO) {
        // 改为NO，及时改为YES。
        _isShowMBHud = YES;
    }
}


#pragma mark - // 当前是否连入3G或wifi。
- (BOOL)isNetWorkUsable {
    // 检查网络状态
    BOOL usable = YES;
	NSString *netType = nil;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
		case NotReachable:
			// 没有网络连接
			netType = @"没有网络连接";
            usable = NO;
			break;
		case ReachableViaWWAN:
			// 使用3G网络
			netType = @"3G";
			break;
		case ReachableViaWiFi:
			// 使用WiFi网络
			netType = @"WiFi";
			break;
    }
	//NSLog(@"netType:%@",netType);
    return usable;
}



#pragma mark - // ************* 普通接口方法 ************************************
#pragma mark - // post 同步 方法
- (ASIHTTPRequest *)postSynchronousNeedSession:(NSString *)param
                    JYM:(NSString *)jym
    isShowErrorMessage:(int)isShowErrorMsg{
    
    
     //进行AES加密
    NSString *params=[AESUtil encrypt:param password:[ValueUtils md5UpStr:AES_PWD]];
    
    
    
    //交易类的
    NSString *urlString =@"";
//    if(isShowErrorMsg==0){
//        urlString=[NSString stringWithFormat:@"%@%@%@.%@",TRADE_BASE_URL,TRADE_URL,jym,TRADE_LAST_URL];
//    }else{
//        urlString=[NSString stringWithFormat:@"%@%@%@.%@",NO_TRADE_BASE_URL,NO_TRADE_URL,jym,NO_TRADE_LAST_URL];
//    }
  //http://211.147.87.20:8092/Vpm/199037.tranm
    //tranm199037
  //  http://211.147.87.20:8092/Vpm/199016.tranm
    urlString=[NSString stringWithFormat:@"%@%@.%@",TRADE_BASE_URL,jym,TRADE_LAST_URL];

    DLog(@"request-url:\n%@",urlString);
    DLog(@"request-param:\n%@",param);
    
    return [self postSynchronousUrlString:urlString parameters:params JYM:jym isShowErrorMessage:isShowErrorMsg];
    
}

- (ASIHTTPRequest *)postSynchronousUrlString:(NSString *)urlString
           parameters:(NSString *)requestParam
                  JYM:(NSString *)jym
   isShowErrorMessage:(int)isShowErrorMsg{
 
    NSString *encodeUrl = [NSString stringWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    
    NSURL *baseUrl = [NSURL URLWithString:encodeUrl];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:baseUrl];
    
    // set header
    //    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"xface-Version" value:@"1.5.9953"];
    [request addRequestHeader:@"CONTENT-TYPE" value:@"application/x-www-form-urlencoded;charset=utf-8"];
    [request addRequestHeader:@"xface-UserId" value:@"460013181089809"];
    [request addRequestHeader:@"xface-Agent" value:@"w480h800"];
    [request addRequestHeader:@"User-Agent" value:@"IOS;DeviceId:iPhone;"];
    [request addRequestHeader:@"User-Agent-Backup" value:@"IOS;DeviceId:iPhone;"];
    [request addRequestHeader:@"Accepts-Encoding" value:@"utf-8"];
    //    [request addRequestHeader:@"charset" value:@"UTF-8"];
    
    
    [request buildRequestHeaders];
    
    [request addPostValue:requestParam forKey:@"requestParam"];
    
    [request setRequestMethod:@"POST"];
    
    request.delegate = self;
    [request setTimeOutSeconds:30];
    /*设置超时自动重试最大次数为2*/
    //[request setNumberOfTimesToRetryOnTimeout:10];
    
    /*
     如果需要对队列里面的每个request进行区分，那么可以设定request的userInfo属性，它是个NSDictionary，或者更简单的方法是设定每个request的tag属性，这两个属性都不会被发送到服务器。
     */
    
    // 如果 target 不存在，则不需要 回调方法，
    [request setDidFinishSelector:nil];
    [request setDidFailSelector:nil];
    /*
     如果需要对队列里面的每个request进行区分，那么可以设定request的userInfo属性，它是个NSDictionary，或者更简单的方法是设定每个request的tag属性，这两个属性都不会被发送到服务器。
     */
    
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                          jym,CMD_JYM,
                          [NSNumber numberWithInt:isShowErrorMsg],kIsShowErrorMsg,nil]];
    
    // 进展指示符
    [ASIHTTPRequest showNetworkActivityIndicator];
    
    if (self.isShowMBHud==NO) {
        // 改为NO，及时改为YES。
        self.isShowMBHud = YES;
    }
    
    [request startSynchronous];
    return request;
    
    
}







@end
