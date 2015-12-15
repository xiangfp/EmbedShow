/******************************************************************
 文件名称: NSStringAdditions.m
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


#import "NSStringAdditions.h"
//#import <curl/curl.h>
#import "Transcode.h"


@implementation NSString (Convert)

-(int)convert2UINT
{
    NSString *regex = @"^[0-9]*[1-9][0-9]*$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![test evaluateWithObject:self]) {
        return 0;
    }
    return self.intValue;
}

@end

@implementation NSString (Pinyin)

-(NSString *)pinyin
{
	NSMutableString *result = [NSMutableString stringWithCapacity:30];
	NSInteger length = [self length];
	unsigned int *p = (unsigned int *)[self cStringUsingEncoding:NSUTF32StringEncoding];
	while (length>0) {
		if (*p<128) {
			[result appendFormat:@"%c",(char)(*p)];
		}
		else {
			for (int i=0; i<(sizeof(struUTF32PINYIN)/(sizeof(unsigned int)+sizeof(char *))); i++) {
				if (*p==struUTF32PINYIN[i].nUTF32Code) {
					[result appendFormat:@"%s",struUTF32PINYIN[i].pPinyin];
					break;
				}
			}	
			//[result appendString:@" "];
		}
		length--;
		p++;
	}

	return result;
}

@end

@implementation NSString (PhoneNumber)

- (NSString *)phoneNumber
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSMutableString* result = [NSMutableString stringWithCapacity:11];
    NSString* temp = @"";
    NSString* str = @"";
    while (![scanner isAtEnd]) {
        [scanner scanUpToString:@"-" intoString:&temp];
        [scanner scanString:@"-" intoString:nil];
        [result appendString:temp];
    }
    
    if ([[result substringToIndex:3] isEqualToString:@"+86"]) {
        str = [result substringFromIndex:3];
    }
    else {
        str = (NSString *)result;
    }
    
    return [str stringByTrimHeadSpace];
}

@end

@implementation NSString (Trim)
- (NSString*)stringByTrimHeadSpace
{
	NSScanner* scanner = [NSScanner scannerWithString:self];
	[scanner setCharactersToBeSkipped:nil];
	[scanner scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:nil];
	//delete space at head
	return [self substringWithRange:NSMakeRange([scanner scanLocation], [self length] - [scanner scanLocation])];
}

- (NSString*)stringByTrimTailSpace
{
	NSMutableString* result = [NSMutableString stringWithCapacity:30];
	NSScanner* scanner = [NSScanner scannerWithString:self];
	[scanner setCharactersToBeSkipped:nil];
	
	NSString* temp = @"";
	//copy space at head
	[scanner scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:&temp];
	[result appendString:temp];
	
	//delete space at tail & copy content
	while (![scanner isAtEnd]) {
		[scanner scanUpToCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:&temp];
		[result appendString:temp];
		
		if (![scanner isAtEnd]) {//we should copy space in content
			[scanner scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:&temp];
			if (![scanner isAtEnd]) {//space in content
				[result appendString:temp];
			}
			else {//space at tail
				break;
			}
		}
		else {//reach the end
			break;
		}
	}
	return result;
}

- (NSString*)stringByTrimHeadAndTailSpace
{
	NSMutableString* result = [NSMutableString stringWithCapacity:30];
	NSScanner* scanner = [NSScanner scannerWithString:self];
	[scanner setCharactersToBeSkipped:nil];
	
	//delete space at head
	[scanner scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:nil];
	
	//delete space at tail & copy content
	NSString* temp = @"";
	while (![scanner isAtEnd]) {
		[scanner scanUpToCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:&temp];
		[result appendString:temp];
		
		if (![scanner isAtEnd]) {//we should copy space in content
			[scanner scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:&temp];
			if (![scanner isAtEnd]) {//space in content
				[result appendString:temp];
			}
			else {//space at tail
				break;
			}
		}
		else {//reach the end
			break;
		}
	}
	return result;
}
@end

#pragma mark -
#import "regex.h"
@implementation NSString (Regex)
- (BOOL)matchRegularExpression:(NSString*)exp
{
	
	OSErr error = noErr;
//	char errBuf[256];
	regex_t regex;
	
	//create regex
	error = regcomp(&regex, [exp cStringUsingEncoding:NSASCIIStringEncoding], REG_EXTENDED);
	if (error == noErr) { //create success
		//regex match
		regmatch_t regmatch[256];
		error = regexec(&regex, [self cStringUsingEncoding:NSASCIIStringEncoding], 
						sizeof(regmatch_t), regmatch, REG_TRACE);
//		if (error != noErr) { //match failed
//			regerror(error, &regex, errBuf, 256);
//			NSLog(@"self match regex expression %@ failed .", self, exp);
//			printf("%s",errBuf);
//		}
	}
//	else { //create failed
//		regerror(error, &regex, errBuf, 256);
//		NSLog(@"self create regex expression %@ failed . ", self, exp);
//		printf("%s",errBuf);
//	}

	//clear up
	regfree(&regex);
	return error == noErr;
}
@end

#pragma mark -
@implementation NSString (Path)
+ (NSString*)homeDirectory
{
	return NSHomeDirectory();
}

+ (NSString*)bundleDirectory
{
	return [[NSBundle mainBundle] bundlePath];
}

+ (NSString*)documentDirectory
{
	NSArray* array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [array lastObject];
}

+ (NSString*)libraryDirectory
{
	NSArray* array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	return [array lastObject];
}
@end

#pragma mark -
@implementation NSString (URL)


+ (NSString *)URLEncode:(NSString *)unencodedURL
{
    return [unencodedURL stringByURLEncode];
}

+ (NSString *)URLDecode:(NSString *)undecodedURL
{
    return [undecodedURL stringByURLDecode];
}

- (NSString*)stringByURLEncode
{
    NSMutableString *result = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [result appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [result appendFormat:@"%c", thisChar];
        } else {
            [result appendFormat:@"%%%02X", thisChar];
        }
    }
    return result;
}

- (NSString*)stringByURLDecode
{
    NSString* result = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSParameterAssert(result);
    return result;
}


@end


#pragma mark -
@implementation NSString (Amount)
- (NSString*)amountChange:(NSString*)input
{
	NSArray *_numArray = [NSArray arrayWithObjects:@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖",nil];
	NSArray *_unitArray = [NSArray arrayWithObjects:@"拾",@"佰",@"仟",@"万",nil];
	NSMutableString *output = [[NSMutableString alloc] initWithCapacity:8];//输出
	NSInteger lenbp = 0;//小数点前的长度
	NSInteger lenap = 0;//小数点后的长度
	
	//没有小写大写也要一并清空
	if (input.length == 0) {
		[output appendString: @"零圆整"];
		return (NSString*)output;
	}
	
	NSRange range = [input rangeOfString:@"."];//找小数点
	if (range.location != NSNotFound)//有小数点
	{
		//根据小数点的位置取得小数点后的长度，最大为2，超过截取
		lenap = input.length - NSMaxRange(range) < 2 ? input.length - NSMaxRange(range) : 2;
		if ([input substringFromIndex:NSMaxRange(range)].length > 2) {
			//小数点后长度超过两位要截断，最多只能有2位，截断后同样需要返回，理由同上
			input = [input substringToIndex:NSMaxRange(range)+2];
		}
		//小数点前的长度
		if (range.location == 0) {
			lenbp = 1;
		}
		else {
			lenbp = range.location;
		}
	}
	else {//没有小数点
		lenbp = input.length;
		lenap = 0;
	}
	
	
	
	//处理整数部分
	NSInteger i,lastn = -1;//lastn是上次读取的数字，用于去除多余的0
	for (i = lenbp; i > 0; i--)//从后往前一个一个字符读取
	{
		int n = [[input substringWithRange:NSMakeRange(i-1, 1)] intValue];//每次读一个
		if (n == 0&& n == lastn) {
			if ((lenbp-i) % 4 != 0) {
				lastn = n;
				continue;
			}
		}
		if ((lenbp - i > 0)) {
			if ((lenbp - i) % 8 == 0) {
				if ([@"万" isEqualToString:[output substringToIndex:1]]) {
					[output deleteCharactersInRange:NSMakeRange(0, 1)];
				}
				[output insertString:@"亿" atIndex:0];
			}
			else {
				if ((n != 0) || (lenbp - i) % 4 == 0) {
					[output insertString:[_unitArray objectAtIndex:(lenbp-i-1)%[_unitArray count]] atIndex:0];
				}
			}
		}
		if (n != 0) {
			[output insertString:[_numArray objectAtIndex:n] atIndex:0];
		}
		else if ((lenbp - i) % 4 != 0) {
			[output insertString:[_numArray objectAtIndex:n] atIndex:0];
		}
		if (n == 0 && lenbp == 1) {
			[output insertString:[_numArray objectAtIndex:n] atIndex:0];
		}
		lastn=n;
	}
	[output appendString:@"圆"];
	
	NSInteger m, n;
	switch (lenap) {
		case 0:
			[output appendString:@"整"];
			break;
		case 1:
			n = [[input substringWithRange:NSMakeRange(NSMaxRange(range), 1)] intValue];
			if (n != 0) {
				[output appendString:[_numArray objectAtIndex:n]];
				[output appendString:@"角整"];
			}
			else {
				[output appendString:@"整"];
			}
			break;
		case 2:
			m = [[input substringWithRange:NSMakeRange(NSMaxRange(range), 1)] intValue];
			n = [[input substringWithRange:NSMakeRange(NSMaxRange(range)+1, 1)] intValue];
			if (m != 0 && n != 0) {
				[output appendString:[_numArray objectAtIndex:m]];
				[output appendString:@"角"];
				[output appendString:[_numArray objectAtIndex:n]];
				[output appendString:@"分"];
			}
			else if (m != 0 && n == 0) {
				[output appendString:[_numArray objectAtIndex:m]];
				[output appendString:@"角整"];
			}
			else if (m == 0 && n != 0) {
				[output appendString:[_numArray objectAtIndex:m]];
				[output appendString:[_numArray objectAtIndex:n]];
				[output appendString:@"分"];
			}
			else if(m == 0 && n == 0) {
				[output appendString:@"整"];
			}
			break;
		default:
			break;
	}
	
	return (NSString*)output;
}

@end

@implementation NSString(ServiceConvert)

- (NSDictionary *)convertToDict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    while (![scanner isAtEnd]) {
        NSString *param = nil;
        [scanner scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:nil];
        [scanner scanUpToString:@"&" intoString:&param];
        [scanner scanString:@"&" intoString:nil];
        NSScanner *s = [NSScanner scannerWithString:param];
        while (![s isAtEnd]) {
            NSString *key = nil;
            NSString *value = nil;
            [s scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:nil];
            [s scanUpToString:@"=" intoString:&key];
            [s scanString:@"=" intoString:nil];
            [s scanUpToCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:&value];
            [s scanCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:nil];
            
            [dict setObject:value forKey:key];
        }
    }
    return dict;
}

@end

@implementation NSString (Reversed)

+ (NSString *)reversedStringFromString:(NSString *)string
{
    NSUInteger count = [string length];
    
    if (count <= 1) { // Base Case
        return string;
    } else {
        NSString *lastLetter = [string substringWithRange:NSMakeRange(count - 1, 1)];
        NSString *butLastLetter = [string substringToIndex:count - 1];
        return [lastLetter stringByAppendingString:[self reversedStringFromString:butLastLetter]];
    }
}

@end
