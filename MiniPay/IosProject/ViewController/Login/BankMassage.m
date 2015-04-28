//
//  BankMassage.m
//  MiniPay
//
//  Created by apple on 14-4-9.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "BankMassage.h"

@implementation BankMassage
@synthesize bank_Id=_bank_Id;
@synthesize bank_Name=_bank_Name;
@synthesize bank_No=_bank_No;
@synthesize bank_Showname=_bank_Showname;
-(id)initWithIdAndName:(NSString*)bkid andNmame:(NSString*)bkname andbankno:(NSString*)bankno andshowname:(NSString*)showname
{
    _bank_Id=bkid;
    _bank_Name=bkname;
    _bank_No=bankno;
    _bank_Showname=showname;
    return self;
    
}
-(id)initWithIdAndName:(NSString*)bkid andNmame:(NSString*)bkname{
    _bank_Id=bkid;
    _bank_Name=bkname;
    
    return self;
    
}
@end
