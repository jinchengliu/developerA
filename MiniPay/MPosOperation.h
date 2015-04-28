//
//  MPosOperation.h
//  PaxMPosDriverTest
//
//  Created by admin on 1/15/14.
//  Copyright (c) 2014 paxhz. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    OPER_START,
    OPER_STOP,
    OPER_SWIPE,
    OPER_GET_PIN,
    OPER_GET_SN,
    OPER_WRITE_KEY,
    OPER_GET_MAC,
    OPER_GET_PSAMNO,
    STOP,
    
} MPosOperationType;

@protocol MPosOperationDelegate <NSObject>

- (void)taskFinishedWithResult:(NSString *)result;

@end


@interface MPosOperation : NSOperation

- (id)initWithType:(MPosOperationType)type withName:(NSString *)name withArgNum:(int)argNum withArgs:(NSArray *)args withDelegate:(id<MPosOperationDelegate>)delegate;

@property MPosOperationType type;
@property NSString *name;
@property int argNum;       // the declared number
@property NSArray *args;

@property id<MPosOperationDelegate> delegate;

@end
