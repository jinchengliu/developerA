//
//  ViewUitls.h
//  CQRCBank_iPhone
//
//  Created by carlos on 12-12-9.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import <Foundation/Foundation.h>
// 在 YLabel和YTextfield 中使用，规定 加星的 类型。
typedef enum {
    SecureTextEntry_Non,  // 默认不加星
    SecureTextEntry_PhoneNo,  // 手机号
    SecureTextEntry_Name,     // 姓名
    SecureTextEntry_BankNo,    // 银行卡号
    SecureTextEntry_Money,      // 金额，加千分号
    SecureTextEntry_CredentialNO  // 客户信息中 给证件号码加星号 规则：(显示前一位、后两位，其余用“****”替换)改了，，前三后三啦
}SecureTextEntryType;

// 加星 的控制来源
typedef enum {
//    SecureTextEntryControlSource_Non,   // 默认没有任何控制，即 不加星号。
    SecureTextEntryControlSource_NonButEntryAlways, // 默认没有任何控制，但是 一直加星号
    SecureTextEntryControlSource_PreController, // 从前一页面控制
    SecureTextEntryControlSource_UserInfo  // 从UserInfo的 SAFE_OPEN_COLSE 控制。
}SecureTextEntryControlSource;

@interface ViewUitls : NSObject

#define setY(mView,y) mView.frame = CGRectMake(mView.frame.origin.x, y, mView.frame.size.width, mView.frame.size.height)
//根据间隔值和上面的view来确定当前view的y坐标
#define setYWithAboveView(mView,interval,aboveView) mView.frame = CGRectMake(mView.frame.origin.x, aboveView.frame.origin.y + aboveView.frame.size.height+interval, mView.frame.size.width, mView.frame.size.height)

//设置scrollview的总高度，根据最后的view的y和height
#define  setContentSize(lastView) CGSizeMake(k_frame_base_width, lastView.frame.origin.y + lastView.frame.size.height +30)
//获取自动伸缩的图片
+(UIImage *)createCapImage:(NSString *)mImageName;

//获取各种详情界面的居中按钮
+(UIButton *)createDetailViewBtnWithY:(int )y withDelegate:(id)mDelegate whithBtnName:(NSString *)mBtnName withSEL:(SEL)onClickSEL;

//根据point创建imageview，大小为image的size
+(UIImageView *)createImageViewWithImageName:(NSString *)mImageName withPoint:(CGPoint)mPoint;
//格式化金额
+(NSString *)insertMicrometerSymbolToMoney:(NSString *)money;


#pragma mark - // 对字符串加星号
+ (NSString *)encryptString:(NSString *)string
    withsecureTextEntryType:(SecureTextEntryType)secureTextEntryType;

#pragma mark - // 登录 按钮 的图片
+(UIImage *)loginButtonNormalImage;
+(UIImage *)loginButtonHighlightImage;
#pragma mark - // 豆腐块背景的图片
+(UIImage *)cornerViewBackgroundImage;
#pragma mark - // 获取验证码按钮的图片
+(UIImage *)getAuthCodeButtonNormalBackgroundImage;
+(UIImage *)getAuthCodeButtonHighlightBackgroundImage;

#pragma mark - // 蓝底 的背景图片,激活界面，公告界面用到
+(UIImage *)blueBackgroundImage;

+(UIImage *)grayBackgroundImage;

#pragma mark - // 选择按钮，（下三角图片）不用放在input输入框里的。
+(UIImage *)choosePickerButtonNormalImage;
+(UIImage *)choosePickerButtonHighlightImage;

@end
