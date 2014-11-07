//
//  HttpRequest.m
//  Ule
//
//  Created by ysw on 12-11-29.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "HttpRequest.h"
#import "JSONKit.h"
#import "NSDictionary+JSON.h"
#import "NSString+StringUtility.h"
#import "MemoryData.h"

#import <AFNetworking.h>

//#import "BQUtil.h"

@interface HttpRequest ()

@end


@implementation HttpRequest
static NSMutableArray *infoArray;
/* 
   JSON 解析函数
   param: clsName为解析后，所要得到的class类型名
 */
+(id)decodeJsonStr:(NSString*)jsonStr withClsName:(NSString*)clsName
{
    NSDictionary* dic = nil;
 
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    if(version>=5.0f){
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves  error:&error];
    } else {
        dic = [jsonStr objectFromJSONString];
    }
    
    return dic;
}

/*
 JSON 解析函数
 param: clsName为解析后，所要得到的class类型名
 */
+(id)decodeJsonStrNotReturnCode:(NSString*)jsonStr withClsName:(NSString*)clsName
{
    NSDictionary* dic = nil;
    //NSLog(@"json--->%@",jsonStr);
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    if(version>=5.0f){
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves  error:&error];
    } else {
        dic = [jsonStr objectFromJSONString];
    }

    return dic;
}


#pragma mark - 更换成  AFNetWorking 的http请求  ##############

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

/*
 如果需要深度定制http请求头以及http协议相关处理，请单独另写文件完成，保证文件的耦合性最低
 */

+(void)httpRequest:(EnvApiHost) _envApiHost
           apiPath:(NSString *)path
       extraParams:(NSMutableDictionary *)extraParams
         className:(NSString *)className
            object:(id)object
            action:(SEL)action
{
    NSString * actionName = [extraParams objectForKey:APP_ACTIONNAME];
    
    NSString *urlString = _envApiHost == api_BOQIIMALL ? kHostUrl_boqiiMall: kHostUrl_boqiiLife;
    urlString = [NSString stringWithFormat:@"http://%@/%@",urlString,path];

    [extraParams addEntriesFromDictionary: [PMGlobal shared].httpCommonParams];  //公共参数
    NSArray * keys= [[extraParams allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSString * signValues=@"";
    for (NSString * kv in keys)
    {
        signValues = [NSString stringWithFormat:@"%@%@",signValues,[extraParams objectForKey:kv]];
    }
    signValues = [NSString stringWithFormat:@"%@%@",signValues,APP_SIGNKEY];
    [extraParams setObject:[NSString YKMD5:signValues] forKey:HEAD_KEY_SIGN];  //计算sign
    
    if (![HttpRequest judgeWhetherToRequest:actionName])  //判断如果不需要去 从服务器抓取数据。
    {
        NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent: MemoryFileName];
        NSMutableDictionary * dic_Plist = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
        NSString * jsonPlist = [dic_Plist objectForKey:actionName];
        
        id jsonObj = [HttpRequest  decodeJsonStr:jsonPlist  withClsName:className];
        [object performSelector:action withObject: jsonObj];
    }
    else {
        /*
         请注意 如果直接从git上拉AFNETworking  请将manager方法 改为单例写法
         需要double check
         */
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [manager POST:urlString parameters:extraParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          NSString *responseString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
          NSString *convertJsonString = [HttpRequest convertJson_FilterData:actionName jasonString:responseString];
          
          id jsonObject = [HttpRequest  decodeJsonStr:convertJsonString  withClsName:className];
          
          [HttpRequest saveJsonToPlist:actionName jsonStr:convertJsonString backObj:jsonObject];
            
          [object performSelector:action withObject: jsonObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [object performSelector:@selector(failWithErrorText:) withObject:@"请求数据异常"];
            
        }];
    }
}

#pragma clang diagnostic pop

#pragma mark - end ##############

///*
// *  Http请求函数:不需要传递参数
// */
+(void)httpRequest:(NSString *)url
         className:(NSString *)className
            object:(id)object
            action:(SEL)action
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString* responseString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [object performSelector:action withObject:[HttpRequest decodeJsonStrNotReturnCode:responseString withClsName:className]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [object performSelector:@selector(failWithErrorText:) withObject:@"请求数据异常"];
        
    }];
    
#pragma clang diagnostic pop
    
}


//GET
+ (void)httpRequestWithAddress:(NSString*)urlstring parameters:(NSDictionary *)para success:(success) suc failure:(failure)fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlstring parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        suc(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(operation,error);
    }];

}




