//
//  resMod_ProvinceCityArea.h
//  boqiimall
//
//  Created by YSW on 14-7-7.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_ProvinceCityArea : NSObject{
    NSString * pca_provinceId;
    NSString * pca_cityId;
    NSString * pca_areaId;
}
@property(nonatomic,retain) NSString * pca_provinceId;
@property(nonatomic,retain) NSString * pca_cityId;
@property(nonatomic,retain) NSString * pca_areaId;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end




@interface resMod_ProvinceInfo : NSObject{
    int ProvinceId;             //--	Int	省份id
    NSString * ProvinceName;    //--	String	省份名称
    NSMutableArray * CityList;  //--	JsonArray	市区信息列表
}
@property (assign,nonatomic) int ProvinceId;
@property (retain,nonatomic) NSString * ProvinceName;
@property (retain,nonatomic) NSMutableArray * CityList;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



@interface resMod_CityInfo : NSObject{
    int CityId;                 //--	Int	市id
    NSString * CityName;        //--	String	市名称
    NSMutableArray * AreaList;  //--	JsonArray	区域信息列表
}
@property (assign,nonatomic) int CityId;
@property (retain,nonatomic) NSString * CityName;
@property (retain,nonatomic) NSMutableArray * AreaList;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end




@interface resMod_AreaInfo : NSObject{
    int AreaId;                 //--	Int	区id
    NSString * AreaName;        //--	String	区名称
}
@property (assign,nonatomic) int AreaId;
@property (retain,nonatomic) NSString * AreaName;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end








/******************************************************
 ---------       call back : 省 市 区
 ******************************************************
 */
@interface resMod_CallBack_ProvinceCityArea : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end