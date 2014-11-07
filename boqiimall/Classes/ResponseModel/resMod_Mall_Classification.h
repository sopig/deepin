//
//  resMod_Mall_Classification.h
//  boqiimall
//
//  Created by YSW on 14-6-30.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//  ...........
@interface resMod_Mall_Class1th : NSObject
@property (assign,nonatomic) int TypeId;
@property (retain,nonatomic) NSString * TypeName;
@property (retain,nonatomic) NSMutableArray * TypeList;
@property (retain,nonatomic) NSString * HotKeyword;
@property (retain,nonatomic) NSString * TypeImg;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  ...........
@interface resMod_Mall_Class2th : NSObject
@property (assign,nonatomic) int SubTypeId;
@property (retain,nonatomic) NSString * SubTypeName;
@property (retain,nonatomic) NSMutableArray * SubTypeList;
@property (retain,nonatomic) NSString * SubTypeImg;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  ...........
@interface resMod_Mall_Class3th : NSObject
@property (assign,nonatomic) int ThirdTypeId;
@property (retain,nonatomic) NSString * ThirdTypeName;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end





/******************************************************
 ---------        return: call back
 ******************************************************
 */
@interface resMod_CallBackMall_Classification: NSObject
@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
