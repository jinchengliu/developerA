//
//  AddCreditCardCell.m
//  MiniPay
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "AddCreditCardCell.h"

@interface AddCreditCardCell ()

@end

@implementation AddCreditCardCell

@synthesize delegate=_delegate;
-(IBAction)AddCreditCardBtn:(id)sender
{

    if([_delegate respondsToSelector:@selector(addCreditCard)]){
        [_delegate addCreditCard];
    }
}

@end
