//
//  NSString+StringUtility.h
//  Ule
//
//  Created by YSW on 11/30/12.
//  Copyright (c) 2012 Ule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringUtility)

/**
 将字符串转换为MD5码
 @returns   返回過濾掉關鍵字符後的UTF8編碼的字符串
 */
- (NSString *)stringByURLEncodingString;

/**
 字符串採用MD5加密
 @returns   返回使用MD5加密後的字符串
 */
- (NSString *) stringFromMD5;

/**
 安全获取字符串
 @param str 字符串
 @returns 若字符串为nil，则返回空字符串，否则直接返回字符串
 */
+   (NSString*)strOrEmpty:(NSString*)str;
/**
 去掉首尾空格
 @param str 字符串
 @returns 去掉首尾空格的字符串
 */
+   (NSString*)stripWhiteSpace:(NSString*)str;
/**
 去掉首尾空格和换行符
 @param str 字符串
 @returns 去掉首尾空格和换行符的字符串
 */
+   (NSString*)stripWhiteSpaceAndNewLineCharacter:(NSString*)str;
/**
 将字符串转换为MD5码
 @param str 字符串
 @returns 已转码为MD5的字符串
 */
+   (NSString*)YKMD5:(NSString*)str;

/**
 判断字符串是否符合Email格式。
 @param input 字符串
 @returns 布尔值 YES: 符合 NO: 不符合
 */
//+   (BOOL)isEmail:(NSString *)input;

/**
 判断字符串是否符合手机号格式。
 @param input 字符串
 @returns 布尔值 YES: 符合 NO: 不符合
 */
+  (BOOL)isPhoneNum:(NSString *)input;

/**
 判断字符串是否符合电话格式。
 @param input 字符串
 @returns 布尔值 YES: 符合 NO: 不符合
 */
//+   (BOOL)isMobileNum:(NSString *)input;

/**
 计算string的字节数
 @param input 字符串
 @returns 返回字符串的字节数量
 */
//+ (int)calc_charsetNum:(NSString *)str;

/**
 获取中英文混合字符串长度 方法1
 @param input   字符串
 @returns   返回字符串的字节数量
 */
+ (int)convertToInt:(NSString *)str;

/**
 将NSString类型日期值转换为指定格式日期类型值
 @param input 字符串
 @param oldDate 原日期格式
 @param newDate 新日期格式
 @returns   返回新字符串
 */
+ (NSString *)stringToDate:(NSString *)input OldDateFormat:(NSString *)oldDate NewDateFormat:(NSString *)newDate;

/***    转化为时间格式         ***/
+(NSString*)dateToStringWithFormat:(NSDate*)date format:(NSString *) _format;
/*
 加密函数
 param: key 密钥
 param: data 需要加密的字符串
*/
//+ (NSString *)HMACMD5WithKey:(NSString *)key andData:(NSString *)data;


- (NSArray *)allURLs;

- (NSString *)urlByAppendingDict:(NSDictionary *)params;
- (NSString *)urlByAppendingArray:(NSDictionary *)params;
- (NSString *)urlByAppendingKeyValues:(NSDictionary *)first,...;

- (NSString *)queryStringFromDictionary:(NSDictionary *)dict;
- (NSString *)queryStringFromArray:(NSArray *)array;
- (NSString *)queryStringFromKeyValues:(id)first, ...;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;

- (BOOL)empty;
- (BOOL)notEmpty;

- (BOOL)is:(NSString *)other;

- (BOOL)isValueOf:(NSArray *)array;
- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;


// 去掉html格式和转义字符
+ (NSString *)filterHtmlTag:(NSString *)html trimWhiteSpace:(BOOL)trim;
// 解析html,带有imgurl链接的
//+ (NSString *)filterHtmlWithImgUrl:(NSString *)html;
//去掉html和前后空格
+(NSString*) replaceHtmlAndSpace:(NSString*)listNameRef;
@end
