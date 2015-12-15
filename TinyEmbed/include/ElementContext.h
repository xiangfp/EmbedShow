//
//  ElementContext.h
//  Breeze
//
//  Created by  on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "View.h"
#import "ViewContext.h"
@class Element, Box, Styles, Border, Background;
@interface ElementContext : NSObject{
    Element             *_element;
    UIView<View>        *_view;
    id<ViewContext>     _viewContext;
    
    Box                 *_box;
    Styles              *_styles;
//    Border              *_border;
    Background          *_background;
    
    BOOL                _absolute;
    BOOL                _relative;
    CGPoint             _offset;
    NSString            *_type;
    CGSize              _layoutSize;
}

- (id)initWithElement:(Element *)element;
#pragma mark access
@property (nonatomic, assign) Element *element;
@property (nonatomic, assign) UIView<View> *view;
@property (nonatomic, retain) id<ViewContext> viewContext;


#pragma mark change notify
- (void)attributeChanged:(NSString*)attribute from:(NSString*)from to:(NSString*)to;

#pragma mark style
- (void)loadStyles;
//- (void)setStyle:(NSString*)name value:(NSString*)value;
- (void)loadPseudo:(NSString*)pseudo;
- (void)loadGroupPseudo:(NSString*)pseudo;
- (ElementContext*)positionedElement:(Element*)element;
- (void)positionWithStyles:(NSDictionary*)style withType:(NSString*)type;
- (CGFloat)lineHeight;
-(void)setBackgroundImage:(UIImage *)image;



@property (nonatomic, readonly) NSDictionary *styles;
@property (nonatomic, readonly) NSDictionary *inlineStyles;
@property (nonatomic, readonly) Box *box;
@property (nonatomic, readonly) UIFont *font;
@property (nonatomic, readonly) UIColor *fontColor;
@property (nonatomic, assign) BOOL absolute;
@property (nonatomic, assign) BOOL relative;
@property (nonatomic, assign) CGPoint offset;
@property (nonatomic, assign) NSString *floatType;
@property (nonatomic, assign) CGSize layoutSize;

/**
 *  上次加载的element元素
 */
@property(nonatomic, assign) Element *lastChildElement;

@property(nonatomic, assign) Element *firstChildElement;



#pragma mark draw
//- (void)drawBorderInContext:(CGContextRef)context bounds:(CGRect)bounds InView:(UIView*)view;
- (void)drawBackgroundInContext:(CGContextRef)context bounds:(CGRect)bounds;
@end
