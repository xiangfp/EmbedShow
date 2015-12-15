//
//  NetworkConstants.h
//  Breeze
//
//  Created by  on 12-7-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark scheme

static NSString * const kSchemeFile		= @"file";
static NSString * const kSchemeHTTP		= @"http";
static NSString * const kSchemeHTTPS	= @"https";

#pragma mark UA
#define kUAiPhone   "iPhone"
#define kUAiPad     "iPad"


#pragma mark -
#pragma mark method
typedef enum RequestMethod {
	RequestMethodGet,
	RequestMethodPost,
	RequestMethodPut,
	RequestMethodDelete,
	RequestMethodHead,
	RequestMethodOption,
	RequestMethodTrace,
	RequestMethodConnect,
	RequestMethodNone
} RequestMethod;

#define RequestMethodDefault RequestMethodGet
NSString* StringForRequestMethod(RequestMethod method);
RequestMethod RequestMethodForString(NSString *string);


#pragma mark -
#pragma mark priority level
typedef enum QueuePriority {
	QueuePriorityPageResource = 1,
	QueuePriorityLocalResource = 2,
	QueuePriorityRemoteResource = 3,
} QueuePriority;

#define QueuePriorityDefault QueuePriorityRemoteResource


#pragma mark -
#pragma mark cache poli
typedef enum CachePolicy {
	CachePoliPersist,
	CachePoliExpire,
	CachePoliNoCache
} CachePolicy;

#define CachePoliDefault CachePoliNoCache


#pragma mark -
#pragma mark status code
typedef enum HttpStatusCode {
	HttpStatusCodeContinue = 100,
	HttpStatusCodeOK = 200,
	HttpStatusCodeMultiChoice = 300,
	HttpStatusCodeBadRequest = 400,
	HttpStatusCodeServerError = 500
} HttpStatusCode;


#pragma mark -
#pragma mark network error code
typedef enum NetworkErrorCode {
    NetworkErrorNone,
    NetworkErrorInvalidHost,
    NetworkErrorOpenFailed,
    NetworkErrorWriteFailed,
    NetworkErrorReadFailed,
    NetworkErrorTimeout = 28,
    NetworkErrorParseFailed,
    NetworkErrorEncapsulateFailed,
	NetworkErrorBadRequest,
    NetworkErrorNotFound = 404,
    NetworkErrorOther
} NetworkErrorCode;

NSString* MessageForErrorCode(NetworkErrorCode code);