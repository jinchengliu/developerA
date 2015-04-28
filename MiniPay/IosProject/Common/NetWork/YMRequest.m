//
//  EDRequest.m
//  EDrivel
//
//  Created by chen wang on 11-11-20.
//  Copyright (c) 2011年 bonet365.com. All rights reserved.
//

#import "YMRequest.h"
#import "YMDecodingProtocol.h"
#import "StatusMessage.h"


@implementation YMRequest

@synthesize result = _result;
@synthesize requestDelegate = _requestDelegate;
@synthesize responseClass=_responseClass;

+ (void)initialize {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
}



- (void)setRequestDelegate:(id<YMRequestDelegate>)requestDelegate {
    [_requestDelegate autorelease];
    _requestDelegate = [requestDelegate retain];
    self.delegate = self;
}

- (void)requestFinished:(ASIHTTPRequest *)aRequest {
    DLog(@"====requestUrl:%@", aRequest.url);
    NSString *responseString = aRequest.responseString;
    
    DLog(@"====responseStr:%@",responseString);
    
    id jsonValue = [responseString JSONValue];
    if (jsonValue) {
        NSDictionary *dataDict = jsonValue;
        
      
        if (_responseClass) {
            Class responseClass = NSClassFromString(_responseClass);
            id decodingData=[[[[responseClass alloc] init] initWithData:dataDict] autorelease];
                
            self.result = decodingData;
        } else {
            self.result = dataDict;
        }

        [_requestDelegate requestFinished:self];        
    } else {
        self.result = [[[StatusMessage alloc] initWithErrorcode:1000 errorInfo:@"后台服务异常，请稍后再试"] autorelease];
        [_requestDelegate requestFailed:self];                    
    }
    if (jsonValue) {
        DLog(@"result:%@", self.result);
    } else {
        DLog(@"result:%@", responseString);
    }
}

- (void)requestFailed:(ASIHTTPRequest *)aRequest {
    DLog(@"url:%@", aRequest.url);
    DLog(@"url:%@ \nrequestFailed:%@",aRequest.url, aRequest.error);
     self.result = [[[StatusMessage alloc] initWithErrorcode:1000 errorInfo:@"后台服务异常，请稍后再试"] autorelease];
    [_requestDelegate requestFailed:self];
}

- (void)dealloc {
    [self cancel];
    self.delegate = nil;
    
    [_result release];
    [_requestDelegate release];
    
    [super dealloc];
}

@end
