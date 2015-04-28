//
//  BankMassage.h
//  MiniPay
//
//  Created by apple on 14-4-9.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankMassage : NSObject
@property (nonatomic, copy)NSString*bank_Id;
@property (nonatomic, copy)NSString*bank_Name;
@property(nonatomic,copy)NSString*bank_No;
@property (nonatomic, copy)NSString*bank_Showname;

-(id)initWithIdAndName:(NSString*)bkid andNmame:(NSString*)bkname;

@end
