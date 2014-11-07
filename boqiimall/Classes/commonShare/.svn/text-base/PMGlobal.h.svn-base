//
//  PMGlobal.h
//  Ule
//
//  Created by ysw on 14-4-18.
//  Copyright (c) 2014年 boqii. All rights reserved.
//
// 

#import <Foundation/Foundation.h>
#import "resMod_Mall_IndexData.h"


@interface PMGlobal : NSObject{
    
    //http请求共同参数设置
    NSDictionary    * httpCommonParams;
    
    NSString *      tabBarIndex;
    
    BOOL    isHttp;             //是否有网络连接
    
    
    NSMutableArray * MainCategorys;  //
}

@property (nonatomic, retain)NSDictionary    *ApiKeyForMemoryResponseJson;
@property (nonatomic, retain)NSDictionary    *httpCommonParams;
@property (nonatomic, retain)NSString   *tabBarIndex;
@property (nonatomic, assign)BOOL    isHttp;

+ (PMGlobal *) shared;


//----------------- 选中的分类 ：首页tab切换
- (void) SaveOverAllIdxForClassify:(int) idx;
- (BOOL) isSetOverAllIdxForClassify;
- (int)  overAllIdxForClassify;     //所选全局分类索引 : 仅用于商城分类 ，生活馆不能用


/******************    定位 : 用户所在城市 及 选中城市       ************************/

- (void) location_SetLocalCity:(NSString *) cityname;           //--所在城市

- (void) location_SetUserCheckedCity:(NSDictionary *) cityname;     //--选中城市

- (NSString*) location_GetLocalCity;                //--获取 所在 城市

- (NSDictionary*) location_GetUserCheckedCity;      //--获取 选中 城市


/********************************************************************************
 *
 *                           缓 存 本 地 数 据
 *
 ********************************************************************************/

//  ------------------      商城首页
- (resMod_Mall_IndexResponseData *) GetDataFromPlist_MallIndex;

//  ------------------      地址部分 : 省 市 区
//- (void) setProvinceCityArea:(NSMutableArray*) pcadata;
- (NSMutableArray *) GetDataFromPlist_ProvinceCityArea;

@end
