//
//  ViewContext.h
//  Breeze
//
//  Created by  on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewContext <NSObject>

@optional
- (void)attributeChanged:(NSString*)attribute from:(NSString*)from to:(NSString*)to;

@end
