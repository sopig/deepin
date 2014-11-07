//
//  NSString+StringUtility.m
//  Ule
//
//  Created by YSW on 11/30/12.
//  Copyright (c) 2012 Ule. All rights reserved.
//

#import "NSString+StringUtility.h"
#import <CommonCrypto/CommonDigest.h>

#import "Base64.h"

const NSString* REG_EMAIL = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
const NSString* REG_MOBILE = @"^(13[0-9]|15[0-9]|18[0-9]|14[0-9])\\d{8}$";
const NSString* REG_PHONE = @"^(([0\\+]\\d{2,3}-?)?(0\\d{2,3})-?)?(\\d{7,8})";//(-(\\d{3,}))?$";

@implementation NSString (StringUtility)

- (NSString *)stringByURLEncodingString {
    CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                  (CFStringRef) self,
                                                                  NULL,
                                                                  (CFStringRef) @"!*'\"();:@&=+$,/?%#[]% ",
                                                                  kCFStringEncodingUTF8);
    return [(NSString *) encoded autorelease];
}

- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return [outputString autorelease];
}

+(NSString*)strOrEmpty:(NSString*)str{
    return (str==nil?@"":str);
}

+(NSString*)stripWhiteSpace:(NSString*)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+(NSString*)stripWhiteSpaceAndNewLineCharacter:(NSString*)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+(NSString*)YKMD5:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    return [[NSString
             stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1],
             result[2], result[3],
             result[4], result[5],
             result[6], result[7],
             result[8], result[9],
             result[10], result[11],
             result[12], result[13],
             result[14], result[15]
             ] lowercaseString];
}


+ (int)convertToInt:(NSString *)str
{
    int strlength   =   0;
    char *  p   =   (char *)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return strlength;
}

+ (NSString *)stringToDate:(NSString *)input OldDateFormat:(NSString *)oldDate NewDateFormat:(NSString *)newDate
{
    NSDateFormatter *inputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [inputFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] autorelease]];
    [inputFormatter setDateFormat:oldDate];
    NSDate* inputDate = [inputFormatter dateFromString:input];
    
    NSDateFormatter *outputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:newDate];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    
    return str;
}


//日期转字符串格式4
+(NSString*)dateToStringWithFormat:(NSDate*)date format:(NSString *) _format{
	//得到毫秒
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	//[dateFormatter setDateFormat:@"hh:mm:ss"]
	[dateFormatter setDateFormat:_format];//@"yyyy-MM-dd hh:mm:ss"
	//NSLog(@"Date%@", [dateFormatter stringFromDate:[NSDate date]]);
	NSString *currentdt = [dateFormatter stringFromDate:date];
	[dateFormatter release];
	return currentdt;
}

- (NSArray *)allURLs
{
	NSMutableArray * array = [NSMutableArray array];
	
	NSInteger stringIndex = 0;
	while ( stringIndex < self.length )
	{
		NSRange searchRange = NSMakeRange(stringIndex, self.length - stringIndex);
		NSRange httpRange = [self rangeOfString:@"http://" options:NSCaseInsensitiveSearch range:searchRange];
		NSRange httpsRange = [self rangeOfString:@"https://" options:NSCaseInsensitiveSearch range:searchRange];
		
		NSRange startRange;
		if ( httpRange.location == NSNotFound )
		{
			startRange = httpsRange;
		}
		else if ( httpsRange.location == NSNotFound )
		{
			startRange = httpRange;
		}
		else
		{
			startRange = (httpRange.location < httpsRange.location) ? httpRange : httpsRange;
		}
		
		if (startRange.location == NSNotFound)
		{
			break;
		}
		else
		{
			NSRange beforeRange = NSMakeRange( searchRange.location, startRange.location - searchRange.location );
			if ( beforeRange.length )
			{
				//				NSString * text = [string substringWithRange:beforeRange];
				//				[array addObject:text];
			}
			
			NSRange subSearchRange = NSMakeRange(startRange.location, self.length - startRange.location);
			NSRange endRange = [self rangeOfString:@" " options:NSCaseInsensitiveSearch range:subSearchRange];
			if ( endRange.location == NSNotFound)
			{
				NSString * url = [self substringWithRange:subSearchRange];
				[array addObject:url];
				break;
			}
			else
			{
				NSRange URLRange = NSMakeRange(startRange.location, endRange.location - startRange.location);
				NSString * url = [self substringWithRange:URLRange];
				[array addObject:url];
				
				stringIndex = endRange.location;
			}
		}
	}
	
	return array;
}

