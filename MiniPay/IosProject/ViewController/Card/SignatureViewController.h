//
//  SignatureViewController.h
//  MiniPay
//
//  Created by allen on 13-12-4.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAScratchPadView.h"
#import "TradeResultViewController.h"
#import "AESUtil.h"


@protocol SignatureDelegate <NSObject>

-(void)didFinishTrade:(BOOL)isSucess;

@end

@interface SignatureViewController : YMViewController<UIAlertViewDelegate>{
    
    id<SignatureDelegate> delegate;
    
    NSString *signatureImageStr;

    
}

@property(nonatomic,strong) NSString *money;
@property(nonatomic,strong) NSString *logno;
@property(nonatomic,assign) int type;
@property(nonatomic,assign) id<SignatureDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

-(IBAction)confirmBtn:(id)sender;

-(IBAction)cancelmBtn:(id)sender;


@end
