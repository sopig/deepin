//
//  PMGlobal.m
//  Ule
//
//  Created by ysw on 14-4-18.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "PMGlobal.h"
#import "FileController.h"
#import "resMod_ProvinceCityArea.h"

static PMGlobal *sharedManager = nil;

@implementation PMGlobal
@synthesize httpCommonParams;
@synthesize ApiKeyForMemoryResponseJson;
@synthesize tabBarIndex;
@synthesize isHttp;

+ (PMGlobal *) shared {
	@synchronized(self) {
        if (sharedManager == nil) {
            sharedManager = [[self alloc] init];
        }
    }
    return sharedManager;
}

//  -- http请求共同参数设置
- (NSDictionary *) setHttpParams{
    
    HEAD_VALUE_DEVICETYPE = [BQ_global questModelInfo];
    HEAD_VALUE_SYSTEMVERSION = [BQ_global questSystemVersion];
    HEAD_VALUE_UDID = [BQ_global getUDID];
    NSDictionary* dic = [[[NSDictionary alloc]initWithObjectsAndKeys:
                         HEAD_VALUE_APPVERSION   , HEAD_KEY_APPVERSION,
                         HEAD_VALUE_FORMAT       , HEAD_KEY_FORMAT,
                         HEAD_VALUE_SYSTEMNAME   , HEAD_KEY_DEVICETYPE,
//                         HEAD_VALUE_VERSION      , HEAD_KEY_VERSION,
                         HEAD_VALUE_DEVICETYPE   , HEAD_KEY_DEVICETYPE,
                         HEAD_VALUE_SYSTEMVERSION, HEAD_KEY_SYSTEMVERSION,
                         HEAD_VALUE_SYSTEMNAME   , HEAD_KEY_SYSTEMNAME,
                         HEAD_VALUE_UDID         , HEAD_KEY_UDID,
                         nil] autorelease];
    return dic;
}

- (NSDictionary *) setApiKeyForMemoryJson{
    NSDictionary* dic = [[[NSDictionary alloc]initWithObjectsAndKeys:
                          kApiMethod_Mall_HomeData      ,kApiMethod_Mall_HomeData,
                          kApiMethod_GetProviceCityArea ,kApiMethod_GetProviceCityArea,
                          kApiMethod_Mall_Classification,kApiMethod_Mall_Classification,
                          kApiMethod_GetAreaType        ,kApiMethod_GetAreaType,
                          kApiMethod_GetSortType        ,kApiMethod_GetSortType,
                          kApiMethod_GetMerchantSortType,kApiMethod_GetMerchantSortType,
                          kApiMethod_GetOpenCityList    ,kApiMethod_GetOpenCityList,
                          nil] autorelease];
    return dic;
}

- (id) init {
	if (self = [super init]){
        
        self.httpCommonParams = [self setHttpParams];
        self.ApiKeyForMemoryResponseJson = [self setApiKeyForMemoryJson];

        tabBarIndex = @"";      //tabBar索引
        
        isHttp = YES;
    }
    return self;
}

/******************    所选的全局分类       ************************/
- (void) SaveOverAllIdxForClassify:(int) idx{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",idx] forKey:UserDetault_CheckedCategory];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL) isSetOverAllIdxForClassify{
    NSString * str = [[NSUserDefaults standardUserDefaults] stringForKey:UserDetault_CheckedCategory];
    return str.length>0;
}
- (int) overAllIdxForClassify{     //所选全局分类索引 : 仅用于商城分类 ，生活馆不能用
    NSString * str = [[NSUserDefaults standardUserDefaults] stringForKey:UserDetault_CheckedCategory];
    if (str.length>0) {
        return [str intValue];
    }
    return 0;
}

/******************    定位 : 用户所在城市 及 选中城市       ************************/

- (void) location_SetLocalCity:(NSString *) cityname {          //--设置 所在 城市
    [[NSUserDefaults standardUserDefaults] setObject:cityname  forKey:UserDefault_locationCity];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) location_SetUserCheckedCity:(NSDictionary *) dicCity{     //--设置 选中 城市
    [[NSUserDefaults standardUserDefaults] setObject:dicCity  forKey:UserDefault_CheckedCity];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*) location_GetLocalCity{         //--获取 所在 城市
   return  [[NSUserDefaults standardUserDefaults] objectForKey:UserDefault_locationCity];
}

