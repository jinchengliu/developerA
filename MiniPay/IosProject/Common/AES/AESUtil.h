//
//  AESUtil.h
//  MiniPay
//
//  Created by allen on 13-11-25.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
@interface AESUtil : NSObject{
    
    
}

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText password:(NSString *)pwd;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText password:(NSString *)pwd;

// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;

//转换成16进制字符串
+ (NSString *)hexStringFromString:(NSData *)myD;

//转换pasam卡号
+(NSString *)changePsamNo:(NSString *)psamNo;


//3des加解密
+(NSString *)TripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt encryptOrDecryptKey:(NSString *)encryptOrDecryptKey;
@end
