//
//  ValueUtils.h
//  CQRCBank_iPhone
//
//  Created by carlos on 12-12-11.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValueUtils : NSObject
//把金额转换成大写
+(NSString *)getUppercaseBalance:(NSString *)mBalance;
//把日期转换成字符串     yyyy-MM-dd
+(NSString *)getStringByDate:(NSDate *)mDate;
/*
 2013-2-27 added by qinhu
 */
//前1个月的日期
+(NSDate *)previousMonth:(NSDate *)date;
//格式化日期字符串     yyyyMMdd => yyyy-MM-dd
+(NSString *)formatDateString0:(NSString *)dateStr;
//格式化日期字符串     HHmmss => HH:mm:ss
+(NSString *)formatDateString:(NSString *)dateStr;

//验证date1是否大于date2
+(BOOL)date1IsAfterDate2:(NSString *)date1 date2:(NSString *)date2;

+(NSString *)getUrlStringFromString:(NSString *)aStr;

+ (NSString *) md5: (NSString *) inPutText ;
+ (NSString *) md5UpStr: (NSString *) inPutText;

//获取星期     yyyyMMdd
+(NSString *)getWeekDay:(NSString *)dateStr;
//获取星期     yyyyMMddHHmmss
+(NSString *)getWeekDay1:(NSString *)dateStr;

//日期字符串格式化

#pragma mark - // 当前日期 格式：yyyyMMdd
+ (NSString *)currentDayStringFormatyyyyMMdd;
+ (NSString *)formatDateStringToyyyyMMdd:(NSDate *)date;

+(NSString *)formatDateString:(NSString *)dateStr from:(NSString *)aformat to:(NSString *)bformat;

+(BOOL)isConnectNet;

+(NSString *)fillterEight:(NSString *)phoneNumber;

// 生成两位随机数
+ (NSString *)doubleDigitRandomNumbers;

+ (NSString *)showSMSAuthCodeSequenceNumString:(NSString *)seqenceNum andString:(NSString *)string;

//获取当前日期MMdd
+(NSString *)getNowDate;
+(NSDate *)formatStrToDate:(NSString *)date;
//获取当前时间hhmmss
+(NSString *)getNowTime;
+(NSString *)getNowDateTime;
//刷卡消费
+(NSMutableArray *)createParam:(NSString *)trackInfo tradeMoney:(NSString *)tradeMoney pinInfo:(NSString *)pinInfo
                    cardNoInfo:(NSString *)cardNoInfo cmd:(NSString *)cmd phonerNumber:(NSString *)phonerNumber
                     termialNo:(NSString *)termialNo pasamNo:(NSString *)pasamNo tseqno:(NSString *)tseqno nowDate:(NSString *)nowDate nowTime:(NSString *)nowTime mac:(NSString *)mac CHECKX:(NSString*)latitude CHECKY:(NSString*)longitude;


+(NSMutableArray *)createParam:(NSString *)trackInfo tradeMoney:(NSString *)tradeMoney pinInfo:(NSString *)pinInfo
                    cardNoInfo:(NSString *)cardNoInfo cmd:(NSString *)cmd phonerNumber:(NSString *)phonerNumber
                     termialNo:(NSString *)termialNo pasamNo:(NSString *)pasamNo tseqno:(NSString *)tseqno nowDate:(NSString *)nowDate nowTime:(NSString *)nowTime mac:(NSString *)mac elesinga:(NSString*)eles CHECKX:(NSString*)latitude CHECKY:(NSString*)longitude;

//刷卡查询余额
+(NSMutableArray *)createParam:(NSString *)phonerNumber termialNo:(NSString *)termialNo cardNoInfo:(NSString *)cardNoInfo trackInfo:(NSString *)trackInfo pinInfo:(NSString *)pinInfo tseqno:(NSString *)tseqno pasamNo:(NSString *)pasamNo nowDate:(NSString *)nowDate nowTime:(NSString *)nowTime mac:(NSString *)mac;

//撤销交易参数
+(NSMutableArray *)createParam:logno phonerNumber:(NSString *)phonerNumber termialNo:(NSString *)termialNo cardNoInfo:(NSString *)cardNoInfo pinInfo:(NSString *)pinInfo tseqno:(NSString *)tseqno tradeMoney:(NSString *)tradeMoney pasamNo:(NSString *)pasamNo trackInfo:(NSString *)trackInfo nowDate:(NSString *)nowDate nowTime:(NSString *)nowTime mac:(NSString *)mac;

@end
