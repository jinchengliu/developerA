//
//  ValueUtils.m
//  CQRCBank_iPhone
//
//  Created by carlos on 12-12-11.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import "ValueUtils.h"
#import "CommonCrypto/CommonDigest.h"
#import "AESUtil.h"

@implementation ValueUtils
//把金额转换成大写
+(NSString *)getUppercaseBalance:(NSString *)mBalance
{
    return @"壹佰元整";
}
//把日期转换成字符串     yyyy-MM-dd
+(NSString *)getStringByDate:(NSDate *)mDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return  [dateFormatter stringFromDate:mDate];
}

//前1个月的日期
+(NSDate *)previousMonth:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *dc = [cal components:NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit fromDate:date];
    if(dc.month == 1) {
        [dc setYear:dc.year - 1];
        [dc setMonth:12];
    }
    else {
        [dc setMonth:dc.month - 1];
    }

    return [cal dateFromComponents:dc];
}

//格式化日期字符串  yyyyMMdd => yyyy-MM-dd
+(NSString *)formatDateString0:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    return [self getStringByDate:[dateFormatter dateFromString:dateStr]];
}
//格式化日期字符串  HHmmss => HH:mm:ss
+(NSString *)formatDateString:(NSString *)dateStr from:(NSString *)aformat to:(NSString *)bformat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:aformat];
    NSDate *temp = [dateFormatter dateFromString:dateStr];
    [dateFormatter setDateFormat:bformat];
    return [dateFormatter stringFromDate:temp];
}

//格式化时间字符串     HHmmss => HH:mm:ss
+(NSString *)formatDateString:(NSString *)dateStr
{
    return [self formatDateString:dateStr from:@"HHmmss" to:@"HH:mm:ss"];
}


//验证date1是大于date2，date1--yyyyMMDD  date2--yyyyMMDD
+(BOOL)date1IsAfterDate2:(NSString *)date1 date2:(NSString *)date2{
    
    //NSDate *cuDate1=[self formatStrToDate:date1];
    //NSDate *cuDate2=[self formatStrToDate:date2];
    
    //BOOL isAfter=[cuDate1 earlierDate:cuDate2]==cuDate2;
    BOOL isAfter=[date1 compare:date2]>0;

    return isAfter;
    
}

//url转码
+(NSString *)getUrlStringFromString:(NSString *)aStr{
    CFStringRef ref=CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)aStr,
                                            NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8);
    NSString  *str = [[NSString  alloc]initWithCString:CFStringGetCStringPtr(ref, 0)
                                                        encoding:NSUTF8StringEncoding];
    if(IsNilString(str))
       return @"";
    return str;
}

+(NSString *)getWeekDay:(NSString *)dateStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date=[dateFormatter dateFromString:dateStr];
   
    
    return [self calWeekday:date];
}


+(NSString *)getWeekDay1:(NSString *)dateStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date=[dateFormatter dateFromString:dateStr];
    
    
    return [self calWeekday:date];
}



+(NSString *)calWeekday:(NSDate *)date{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    NSArray *array=[[NSArray alloc] initWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSString *weekday=@"星期一";
    if(week>=1 &&week<=7){
        weekday=[array objectAtIndex:week-1];
    }
    
    return weekday;

    
}


+(NSDate *)formatStrToDate:(NSString *)date{
    
   NSString *year=[date substringWithRange:NSMakeRange(0, 4)];
   NSString *month=[date substringWithRange:NSMakeRange(4, 2)];
   NSString *day=[date substringWithRange:NSMakeRange(6, 2)];
    
   NSDateComponents *comp = [[NSDateComponents alloc]init];
   [comp setMonth:[month integerValue]];
   [comp setDay:[day integerValue]];
   [comp setYear:[year integerValue]];
   NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
   NSDate *myDate= [myCal dateFromComponents:comp];

   return myDate;
    
}


#pragma mark - // 当前日期 格式：yyyyMMdd
+ (NSString *)currentDayStringFormatyyyyMMdd {
    NSDate *date = [NSDate date];
    return [ValueUtils formatDateStringToyyyyMMdd:date];
}

+ (NSString *)formatDateStringToyyyyMMdd:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    return  [dateFormatter stringFromDate:date];
}

