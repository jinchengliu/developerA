//
//  DataManager.m
//  CQRCBank_iPhone
//
//  Created by magicmac on 12-11-13.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import "DataManager.h"

#import "GetDeviceMacAddress.h"
#import "SFHFKeychainUtils.h"


// 存储钥匙串时的servicename
#define kKeyBindKeychainServiceName @"CQRCBindKeychainServiceName"
#define kKeyBindKeychainUUID @"CQRCBindUUID"
#include <sys/xattr.h>


@implementation DataManager
#pragma mark - 单一实例
static DataManager *sharedDataManager = nil;
@synthesize sessionId = _sessionId;
@synthesize isQpos=_isQpos;
@synthesize token = _token;
@synthesize isLogin = _isLogin;
@synthesize isSign=_isSign;
@synthesize gridDatas = _gridDatas;
@synthesize PWD = _PWD;
@synthesize regions = _regions;
@synthesize bankList = _bankList;
@synthesize bizData = _bizData;
@synthesize postype_Vison=_postype_Vison;
@synthesize device_Type=_device_Type;
@synthesize seetingdict=_seetingdict;
@synthesize TerminalSerialNumber=_TerminalSerialNumber;
@synthesize ShanghuStus=_ShanghuStus;

+ (DataManager *)sharedDataManager {
    @synchronized(self){  // 防止多线程同事访问
        if (sharedDataManager == nil) {
            sharedDataManager = [[DataManager alloc] init];
        }
        return sharedDataManager;
    }
}

- (id)init
{
	if((self = [super init])) {
        self.isLogin = NO;
        self.isQpos=TRUE;
         self.postype_Vison=hf;

    }
    return self;
}



- (void)clearLoginData {
    self.sessionId = nil;
    [self clearLoginDataWithOutSession];
}

- (void)clearLoginDataWithOutSession {
    self.token = nil;
    self.token = nil;
    self.CSN = nil;
    self.KEYVER = nil;
    self.isLogin = NO;
    self.gridDatas = nil;
}




#pragma mark - //  UUID
-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
     CFRelease(puuid);
    CFRelease(uuidString);
//    return [result autorelease];
    return result;
}

#pragma mark - // 读取 存储 UUID
- (NSString *)readUUID {
    NSString *uuid = [SFHFKeychainUtils getPasswordForUsername:kKeyBindKeychainUUID
                                                    andServiceName:kKeyBindKeychainServiceName error:nil];
    
    if (IsNilString(uuid)) {
        uuid = [self uuid];
        
        // save to keychain
        [SFHFKeychainUtils storeUsername:kKeyBindKeychainUUID
                             andPassword:uuid
                          forServiceName:kKeyBindKeychainServiceName
                          updateExisting:YES
                                   error:nil];
    }else {
        
    }
    
    return uuid;
}

#pragma mark - // 读取 绑定信息
- (NSString *)readBindMSG {
    NSString *name = [[UIDevice currentDevice] model];
    NSString *mac = [GetDeviceMacAddress macaddress];
    NSString *uuid = [self readUUID];
    NSString *bindMSG = [NSString stringWithFormat:@"SYS_TYPE:2|NAME:%@|UUID:%@|MAC:%@",name,uuid,mac];
    
    DLog(@"bindMSG:%@",bindMSG);
    
    return bindMSG;
}

#pragma mark - // 从绑定信息中读取数据
- (NSDictionary *)dictionaryFromBindMSG:(NSString *)bindMSG {
    if (IsNilString(bindMSG)) {
        return nil;
    }
    NSArray *keyValuesArray = [bindMSG componentsSeparatedByString:@"|"];
    
    NSMutableDictionary *keyValueDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (NSString *keyValue in keyValuesArray) {
        
        NSString *key =nil;
        NSString *value = nil;
        NSRange sepRange = [keyValue rangeOfString:@":"];
        if (sepRange.location != NSNotFound) {
            key = [keyValue substringToIndex:sepRange.location];
            
            if (sepRange.location == keyValue.length-1) {
                // 是最后 一位
                value = @"";
            }else {
                value = [keyValue substringFromIndex:sepRange.location+1];
            }
        }else {
            key = keyValue;
            value = @"";
        }
        [keyValueDic setObject:value forKey:key];
    }
    return keyValueDic;
}
// 读取绑定信息中的设备名
- (NSString *)readBindNameFromBindMSG:(NSString *)bindMSG {
    NSDictionary *dic = [self dictionaryFromBindMSG:bindMSG];
    
    for (NSString *key in dic) {
        if ([key isEqualToString:@"NAME"]) {
            NSString *value = [dic objectForKey:key];
            return value;
        }
    }
    
    return nil;
}
// 读取绑定信息中的设备mac地址
- (NSString *)readBindMacAddressFromBindMSG:(NSString *)bindMSG {
    NSDictionary *dic = [self dictionaryFromBindMSG:bindMSG];
    
    for (NSString *key in dic) {
        if ([key isEqualToString:@"MAC"]) {
            NSString *value = [dic objectForKey:key];
            return value;
        }
    }
    
    return nil;
}

