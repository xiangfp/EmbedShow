//
//  TinyPlus.h
//  TinyPlus
//
//  Created by xiangfp on 15/6/24.
//  Copyright (c) 2015年 Sunline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TinyPlus : NSObject

+ (TinyPlus *)tinyPlus;

@property(nonatomic, assign) UIViewController *viewController;

-(BOOL)handleOpenURL:(NSURL *)url;

-(void)applicationDidBecomeActive;

@end