// 生成两位随机数
static int staticDecadeNumber = 0;
+ (NSString *)doubleDigitRandomNumbers {
    int i = arc4random()%10;
    
    
    if (staticDecadeNumber == 10) {
        staticDecadeNumber = 0;
    }
    NSString *string = [NSString stringWithFormat:@"%i%i",staticDecadeNumber,i];
    
//    int result = staticDecadeNumber*10 + i;
    
    staticDecadeNumber += 1;
    
    return string;
}

+ (NSString *)showSMSAuthCodeSequenceNumString:(NSString *)seqenceNum andString:(NSString *)string{
    if ([string hasSuffix:@":"] || [string hasSuffix:@"："]) {
        string = [string substringToIndex:string.length-1];
    }
    
    NSString *stringAll = [NSString stringWithFormat:@"请输入序号为%@的%@",seqenceNum,string];
    return stringAll;
}

//判断是否有网络连接
+(BOOL)isConnectNet{
    
    if (([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) &&
        ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable)) {
        
        return false;
    }else{
        return true;
    }
    
}

+(NSString *)fillterEight:(NSString *)phoneNumber{
    
    NSMutableString *str=[NSMutableString stringWithString:phoneNumber];
    
    NSString * rege = @"[0-9]*$";//*代表无限长度
    NSPredicate * preTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rege];

    
    NSRange jiaRange1=[str rangeOfString:@","];
    if(jiaRange1.location!=NSNotFound){
        [str deleteCharactersInRange:jiaRange1];
    }
    
    NSRange jiaRange2=[str rangeOfString:@";"];
    if(jiaRange2.location!=NSNotFound){
        [str deleteCharactersInRange:jiaRange2];
    }
    
    NSRange jiaRange3=[str rangeOfString:@"*"];
    if(jiaRange3.location!=NSNotFound){
        [str deleteCharactersInRange:jiaRange3];
    }
    
    NSRange jiaRange4=[str rangeOfString:@"#"];
    if(jiaRange4.location!=NSNotFound){
        [str deleteCharactersInRange:jiaRange4];
    }
    
    NSRange jiaRange=[str rangeOfString:@"+"];
    if(jiaRange.location!=NSNotFound){
        [str deleteCharactersInRange:jiaRange];
    }
    
    NSRange eightRange=[str rangeOfString:@"86"];
    if(eightRange.location==0){
        [str deleteCharactersInRange:eightRange];
    }
    
    NSRange eightRangeO=[str rangeOfString:@"086"];
    if(eightRangeO.location==0){
        [str deleteCharactersInRange:eightRangeO];
    }

    if (![preTest evaluateWithObject:str]) {
       str = [ValueUtils fillterEight:str];
    }
    
    return str;
    
}


// Md5加密
+ (NSString *) md5: (NSString *) inPutText {
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString *) md5UpStr: (NSString *) inPutText {
    
    return [[self md5:inPutText] uppercaseString];
}

//获取当前日期MMdd
+(NSString *)getNowDate{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMdd"];
    NSString *nowDate=[dateFormatter stringFromDate:date];
    
    return nowDate;
    
}

//获取当前日期MMdd
+(NSString *)getNowDateTime{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyMMdd"];
    NSString *nowDate=[dateFormatter stringFromDate:date];
    
    return nowDate;
    
}


//获取当前时间hhmmss
+(NSString *)getNowTime{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hhmmss"];
    NSString *nowTime=[timeFormatter stringFromDate:date];
    
    return nowTime;
    
}

