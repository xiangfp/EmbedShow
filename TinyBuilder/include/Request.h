//
//  Request.h
//  Breeze
//
//  Created by  on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDelegate.h"

@interface Request : NSObject {
	//delegate
	id<NetworkDelegate>     _delegate;
	
	//config
	RequestMethod           _method;
	QueuePriority           _priority;
	CachePolicy             _policy;
	
	//info
	NSURL                   *_uri;
	NSMutableDictionary     *_header;
	NSMutableDictionary     *_parameters;
	NSString                *_postFields;
}

#pragma mark life cle
- (id)initWithURIString:(NSString*)string relativeToURL:(NSURL*)base delegate:(id<NetworkDelegate>)delegate;
+ (id)requestWithURIString:(NSString*)string relativeToURL:(NSURL*)base delegate:(id<NetworkDelegate>)delegate;

#pragma mark property
@property (nonatomic, assign) id<NetworkDelegate> delegate;
@property (nonatomic, assign) RequestMethod method;
@property (nonatomic, assign) QueuePriority priority;
@property (nonatomic, assign) CachePolicy policy;
@property (nonatomic, retain, readonly) NSURL *uri;
@property (nonatomic, retain, readonly) NSMutableDictionary *header;
@property (nonatomic, retain, readonly) NSMutableDictionary *parameters;
@property (nonatomic, retain) NSString *postFields;

@end
