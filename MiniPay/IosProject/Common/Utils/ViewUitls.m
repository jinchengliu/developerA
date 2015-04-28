//
//  ViewUitls.m
//  CQRCBank_iPhone
//
//  Created by carlos on 12-12-9.
//  Copyright (c) 2012年 magic-point. All rights reserved.
//

#import "ViewUitls.h"

@implementation ViewUitls

//获取自动伸缩的图片
+(UIImage *)createCapImage:(NSString *)mImageName
{
    UIImage *backImage = [ViewUitls cornerViewBackgroundImage];
    
    // set image
//    if (kSystemVersion < 5.0) {
//        backImage = [backImage stretchableImageWithLeftCapWidth:20.0 topCapHeight:20.0];
//    }else if (kSystemVersion <6.0) {
//        backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)];
//    }else if (kSystemVersion >= 6.0) {
//        backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0) resizingMode:UIImageResizingModeTile];
//    }
    
    return backImage;
}

//获取各种详情界面的居中按钮
+(UIButton *)createDetailViewBtnWithY:(int )y withDelegate:(id)mDelegate whithBtnName:(NSString *)mBtnName withSEL:(SEL)onClickSEL
{
    UIButton *_queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        _queryBtn.frame = kListBtnFrame;
    [_queryBtn setTitle:mBtnName forState:UIControlStateNormal];
    UIImage *normalImage = [ViewUitls loginButtonNormalImage];
    
    UIImage *highlightImage = [ViewUitls loginButtonHighlightImage];
    [_queryBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    _queryBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    
    [_queryBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [_queryBtn addTarget:mDelegate action:onClickSEL forControlEvents:UIControlEventTouchUpInside];
    
    int width = highlightImage.size.width;
    
    CGRect frame = CGRectMake(k_frame_base_width/2 - width/2, y, width, 30);
    _queryBtn.frame = frame;
    return _queryBtn;
}

//根据point创建imageview，大小为image的size
+(UIImageView *)createImageViewWithImageName:(NSString *)mImageName withPoint:(CGPoint)mPoint
{
    UIImage *image = [UIImage imageNamed:mImageName];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(mPoint.x, mPoint.y, image.size.width, image.size.height)];
    imageView.image = image;
    return imageView;
}

#pragma mark - // 登录 按钮 的图片
+(UIImage *)loginButtonNormalImage {
    UIImage *normalImage = [UIImage imageNamed:kImage_loginButton];
    normalImage = [normalImage stretchableImageWithLeftCapWidth:5.0 topCapHeight:5.0];
    
    return normalImage;
}

+(UIImage *)loginButtonHighlightImage {
    UIImage *highlightImage = [UIImage imageNamed:kImage_loginButtonDown];
    highlightImage = [highlightImage stretchableImageWithLeftCapWidth:5.0 topCapHeight:5.0];
    
    return highlightImage;
}

#pragma mark - // 豆腐块背景的图片
+(UIImage *)cornerViewBackgroundImage {
    UIImage *backImage = [UIImage imageNamed:kImage_CellBackgroundImage];
    // set image
    backImage = [backImage stretchableImageWithLeftCapWidth:8.0 topCapHeight:8.0];
    
    return backImage;
}

#pragma mark - // 获取验证码按钮的图片
+(UIImage *)getAuthCodeButtonNormalBackgroundImage {
    UIImage *image = [UIImage imageNamed:kImage_Btn_SendAuthCode_Nomal];
    
    // set image
    image = [image stretchableImageWithLeftCapWidth:8.0 topCapHeight:8.0];
    
    return image;
}
+(UIImage *)getAuthCodeButtonHighlightBackgroundImage {
    UIImage *highlight = [UIImage imageNamed:kImage_Btn_SendAuthCode_Down];
    // set image
    highlight = [highlight stretchableImageWithLeftCapWidth:8.0 topCapHeight:8.0];
    
    return highlight;
}

#pragma mark - // 蓝底 的背景图片,激活界面
+(UIImage *)blueBackgroundImage {
    UIImage * image = [UIImage imageNamed:kImage_Announcementment_Backgound];
    image = [image stretchableImageWithLeftCapWidth:10.0f topCapHeight:30.0f];
    
    return image;
}

#pragma mark - // 蓝底 的背景图片公告界面用到
+(UIImage *)grayBackgroundImage {
    UIImage * image = [UIImage imageNamed:kImage_Announcementment_Backgound_Orther];
    image = [image stretchableImageWithLeftCapWidth:10.0f topCapHeight:30.0f];
    
    return image;
}

// 选择的按钮 （下三角图片），放在input输入框里面的。

#pragma mark - // 选择按钮，（下三角图片）不用放在input输入框里的。
+(UIImage *)choosePickerButtonNormalImage {
    UIImage * image = [UIImage imageNamed:kImage_Btn_ChoosePicker_Normal];
    image = [image stretchableImageWithLeftCapWidth:6.0f topCapHeight:23.0f];
    
    return image;
}

+(UIImage *)choosePickerButtonHighlightImage {
    UIImage * image = [UIImage imageNamed:kImage_Btn_ChoosePicker_Highlight];
    image = [image stretchableImageWithLeftCapWidth:6.0f topCapHeight:23.0f];
    
    return image;
}

#pragma mark - // 对字符串加星号
+ (NSString *)encryptString:(NSString *)string
    withsecureTextEntryType:(SecureTextEntryType)secureTextEntryType{
    
    NSMutableString *encry = [NSMutableString stringWithFormat:@"%@",string];
    if (!IsNilString(string)) {
        NSRange range = NSMakeRange(0, 0);
        NSError* error = NULL;
        switch (secureTextEntryType) {
            case SecureTextEntry_Non:
                
                break;
            case SecureTextEntry_PhoneNo:
            {
                NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]{11}"
                                                                                       options:0
                                                                                         error:&error];
                NSString *result = [ViewUitls subStringFromEncryptString:string withRegex:regex];
                if (IsNilString(result) == NO) {
                    range = [string rangeOfString:result];
                    
                    NSRange range2 = NSMakeRange(3, 4);
                    
                    NSRange finalRange = NSMakeRange(range2.location+range.location, range2.length);
                    
                    if (encry.length >= finalRange.location+finalRange.length) {
                        [encry replaceCharactersInRange:finalRange withString:@"****"];
                    }
                }
                
            }
                break;
            case SecureTextEntry_Name:
            {
                if (encry.length >=2) {
                    range = NSMakeRange(encry.length-2, 1);
                    if (encry.length >= range.location+range.length) {
                        [encry replaceCharactersInRange:range withString:@"*"];
                    }
                }
               
            }
                break;
            case SecureTextEntry_BankNo:
            {
                NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]{16}|[0-9]{18}|[0-9]{19}"
                                                                                       options:0
                                                                                         error:&error];
                NSString *result = [ViewUitls subStringFromEncryptString:string withRegex:regex];
                if (IsNilString(result) == NO) {
                    range = [string rangeOfString:result];
//                    6228671141487042asdf
                    NSRange range2 = NSMakeRange(7, 5);
                    NSRange finalRange = NSMakeRange(range2.location+range.location, range2.length);
                    
                    if (encry.length >= finalRange.location+finalRange.length) {
                        [encry replaceCharactersInRange:finalRange withString:@"*****"];
                    }
                }
            }
                break;
            case SecureTextEntry_Money:
            {
                encry = (NSMutableString *)[ViewUitls insertMicrometerSymbolToMoney:encry];
            }
                break;
            case SecureTextEntry_CredentialNO: // 客户信息中 给证件号码加星号 规则：(显示前一位、后两位，其余用“****”替换) 改了 改为前三后三了
            {
                if (encry.length > 3 ) {
                    NSString * firstOneChar = [encry substringToIndex:3];//前三位，
                    NSString * lastTwoChar = [encry substringFromIndex:string.length-3];//后三位
                    
                    NSMutableString * appendStr = [[NSMutableString alloc] initWithCapacity:5];
                    for (int i = 3; i < encry.length - 3; i ++) {
                        [appendStr appendString:@"*"];
                    }
                    encry = [NSMutableString stringWithFormat:@"%@%@%@",firstOneChar,appendStr,lastTwoChar];
                }
            }
                break;
            default:
                break;
        }
    }
    return encry;
}
// 从 字符串中 找到 需要加星的 字符串。例如：从 abcd15816390528efghi 中找到需要加星 手机号。
+ (NSString *)subStringFromEncryptString:(NSString *)string withRegex:(NSRegularExpression *)regex {
   
    NSString *result = nil;
    NSString* sample = string;
    //    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<=title\\>).*(?=</title)" options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:sample
                                                           options:0
                                                             range:NSMakeRange(0, [sample length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            
            //从urlString当中截取数据
            result=[sample substringWithRange:resultRange];
            //输出结果

        }
        
    }
//    NSRange range = NSMakeRange(0, 0);
//    
//    range = [string rangeOfString:result];
    
    return result;
}

#pragma mark - // 给数字 加 千分符号,保留两位 小数。
+ (NSString *)insertMicrometerSymbolToMoney:(NSString *)money {
    // 先判断money  中间 是否有 “,”。
    NSRange range1 = [money rangeOfString:@","];
    if (range1.location != NSNotFound) {
        return money;
    }
    
    NSString *mMoney = [NSString stringWithFormat:@"%.2f",money.doubleValue];
    
    // 12345.678   12345723
    NSRange range = NSMakeRange(0, mMoney.length);
    
    // 取整数部分。
    NSRange digitalRange = [mMoney rangeOfString:@"."];
    
    if (digitalRange.location != NSNotFound) {
        range.length = digitalRange.location;
    }
    NSString *subString1 = [mMoney substringFromIndex:digitalRange.location];
    
    NSString *subString = [mMoney substringWithRange:range];
    
    NSMutableString *result = [[NSMutableString alloc] initWithString:subString];
    for (int i = 1; i < subString.length ; i++) {
        if (i%3 == 0) {
            if (subString.length-i != 0) {
                [result insertString:@"," atIndex:subString.length-i];
            }
        }
    }
    return [NSString stringWithFormat:@"%@%@",result,subString1];
}

@end