//刷卡消费组合参数
+(NSMutableArray *)createParam:(NSString *)trackInfo tradeMoney:(NSString *)tradeMoney pinInfo:(NSString *)pinInfo cardNoInfo:(NSString *)cardNoInfo cmd:(NSString *)cmd phonerNumber:(NSString *)phonerNumber
                     termialNo:(NSString *)termialNo pasamNo:(NSString *)pasamNo tseqno:(NSString *)tseqno nowDate:(NSString *)nowDate nowTime:(NSString *)nowTime mac:(NSString *)mac CHECKX:(NSString*)latitude CHECKY:(NSString*)longitude{
    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRACK"];  //卡磁道密文
    [array addObject:trackInfo];
    
    [array addObject:@"TSEQNO"];   //终端流水号
    [array addObject:tseqno];
    
    [array addObject:@"CTXNAT"];  //消费金额
    [array addObject:tradeMoney];
    
    [array addObject:@"TPINBLK"]; //支付密码
    [array addObject:pinInfo];
    
    [array addObject:@"PCSIM"];  //PCSIM卡号
    [array addObject:@"获取不到"];
    
    [array addObject:@"CRDNO"];  //卡号密文
    [array addObject:cardNoInfo];
    
    [array addObject:@"TRANCODE"];  //交易码
    [array addObject:cmd];
    
    [array addObject:@"PHONENUMBER"];  //手机号码
    [array addObject:phonerNumber];
    
    [array addObject:@"CHECKX"];  //交易经度
    [array addObject:latitude];
    
    [array addObject:@"APPTOKEN"]; //token，目前随便传
    [array addObject:@"apptoken"];
    
    [array addObject:@"CHECKY"];  //交易纬度
    [array addObject:longitude];
    
    [array addObject:@"TERMINALNUMBER"];  //设备终端号
    [array addObject:termialNo];
    
    [array addObject:@"TTXNTM"]; //交易时间
    [array addObject:nowTime];
    
    [array addObject:@"TTXNDT"];  //交易日期
    [array addObject:nowDate];
    
    
    [array addObject:@"PSAMCARDNO"];  //PSAM卡号
    [array addObject:pasamNo];
    
    [array addObject:@"MAC"]; //mac
    [array addObject:mac];

    return array;
    
    
}


//刷卡消费组合参数
+(NSMutableArray *)createParam:(NSString *)trackInfo tradeMoney:(NSString *)tradeMoney pinInfo:(NSString *)pinInfo
                    cardNoInfo:(NSString *)cardNoInfo cmd:(NSString *)cmd phonerNumber:(NSString *)phonerNumber
                     termialNo:(NSString *)termialNo pasamNo:(NSString *)pasamNo tseqno:(NSString *)tseqno nowDate:(NSString *)nowDate nowTime:(NSString *)nowTime mac:(NSString *)mac elesinga:(NSString*)eles CHECKX:(NSString*)latitude CHECKY:(NSString*)longitude{
    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRACK"];  //卡磁道密文
    [array addObject:trackInfo];
    
    [array addObject:@"TSEQNO"];   //终端流水号
    [array addObject:tseqno];
    
    [array addObject:@"CTXNAT"];  //消费金额
    [array addObject:tradeMoney];
    
    [array addObject:@"TPINBLK"]; //支付密码
    [array addObject:pinInfo];
    
    [array addObject:@"PCSIM"];  //PCSIM卡号
    [array addObject:@"获取不到"];
    
    [array addObject:@"CRDNO"];  //卡号密文
    [array addObject:cardNoInfo];
    
    [array addObject:@"TRANCODE"];  //交易码
    [array addObject:cmd];
    
    [array addObject:@"PHONENUMBER"];  //手机号码
    [array addObject:phonerNumber];
    
    [array addObject:@"CHECKX"];  //交易经度
    [array addObject:latitude];
    
    [array addObject:@"APPTOKEN"]; //token，目前随便传
    [array addObject:@"apptoken"];
    
    [array addObject:@"CHECKY"];  //交易纬度
    [array addObject:longitude];
    
    [array addObject:@"TERMINALNUMBER"];  //设备终端号
    [array addObject:termialNo];
    
    [array addObject:@"TTXNTM"]; //交易时间
    [array addObject:nowTime];
    
    [array addObject:@"TTXNDT"];  //交易日期
    [array addObject:nowDate];
    
    [array addObject:@"ELESIGNA"];  //交易日期
    [array addObject:eles];
    
    [array addObject:@"PSAMCARDNO"];  //PSAM卡号
    [array addObject:pasamNo];
    
    [array addObject:@"MAC"]; //mac
    [array addObject:mac];
    
    return array;
    
    
}



