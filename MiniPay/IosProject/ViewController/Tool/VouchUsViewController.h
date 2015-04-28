//
//  VouchUsViewController.h
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WeiboSDK.h"

@interface VouchUsViewController : YMTableViewController<WXApiDelegate>{
    
    enum WXScene _scene;
}
@property (strong, nonatomic) IBOutlet UITableViewCell *sinaCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *weixinCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *weixinFriCell;



@end
