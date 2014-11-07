//
//  BQUtil.h
//  boqiimall
//
//  Created by 张正超 on 14-8-25.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>


@interface BQUtil : NSObject
{
}

/*
 加密实现MD5和SHA1
 */
+(NSString *) md5:(NSString *)str;
+(NSString*) sha1:(NSString *)str;
/**
 实现http GET/POST 解析返回的json数据
 */
+(NSDictionary *) httpSendJson:(NSString *)url method:(NSString *)method data:(NSString *)data;
//tojson 将集合的数据转换成json字符串
+(NSString *) toJson:(NSDictionary *)params;
+(NSDictionary*)toDict:(NSString*)jsonString;
@end
