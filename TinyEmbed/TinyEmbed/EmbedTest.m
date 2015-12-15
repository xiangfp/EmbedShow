//
//  EmbedTest.m
//  TinyEmbed
//
//  Created by xiangfp on 15/12/8.
//  Copyright © 2015年 Sunline. All rights reserved.
//

#import "EmbedTest.h"
#import "Box.h"
#import "ElementContext.h"

@implementation EmbedTest

- (id)initWithElement:(Element*)element {
    if (self = [super initWithElement:element]) {
        self.button = [[UIButton alloc] init];
        [self.button setTitle:@"BUTTON" forState:UIControlStateNormal];
        
        [self.button addTarget:self action:@selector(onclick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.button];
    }
    return self;
}

-(void)onclick{
    [self executiveEvent:@"embedClick" data:@""];
}




- (void)layout {
    [super layout];
    
    Box *box = _context.box;
    
    //page & control
    float fixedWidth = box.fixedWidth;
    float fixedHeight = box.fixedHeight;
    
    CGSize size = CGSizeMake(100, 100);
    if (fixedWidth >= 0) {
        size.width = fixedWidth;
    }
    if (fixedHeight >= 0) {
        size.height = fixedHeight;
    }
    size = [box sizeOutsetPadding:size];
    self.frame = (CGRect){self.frame.origin, size};
    self.button.frame = self.bounds;

}


-(void)setParam:(NSString *)name value:(NSString *)value
{
    [super setParam:name value:value];
}


@end
