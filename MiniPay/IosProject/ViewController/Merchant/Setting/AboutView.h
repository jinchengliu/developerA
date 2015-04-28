//
//  AboutView.h
//  MiniPay
//
//  Created by apple on 14-1-9.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "YMTableViewController.h"

#define kSettingMenuId         @"id"
#define kSettingMenuTitle      @"title"
#define kSettingMenuurl        @"url"
#define kSettingMenutellphone  @"tellphone"
#define kSettingMenuweibo      @"weibo"

@interface AboutView : YMTableViewController<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labl_title;
@property (strong, nonatomic) IBOutlet UIButton *btn_url;
@property (strong, nonatomic) IBOutlet UILabel *versionLable;
@property (strong, nonatomic) IBOutlet UIButton *btn_phone;
@property (strong, nonatomic) IBOutlet UIButton *btn_weibo;
@property (strong, nonatomic) IBOutlet UILabel *labl_title1;
@property (strong, nonatomic) IBOutlet UILabel *title_lable;


-(IBAction)CallNumb:(id)sender;
-(IBAction)OpenUrl:(id)sender;
-(IBAction)Openweibo:(id)sender;
@end
