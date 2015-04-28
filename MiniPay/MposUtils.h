//
//  Utils.h
//  MposApi
//
//  Created by admin on 6/3/13.
//  Copyright (c) 2013 paxhz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MposUtils : NSObject

+ (BOOL)is_human_readable:(Byte) ch;
+ (void)randomBytes:(Byte  *)bytes len:(UInt32)len ;
+ (void)hexDump:(const Byte  *)buf len:(UInt32)len header:(const Byte  *)header;
+ (NSString  *)byte2HexStrUnformatted:(const Byte  *)buf bufLen:(UInt32)bufLen offset:(UInt32)offset len:(UInt32)len;
+ (NSString  *)byte2HexStrForLog:(const Byte  *)buf bufLen:(UInt32)bufLen offset:(UInt32)offset len:(UInt32)len;
+ (NSString  *)byte2HexStr:(const Byte  *)buf bufLen:(UInt32)bufLen offset:(UInt32)offset len:(UInt32)len;
+ (NSString  *)bcd2Str:(const Byte  *)bytes len:(UInt32)len;
+ (UInt32)str2Bcd:(const NSString  *)asc to:(Byte *)bcd;

+ (void)intValue:(UInt32)x to:(Byte *)byteArray offset:(UInt32)offset bigEndian:(BOOL)flag;
+ (void)shortValue:(UInt16)x to:(Byte *)byteArray offset:(UInt32)offset bigEndian:(BOOL)flag;
+ (UInt32)intValueFrom:(const Byte *)byteArray offset:(UInt32)offset bigEndian:(BOOL)flag;
+ (UInt16)shortValueFrom:(const Byte *)byteArray offset:(UInt32)offset bigEndian:(BOOL)flag;
@end
