//
//  resMod_Mall_GoodsSpec.h
//  boqiimall
//
//  Created by YSW on 14-7-4.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>


//  ---................
@interface resMod_Mall_GoodsSpecPropertyInfo : NSObject{
    int Id;
    NSString * Name;
}

@property (assign,nonatomic) int Id;
@property (retain,nonatomic) NSString * Name;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

//  ---................ 规格列表
@interface resMod_Mall_GoodsSpecProperties : NSObject{
    int PropertyID;
    NSString * PropertyName;
    NSMutableArray * Properties;
}

@property (assign,nonatomic) int PropertyID;
@property (retain,nonatomic) NSString * PropertyName;
@property (retain,nonatomic) NSMutableArray * Properties;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

//  ---................ 规格所有组合
@interface resMod_Mall_GoodsSpecGroups : NSObject{
    NSString * SpecId;
    float SpecPrice;
    float SpecOriPrice;
    int SpecLimit;
    int SpecSotck;
    NSString * SpecProperties;
}

@property (retain,nonatomic) NSString * SpecId;
@property (assign,nonatomic) float SpecPrice;
@property (assign,nonatomic) float SpecOriPrice;
@property (assign,nonatomic) int SpecLimit;
@property (assign,nonatomic) int SpecSotck;
@property (retain,nonatomic) NSString * SpecProperties;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  ---...................
@interface resMod_Mall_GoodsSpecList : NSObject{
    NSMutableArray * GoodsProperties;
    NSMutableArray * GoodsSpecs;
}

@property (retain,nonatomic) NSMutableArray * GoodsProperties;
@property (retain,nonatomic) NSMutableArray * GoodsSpecs;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

/******************************************************
 ---------        return    Detail : call back
 ******************************************************
 */
@interface resMod_CallBackMall_GoodsSpec: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_Mall_GoodsSpecList * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_Mall_GoodsSpecList * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
