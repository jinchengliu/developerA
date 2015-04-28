//
//  PaxMPosRetCodes.h
//  PaxMPosManager
//
//  Created by admin on 4/16/14.
//  Copyright (c) 2014 pax. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MPOS_OK = 0,                                    // OK
    
    //////////////// GENERAL /////////////////////////

    MPOS_ERR_PROTO_NAKED            = -0x02 ,		// 通讯协议错误 - 发送数据被terminal NAK
    MPOS_ERR_PROTO_NO_ENOUGH_DATA   = -0x03 ,		// 通讯协议错误 - 未收到足够数据
    MPOS_ERR_PROTO_DATA_FORMAT      = -0x04 ,		// 通讯协议错误 - 接收的数据包格式不正确
    MPOS_ERR_PROTO_CHKSUM           = -0x05 ,		// 通讯协议错误 - 接收的数据包校验错误
    
    MPOS_ERR_COMM                   = -0x09 ,		// 通讯错误
    
    MPOS_ERR_PARAM                  = -0x100 ,		// 参数错误
    MPOS_ERR_DATA_FORMAT            = -0x101 ,		// 终端返回数据格式错误
    
    MPOS_ERR_GET_SN                 = -0x501,       // 获取SN出错
    MPOS_ERR_GET_PSAMNO             = -0x502,       // 获取PSAM卡号错误
    
    //////////////// PED /////////////////////////
    MPOS_ERR_PIN_CANCEL             = -0x10001,     // 输入密码取消
    MPOS_ERR_PIN_TIMEOUT            = -0x10002,     // 输入密码超时
    
    MPOS_ERR_CALCMAC                = -0x10003,     // 计算mac出错
    
    MPOS_ERR_WRITE_PINKEY           = -0x10004,     // 写PINKEY错误
    MPOS_ERR_WRITE_MACKEY           = -0x10005,     // 写MACKEY错误
    MPOS_ERR_WRITE_DESKEY           = -0x10006,     // 写DESKEY错误
    
    //////////////// MSR /////////////////////////
    MPOS_ERR_SWIPE_CANCEL           = -0x20001,     // 刷卡取消
    MPOS_ERR_SWIPE_TIMEOUT          = -0x20002,     // 刷卡超时
    
    //////////////// EMV /////////////////////////
    MPOS_ERR_SELAPP_CANCEL          = -0xa0001,     // ic卡应用选择取消
    MPOS_ERR_SELAPP_TIMEOUT         = -0xa0002,     // ic卡应用选择超时
    
} PaxMPosRetCode;

@interface PaxMPosRetCodes : NSObject

+ (NSString *)code2String:(PaxMPosRetCode) code;
    
@end
