//
//  JSWindow.h
//  Tiny
//
//  Created by xiangfp on 15/5/25.
//  Copyright (c) 2015年 xiangfp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Document.h"




@interface JSWindow : NSObject

@property (nonatomic,  assign) Document *document;

@property (nonatomic,  strong) NSMutableDictionary *openKeyBoardDictionary;

@property (nonatomic,  strong) NSMutableDictionary *closeKeyBoardDictionary;

- (void)keyboardDidHidden;



@end
