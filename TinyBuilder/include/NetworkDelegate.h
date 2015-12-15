//
//  NetworkDelegate.h
//  Breeze
//
//  Created by  on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NetworkConstants.h"

@class Request, Response;

@protocol NetworkDelegate <NSObject>
- (void)request:(Request*)request didFinishedWithResponse:(Response*)response;
- (void)request:(Request*)request didFailWithError:(NetworkErrorCode)error;
@optional
- (void)request:(Request *)request responseTotalSize:(NSNumber *)total currentSize:(NSNumber *)current;
- (void)request:(Request *)request didReceiveDataWithBytes:(const void *)bytes length:(NSUInteger)length;
@end