// 读取绑定信息中的设备UUID地址
- (NSString *)readBindUUIDAddressFromBindMSG:(NSString *)bindMSG
{
    NSDictionary *dic = [self dictionaryFromBindMSG:bindMSG];
    
    for (NSString *key in dic) {
        if ([key isEqualToString:@"UUID"]) {
            NSString *value = [dic objectForKey:key];
            return value;
        }
    }
    return nil;
}
// 读取绑定信息中的设备绑定时间
#pragma mark - //  沙盒目录
- (NSString *)dataFilePath:(NSString *)fileName{
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(
														  NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths1 objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

#pragma mark - // 写全局配置文件
- (BOOL)saveConfigsWithObject:(id)object key:(NSString *)key {
    NSMutableDictionary *configDic=[NSMutableDictionary dictionaryWithContentsOfFile:[self dataFilePath:kConfigFileName]];
    if (configDic==nil) {
        configDic=[NSMutableDictionary dictionaryWithCapacity:0];
    }
    [configDic setObject:object forKey:key];
    return [configDic writeToFile:[self dataFilePath:kConfigFileName] atomically:YES];
}
- (NSDictionary *)readConfigsFromDocuments {
    NSMutableDictionary *configDic=[NSMutableDictionary dictionaryWithContentsOfFile:[self dataFilePath:kConfigFileName]];
    if (configDic==nil) {
        configDic=[NSMutableDictionary dictionaryWithCapacity:0];
    }
    return configDic;
}

#pragma mark - // 存储用户名和密码
- (NSString *)encryptUserName:(NSString *)userName {
    NSMutableString *encry = [NSMutableString stringWithFormat:@"%@",userName];
    if (!IsNilString(userName)) {
        NSRange range = NSMakeRange(3, 4);
        [encry replaceCharactersInRange:range withString:@"****"];
    }
    return encry;
}

- (BOOL)saveUserLoginInfoWithUserName:(NSString *)userName {
    // 存储username  autoLogin到config.plist
    NSString *encryStr = [self encryptUserName:userName];
    if (IsNilString(encryStr)) {
        encryStr = @"";
    }
    NSDictionary *loginInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               userName,kKeyUserName,
                               encryStr,kKeyUserNameEncryption, nil];
    NSMutableArray *mArray = [self readUserLoginInfo];
    if (mArray == nil) {
        mArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    //BOOL isExist = NO;
    int index = NSNotFound;
    for (int i = 0; i< mArray.count; i++) {
        NSDictionary *info = [mArray objectAtIndex:i];
        NSString *name = [info objectForKey:kKeyUserName];
        if ([name isEqualToString:userName]) {
            // 原来已经存储过
            //isExist = YES;
            index = i;
            break;
        }
        else {
            // 新的 账户
            
        }
    }
    
    if (index != NSNotFound) {
        //[mArray replaceObjectAtIndex:index withObject:loginInfo];
        //[mArray exchangeObjectAtIndex:0 withObjectAtIndex:index];
        [mArray removeObjectAtIndex:index];
        [mArray insertObject:loginInfo atIndex:0];
        
    }else {
        [mArray insertObject:loginInfo atIndex:0];
    }
    
    return [self saveConfigsWithObject:mArray key:kKeyLoginInfo];
}

- (BOOL)deleteUserInfoWithUserName:(NSString *)userName {
    NSMutableArray *mArray = [self readUserLoginInfo];
    if (mArray == nil) {
        mArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    //BOOL isExist = NO;
    int index = NSNotFound;
    for (int i = 0; i< mArray.count; i++) {
        NSDictionary *info = [mArray objectAtIndex:i];
        NSString *name = [info objectForKey:kKeyUserName];
        if ([name isEqualToString:userName]) {
            // 原来已经存储过
            //isExist = YES;
            index = i;
            
            [mArray removeObject:info];
            break;
        }
        else {
            // 新的 账户
            
        }
    }
    
    return [self saveConfigsWithObject:mArray key:kKeyLoginInfo];
}

#pragma mark - // 读取用户名，密码
- (NSMutableArray *)readUserLoginInfo {
    NSDictionary *dic = [self readConfigsFromDocuments];
    NSMutableArray *loginInfoArray = [dic objectForKey:kKeyLoginInfo];
    return loginInfoArray;
}

#pragma mark - // 从本地 读取 省市列表，银行列表
- (NSDictionary *)readRegions {
    return self.regions;
}


- (BOOL)isAnnouncementDicSaved:(NSDictionary *)announcementDic {
    BOOL result = NO;
    NSMutableDictionary *dicOld = [self readAnnouncementDictionary];
    if (dicOld== nil || dicOld.count == 0) {
        // 原来没有 存储过
    }
    else {
        NSString *IDNew = [announcementDic objectForKey:@"ID"];
        NSMutableArray *announcementArrayOld = (NSMutableArray *)[dicOld objectForKey:@"LIST"];
        
        for (NSDictionary *dic in announcementArrayOld) {
            NSString *IDOld = [dic objectForKey:@"ID"];
            if ([IDOld isEqualToString:IDNew]) {
                result = YES;
                break;
            }
        }
    }
    
    
    return result;
}

- (NSMutableDictionary *)readAnnouncementDictionary {
    NSMutableDictionary *announcement = [[NSMutableDictionary alloc] initWithContentsOfFile:[self dataFilePath:@"Announcement.plist"]];
    
    return announcement;
}


//保存临时的值，如是否签到信息
-(void)SetTempObjectWithNSUserDefaults:(NSString *)string forUsername: (NSString *)username
{
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject: string forKey: username];
    
}

// 对NSUserDefaults的处理方法 写入/读取/移出
-(void)SetObjectWithNSUserDefaults:(NSString *)string forUsername: (NSString *)username
{
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject: string forKey: username];
    [defaults synchronize];
}
-(id)GetObjectWithNSUserDefaults:(NSString *)username
{
	return [[NSUserDefaults standardUserDefaults] objectForKey: username];
}
-(void)RemoveObjectWithNSUserDefaults:(NSString *)username
{
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults removeObjectForKey: username];
	[defaults synchronize];
}

@end
