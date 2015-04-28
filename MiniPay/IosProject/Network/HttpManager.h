//
//  HttpManager.h
//  CQRCBank_iPhone
//
//  Created by magicmac on 12-11-15.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

#import "MBProgressHUD.h"

#import "ASIFormDataRequest.h"
#import "Reachability.h"

@class GridRowDomain;
@class GridEachRowView;

// 普通接口ip
#define ipUrl @"http://hlu010048.chinaw3.com/modules/mobile/"

//#define khttpRequestSuccess @"httpRequestSuccess"
//#define khttpRequestFailed @"httpRequestFailed"
#define kSUCCESSSELECTOR @"successSelector"
#define kTARGET @"target"
#define kFAILEDSELECTOR @"failedSelector"
#define kHttpRequestResult @"httpRequestResult"

#define kIsShowErrorMsg @"isShowErrorMsg"

#define kIsNeedUpdateSession @"isNeedUpdateSession"

#pragma mark - // zip下载 的目录管理
/* 期刊下载的目录管理 */
// 期刊存储时 的文件目录
#define kKeySaveZipFilePath @"CQRCZip"
// 期刊解压时 的目标文件目录
#define kKeyUnzipFilePath @"CQRCZip/CQRCUnzipFile"

// 在解压缩成功后写如一个文件以 下次 判断解压缩是否成功。
#define kKeyUnzipIsSuccessFile @"UnzipIsSuccessFile"


@protocol DownloadDelegate;
@interface HttpManager : NSObject  {
//    ASINetworkQueue *_networkQueue;
    ASINetworkQueue *_downloadQueue; // 下载的queue
    
    BOOL _failed;
    // 缓冲动画
    MBProgressHUD *_mbHud;
    BOOL _isShowMBHud;  // 是否显示动画，默认显示,如果改为
}
@property (nonatomic,assign) BOOL isShowMBHud;


+ (HttpManager *)sharedHttpManager;


- (void)showHudProgress;
- (void)hideHudProgress;



#pragma mark - // post 同步 方法
- (ASIHTTPRequest *)postSynchronousNeedSession:(NSString *)param
                                           JYM:(NSString *)jym
                            isShowErrorMessage:(int)isShowErrorMsg;


@end
