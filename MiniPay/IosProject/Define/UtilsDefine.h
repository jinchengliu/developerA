//
//  UtilsDefine.h
//  CpicPeriodicaliPad
//
//  Created by magicmac on 12-9-3.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#ifndef CpicPeriodicaliPad_UtilsDefine_h
#define CpicPeriodicaliPad_UtilsDefine_h

#define AES_PWD @"dynamicode"

#define kAppKey @"2961068454"
#define kRedirectURI @"http://www.uenpay.com"

#define wEIXINKey @"wx68a172395231fef5"

#define cyhwEIXINKey @"wx0ed197049820ceea"


#define SHAIR_CONTENT @"没有做不到，只有想不到，最好用的手机刷卡器——微付宝手机Pos，移动互联网时代的刷卡利器，快来围观！！www.uenpay.com"


//#define cyh_SHAIR_CONTENT @"我在用畅意汇刷卡器收款，见证移动互联网刷卡时代的到来"

//正式地址
//#define NO_TRADE_BASE_URL @"http://211.147.87.29:8092/"
#define NO_TRADE_BASE_URL @"http://211.147.87.20:8092/"

//#define TRADE_BASE_URL @"http://211.147.87.29:8092/Vpm/"
#define TRADE_BASE_URL @"http://211.147.87.20:8092/Vpm/"

//测试地址
//#define TRADE_BASE_URL @"http://211.147.87.21:8088/"
//#define NO_TRADE_BASE_URL @"http://211.147.87.22:8092/"


#define TRADE_URL @"posp/"
#define NO_TRADE_URL @"posm/"

#define TRADE_LAST_URL @"tranm"
#define NO_TRADE_LAST_URL @"tran5"

#define PARSE_ERROR @"parse_error"

//关于我们url
#define ABOUT_US_URL @"Vpm/200133.tran?EPOSFLG=2"
//通知中心url
#define NOTICE_CENTER_URL @"Vpm/200140.tran?EPOSFLG=2"
//常见问题url
#define NORMAL_QUESTION_URL @"Vpm/200132.tran?EPOSFLG=2"
//意见反馈url
#define FEE_BACK_URL @"Vpm/200146.tran?EPOSFLG=2&phonenumber=%@"
//官方微博url
#define WEIBO_URL @"http://m.weibo.cn/u/3685385841"

//tixian
#define NOTICE_TIXIAN_URL @"Vpm/300138.tran?EPOSFLG=2"

//zhuanzhang
#define NOTICE_ZHUANZHANG_URL @"Vpm/300137.tran?EPOSFLG=2"

//zhuce
#define NOTICE_ZHUCE_URL @"Vpm/300133.tran?EPOSFLG=2"

//shuaka
#define NOTICE_SHUAKA_URL @"Vpm/300134.tran?EPOSFLG=2&phonenumber=%@"

//chongzhi
#define NOTICE_CHONGZHI_URL @"Vpm/300135.tran?EPOSFLG=2"

//xinyongka
#define NOTICE_HUANGKUAN_URL @"Vpm/300136.tran?EPOSFLG=2"

//#define cyh_WEIBO_URL @"http://weibo.com/3989184165"

//参考信息
#define CONSULTINFO_URL @"posm/200131.tran?EPOSFLG=2"
//客服电话
#define SERVICE_PHONE @"4006269987"

//用户登陆
#define LOGIN_CMD_199002 @"199002"

//用户注册发送短信验证码
#define SEND_MSG_TYPE_REGISTER @"100001"

//忘记密码发送短信验证码
#define SEND_MSG_TYPE_FORGETPWD @"100002"

//修改密码
#define MODIFYPWD_CMD_199003 @"199003"

//流水信息
#define FLOW_CMD_199008  @"199008"

//便民记录
#define FLOW_CMD_199040  @"199040"
#define FLOW_CMD_199041  @"199041"

//流水详情
#define FLOW_CMD_199036  @"199036"

//发送电子小票
#define FLOW_CMD_199037  @"199037"

//版本检测
#define FLOW_CMD_199015  @"199015"


//清算列表
#define MERCHANT_CMD_199009  @"199009"

//商户信息
#define MERCHANT_INFO_CMD_199011 @"199022"

//商户基本信息
#define MERCHANT_INFO_CMD_P77023  @"P77023"

//刷卡机器类型
#define MERCHANT_INFO_CMD_P77024  @"P77024"

#define MERCHANT_INFO_CMD_P77025  @"P77025"

#define MERCHANT_INFO_CMD_P77022  @"P77022"


//获取设备类型
#define MERCHANT_INFO_CMD_300143  @"300143"


//我的账户
#define MERCHANT_INFO_CMD_199026 @"199026"

//提现
#define MERCHANT_INFO_CMD_199025 @"199025"

//发送短信验证码
#define SENDCODE_CMD_199018  @"199018"

//获取原始密码
#define BEGIN_MODIFYPWD_CMD_199004  @"199004"


//判断验证码
#define BEGIN_MODIFYPWD_CMD_199019  @"199019"

//用户签到操作
#define SIGNED_CMD_199020 @"199020"

//用户刷卡交易操作
#define SWIPE_CARD_CMD_199005 @"199053"

//读扣率
#define SENDCODE_CMD_199038  @"199038"

// 小刷卡器交易
#define SWIPE_CARD_CMD_1990051 @"1990052"

