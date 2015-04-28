//
//  ResultList.h
//  Macalline
//
//  Created by chen wang on 12-4-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMDecodingProtocol.h"

@interface ResultList : NSObject <YMDecodingProtocol>

@property (nonatomic, readonly) BOOL isSuccess;
@property (nonatomic, readonly) NSInteger isEnd;
@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) NSInteger errorCode;
@property (nonatomic, readonly) NSInteger nextStartIndex;
@property (nonatomic, readonly) NSArray *list;

- (YMDecodingFactory *)objectDecodingFactory;

- (id)initWithData:(NSDictionary *)data;

- (id)initWithCount:(NSInteger)count list:(NSArray *)list;
@end
