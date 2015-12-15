//
//  Window.h
//  Breeze
//
//  Created by  on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

@class DocumentContext;
@protocol Window <NSObject>

@property (nonatomic, retain, readonly) DocumentContext *currentContext;
- (void)pushFromContext:(DocumentContext*)from toContext:(DocumentContext*)to;
- (void)popFromContext:(DocumentContext*)from toContext:(DocumentContext*)to;
@end
