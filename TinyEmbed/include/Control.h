//
//  Control.h
//  Breeze
//
//  Created by  on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "View.h"

@class ElementContext;
@interface Control : UIControl<View>{
    ElementContext  *_context;
}

- (void)registerForEvent;
- (void)touchCancel:(id)sender event:(UIEvent*)event;
- (void)touchDown:(id)sender event:(UIEvent*)event;
- (void)touchUpInside:(id)sender event:(UIEvent*)event;
- (void)touchUpOutside:(id)sender event:(UIEvent*)event;
@end