- (NSString *)queryStringFromDictionary:(NSDictionary *)dict
{
    NSMutableArray * pairs = [NSMutableArray array];
	for ( NSString * key in [dict keyEnumerator] )
	{
		if ( !([[dict valueForKey:key] isKindOfClass:[NSString class]]) )
		{
			continue;
		}
		
		NSString * value = [dict objectForKey:key];
		NSString * urlEncoding = [value URLEncoding];
		[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, urlEncoding]];
	}
	
	return [pairs componentsJoinedByString:@"&"];
}

- (NSString *)urlByAppendingDict:(NSDictionary *)params
{
    NSURL * parsedURL = [NSURL URLWithString:self];
	NSString * queryPrefix = parsedURL.query ? @"&" : @"?";
	NSString * query = [self queryStringFromDictionary:params];
	return [NSString stringWithFormat:@"%@%@%@", self, queryPrefix, query];
}

- (NSString *)queryStringFromArray:(NSArray *)array
{
	NSMutableArray *pairs = [NSMutableArray array];
	
	for ( NSUInteger i = 0; i < [array count]; i += 2 )
	{
		NSObject * obj1 = [array objectAtIndex:i];
		NSObject * obj2 = [array objectAtIndex:i + 1];
		
		NSString * key = nil;
		NSString * value = nil;
		
		if ( [obj1 isKindOfClass:[NSNumber class]] )
		{
			key = [(NSNumber *)obj1 stringValue];
		}
		else if ( [obj1 isKindOfClass:[NSString class]] )
		{
			key = (NSString *)obj1;
		}
		else
		{
			continue;
		}
		
		if ( [obj2 isKindOfClass:[NSNumber class]] )
		{
			value = [(NSNumber *)obj2 stringValue];
		}
		else if ( [obj1 isKindOfClass:[NSString class]] )
		{
			value = (NSString *)obj2;
		}
		else
		{
			continue;
		}
		
		NSString * urlEncoding = [value URLEncoding];
		[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, urlEncoding]];
	}
	
	return [pairs componentsJoinedByString:@"&"];
}

- (NSString *)urlByAppendingArray:(NSArray *)params
{
    NSURL * parsedURL = [NSURL URLWithString:self];
	NSString * queryPrefix = parsedURL.query ? @"&" : @"?";
	NSString * query = [self queryStringFromArray:params];
	return [NSString stringWithFormat:@"%@%@%@", self, queryPrefix, query];
}

- (NSString *)urlByAppendingKeyValues:(id)first, ...
{
	NSMutableDictionary * dict = [NSMutableDictionary dictionary];
	
	va_list args;
	va_start( args, first );
	
	for ( ;; )
	{
		NSObject<NSCopying> * key = [dict count] ? va_arg( args, NSObject * ) : first;
		if ( nil == key )
			break;
		
		NSObject * value = va_arg( args, NSObject * );
		if ( nil == value )
			break;
        
		[dict setObject:value forKey:key];
	}
    
	return [self urlByAppendingDict:dict];
}

- (NSString *)queryStringFromKeyValues:(id)first, ...
{
	NSMutableDictionary * dict = [NSMutableDictionary dictionary];
	
	va_list args;
	va_start( args, first );
	
	for ( ;; )
	{
		NSObject<NSCopying> * key = [dict count] ? va_arg( args, NSObject * ) : first;
		if ( nil == key )
			break;
		
		NSObject * value = va_arg( args, NSObject * );
		if ( nil == value )
			break;
		
		[dict setObject:value forKey:key];
	}
    
	return [self queryStringFromDictionary:dict];
}

