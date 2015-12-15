//
//  TBControllerManager.h
//  Breeze2.1.1
//
//  Created by xiangfp on 15/4/11.
//
//

#import <Foundation/Foundation.h>
#import "TinyView.h"

@class TinyControllerManger;
@protocol TBControllerManagerDelegate <NSObject>

@optional

- (void)tbControllerManager:(TinyControllerManger *)tbControllerManager popViewControllerAnimated:(BOOL)popViewControllerAnimated;

- (void)tbControllerManager:(TinyControllerManger *)tbControllerManager presentViewController:(UIViewController *)viewController;

- (void)tbControllerManager:(TinyControllerManger *)tbControllerManager pushViewController:(UIViewController *)viewController;

@end



@interface TinyControllerManger : NSObject<TinyViewDelegate>

@property (nonatomic, weak) id<TBControllerManagerDelegate> delegate;

@end
