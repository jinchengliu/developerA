//
//  VouchUsViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//推荐我们
#import "VouchUsViewController.h"

@interface VouchUsViewController ()

@end

@implementation VouchUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setpageTitle:@"推荐我们"];
    //self.title=@"推荐我们";
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 1;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    if(indexPath.section==0){
        return self.sinaCell;
    }else{
        if(indexPath.row==0){
            return self.weixinCell;
        }else{
            return self.weixinFriCell;
        }
    }
    return nil;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){  //分享微博
        
        WBMessageObject *message = [WBMessageObject message];
        if([DataManager sharedDataManager].postype_Vison!=wfb)
        {
            NSString *text=[[DataManager sharedDataManager].seetingdict objectForKey:@"weixindecp"];
            message.text = text;
        }
        else
        message.text = SHAIR_CONTENT;
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:request];
        
    }else{
        if(indexPath.row==0){  //分享微信
            _scene=WXSceneSession;
            
        }else{   //分享朋友圈
            _scene=WXSceneTimeline;
        }
        [self sendTextContent];
    }

    
}

- (void) sendTextContent
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    if([DataManager sharedDataManager].postype_Vison!=wfb)
    {
        
        NSString *text=[[DataManager sharedDataManager].seetingdict objectForKey:@"weixindecp"];

       req.text = text;
    }
    else
    req.text = SHAIR_CONTENT;
    req.bText = YES;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
