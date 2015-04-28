//
//  CreditCardCell.m
//  MiniPay
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "CreditCardCell.h"

@interface CreditCardCell ()

@end

@implementation CreditCardCell
@synthesize delegate=_delegate;

-(IBAction)DeleteCreditCardBtn:(id)sender
{
    UIButton *btn=sender;
    if([_delegate respondsToSelector:@selector(deletecreditcrd:)]){
        [_delegate deletecreditcrd:btn.tag];
    }

}
@end
