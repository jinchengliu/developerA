//
//  ControlCentral.m
//  CQRCBank_iPhone
//
//  Created by ScofieldCai on 12-11-11.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import "ControlCentral.h"
#import <objc/runtime.h>
#import "DataManager.h"
#import "Reachability.h"
#import "ValueUtils.h"
#import "GDataXMLNode.h"
#import "AESUtil.h"
#import "ForgetPwdViewController.h"
static ControlCentral * _sharedInstance;

@implementation ControlCentral

#pragma mark - Singleton Instance

+ (ControlCentral *)sharedInstance
{
    @synchronized(self){  
        if(_sharedInstance == nil) {
            _sharedInstance = [[ControlCentral alloc] init];
        }
        return _sharedInstance;
	}
}

- (id)init {
    self = [super init];
    if (self) {
        _mainQueue = dispatch_get_main_queue();
        
        _concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        _httpManager = [HttpManager sharedHttpManager];
    }
    return self;
}

#pragma mark - // 新的接口方法
/*
 ShowErrorMessageType_Nothing = 0,  // 不处理
 ShowErrorMessageType_AddErrorView = 1, // 添加失败页面、
 ShowErrorMessageType_PushErrorController = 2, // pushErrorViewController
 ShowErrorMessageType_ShowAlert, // 弹出alert，
 ShowErrorMessageType_ShowHudText // 弹出 hudText，自动消失
 */
- (void)requestDataWithJYM:(NSString *)jym
                parameters:(id)parameters
        isShowErrorMessage:(int)isShowErrorMessage
                completion:(void(^)(id result, NSError *requestError,NSError *parserError))completion{
    
    //判断网络状态
    if(![ValueUtils isConnectNet]){
        
        [self.requestController hideWaiting];
        if([self.requestController respondsToSelector:@selector(hideAllView)]){
            [self.requestController hideAllView];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"与后台通信中网络异常，请检查您的网络"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:k_text_sure, nil];
        [alert show];
        return;
    
    }
    dispatch_async(_concurrentQueue, ^{
        
        ASIHTTPRequest *request = [_httpManager postSynchronousNeedSession:parameters  JYM:jym isShowErrorMessage:isShowErrorMessage];
        
        NSError *error = request.error;
        NSString *resultTemp=nil;
        
        if (error == nil) {
            
            resultTemp = [request responseString];
            resultTemp=[AESUtil decrypt:resultTemp password:[ValueUtils md5UpStr:AES_PWD]];
            DLog(@"===response:%@",resultTemp);
            
        }
         
        dispatch_sync(_mainQueue, ^{
            ILog(@" \n main thread ");
            if (error) {
                // 网络超时，强制 停止动画
                [self.requestController hideWaiting];
                if([self.requestController respondsToSelector:@selector(hideAllView)]){
                    [self.requestController hideAllView];
                }
                // 网络连接失败
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"后台服务异常，请稍后再试！"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:k_text_sure, nil];
                alert.tag = jym.intValue;
                [alert show];
                return ;
            }
            NSData *responseData=[resultTemp dataUsingEncoding:NSUTF8StringEncoding];
            //使用NSData对象初始化
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseData  options:0 error:nil];
            //获取根节点（Users）
            GDataXMLElement *rootElement = [doc rootElement];
            GDataXMLElement *codeElement = [[rootElement elementsForName:@"RSPCOD"] objectAtIndex:0];
            NSString *resCode = [codeElement stringValue];
            
            GDataXMLElement *msgElement = [[rootElement elementsForName:@"RSPMSG"] objectAtIndex:0];
            NSString *resMsg = [msgElement stringValue];
            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:resCode,@"RSPCOD",resMsg,@"RSPMSG",nil];
            
            if(![resCode isEqualToString:@"000000"] && ![resCode isEqualToString:@"00"]&&![resCode isEqualToString:@"00000"]&&![resCode isEqualToString:@"02000"] ){
                if([self.requestController respondsToSelector:@selector(hideAllView)]){
                    [self.requestController hideAllView];
                   
                }
                if(![resCode isEqualToString:@"980911"])
                {
                    if (completion) {
                        completion(nil,error,nil);
                    }
                }
                else
                {
                        if (completion) {
                            completion(rootElement,error,nil);
                  }
                        
                    }
                if([_requestController isMemberOfClass:[ForgetPwdViewController class]]&&jym==FEEBACK_CMD_199016)
                    return;

                [[NSNotificationCenter defaultCenter] postNotificationName:PARSE_ERROR
                                                                    object:self.requestController
                                                                  userInfo:userInfo];
                
            }else{

                if (completion) {
                    completion(rootElement,error,nil);
                }
            }
        });
        

    });
}







@end
