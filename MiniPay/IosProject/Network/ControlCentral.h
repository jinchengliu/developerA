//
//  ControlCentral.h
//  CQRCBank_iPhone
//
//  Created by ScofieldCai on 12-11-11.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HttpManager.h"

@class GridRowDomain;
@class GridEachRowView;

#define kParserError @"ParserError"
#define kParserErrorClean @"ParserErrorClean"
//<lp>8.1
#define kAccountingTreatmentParserError @"AccountingTreatmentParserError"
//<LP>
#define kParserErrorJYM @"ParserErrorJYM"
#define kParserErrorCode @"ParserErrorCode"
#define kParserResponseCode @"ParserResponseCode"
#define kParserErrorMessage @"ParserErrorMessage"
#define kParserErrorShowErrorMessageType @"ShowErrorMessageType"

typedef enum {
    ShowErrorMessageType_Nothing = 0,  // 不处理
    ShowErrorMessageType_AddErrorView = 1, // 添加失败页面、
    ShowErrorMessageType_PushErrorController = 2, // pushErrorViewController
    ShowErrorMessageType_ShowAlert, // 弹出alert，
    ShowErrorMessageType_ShowHudText // 弹出 hudText，自动消失
}ShowErrorMessageType;

typedef enum {
    TRADE_URL_TYPE = 0,  // 不处理
    NO_TRADE_URL_TYPE = 1, // 添加失败页面、
   
}RequestURLType;

@interface ControlCentral : NSObject <UIAlertViewDelegate>{
    dispatch_queue_t _mainQueue ;
    
    dispatch_queue_t _concurrentQueue;
    
    HttpManager *_httpManager;
}


+ (ControlCentral *)sharedInstance;

// 是哪个 controller 掉的请求。
@property (nonatomic,assign) id requestController;



#pragma mark - // 新的接口方法
- (void)requestDataWithJYM:(NSString *)jym
                parameters:(id)parameters
        isShowErrorMessage:(int)isShowErrorMessage
                completion:(void(^)(id result, NSError *requestError,NSError *parserError))completion;

@end
