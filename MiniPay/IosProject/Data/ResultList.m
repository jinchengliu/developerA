//
//  ResultList.m
//  Macalline
//
//  Created by chen wang on 12-4-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResultList.h"

@implementation ResultList
@synthesize isSuccess=_isSuccess;
@synthesize count = _count;
@synthesize errorCode=_errorCode;
@synthesize isEnd = _isEnd;
@synthesize nextStartIndex = _nextStartIndex;
@synthesize list = _list;

- (void)dealloc {
    [_list release];
    [super dealloc];
}

- (id)initWithCount:(NSInteger)count list:(NSArray *)list {
    self = [super init];
    if (self) {
        _count = count;
        _list = [list retain];
    }
    return self;
}


/*
- (YMDecodingFactory *)objectDecodingFactory {
    return nil;
}

+ (YMDecodingFactory *)decodingFactory {
    return nil;    
}
 */

- (id)initWithData:(NSDictionary *)data {
    
    //NSLog(@"====%@",data);
    self = [super init];
    if (self) {
        _isSuccess=[[data objectForKey:@"success"] boolValue];
        _isEnd = [[data objectForKey:@"isEnd"] boolValue];
        _count = [[data objectForKey:@"count"] intValue];
        _errorCode = [[data objectForKey:@"errorcode"] intValue];
        _nextStartIndex = [[data objectForKey:@"nextstartindex"] intValue];
        NSArray *datas = [data objectForKey:@"data"];
        if (datas && [datas count] > 0) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[datas count]];
            for (int i=0; i < [datas count]; i++) {
                id decodingData = [[self objectDecodingFactory] initWithData:[datas objectAtIndex:i]];
                [arr addObject:decodingData];
                [decodingData release];
            }
            _list = arr;
        }
    }
    NSLog(@"~~~~~~~~~~~~~~~nextindex:%d",_nextStartIndex);
    //NSLog(@"isend:%d",_isEnd);

    return self;
}

/*
- (NSString *)description {
    return [_list description];
}
 */


@end
