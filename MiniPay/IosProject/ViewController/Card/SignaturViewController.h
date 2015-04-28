//
//  SignaturViewController.h
//  MiniPay
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyView.h"
typedef void(^FinshcaedBlock)(NSString *singmage);
@protocol SignatureDelegate <NSObject>

-(void)didFinishTrade:(BOOL)isSucess;

@end
@interface SignaturViewController : YMViewController
{
     id<SignatureDelegate> delegate;
    NSString *signatureImageStr;
    BOOL againsumit;


}
@property (nonatomic,retain)FinshcaedBlock finshcaedBlock;

@property(nonatomic,strong) NSString *money;
@property(nonatomic,strong) NSString *logno;
@property(nonatomic,assign) int type;
@property (retain, nonatomic) IBOutlet UIImageView *imageview1;
@property (retain,nonatomic)   MyView *drawView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property(nonatomic,assign) id<SignatureDelegate> delegate;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *moneylable;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lable;

-(IBAction)confirmBtn:(id)sender;

-(IBAction)cancelmBtn:(id)sender;
@end
