//
//  Response_199009_Model.h
//  MiniPay
//
//  Created by allen on 13-11-28.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponseModel.h"

@interface Response_199009_Model : BaseResponseModel

@property (nonatomic, copy) NSString *BRAACTNO;
@property (nonatomic, copy) NSString *MERNAM;
@property (nonatomic, copy) NSString *OPNBNK;
@property (nonatomic, copy) NSString *TXNENDDT;
@property (nonatomic, copy) NSString *TOTTXNCNT;
@property (nonatomic, copy) NSString *CRDFLG;
@property (nonatomic, copy) NSString *STLDT;
@property (nonatomic, copy) NSString *STLTOTALAMT;
@property (nonatomic, copy) NSString *TOTTXNAMT;
@property (nonatomic, copy) NSString *TXNSTRDT;


@end