- (BOOL)empty
{
	return [self length] > 0 ? NO : YES;
}

- (BOOL)notEmpty
{
	return [self length] > 0 ? YES : NO;
}

- (BOOL)is:(NSString *)other
{
	return [self isEqualToString:other];
}

- (BOOL)isValueOf:(NSArray *)array
{
	return [self isValueOf:array caseInsens:NO];
}

- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens
{
	NSStringCompareOptions option = caseInsens ? NSCaseInsensitiveSearch : 0;
	
	for ( NSObject * obj in array )
	{
		if ( NO == [obj isKindOfClass:[NSString class]] )
			continue;
		
		if ( [(NSString *)obj compare:self options:option] )
			return YES;
	}
	
	return NO;
}

- (NSString *)URLEncoding
{
	NSString * result = (NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,
																			(CFStringRef)self,
																			NULL,
																			(CFStringRef)@"!*'();:@&=+$,/?%#[]",
																			kCFStringEncodingUTF8 );
	return [result autorelease];
}

- (NSString *)URLDecoding
{
	NSMutableString * string = [NSMutableString stringWithString:self];
    [string replaceOccurrencesOfString:@"+"
							withString:@" "
							   options:NSLiteralSearch
								 range:NSMakeRange(0, [string length])];
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
// 去掉html格式和转义字符
+ (NSString *)filterHtmlTag:(NSString *)html trimWhiteSpace:(BOOL)trim{
    
    NSString *result = [html stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    result=[result stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    NSScanner *theScanner = [NSScanner scannerWithString:result];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL];
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text];
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        result = [result stringByReplacingOccurrencesOfString:
                  [ NSString stringWithFormat:@"%@>", text]
                                                   withString:@""];
    }
    return trim ? [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : result;
}

// 解析html,带有imgurl链接的
//+ (NSString *)filterHtmlWithImgUrl:(NSString *)html {
//        
//    NSString *result = [html stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    result = [result stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//    if ([result hasPrefix:@"<span style"]) {
//        NSArray * _arr = [result componentsSeparatedByString:@">"];
//        
//        for (int i = 0; i < _arr.count; i++) {
//            NSString *_str = _arr[0];   // 只需要取出第一个>就可以了
//            result = [result stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", _str] withString:@""];
//            break;
//        }
//        
//        if ([result hasSuffix:@"</span>"]) {
//            result = [result stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
//        }
//        
//        NSScanner *theScanner = [NSScanner scannerWithString:result];
//        NSString *text = nil;
//        while ([theScanner isAtEnd] == NO) {
//            [theScanner scanUpToString:@"<img src=" intoString:NULL];
//            [theScanner scanUpToString:@">" intoString:&text];
//            
//            if (text.length || text != NULL) {
//                // 只有扫瞄到带有图片的链接，才用正则匹配链接内容
//                NSString *_regexStr = @"alt=\'(.*?)\'";
//                NSArray *_hrefs = [text componentsMatchedByRegex:_regexStr capture:0];
//                NSLog(@"%@", _hrefs[0]);
//                
//                NSString *_mean = [_hrefs[0] stringByReplacingOccurrencesOfString:@"alt='" withString:@""];
//                _mean = [_mean stringByReplacingOccurrencesOfString:@"'" withString:@""];
//                NSLog(@"%@", _mean);
//                
//                result = [result stringByReplacingOccurrencesOfString:
//                          [ NSString stringWithFormat:@"%@>", text]
//                                                           withString:[NSString stringWithFormat:@"[%@]", _mean]];
//            }
//            
//        }
//
//    }
//    return result;
//}

//去掉html和前后空格
+(NSString*) replaceHtmlAndSpace:(NSString*)listNameRef{
    
    NSString *listName=[NSString filterHtmlTag:listNameRef    trimWhiteSpace:YES];
    NSString *newListName=[NSString stripWhiteSpace:listName];
    
    return  newListName;
    
}



+ (BOOL)isPhoneNum:(NSString *)input{

//    @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$"

    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])\\d{8}$"];
    return [phoneTest evaluateWithObject:input];
    
}




@end
