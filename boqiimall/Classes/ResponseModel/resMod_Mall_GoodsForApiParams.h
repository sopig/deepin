//
//  resMod_Mall_GoodsForApiParams.h
//  boqiimall
//
//  Created by YSW on 14-7-17.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_Mall_GoodsForApiParams : NSObject
@property   (assign, nonatomic) int   GoodsId;
@property   (assign, nonatomic) int   GoodsNum;
@property   (assign, nonatomic) int   limitNum;
@property   (assign, nonatomic) int   GoodsType;              //--普通商品\团购商品等
@property   (retain, nonatomic) NSString    *   GoodsSpecId;  //--组合规格id

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

