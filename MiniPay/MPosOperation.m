//
//  MPosOperation.m
//  PaxMPosDriverTest
//
//  Created by admin on 1/15/14.
//  Copyright (c) 2014 paxhz. All rights reserved.
//

#import "MPosOperation.h"
#import "PaxMPosManager.h"
#import "PaxMPosRetCodes.h"
#import "MposUtils.h"       //NOTE: this is private class used internally!

@implementation MPosOperation

- (id)initWithType:(MPosOperationType)type withName:(NSString *)name withArgNum:(int)argNum withArgs:(NSArray *)args withDelegate:(id<MPosOperationDelegate>)delegate {
    if (self = [super init]) {
        _type = type;
        _name = name;
        _argNum = argNum;
        _args = args;
        _delegate = delegate;
    }
    return self;
    
}

- (void)main
{
    @try {
        @autoreleasepool {
            PaxMPosManager *mpos = [PaxMPosManager sharedInstance];
            NSString *result = @"OK";
            switch (_type) {
                case OPER_START:
                {
                    BOOL ret = [mpos startBluetooth: _args[0]];
                    result = ret ? @"true" : @"false";
                    break;
                }
                case OPER_STOP:
                {
                    [mpos stopBluetooth];
                
                    break;
                }
                
                case OPER_SWIPE:
                {
                    NSString *track;
                    NSString *money = _args[0];
                    PaxMPosRetCode ret = [mpos swipeCardWithAmount:money withTrackData:&track];
                    if (ret == MPOS_OK) {
                        result = track;
                    } else {
                        result = [PaxMPosRetCodes code2String:ret];
                    }
                    break;
                }
                    
                case OPER_GET_PIN:
                {
                    NSString *pb;
                    
                    PaxMPosRetCode ret = [mpos getPinWithPinBlock:&pb];
                    if (ret == MPOS_OK) {
                        result = pb;
                    } else {
                        result = [PaxMPosRetCodes code2String:ret];
                    }
                    break;
                }
                
                case OPER_GET_SN:
                {
                    NSString *sn;
                    
                    PaxMPosRetCode ret = [mpos getTermSN:&sn];
                    if (ret == MPOS_OK) {
                        result = sn;
                    } else {
                        result = [PaxMPosRetCodes code2String:ret];
                    }
                    break;
                }
                    
                case OPER_WRITE_KEY:
                {
                    PaxMPosRetCode ret = [mpos writePinKey:_args[0] macKey:_args[1] desKey:_args[2]];
                    if (ret != MPOS_OK) {
                        result = [PaxMPosRetCodes code2String:ret];
                    }
                    break;
                }
                
                case OPER_GET_MAC:
                {
                    NSString *data = _args[0];
                    NSString *mac;
                    
                    PaxMPosRetCode ret = [mpos calcMacWithData:data withMac:&mac];
                    if (ret == MPOS_OK) {
                        result = mac;
                    } else {
                        result = [PaxMPosRetCodes code2String:ret];
                    }
                    break;
                }
                    
                case OPER_GET_PSAMNO:
                {
                    NSString *psamNo;
                    
                    PaxMPosRetCode ret = [mpos getPsamNo:&psamNo];
                    if (ret == MPOS_OK) {
                        result = psamNo;
                    } else {
                        result = [PaxMPosRetCodes code2String:ret];
                    }
                    break;
                }
                    
                case STOP:
                    [mpos stopBluetooth];
                    break;
               

            } // switch
            
            if ([_delegate respondsToSelector:@selector(taskFinishedWithResult:)]) {
                [(NSObject *)_delegate performSelectorOnMainThread:@selector(taskFinishedWithResult:) withObject:result waitUntilDone:NO];
            }
            
        }   // autooreleasepool
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}


@end
