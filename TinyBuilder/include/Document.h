/******************************************************************
 文件名称: Document.h
 系统名称: 移动平台
 模块名称: 客户端
 类 名 称: Document
 软件版权: 杭州长亮金融信息服务有限公司
 功能说明: dom树
 系统版本:
 开发人员: 
 开发时间: 11-4-16
 审核人员:
 相关文档:
 修改记录:
 ******************************************************************/
#import <Foundation/Foundation.h>

@class Element, DocumentContext;
@interface Document : NSObject{
    Element *_root;
    NSMutableArray *_list;
    DocumentContext *_context;
}

#pragma mark access
@property (nonatomic, retain) Element *root;
@property (nonatomic, assign) DocumentContext *context;



- (void)appendElement:(Element*)element;
- (void)removeElement:(Element*)element;

#pragma mark traversal
- (Element*)elementForIDInDocument:(NSString*)ID;
- (NSArray*)elementsForTagInDocument:(NSString*)tag;
- (NSArray*)elementsForNameInDocument:(NSString*)name;
- (NSArray*)elementsForAttribute:(NSString*)attribute valueInDocument:(NSString*)value;
- (NSArray*)elementsForClass:(NSString*)attribute valueInDocument:(NSString*)value;
- (void)clearRules;
@end
