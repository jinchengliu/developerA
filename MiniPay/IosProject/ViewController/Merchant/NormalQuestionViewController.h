//
//  NormalQuestionViewController.h
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    zhuce=0,
    shuaka=1,
    chongzhi=2,
    xinyoongka=3,
    cjwt=4,
    zhuanzhang=5,
    tixian=6
    
} urltype;


@interface NormalQuestionViewController : YMTradeBaseController<UIWebViewDelegate>{
    
    
}
@property (nonatomic,assign) urltype url_type;

@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *webView;

@end