//
/******************************************************
 ---------       一 些 特 殊 处 理 需 要 方 法.
 ******************************************************
 */

//  --  统一筛选数据格式
+ (NSString *) convertJson_FilterData:(NSString *) methodName jasonString:(NSString *) _sJSON{
    NSString * resultJsonString = _sJSON;
    if ([methodName isEqualToString:kApiMethod_GetAreaType]) {
        resultJsonString = [resultJsonString stringByReplacingOccurrencesOfString:@"AreaName" withString:@"TypeName"];
        resultJsonString = [resultJsonString stringByReplacingOccurrencesOfString:@"AreaList" withString:@"TypeList"];
        resultJsonString = [resultJsonString stringByReplacingOccurrencesOfString:@"SubAreaName" withString:@"SubTypeName"];
        resultJsonString = [resultJsonString stringByReplacingOccurrencesOfString:@"SubAreaId" withString:@"SubTypeId"];
    }
    if([methodName isEqualToString:kApiMethod_GetMerchantSortType]){
        resultJsonString = [resultJsonString stringByReplacingOccurrencesOfString:@"TypeId" withString:@"CategoryId"];
    }
    
//    if ([methodName isEqualToString:kApiMethod_Mall_CartDetailV2]) {
//        
//        NSURL * url = [[NSBundle mainBundle] URLForResource:@"CommonList" withExtension:@"plist"];
//        NSMutableDictionary *dicAllPages = [NSMutableDictionary dictionaryWithContentsOfURL:url];
//        resultJsonString = [dicAllPages objectForKey:@"ShoppingCartJsonString"];
//    }
    return resultJsonString;
}

//  --  对于缓存到plist的数据  :  判断是否 去 服务器 取数据
+ (BOOL) judgeWhetherToRequest:(NSString *) methodName{
    
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent: MemoryFileName];
    if (path.length>0) {
        NSMutableDictionary * dic_Plist = [[[NSMutableDictionary alloc]initWithContentsOfFile:path] mutableCopy];
        if (dic_Plist!=nil) {
            NSString * skey = [NSString stringWithFormat:@"updateTime%@",methodName];
            if ([dic_Plist objectForKey:skey]) {
                
                //  --  对于缓存过 并每次都要更新的接口
                if ([methodName isEqualToString:kApiMethod_Mall_HomeData]
                    || [methodName isEqualToString:kApiMethod_GetAreaType]) {
                    return YES;
                }
                //  --  开始说根据时间判断，后来改为按启动。。。。
//                NSDate * lastUpdateTime = [dic_Plist objectForKey:skey];
//                NSLog(@"%@---update time：%.2f",lastUpdateTime,[[NSDate date] timeIntervalSinceDate:lastUpdateTime]);

                //  --  对于每次开启后 只需第一次请求接口
                NSString * jsonResponse = [dic_Plist objectForKey:methodName];
                if (jsonResponse!=nil && jsonResponse.length>0) {
                    
                    NSString * isLaunch = [dic_Plist objectForKey:[NSString stringWithFormat:@"Launch%@",methodName]];
                    if (   isLaunch!=nil && isLaunch.length>0 && [isLaunch isEqualToString:@"PleaseApiRequest"]) {
                        
                        [dic_Plist setValue:@"DonotApiRequest" forKey:[NSString stringWithFormat:@"Launch%@",methodName]];
                        [dic_Plist writeToFile:path atomically:YES];
                        return YES;
                    }
                    else{
                        return NO;
                    }
                }
                else{
                    return YES;
                }
            }
        }
    }
    return YES;
}

//  --  缓存解析Json 的对像 : 一些大数据
+ (void) saveJsonToPlist:(NSString *) methodName jsonStr:(NSString *) jsonStr backObj:(id) jsonObject{
    
    ResponseBase* retObj = [[ResponseBase alloc] initWithDic:jsonObject];
    if (retObj == nil)
        return;

    //  -- 成功返回数据时 才保存到 plist
    if (retObj.ResponseStatus == SUCCESS_CODE){
        
        if([[[PMGlobal shared] ApiKeyForMemoryResponseJson] objectForKey:methodName]) {
        
            //  --  保存本次 json
            NSString *pathJson = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent: MemoryFileName];
            NSMutableDictionary *applist = [[[NSMutableDictionary alloc]initWithContentsOfFile:pathJson] mutableCopy];
            
            if (applist==nil) {
                applist = [[NSMutableDictionary alloc] initWithCapacity:0];
            }
            
            [applist setObject:jsonStr forKey:methodName];
            [applist writeToFile:pathJson atomically:YES];
            
            //  --  保存本次更新时间
            [applist setObject:[NSDate date] forKey:[NSString stringWithFormat:@"updateTime%@",methodName]];
            [applist writeToFile:pathJson atomically:YES];
        }
    }
}

