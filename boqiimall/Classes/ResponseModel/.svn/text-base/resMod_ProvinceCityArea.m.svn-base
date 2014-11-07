//
//  resMod_ProvinceCityArea.m
//  boqiimall
//
//  Created by YSW on 14-7-7.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_ProvinceCityArea.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"


@implementation resMod_ProvinceCityArea
@synthesize pca_provinceId,pca_cityId,pca_areaId;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.pca_provinceId = [dic ConvertStringForKey:@"pca_provinceId"];
        self.pca_cityId = [dic ConvertStringForKey:@"pca_cityId"];
        self.pca_areaId = [dic ConvertStringForKey:@"pca_areaId"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void)dealloc {
    [pca_provinceId release];
    [pca_cityId release];
    [pca_areaId release];
    
    [super dealloc];
}
#endif
@end



@implementation resMod_ProvinceInfo
@synthesize ProvinceId;
@synthesize ProvinceName;
@synthesize CityList;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ProvinceId = [[dic ConvertStringForKey:@"ProvinceId"] intValue];
        self.ProvinceName = [dic ConvertStringForKey:@"ProvinceName"];

        NSArray * tmpCityList = [dic ConvertArrayForKey:@"CityList"];
        self.CityList = [[NSMutableArray alloc] initWithCapacity:tmpCityList.count];
        for (NSDictionary * item in tmpCityList) {
            [CityList addObject:[[resMod_CityInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)CityList{
//    if (CityList && [CityList isKindOfClass:[NSArray class]]) {
//        
//        for (int i = 0; i < CityList.count; i++) {
//            if([[CityList objectAtIndex:i] class] != [resMod_CityInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[CityList objectAtIndex:i];
//                [CityList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_CityInfo")]];
//            }
//        }
//        return CityList;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ProvinceName release];
    [CityList release];
    [super dealloc];
}
#endif
@end


@implementation resMod_CityInfo
@synthesize CityId;
@synthesize CityName;
@synthesize AreaList;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.CityId = [[dic ConvertStringForKey:@"CityId"] intValue];
        self.CityName = [dic ConvertStringForKey:@"CityName"];
        
        NSArray * tmpAreaList = [dic ConvertArrayForKey:@"AreaList"];
        self.AreaList = [[NSMutableArray alloc] initWithCapacity:tmpAreaList.count];
        for (NSDictionary * item in tmpAreaList) {
            [AreaList addObject:[[resMod_AreaInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)AreaList{
//    if (AreaList && [AreaList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < AreaList.count; i++) {
//            if([[AreaList objectAtIndex:i] class] != [resMod_AreaInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[AreaList objectAtIndex:i];
//                [AreaList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_AreaInfo")]];
//            }
//        }
//        return AreaList;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [CityName release];
    [AreaList release];
    [super dealloc];
}
#endif
@end


@implementation resMod_AreaInfo
@synthesize AreaId;
@synthesize AreaName;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.AreaId = [[dic ConvertStringForKey:@"AreaId"] intValue];
        self.AreaName = [dic ConvertStringForKey:@"AreaName"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [AreaName release];
    [super dealloc];
}
#endif
@end




//  --................
@implementation resMod_CallBack_ProvinceCityArea
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];

        NSArray * tmpResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc] initWithCapacity:tmpResponseData.count];
        for (NSDictionary * item in tmpResponseData) {
            [ResponseData addObject:[[resMod_ProvinceInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_ProvinceInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_ProvinceInfo")]];
//            }
//        }
//        return ResponseData;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
- (void)dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end