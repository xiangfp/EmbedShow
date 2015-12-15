//
//  WindowsManagerProtocol.h
//  Breeze
//
//  Created by  on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Window.h"

@class Request, Hsml, DocumentContext;

@protocol WindowsManagerProtocol

#pragma mark push & pop & cancel
- (void)window:(id)window requestPage:(Request*)request;
- (void)window:(id)window cancelRequest:(Request*)request;
- (void)window:(id)window pushContext:(DocumentContext*)context;
- (void)window:(id)window popToContext:(NSString*)pageID;
- (void)windowClear:(id)window;

#pragma mark -
#pragma mark window simulate control
- (void)registerAsWindow:(id<Window>)window;
- (void)unregisterWindow:(id<Window>)window;

#pragma mark window control
- (void)openWindowWithContext:(DocumentContext*)context;
- (void)openWindowWithRequest:(Request*)request;
- (void)openWindowUnLockWithRequest:(Request*)request;
- (void)closeWindow:(id)window;
- (void)openWindowWithURL:(NSString *)url width:(NSString *)width height:(NSString *) height;
- (void)openWindowWithURL:(NSString *)url width:(NSString *)width height:(NSString *) height animated:(BOOL)animated;


#pragma template
- (void)window:(id)window target:(NSString *)target;




#pragma mark -
#pragma mark get window
@property (nonatomic, readonly) Hsml *mainWindow;
@property (nonatomic, readonly) Hsml *currentWindow;
@property (nonatomic, readonly) NSArray *windows;


@end