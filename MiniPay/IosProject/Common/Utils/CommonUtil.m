//
//  CommonUtil.m
//  MiniPay
//
//  Created by allen on 13-11-27.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "CommonUtil.h"
#import "GDataXMLNode.h"

@implementation CommonUtil

+ (NSString *)fileResourceDir:(NSString *)path{
	NSString *resPath = [[NSBundle mainBundle] resourcePath];
	NSString *filePath = [resPath stringByAppendingPathComponent:path];
	return filePath;
}

//创建xml字符串
+ (NSString *) createXml:(NSMutableArray *)array{
    
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"EPOSPROTOCOL"];

    for(int i=0;i<[array count]-1;i+=2){
        
        GDataXMLElement *element = [GDataXMLNode elementWithName:[array objectAtIndex:i] stringValue:[array objectAtIndex:i+1]];
        [rootElement addChild:element];
    }
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    [document setCharacterEncoding:@"UTF-8"];
    NSData *data =  [document XMLData];
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSRange range =[content rangeOfString:@"\n"];
    content=[content stringByReplacingCharactersInRange:range withString:@""];
    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return content;
    
}

//判断字符串空或nil
+ (BOOL)strNilOrEmpty:(NSString *)string{
	if ([string isKindOfClass:[NSString class]]) {
		if (string.length > 0) {
			return NO;
		}
		else {
			return YES;
		}
	}
	else {
		return YES;
	}
}

+ (NSString *)fileDocDir {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return docDir;
}

+(void)savepostype:(NSString*)type{
	NSUserDefaults *loginDefaults = [NSUserDefaults standardUserDefaults];
     [loginDefaults setObject:type forKey:@"Uenpostype"];
    [loginDefaults synchronize];
}

+(NSString *)loadpostypeCache{
	NSUserDefaults *loginDefaults = [NSUserDefaults standardUserDefaults];
	NSString *userName = [loginDefaults objectForKey:@"Uenpostype"];
	return userName;
}

/**
 
 * 功能:验证身份证是否合法
 
 * 参数:输入的身份证号
 
 */

+(BOOL) chk18PaperId:(NSString *) sPaperId

{
    
    //判断位数
    
    
    if ([sPaperId length] != 15 && [sPaperId length] != 18) {
        return NO;
    }
    NSString *carid = sPaperId;
    
    long lSumQT =0;
    
    //加权因子
    
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    
    
    //将15位身份证号转换成18位
    
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    
    if ([sPaperId length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        
        const char *pid = [mString UTF8String];
        
        for (int i=0; i<=16; i++)
            
        {
            
            p += (pid[i]-48) * R[i];
            
        }
        
        int o = p%11;
        
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        
        [mString insertString:string_content atIndex:[mString length]];
        
        carid = mString;
        
    }
    
    //判断地区码
    
    NSString * sProvince = [carid substringToIndex:2];
    
    if (![self areaCode:sProvince]) {
        
        return NO;
        
    }
    
    //判断年月日是否有效
    
    
    
    //年份
    
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    
    //月份
    
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    
    //日
    
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        
        return NO;
        
    }
    
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    
    if( 18 != strlen(PaperId)) return -1;
    
    
    
    //校验数字
    
    for (int i=0; i<18; i++)
        
    {
        
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
            
        {
            
            return NO;
            
        }
        
    }
    
    //验证最末的校验码
    
    for (int i=0; i<=16; i++)
        
    {
        
        lSumQT += (PaperId[i]-48) * R[i];
        
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] )
        
    {
        
        return NO;
        
    }
    
    return YES;
    
}

/**
 
 * 功能:获取指定范围的字符串
 
 * 参数:字符串的开始小标
 
 * 参数:字符串的结束下标
 
 */



+(NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger *)value1 Value2:(NSInteger )value2;

{
    
    return [str substringWithRange:NSMakeRange(value1,value2)];
    
}



/**
 
 * 功能:判断是否在地区码内
 
 * 参数:地区码
 
 */

+(BOOL)areaCode:(NSString *)code

{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"北京" forKey:@"11"];
    
    [dic setObject:@"天津" forKey:@"12"];
    
    [dic setObject:@"河北" forKey:@"13"];
    
    [dic setObject:@"山西" forKey:@"14"];
    
    [dic setObject:@"内蒙古" forKey:@"15"];
    
    [dic setObject:@"辽宁" forKey:@"21"];
    
    [dic setObject:@"吉林" forKey:@"22"];
    
    [dic setObject:@"黑龙江" forKey:@"23"];
    
    [dic setObject:@"上海" forKey:@"31"];
    
    [dic setObject:@"江苏" forKey:@"32"];
    
    [dic setObject:@"浙江" forKey:@"33"];
    
    [dic setObject:@"安徽" forKey:@"34"];
    
    [dic setObject:@"福建" forKey:@"35"];
    
    [dic setObject:@"江西" forKey:@"36"];
    
    [dic setObject:@"山东" forKey:@"37"];
    
    [dic setObject:@"河南" forKey:@"41"];
    
    [dic setObject:@"湖北" forKey:@"42"];
    
    [dic setObject:@"湖南" forKey:@"43"];
    
    [dic setObject:@"广东" forKey:@"44"];
    
    [dic setObject:@"广西" forKey:@"45"];
    
    [dic setObject:@"海南" forKey:@"46"];
    
    [dic setObject:@"重庆" forKey:@"50"];
    
    [dic setObject:@"四川" forKey:@"51"];
    
    [dic setObject:@"贵州" forKey:@"52"];
    
    [dic setObject:@"云南" forKey:@"53"];
    
    [dic setObject:@"西藏" forKey:@"54"];
    
    [dic setObject:@"陕西" forKey:@"61"];
    
    [dic setObject:@"甘肃" forKey:@"62"];
    
    [dic setObject:@"青海" forKey:@"63"];
    
    [dic setObject:@"宁夏" forKey:@"64"];
    
    [dic setObject:@"新疆" forKey:@"65"];
    
    [dic setObject:@"台湾" forKey:@"71"];
    
    [dic setObject:@"香港" forKey:@"81"];
    
    [dic setObject:@"澳门" forKey:@"82"];
    
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        
        return NO;
        
    }
    
    return YES;
    
}




