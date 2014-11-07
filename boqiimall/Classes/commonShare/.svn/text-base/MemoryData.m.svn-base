//
//  MemoryData.m
//
//  Created by ysw on 14-4-18.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MemoryData.h"
//#import "MKNetworkEngine.h"


const   NSString *          HEAD_KEY_WANTYPE        = @"wantype";
const   NSString *          HEAD_VALUE_WANTYPE      = @"";  //网络连接类型:Wifi、3G,等

/*********************  http公共头名稱  ************************/

const   NSString *          HEAD_KEY_APPVERSION     = @"AppVersion";
const   NSString *          HEAD_KEY_FORMAT         = @"Format";        // 固定值 json
const   NSString *          HEAD_KEY_DEVICETYPE     = @"Model";         // 手机型号 4、4s、5...
const   NSString *          HEAD_KEY_SYSTEMNAME     = @"SystemName";    // ios
const   NSString *          HEAD_KEY_SYSTEMVERSION  = @"SystemVersion"; //
const   NSString *          HEAD_KEY_SIGN           = @"Sign";          // 组合值usertoken
const   NSString *          HEAD_KEY_UDID           = @"UDID";          //
//const   NSString *          HEAD_KEY_VERSION        = @"Version";       // 固定值 1.0

/**********************  http公共头值  ************************/

const   NSString *          HEAD_VALUE_APPVERSION   = APP_VERSION;
const   NSString *          HEAD_VALUE_FORMAT       = APP_FORMAT;
const   NSString *          HEAD_VALUE_SYSTEMNAME   = @"IOS";
//const   NSString *          HEAD_VALUE_VERSION      = @"1.0";
NSString *          HEAD_VALUE_DEVICETYPE   = @"";
NSString *          HEAD_VALUE_SYSTEMVERSION= @"";
NSString *          HEAD_VALUE_SIGN         = @"";
NSString *          HEAD_VALUE_UDID         = @"";


#pragma mark -

static  NSMutableDictionary *commonParams;

@implementation MemoryData

+ (void)initialize {

    if (!commonParams ) {
        commonParams = [[NSMutableDictionary alloc]init];
        
//        NSLog(@"%@---%@----%@",[BQ_global questModelInfo],[BQ_global questSystemName],[BQ_global questSystemVersion]);
       
        
//        NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
//                                    HEAD_VALUE_APPVERSION   , HEAD_KEY_APPVERSION,
//                                    HEAD_VALUE_FORMAT       , HEAD_KEY_FORMAT,
//                                    HEAD_VALUE_SYSTEMNAME   , HEAD_KEY_DEVICETYPE,
//                                    HEAD_VALUE_VERSION      , HEAD_KEY_VERSION,
//                                    HEAD_VALUE_DEVICETYPE   , HEAD_KEY_DEVICETYPE,
//                                    HEAD_VALUE_SYSTEMVERSION, HEAD_KEY_SYSTEMVERSION,
//                                    HEAD_VALUE_SYSTEMNAME   , HEAD_KEY_SYSTEMNAME,
//                                    HEAD_VALUE_UDID         , HEAD_KEY_UDID,
//                                    nil];
        
//        //  --  boqii 商城
//        MKNetworkEngine* mkengine_mall = [[MKNetworkEngine alloc] initWithHostName:kHostUrl_boqiiMall  customHeaderFields:nil];
//        [MemoryData setCommonParam:(id)NETWORK_ENGINE_mall value:mkengine_mall];
//        
//        //  --  boqii 生活馆
//        MKNetworkEngine* mkengine_life = [[MKNetworkEngine alloc] initWithHostName:kHostUrl_boqiiLife  customHeaderFields:nil];
//        [MemoryData setCommonParam:(id)NETWORK_ENGINE_life value:mkengine_life];
    }
}


+ (NSMutableDictionary *)commonParams {
    return commonParams;
}

+ (void)setCommonParam:(id)key value:(id)value {
    [commonParams setValue:value forKey:key];
}

+ (id)commonParam:(id)key {
    return [commonParams objectForKey:key];
}

@end
