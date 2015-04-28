//
//  ZftQiposLib.h
//  ZftQiposLib
//
//  Created by rjb on 13-8-1.
//  Copyright (c) 2013年 rjb. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ZftQiPosDelegate <NSObject>

@required
-(void)EDYonPlugin;
-(void)EDYonPlugOut;
-(void)EDYonSwiper:(NSString*)cardNum  andcardTrac:(NSString*)cardTrac andpin:(NSString*)cardPin;
-(void)EDYonTradeInfo:(NSString*)mac andpsam:(NSString*)psam andtids:(NSString*)tids;
-(void)EDYonError:(NSString*)errmsg;
-(void)EDYGet55Message:(NSString *) message;
-(void)EDYgetTerminalID:(NSString *)terminalId;
-(void)doSignInStatus:(NSString *) status;
-(void)EDYdiscoverDevice:(NSDictionary *)device;

//数字信封下发结果
-(void)EDYdoSecurityCommandStatus:(NSString *) status;

@end
@interface ZftQiposLib : NSObject

/*单例
 * @param type: 0 音频连接
 *              1 蓝牙连接
 *
 */
+ (void)setContectType:(int)type;
+(ZftQiposLib *)getInstance;
/*检测是否插入刷卡器*/
+(BOOL)ispluged_21;
/*检测蓝牙是否连接*/
+(BOOL)isconnect_21;
/*设置代理*/
-(void) setLister:(id<ZftQiPosDelegate>)lister;

/**
 * 读取刷卡器ID，并且下发交易指令
 * @param amountString 交易金额（单位：分）
 * @param type  ：0=磁卡密文
 * 				  1=磁卡密文+密码（六位密码）
 *                2=手工输入卡号+磁卡密文+密码
 *                3=二次输入+磁卡密文+密码
 *                4=只刷卡，
 *                5=只输入六位密码,
 *                6=ICcard支付,
 *                7=非接口支付
 *                8=只输入四位密码
 *                9=刷卡输入四位密码
 * @param random 随机数 随意3位数字
 * @param extraString 额外数
 * @param timeout 超时时间
 * @return
 * 	 	0： 成功
 *      1： 超时，刷卡器无响应
 */
-(NSInteger) doTradeEx:(NSString*) amountString andType:(NSInteger) type andRandom:(NSString*)random
        andextraString:(NSString*)extraString andTimesOut:(NSInteger)timeout;

/* 获取设备版本号
 *praram 无
 *return:
 设备版本号  明文格式
 */

+(NSString *) getVersionID;

- (void)getBanlance:(NSString *)amount;
/**尝试去和读卡器通信，获取terminalID
 *输出为0： 表示成功； 为1：表示超时。
 */
-(void) doGetTerminalID;

/**
 * 设备签到
 * @param data NSString 签到信息
 * @return
 * 签到情况回调doSignInStatus
 */
-(void)doSignIn:(NSString *)strdata;

/**
 * 当doGetTerminalID成功后，可以调用此方法得到当前刷卡器的ID。 得到的ID是一个字符串，ID以明文形式传输
 * doGetTerminalID为异步操作 请避免同时调用doGetTerminalID和getTerminalID
 * 建议在执行doGetTerminalID 2秒后调用get方法获取设备ID
 */

-(NSString*) getTerminalID;

/**
 * @param time 休眠时间
 * @return
 *      0:  成功
 *      1:  失败
 *      -1: 超时
 *
 */
-(NSInteger)setSleepTime:(NSInteger)time;

/**
 * 发送数字信封
 * @param cmd
 */
-(NSInteger)  doSecurityCommand:(NSString*) cmd;
/*
 获取TCK  明文为8位字节码
 */
-(NSData*)getTCK;

/*
 *写入钥密
 *@param key 32位字符串
 *@return
 *1 参数错误（操作失败)
 *0 操作成功
 */
-(NSInteger ) setDesKey:(NSString *) key;

/*
 *给POS机器关机
 *
 */
-(void) powerOff;

- (NSString *)getPsamID;

//搜索设备
- (void)starScan;
//停止搜索
- (void)stopScan;
//连接设备
- (void)connectDevice:(NSString *)name;
//断开蓝牙设备连接
- (void)disconnect_21ionDevice;


@end
