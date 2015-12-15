//
//  JSFunction.h
//  Tiny
//
//  Created by xiangfp on 15/5/22.
//  Copyright (c) 2015年 xiangfp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Document.h"
#import "JSWindow.h"
#import <JavaScriptCore/JSContext.h>


@interface JSFunction : NSObject
{
}

-(void)evaluateScript:(NSString *)script;

-(void)addDocument:(Document *)document;

@property(nonatomic, strong)   JSContext *jsContext;

@property(nonatomic, strong)   JSWindow *jsWindow;


@end