//用户刷卡撤销交易操作
#define CANCEL_TRADE_CMD_199006 @"199006"

//用户刷卡查询余额
#define SEARCH_BLANCE_CMD_199007 @"199007"

//信用卡还款
#define SEARCH_BLANCE_CMD_702704 @"708102"

//手机充值
#define SEARCH_BLANCE_CMD_708111 @"708103"

//卡卡转账
#define SEARCH_BLANCE_CMD_708100 @"708101"




//用户反馈
#define FEEBACK_CMD_199014 @"199014"

//用户注册
#define LOGIN_CMD_199001 @"199001"

#define LOGIN_CMD_199019 @"199019"

//提交审核
#define LOGIN_CMD_199030 @"199030"

//验证用户名
#define FEEBACK_CMD_199016 @"199016"

//获取省
#define FEEBACK_CMD_199031 @"199031"

//银行大行名称
#define FEEBACK_CMD_199035 @"199035"

//银行名称
#define FEEBACK_CMD_199034 @"199034"

//获取城市
#define FEEBACK_CMD_199032 @"199032"

//用户签名
#define SIGNATURE_CMD_199010 @"199010"

//检查是否添加信用卡
#define SIGNATURE_CMD_708012 @"708012"

//信用卡列表
#define SIGNATURE_CMD_708013 @"708013"

//根据卡号判断银行名称
#define SIGNATURE_CMD_708010 @"708010"

//添加信用卡
#define SIGNATURE_CMD_708011 @"708011"

//删除信用卡
#define SIGNATURE_CMD_708014 @"708014"

#define wfbVersion         @"1.4"
#define cyhVersion         @"1.0"
#define xbtVersion         @"1.0"
#define hfbVersion         @"1.0"
#define lxzfVersion        @"1.0"
#define mfVersion          @"1.0"
#define wbhtVersion        @"1.0"
#define hxsnVersion        @"1.0"
#define iposnVersion        @"1.0"

#define hfVersion          @"1.0"

//上传附件
#define SIGNATURE_CMD_702704@"702704"

//验证码是否正确
#define SENDCODE_CMD_199019  @"199019"


#define CMD_JYM @"JYM"

// 屏蔽输出
#ifdef DEBUG
#   define ILog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define DLog(...) NSLog(__VA_ARGS__)
#   define ELog(err) if(err) ILog(@"%@", err)}
#else
#   define ILog(...)
#   define DLog(...) /* */
#   define ELog(err)
#endif

// 安全release
#define RELEASE_SAFELY(__POINTER) if(__POINTER){ [__POINTER release]; __POINTER = nil; }


// 自动适应 arc 和 非arc
// strong/weak  对应  retain/assign
#ifndef Y_STRONG
#if __has_feature(objc_arc)
    #define Y_STRONG strong
#else
    #define Y_STRONG retain
#endif
#endif

#ifndef Y_WEAK
#if __has_feature(objc_arc_weak)
    #define Y_WEAK weak
#elif __has_feature(objc_arc)
    #define Y_WEAK unsafe_unretained
#else
    #define Y_WEAK assign
#endif
#endif

// autorelease/release/retain 。copy 不用定义，arc和非arc一样。
#if __has_feature(objc_arc)
    #define Y_AUTORELEASE(exp) exp
    #define Y_RELEASE(exp) exp
    #define Y_RETAIN(exp) exp
#else
    #define Y_AUTORELEASE(exp) [exp autorelease]
    #define Y_RELEASE(exp) RELEASE_SAFELY(exp)
    #define Y_RETAIN(exp) [exp retain]
#endif


// resource path
#define kResourcePath(__Name,__Type) {[[NSBundle mainBundle] pathForResource:__Name ofType:__Type]}


// 取系统版本，e.g.  4.0 5.0
#define kSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

// 是否iphone5
//#define kIsIphone5 [UIScreen mainScreen].applicationFrame.size.height > 500
#define kIsIphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// 屏幕大小
#define kScreenFrame [UIScreen mainScreen].applicationFrame

#define MyAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]

// 判断string是否为空 nil 或者 @""；
#define IsNilString(__String) (__String==nil || [__String isEqualToString:@""])


// 横屏的frame
#define LANDSCAPE_FRAME CGRectMake(0, 20, 1024, 768-20)
#define LANDSCAPE_WIDTH 1024.0

// 竖屏的frame
#define PORTRAIT_FRAME CGRectMake(0, 20, 768, 1024-20)
//#define PORTRAIT_WIDTH 768.0
#define PORTRAIT_WIDTH 320.0

//RGB color macro
#define UIColorFrom0xRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//RGB color macro with alpha
#define UIColorFrom0xRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

// 从frame 中 获取 bound，即把 x、y 都改为0
CG_INLINE CGRect
CGRectBoundsFromFrame(CGRect frame)
{
    CGRect rect;
    rect.origin.x = 0; rect.origin.y = 0;
    rect.size.width = frame.size.width; rect.size.height = frame.size.height;
    return rect;
}


#define cyhbj [UIColor colorWithRed:234.0/255.0 green:83.0/255.0 blue:3.0/255.0 alpha:1.0]
#define xftbj [UIColor colorWithRed:255.0/255.0 green:73.0/255.0 blue:73.0/255.0 alpha:1.0]
#define hfbj [UIColor colorWithRed:111.0/255.0 green:156.0/255.0 blue:103.0/255.0 alpha:1.0]
#endif
