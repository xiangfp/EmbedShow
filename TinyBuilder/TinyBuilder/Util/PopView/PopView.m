/******************************************************************
 文件名称: PopView
 系统名称: 手机银行
 模块名称: 客户端
 类 名 称: PopView
 软件版权: 恒生电子股份有限公司
 功能说明: 弹出视图
 系统版本:
 开发人员: lingbx
 开发时间: 14-08-20
 审核人员:
 相关文档:
 修改记录: 需求编号 修改日期 修改人员 修改说明
 ******************************************************************/

#import "PopView.h"
#import "AvoidRetainCycleBlockStorge.h"

static const NSTimeInterval kShakeAnimationDuration = 0.60;
static const NSTimeInterval kSlideAnimationDuration = 0.25;
static const NSTimeInterval kDismissAnimationDuration = 0.20;

@interface PopView ()
@property (nonatomic, retain) UIControl* holderView;
@property (nonatomic, retain) UIView* presentingView;
@property (nonatomic, retain) AvoidRetainCycleBlockStorge* popShakeFinishBlockStorge;
@end

@implementation PopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        self.holderView = [[UIControl alloc] init];
        self.holderView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self.holderView addTarget:self action:@selector(touchHolderView:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.holderView];
        
        self.presentingView = [[UIView alloc] init];
        self.presentingView.backgroundColor = [UIColor whiteColor];
        const CGRect defaultFrame = CGRectMake(10, 10, 100, 100);
        self.presentingView.frame = defaultFrame;

        [self.holderView addSubview:self.presentingView];
    }
    return self;
}



- (void)setupPresentView:(PopViewSetupBlock)block
{
    NSArray* subviews = self.presentingView.subviews;
    for (UIView* __sub in subviews) {
        [__sub removeFromSuperview];
    }
    
    if (block) {
        block(self.presentingView);
    }
}

- (void)showInView:(UIView*)containerView
{
    [self showInView:containerView completion:nil];
}
- (void)showInTopMostView
{
    [self showInTopMostViewWithCompletion:nil];
}
- (void)showInNavigationController:(UINavigationController*)navi
{
    [self showInNavigationController:navi completion:nil];
}

- (void)showInView:(UIView*)containerView completion:(dispatch_block_t)completion
{
    [[PopView _findPopViewInView:containerView] removeFromSuperview];
    self.hidden = NO;

    [self _doShowAnimationInContainerView:containerView completion:completion];
}
- (void)showInTopMostViewWithCompletion:(dispatch_block_t)completion
{
    UIView* keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showInView:keyWindow completion:completion];
}
- (void)showInNavigationController:(UINavigationController*)navi
                        completion:(dispatch_block_t)completion
{
    [self showInView:navi.view completion:completion];
}

- (void)dismiss
{
    [self dismissWithCompletion:nil];
}
- (void)dismissWithCompletion:(dispatch_block_t)completion
{
    [self _doDismissAnimationWithCompletion:completion];
}


#pragma mark - Private
+ (PopView*)_findPopViewInView:(UIView*)containerView
{
    for (UIView* __sub in containerView.subviews) {
        if ([__sub isKindOfClass:[PopView class]]) {
            return (PopView*)__sub;
        }
    }
    return nil;
}
- (void)_setupSubviews
{
    self.holderView.frame = self.bounds;

    CGRect frame = self.presentingView.frame;
    frame.origin.x = (CGRectGetWidth(self.holderView.frame) - CGRectGetWidth(self.presentingView.frame)) / 2;
    frame.origin.y = (CGRectGetHeight(self.holderView.frame) - CGRectGetHeight(self.presentingView.frame)) / 2;
    self.presentingView.frame = frame;
}

- (void)touchHolderView:(id)sender
{
    [self dismiss];
}

// popShakeFinishBlock
- (dispatch_block_t)popShakeFinishBlock
{
    if (self.popShakeFinishBlockStorge == nil) {
        self.popShakeFinishBlockStorge = [[AvoidRetainCycleBlockStorge alloc] init];
    }
    return [self.popShakeFinishBlockStorge getBlockReference];
}
- (void)setPopShakeFinishBlock:(dispatch_block_t)popShakeFinishBlock
{
    if (self.popShakeFinishBlockStorge == nil) {
        self.popShakeFinishBlockStorge = [[AvoidRetainCycleBlockStorge alloc] init];
    }
    [self.popShakeFinishBlockStorge setBlockAutoCopy:popShakeFinishBlock];
}

- (void)_doShowAnimationInContainerView:(UIView*)containerView
                             completion:(dispatch_block_t)completion
{
    switch (self.animationType) {
        case PopAnimationType_SlideFromBottom:
        {
            self.alpha = 0.0;
            self.frame = containerView.bounds;
            {
                self.holderView.frame = containerView.bounds;
                
                CGRect frame = self.presentingView.frame;
                frame.origin.x = (CGRectGetWidth(self.holderView.frame) - CGRectGetWidth(self.presentingView.frame)) / 2;
                frame.origin.y = CGRectGetHeight(self.holderView.frame);
                self.presentingView.frame = frame;
            }
            [containerView addSubview:self];

            [UIView animateWithDuration:kSlideAnimationDuration animations:^{
                self.alpha = 1.0;
                [self _setupSubviews];
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }
            break;
        case PopAnimationType_PopShake:
        {
            CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            animation.duration = kShakeAnimationDuration;
            // CAAnimationDelegate
            animation.delegate = self;
            
            animation.removedOnCompletion = YES;
            animation.fillMode = kCAFillModeForwards;
            
            NSMutableArray *values = [NSMutableArray array];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
            
            animation.values = values;
            
            self.alpha = 1.0;
            self.frame = containerView.bounds;
            [self _setupSubviews];
            [containerView addSubview:self];

            // 代理给 popShakeFinishBlock
            [self setPopShakeFinishBlock:completion];
            [self.presentingView.layer addAnimation:animation forKey:nil];
            
        }
            break;
        default:
            break;
    }
}

- (void)_doDismissAnimationWithCompletion:(dispatch_block_t)completion
{
    [UIView animateWithDuration:kDismissAnimationDuration
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             if (self.completionBlock) {
                                 self.completionBlock();
                             }
                             [self removeFromSuperview];
                         }
                     }];

}


#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    dispatch_block_t popShakeFinishBlock = [self popShakeFinishBlock];
    if (popShakeFinishBlock) {
        popShakeFinishBlock();
    }
}

@end