//查询余额时组合参数
+(NSMutableArray *)createParam:(NSString *)phonerNumber termialNo:(NSString *)termialNo cardNoInfo:(NSString *)cardNoInfo trackInfo:(NSString *)trackInfo pinInfo:(NSString *)pinInfo tseqno:(NSString *)tseqno pasamNo:(NSString *)pasamNo nowDate:(NSString *)nowDate nowTime:(NSString *)nowTime mac:(NSString *)mac{
    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRANCODE"];  //交易码
    [array addObject:SEARCH_BLANCE_CMD_199007];
    
    [array addObject:@"PHONENUMBER"];  //手机号码
    [array addObject:phonerNumber];
    
    [array addObject:@"TERMINALNUMBER"];  //设备终端号
    [array addObject:termialNo];
    
    [array addObject:@"PCSIM"];  //PCSIM卡号
    [array addObject:@"获取不到"];
    
    [array addObject:@"APPTOKEN"]; //token，目前随便传
    [array addObject:@"apptoken"];
    
    
    [array addObject:@"CRDNO"];  //卡号密文
    [array addObject:cardNoInfo];
    
    [array addObject:@"TRACK"];  //卡磁道密文
    [array addObject:trackInfo];
    
    [array addObject:@"TPINBLK"]; //支付密码
    [array addObject:pinInfo];
    
    [array addObject:@"TSEQNO"];   //终端流水号
    [array addObject:tseqno];
    
    [array addObject:@"MAC"]; //mac
    [array addObject:mac];
    
    [array addObject:@"PSAMCARDNO"];  //PSAM卡号
    [array addObject:pasamNo];
    
    
    [array addObject:@"TTXNTM"]; //交易时间
    [array addObject:nowTime];
    
    [array addObject:@"TTXNDT"];  //交易日期
    [array addObject:nowDate];
    
    
    return array;
    
}


//撤销交易参数
+(NSMutableArray *)createParam:logno phonerNumber:(NSString *)phonerNumber termialNo:(NSString *)termialNo cardNoInfo:(NSString *)cardNoInfo pinInfo:(NSString *)pinInfo tseqno:(NSString *)tseqno tradeMoney:(NSString *)tradeMoney pasamNo:(NSString *)pasamNo trackInfo:(NSString *)trackInfo nowDate:(NSString *)nowDate nowTime:(NSString *)nowTime mac:(NSString *)mac{
    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRANCODE"];  //交易码
    [array addObject:CANCEL_TRADE_CMD_199006];
    
    [array addObject:@"LOGNO"];  //流水号
    [array addObject:logno];
    
    [array addObject:@"PHONENUMBER"];  //手机号码
    [array addObject:phonerNumber];
    
    [array addObject:@"TERMINALNUMBER"];  //设备终端号
    [array addObject:termialNo];
    
    [array addObject:@"PCSIM"];  //PCSIM卡号
    [array addObject:@"获取不到"];
    
    [array addObject:@"APPTOKEN"]; //token，目前随便传
    [array addObject:@"apptoken"];
    
    [array addObject:@"CRDNO"];  //卡号密文
    [array addObject:cardNoInfo];
    
    [array addObject:@"TRACK"];  //卡磁道密文
    [array addObject:trackInfo];
    
    [array addObject:@"TPINBLK"]; //支付密码
    [array addObject:pinInfo];
    
    [array addObject:@"CHECKX"];  //交易经度
    [array addObject:@"0.0"];
    
    [array addObject:@"CHECKY"];  //交易纬度
    [array addObject:@"0.0"];
    
    [array addObject:@"TSEQNO"];   //终端流水号
    [array addObject:tseqno];
    
    [array addObject:@"CTXNAT"];  //消费金额
    [array addObject:tradeMoney];
    
    [array addObject:@"PSAMCARDNO"];  //PSAM卡号
    [array addObject:pasamNo];
    
    [array addObject:@"TTXNTM"]; //交易时间
    [array addObject:nowTime];
    
    [array addObject:@"TTXNDT"];  //交易日期
    [array addObject:nowDate];

    
    [array addObject:@"MAC"]; //mac
    [array addObject:mac];

    return array;
    
}



@end
