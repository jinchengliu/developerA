//
//  CommonUtil.h
//  MiniPay
//
//  Created by allen on 13-11-27.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString * const postypeKey = @"Uenpostype";

@interface CommonUtil : NSObject

//创建xml字符串
+ (NSString *) createXml:(NSMutableArray *)array;
+ (NSString *)fileDocDir;
+(void)savepostype:(NSString*)type;
+(NSString *)loadpostypeCache;
+(BOOL)strNilOrEmpty:(NSString *)string;
+ (NSString *)fileResourceDir:(NSString *)path;
+(BOOL)chk18PaperId:(NSString *) sPaperId;
+(NSString*)getpinblock:(NSString*)acount andpwd:(NSString*)pwd;
+ (void)tapAnimationWithView:(UIView*)view;
+(void)callPhoneNumber:(NSString*)phoneNumber;
@end
