/******************************************************************
 文件名称: NSStringAdditions.h
 系统名称: 移动平台
 模块名称: 客户端
 类 名 称: NSStringAdditions
 软件版权: 杭州长亮金融信息服务有限公司
 功能说明: 
 系统版本: 
 开发人员: 
 开发时间: 11-4-19
 审核人员:
 相关文档:
 修改记录: 需求编号 修改日期 修改人员 修改说明
        S1.1.2  20120423  修改电话号码格式
        S1.1.2  20120614  service服务格式转换
 ******************************************************************/


#import <Foundation/Foundation.h>


@interface NSString (Convert)
- (int)convert2UINT;
@end
@interface NSString (Pinyin)
- (NSString *)pinyin;
@end

@interface NSString (PhoneNumber)
- (NSString *)phoneNumber;
@end

@interface NSString (Trim)
- (NSString *)stringByTrimHeadSpace;
- (NSString *)stringByTrimTailSpace;
- (NSString *)stringByTrimHeadAndTailSpace;
@end

@interface NSString (Regex)
- (BOOL)matchRegularExpression:(NSString *)exp;
@end

@interface NSString (Path)
+ (NSString *)homeDirectory;
+ (NSString *)bundleDirectory;
+ (NSString *)documentDirectory;
+ (NSString *)libraryDirectory;
@end

@interface NSString (URL)
+ (NSString *)URLEncode:(NSString *)unencodedURL;
+ (NSString *)URLDecode:(NSString *)undecodedURL;
- (NSString *)stringByURLEncode;
- (NSString *)stringByURLDecode;
@end

@interface NSString (Amount)
- (NSString *)amountChange:(NSString *)input;
@end

@interface NSString (ServiceConvert)
- (NSDictionary *)convertToDict;
@end

@interface NSString (Reversed)
+ (NSString *)reversedStringFromString:(NSString *)string;
@end

