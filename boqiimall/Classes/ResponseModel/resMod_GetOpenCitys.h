//
//  resMod_GetOpenCitys.h
//  boqiimall
//
//  Created by YSW on 14-7-23.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_GetOpenCitys : NSObject {
    NSString * CityId;              //--	Int	市id
    NSString * CityName;            //--	String	市名称
}
@property (retain,nonatomic) NSString * CityId;
@property (retain,nonatomic) NSString * CityName;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end





/******************************************************
 ---------       call back : 生活馆 开 通 城 市
 ******************************************************
 */
@interface resMod_CallBack_GetOpenCitys : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end