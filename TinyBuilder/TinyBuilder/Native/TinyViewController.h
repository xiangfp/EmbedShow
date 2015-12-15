//
//  TinyViewController.h
//  Breeze2.1.1
//
//  Created by xiangfp on 15/4/10.
//
//

#import <UIKit/UIKit.h>
#import "TinyView.h"

@class TinyViewController;
@protocol TinyViewControllerDelegate <NSObject>
@optional

- (void)tinyViewController:(TinyViewController *)tinyViewController didSelectTarget:(NSString *)didSelectTarget;

@end


@interface TinyViewController : UIViewController<TinyViewDelegate>

@property (nonatomic, strong) TinyView *tinyView;


@property(nonatomic, strong) id<TinyViewControllerDelegate> delegate;

- (id)initWithTinyViewFrame:(CGRect)frame;


@end




@interface TinyViewController(UIViewControllerConnect)

- (void)connect;

- (void)connectURL:(NSString *)urlString tinyView:(TinyView *)tinyView;

@end



@interface TinyViewController(UIViewControllerTabBar)

-(void)setTabBarName:(NSString *)barName title:(NSString*)title imageName:(NSString*)imageName imageName_F:(NSString *)imageName_F;

@end



