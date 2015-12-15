//
//  View.h
//  Breeze
//
//  Created by  on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class Element, ElementContext;

@protocol View <NSObject>
#pragma mark life cle
- (id)initWithElement:(Element*)element;


#pragma mark property
@property (nonatomic, assign) ElementContext *context;

#pragma mark load
- (void)loadStyle;
- (void)loadElement;

#pragma mark change notify
- (void)attributeChanged:(NSString*)attribute from:(NSString*)from to:(NSString*)to;

#pragma mark layout
- (void)layout;
- (void)relayout;

@optional
/**
 *  加载布局结构  如Vbox Hbox
 */
-(void)loadStructure;

/**
 *  根据方向，加载新插入的数据
 */
-(void)loadNewElementsDirection:(NSString *)direction;

@end