+(NSString*)getpinblock:(NSString*)acount andpwd:(NSMutableString*)pwd
{
    
    NSString* result=@"";
    NSString* accountTemp1 =@"";
    int passwdLen = pwd.length;
    if(passwdLen==0){
          [pwd appendString:@"FFFFFF"];
       // pwd = @"FFFFFF";
    }else if(passwdLen<6){
        for(int i=0;i<6-passwdLen;i++){
            [pwd appendString:@"F" ];
        }
    }
    
    NSString *passwdTemp1 = [NSString stringWithFormat:@"0%d%@FFFFFFFF",passwdLen,pwd];
    if(acount!=nil&&![acount isEqualToString:@""]){
        int len = acount.length;
        NSString* accountTemp = [acount substringWithRange:NSMakeRange(len-13, 12)];
        accountTemp1 =[NSString stringWithFormat:@"0000%@",accountTemp];
    }
    
    if([accountTemp1 isEqualToString:@""]){
        result = passwdTemp1;
    }
    else
    {
        NSData* data2 = [self bcd:accountTemp1];
        Byte *accountByte = (Byte *)[data2 bytes];
        
        NSData* data3 = [self bcd:passwdTemp1];
        Byte *passwdByte = (Byte *)[data3 bytes];
        
        // Byte* passwdByte = [self bcd:@"5678"];
        
        Byte resultByte[8];
        
        for(int i=0;i<8;i++){
            resultByte[i] = (accountByte[i] ^ passwdByte[i]);
        }
        NSData *data1 = [NSData dataWithBytes: resultByte length: sizeof(resultByte)];
        result=[AESUtil hexStringFromString:data1];
        
    }
    
    return  [result uppercaseString];
}

+(NSData*)bcd:(NSString*)asc
{
    // NSString *asc=@"1234";
    int len = asc.length;
    int mod = len % 2;
    
    if (mod != 0) {
        asc=[NSString stringWithFormat:@"0%@",asc];
        
        len = asc.length;
    }
    
    Byte *abt;
    //    byte abt[] = new byte[len];
    if (len >= 2) {
        len = len / 2;
    }
    Byte bbt[len];
    //    byte bbt[] = new byte[len];
    NSData *testData = [asc dataUsingEncoding: NSUTF8StringEncoding];
    abt=(Byte *)[testData bytes];
    //abt = asc.getBytes();
    int j, k;
    
    for (int p = 0; p < asc.length/ 2; p++) {
        if ((abt[2 * p] >= '0') && (abt[2 * p] <= '9')) {
            j = abt[2 * p] - '0';
        } else if ((abt[2 * p] >= 'a') && (abt[2 * p] <= 'z')) {
            j = abt[2 * p] - 'a' + 0x0a;
        } else {
            j = abt[2 * p] - 'A' + 0x0a;
        }
        
        if ((abt[2 * p + 1] >= '0') && (abt[2 * p + 1] <= '9')) {
            k = abt[2 * p + 1] - '0';
        } else if ((abt[2 * p + 1] >= 'a') && (abt[2 * p + 1] <= 'z')) {
            k = abt[2 * p + 1] - 'a' + 0x0a;
        } else {
            k = abt[2 * p + 1] - 'A' + 0x0a;
        }
        
        int a = (j << 4) + k;
        //         NSData *testData1 = [a dataUsingEncoding: NSUTF8StringEncoding];
        //        Byte *b=(Byte *)[testData1 bytes];
        //byte b = (bytes) a;
        bbt[p] = a;
        // printf("bbt = %d\n",bbt[p]);
    }
    NSData *data = [NSData dataWithBytes: bbt length: sizeof(bbt)];
    //    for(int i=0;i<[data length];i++)
    //        printf("bbt = %d\n",bbt[i]);
    return data;
    
    
}

+ (void)tapAnimationWithView:(UIView*)view
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
	animation.duration = 0.50;
	animation.delegate = self;
	animation.removedOnCompletion = YES;
	animation.fillMode = kCAFillModeForwards;
	NSMutableArray *values = [NSMutableArray array];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
	animation.values = values;
	[view.layer addAnimation:animation forKey:nil];
}

+(void)callPhoneNumber:(NSString*)phoneNumber
{
    NSString* machineMode = [self machine];
    if ([machineMode hasPrefix:@"iPhone"])
    {
        NSString *dialURL = [[NSString alloc] initWithFormat:@"tel://%@",phoneNumber];
        //  NSLog(@"dialBtnPressed  URL=%@",dialURL);
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:dialURL]];
        
    }
    else
    {
        [self performSelector:@selector(showdiog) withObject:nil afterDelay:0.3];
        
    }
}

+(NSString *)machine {
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *name = malloc(size);
	sysctlbyname("hw.machine", name, &size, NULL, 0);
	NSString *machine = [NSString stringWithCString:name encoding:NSASCIIStringEncoding];
	free(name);
	return machine;
}

+(void)showdiog
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备不支持电话功能!" delegate:Nil cancelButtonTitle:Nil otherButtonTitles:@"确定", nil];
    [alert show];
}




@end
