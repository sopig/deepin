//
//  MemoryData.h
//  ule_specSale
//
//  Created by ysw on 14-4-18.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>


extern  const   NSString *          HEAD_KEY_WANTYPE;
extern  const   NSString *          HEAD_VALUE_WANTYPE;

/*********************  http公共头名稱  ************************/

extern  const   NSString *          HEAD_KEY_APPVERSION ;
extern  const   NSString *          HEAD_KEY_FORMAT ;
extern  const   NSString *          HEAD_KEY_DEVICETYPE ;
extern  const   NSString *          HEAD_KEY_SYSTEMNAME ;
extern  const   NSString *          HEAD_KEY_SYSTEMVERSION;
extern  const   NSString *          HEAD_KEY_SIGN ;
extern  const   NSString *          HEAD_KEY_UDID ;
extern  const   NSString *          HEAD_KEY_VERSION ;

/**********************  http公共头值  ************************/

extern  const   NSString *          HEAD_VALUE_APPVERSION   ;
extern  const   NSString *          HEAD_VALUE_FORMAT       ;
extern  const   NSString *          HEAD_VALUE_SYSTEMNAME   ;
extern  const   NSString *          HEAD_VALUE_VERSION      ;
extern   NSString *          HEAD_VALUE_DEVICETYPE   ;
extern   NSString *          HEAD_VALUE_SYSTEMVERSION;
extern   NSString *          HEAD_VALUE_SIGN         ;
extern   NSString *          HEAD_VALUE_UDID         ;


#pragma mark -

@interface MemoryData : NSObject

/*
 *  获取数据字典
 */
+ (NSMutableDictionary *)commonParams;
/*
 *  设置公用参数，由[set CommonParam:** value:**]设置
 */
+ (void)setCommonParam:(id)key value:(id)value;

/*
 *  根据key查询数据字典对应value数据
 *  @params
 *  key:
 *  字段关键字
 *  return:
 *  返回obj类型数据
 */
+ (id)commonParam:(id)key;

@end