- (NSDictionary*) location_GetUserCheckedCity{   //--获取 选中 城市
   return  [[NSUserDefaults standardUserDefaults] objectForKey:UserDefault_CheckedCity];
}


/********************************************************************************
 *
 *                          缓 存 本 地 数 据
 *
 ********************************************************************************/


//  ------------------      商城首页
- (resMod_Mall_IndexResponseData *) GetDataFromPlist_MallIndex{
    
    NSString * path = [[FileController documentsPath] stringByAppendingPathComponent: MemoryFileName];
    if (path.length>0) {
        NSMutableDictionary * dic_Plist = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
        if (!dic_Plist) {
            return nil;
        }
        NSString * jsonResponse = [dic_Plist objectForKey:kApiMethod_Mall_HomeData];
        if (jsonResponse.length>0) {
            resMod_CallBackMall_IndexData * backObj = [[resMod_CallBackMall_IndexData alloc] initWithDic:[BQ_global decodeJsonToDictionary:jsonResponse]];
        
            [dic_Plist release];
            return backObj.ResponseData;
        }
    }
    return nil;
}


//  ------------------      地址部分 : 省 市 区
- (NSMutableArray*) GetDataFromPlist_ProvinceCityArea{
    
    NSString * path = [[FileController documentsPath] stringByAppendingPathComponent: MemoryFileName];
    if (path.length>0) {
        NSMutableDictionary * dic_Plist = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
        if (!dic_Plist) {
            return nil;
        }
        NSString * jsonResponse = [dic_Plist objectForKey:kApiMethod_GetProviceCityArea];
        if (jsonResponse.length>0) {
            resMod_CallBack_ProvinceCityArea * backObj = [[resMod_CallBack_ProvinceCityArea alloc] initWithDic:[BQ_global decodeJsonToDictionary:jsonResponse]];
            if(backObj.ResponseData.count>0){
                [dic_Plist release];
                return backObj.ResponseData;
            }
        }
    }
    return  nil;
}

//- (void) setProvinceCityArea:(NSMutableArray*) pcadata{
//    if (pcadata.count>0) {
//        
//        NSMutableArray * arrProvinceCityArea = [[NSMutableArray alloc] initWithCapacity:0];
//        for (resMod_ProvinceInfo * keyprovince in pcadata) {
//            
//            resMod_ProvinceInfo * province = [[resMod_ProvinceInfo alloc] init];
//            province.ProvinceId = keyprovince.ProvinceId;
//            province.ProvinceName = keyprovince.ProvinceName;
//            province.CityList = [[NSMutableArray alloc] initWithCapacity:0];
//
//            for (resMod_CityInfo * keycity in keyprovince.CityList) {
//                resMod_CityInfo * city = [[resMod_CityInfo alloc] init];
//                city.CityId = keycity.CityId;
//                city.CityName = keycity.CityName;
//                city.AreaList = [[NSMutableArray alloc] initWithCapacity:0];
//                
//                for (resMod_AreaInfo * keyarea in keycity.AreaList) {
//                    resMod_AreaInfo * area = [[resMod_AreaInfo alloc] init];
//                    area.AreaId = keyarea.AreaId;
//                    area.AreaName = keyarea.AreaName;
//                    [city.AreaList addObject:area];
//                }
//                
//                if (city.AreaList.count==0) {
//                    resMod_AreaInfo * area = [[resMod_AreaInfo alloc] init];
//                    area.AreaId = -1000;
//                    area.AreaName = @"全部区域";
//                    city.AreaList = [[NSMutableArray alloc]initWithObjects:area, nil];
//                }
//                [province.CityList addObject:city];
//            }
//            [arrProvinceCityArea addObject:province];
//        }
//        
//        [MemoryData setCommonParam:MemoryData_PCA value:arrProvinceCityArea];
//    }
//}


- (void)dealloc {
    
    [tabBarIndex release];
    [super dealloc];
}

@end
