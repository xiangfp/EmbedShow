/******************************************************************
 文件名称: Embed.h
 系统名称: 移动平台
 模块名称: 客户端
 类 名 称: Embed
 软件版权: 杭州长亮金融信息服务有限公司
 功能说明: 插件类
 系统版本:
 开发人员:
 开发时间: 12-1-4
 审核人员:
 相关文档:
 修改记录: 需求编号 修改日期 修改人员 修改说明
 
 ******************************************************************/

#import <Foundation/Foundation.h>
#import "Control.h"

@interface Embed : Control
{
    NSMutableDictionary *_paraDic;
}

- (NSArray *)parameterForName:(NSString *)name;

- (NSArray *)SeparatedForValue:(NSString *)value;

@property(nonatomic, retain)  NSMutableDictionary *paramDictionary;

/**
 *  执行js事件
 *
 *  @param event 事件名称
 *  @param data  事件参数
 */
-(void)executiveEvent:(NSString *)event data:(NSString *)data;

-(void)executiveEvent:(NSString *)event array:(NSArray *)array;


-(void)setParam:(NSString *)name value:(NSString *)value;

-(void)parentlayout;


@end