/*
#pragma mark -
#pragma mark - 解析数据结构
+ (void)describeDictionary:(NSDictionary *)dict ClassName:(NSString *)classname count:(int)icount {
    NSArray *keys;
    NSInteger i,count;
    id key,value;
 
    keys = [dict allKeys];
    count = [keys count];
    for (i = 0; i < count; i++) {
        key = [keys objectAtIndex:i];
        value = [dict objectForKey:key];
        [self checkType:value ClassName:classname fieldName:key count:icount];
    }
}

+ (void)checkType:(id)input ClassName:(NSString *)classname fieldName:(id)field count:(int)icount {
    if ([[NSString stringWithFormat:@"%@",[input class]] isEqualToString:@"__NSCFString"]) {
        [infoArray addObject:[self formateDicWithName:[NSString stringWithFormat:@"%d",icount] ClassName:[self stringCompare:classname] Type:@"NSString" FieldName:field]];
    }
    else if ([[NSString stringWithFormat:@"%@",[input class]] isEqualToString:@"__NSCFNumber"]){
        [infoArray addObject:[self formateDicWithName:[NSString stringWithFormat:@"%d",icount] ClassName:[self stringCompare:classname] Type:@"NSInteger" FieldName:field]];
    }
    else if ([[NSString stringWithFormat:@"%@",[input class]] isEqualToString:@"JKDictionary"]){
        [infoArray addObject:[self formateDicWithName:[NSString stringWithFormat:@"%d",icount] ClassName:[self stringCompare:classname] Type:[NSString stringWithFormat:@"Ule_%@",field] FieldName:[NSString stringWithFormat:@"%@",field]]];
        
        [self describeDictionary:input ClassName:field count:icount+1];
    }
    else if ([[NSString stringWithFormat:@"%@",[input class]] isEqualToString:@"JKArray"]){
        [infoArray addObject:[self formateDicWithName:[NSString stringWithFormat:@"%d",icount] ClassName:[self stringCompare:classname] Type:@"NSMutableArray" FieldName:[NSString stringWithFormat:@"%@",field]]];
        
        for (NSDictionary *__dic in input) {
            [self describeDictionary:__dic ClassName:field count:icount+1];
            break;
        }
    }else if ([[NSString stringWithFormat:@"%@",[input class]] isEqualToString:@"__NSArrayM"]){
        [infoArray addObject:[self formateDicWithName:[NSString stringWithFormat:@"%d",icount] ClassName:[self stringCompare:classname] Type:@"NSMutableArray" FieldName:[NSString stringWithFormat:@"%@",field]]];
        
        for (NSDictionary *__dic in input) {
            [self describeDictionary:__dic ClassName:field count:icount+1];
            break;
        }
    }

    else{
        [infoArray addObject:[self formateDicWithName:[NSString stringWithFormat:@"%d",icount] ClassName:[self stringCompare:classname] Type:@"NSString" FieldName:field]];
    }
}

// 对字段的封装
+ (NSDictionary *)formateDicWithName:(NSString *)index ClassName:(NSString *)calssname Type:(NSString *)type FieldName:(NSString *)fieldname
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            index, @"index",
            calssname, @"classname",
            type, @"type",
            fieldname, @"fieldname",nil];
}

// 实现排序
+ (NSMutableArray *)formateDicWithSequence:(NSMutableArray *)result {
    NSSortDescriptor *sortByDic = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:NO];
    [result sortUsingDescriptors:[NSArray arrayWithObject:sortByDic]];
    
    return result;
}

// 将url解析为 类名
+ (NSString *)formateComponents:(NSString *)input {
    if (input.length > 0) {
        NSArray *arr = [input componentsSeparatedByString:@"/"];
        if (arr.count > 0) {
            NSString *strString = [arr objectAtIndex:arr.count-1];
            NSArray *newArr = [strString componentsSeparatedByString:@"."];
            if (newArr.count > 0) {
                return [newArr objectAtIndex:0];
            }
            else
                return input;
        }
        else
            return input;
    }
    
    return @"";
}

+ (NSString*)stringCompare:(NSString*)input {
    if (input.length < 4) {
        return [NSString stringWithFormat:@"Ule_%@",input];
    }
    else if([[input substringToIndex:4] isEqualToString:@"Ule_"]){
        return input;
    }
    else
    {
        return [NSString stringWithFormat:@"Ule_%@",input];
    }
}
*/

@end
