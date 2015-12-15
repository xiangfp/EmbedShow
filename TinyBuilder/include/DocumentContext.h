//
//  DocumentContext.h
//  Breeze
//
//  Created by  on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSFunction.h"

#import "Window.h"
@class Document, StyleSheet;
@interface DocumentContext : NSObject{
    Document        *_document;
    NSURL           *_uri;
    id<Window>      _window;
    
    DocumentContext *_parent;
}

- (id)initWithDocument:(Document *)document relativeURI:(NSURL *)uri;

#pragma mark access
@property (nonatomic, readonly) NSURL *uri;
@property (nonatomic, readonly) Document *document;
@property (nonatomic, assign) id<Window> window;
@property (nonatomic, assign) DocumentContext *parent;
@property (nonatomic, retain) JSFunction *jsFunction;

@end
