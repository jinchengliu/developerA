//
//  PaxMPosManager.h
//  PaxMPosManager
//
//  Created by admin on 4/16/14.
//  Copyright (c) 2014 pax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaxMPosRetCodes.h"

@interface PaxMPosManager : NSObject

+ (id) sharedInstance;
- (BOOL)startBluetooth:(const NSString *)deviceIdentifier;
- (void)stopBluetooth;
- (PaxMPosRetCode)swipeCardWithAmount:(const NSString *)amount withTrackData:(NSString **)trackData;
- (PaxMPosRetCode)getPinWithPinBlock:(NSString **)pinblock;
- (PaxMPosRetCode)calcMacWithData:(const NSString *)data withMac:(NSString **)mac;
- (PaxMPosRetCode)getTermSN:(NSString **)sn;
- (PaxMPosRetCode)getPsamNo:(NSString **)psamNo;
- (PaxMPosRetCode)writePinKey:(const NSString *)pinKey macKey:(const NSString *)macKey desKey:(const NSString *)desKey;

@end
