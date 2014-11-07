//
//  HttpRequest.h
//  Ule
//
//  Created by ysw on 12-11-29.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BqiAPI.h"
#import <AFHTTPRequestOperation.h>


//tolly 增加关于请求成功和错误的回调代码块
typedef void(^success)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^failure)(AFHTTPRequestOperation *operation, NSError *error);

@interface HttpRequest : NSObject

+(id)decodeJsonStr:(NSString*)jsonStr withClsName:(NSString*)clsName;

+ (void)httpRequest:(EnvApiHost) _envApiHost
           apiPath:(NSString *)path
       extraParams:(NSMutableDictionary *)extraParams
         className:(NSString *)className
            object:(id)object
             action:(SEL)action;

+ (void)httpRequest:(NSString *)url className:(NSString *)className object:(id)object action:(SEL)action;

+ (NSString *) convertJson_FilterData:(NSString *) methodName jasonString:(NSString *) _sJSON;

+ (void)httpRequestWithAddress:(NSString*)urlstring parameters:(NSDictionary *)para success:(success) suc failure:(failure)fail;

@end
