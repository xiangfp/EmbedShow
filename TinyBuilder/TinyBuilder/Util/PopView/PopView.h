/******************************************************************
 文件名称: PopView
 系统名称: 手机银行
 模块名称: 客户端
 类 名 称: PopView
 软件版权:
 功能说明: 弹出视图
 系统版本:
 开发人员: 
 开发时间: 14-08-20
 审核人员:
 相关文档:
 修改记录: 需求编号 修改日期 修改人员 修改说明
 ******************************************************************/

#import <UIKit/UIKit.h>

typedef void (^PopViewSetupBlock) (UIView* presentView);
typedef enum {
    /// 从底部滑出 (默认)
    PopAnimationType_SlideFromBottom = 0,
    /// 抖动弹出
    PopAnimationType_PopShake
} PopAnimationType;

@interface PopView : UIView
/* 动画类型 */
@property (nonatomic, assign) PopAnimationType animationType;

@property (nonatomic, strong) dispatch_block_t completionBlock;


/* 配置传入的view
 * 【注】可以addSubview，必须要设置view的frame（忽略origin，需要size）
 */
- (void)setupPresentView:(PopViewSetupBlock)block;

/* 在某个view中显示
 */
- (void)showInView:(UIView*)containerView;

/* 在顶层视图显示
 */
- (void)showInTopMostView;

/* 在导航控制器中显示
 */
- (void)showInNavigationController:(UINavigationController*)navi;

/* 在某个view中显示，动画完成时调用block
 */
- (void)showInView:(UIView*)containerView completion:(dispatch_block_t)completion;

/* 在顶层视图显示，动画完成时调用block
 */
- (void)showInTopMostViewWithCompletion:(dispatch_block_t)completion;

/* 在导航控制器中显示，动画完成时调用block
 */
- (void)showInNavigationController:(UINavigationController*)navi
                        completion:(dispatch_block_t)completion;

/* 取消显示
 */
- (void)dismiss;

/* 取消显示，动画完成时调用block
 */
- (void)dismissWithCompletion:(dispatch_block_t)completion;

@end
