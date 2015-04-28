//
//  DataManager.h
//  CQRCBank_iPhone
//
//  Created by magicmac on 12-11-13.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#warning // 单一实例，存放 内存中全局共用的 变量。 还负责 想沙盒写入文件。

#import <Foundation/Foundation.h>
@class GridRowDomain;


#define kConfigFileName @"config.plist"
// 存储的用户名，
#define kKeyLoginInfo @"loginInfo"
#define kKeyUserName @"userName"
#define kKeyUserNameEncryption @"userNameEncryption"

// 区域的 key
#define kKeyAreaVersion @"VERSION"
#define kKeyAreaArray @"REPOSITORY"
#define kKeyAreaProvinceCode @"PROVINCECODE"
#define kKeyAreaProvinceName @"PROVINCENAME"
#define kKeyAreaCityArray @"CITIES"
#define kKeyAreaCityCode @"CITYCODE"
#define kKeyAreaCityName @"CITYNAME"

// 银行的 key
#define kKeyBanksVersion @"VERSION"
#define kKeyBanksRecNum @"RECNUM"
#define kKeyBanksArray @"REPOSITORY"
#define kKeyBanksBankName @"BANKNAME"
#define kKeyBanksBankCode @"BANKCODE"

//业务参数数据版本
#define kGridDataVersion        @"GridDataVersion"
//行政区域数据版本
#define kRegionDataVersion     @"RegionDataVersion"
//银行列表数据版本
#define kBankDataVersion        @"BankDataVersion"
//业务参数数据版本
#define kBizDataVersion         @"BizDataVersion"

typedef enum{
    wfb = 1,
    cyh = 2,
    xft=3,
    hf=4,
    hfb=5,
    mf=6,
    lxzf=7,
    nzf=8,
    yf=9,
    hxzf=10,
    wbht=11,
    hxsn=12,
    ipos=13,
    yft=14,
} postype;


typedef enum{
    Vpos = 0,
    Qpos = 1,
    D180=2,
    SKTPOS=3,
    BPOS=4,
    NOpos=5,
    Qpos_blue =6,
    
} deviceType;
@interface DataManager : NSObject {
    
}


#pragma mark - // login
@property (nonatomic,strong) NSString *sessionId;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *CSN;
@property (nonatomic,strong) NSString *KEYVER;
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,assign) BOOL isSign;
@property (nonatomic,assign) BOOL isQpos;
@property (nonatomic,strong) NSString*ShanghuStus;
@property(nonatomic,strong)  NSString *PWD;//密码

@property(nonatomic,strong) NSString *TerminalSerialNumber;

@property (nonatomic,strong) NSString *longitude;

@property (nonatomic,strong) NSString *latitude;

//九宫格数据
@property (nonatomic,copy) NSMutableArray *gridDatas;
//行政区域
@property (nonatomic,copy) NSDictionary *regions;
//银行列表
@property (nonatomic,copy) NSMutableArray *bankList;
//业务参数
@property (nonatomic,copy) NSDictionary *bizData;


@property (nonatomic,copy)  NSDictionary * seetingdict;

@property (nonatomic,assign) postype postype_Vison;

@property (nonatomic,assign) deviceType device_Type;


// 登录后的 设置，总共有几步
@property (nonatomic,assign) int totalSettingSteps;

+ (DataManager*)sharedDataManager;

- (void)clearLoginData;

- (void)clearLoginDataWithOutSession;

#pragma mark - //  沙盒目录
- (NSString *)dataFilePath:(NSString *)fileName;

#pragma mark - // 读取 存储 UUID
- (NSString *)readUUID;
#pragma mark - // 读取 绑定信息
- (NSString *)readBindMSG;

#pragma mark - // 存储用户名和密码
- (BOOL)saveUserLoginInfoWithUserName:(NSString *)userName;
- (BOOL)deleteUserInfoWithUserName:(NSString *)userName;

#pragma mark - // 读取用户名，密码
- (NSMutableArray *)readUserLoginInfo;

#pragma mark - // 从本地 读取 省市列表，银行列表
- (NSMutableArray *)readRegions;
- (NSDictionary *)readBanks;

#pragma mark - // 从绑定信息中读取数据
- (NSDictionary *)dictionaryFromBindMSG:(NSString *)bindMSG;
- (NSString *)readBindNameFromBindMSG:(NSString *)bindMSG;
// 读取绑定信息中的设备mac地址
- (NSString *)readBindMacAddressFromBindMSG:(NSString *)bindMSG;
// 读取绑定信息中的设备UUID地址
- (NSString *)readBindUUIDAddressFromBindMSG:(NSString *)bindMSG;
#pragma mark - // 存储必读公告

// 对NSUserDefaults的处理方法 写入/读取/移出
-(void)SetObjectWithNSUserDefaults:(NSString *)string forUsername: (NSString *)username;
-(void)SetTempObjectWithNSUserDefaults:(NSString *)string forUsername: (NSString *)username;
-(id)GetObjectWithNSUserDefaults:(NSString *)username;
-(void)RemoveObjectWithNSUserDefaults:(NSString *)username;

#pragma mark - // *****************读/存 九宫格json 数据**********
-(NSMutableArray *)createGrids:(NSDictionary *)dic;
//取当前九宫格数据版本
//-(NSString *)getGridVersion;


#pragma mark - // 在有更新的时候，删除旧的zip包，
- (BOOL)deleteZipWithGridRow:(GridRowDomain *)gridRow;
#pragma mark - // // 解压zip包
- (BOOL )unzipWithGridRow:(GridRowDomain *)gridRow;
//取参数列表
- (NSArray *)getBizArrByType:(NSString *)type;

@end
