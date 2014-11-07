//
//  resMod_Mall_IndexData.h
//  boqiimall
//
//  Created by YSW on 14-6-30.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//  --  banner列表
@interface resMod_Mall_IndexBanner : NSObject
@property (assign,nonatomic) int Type;
@property (strong,nonatomic) NSString * ImageUrl;
@property (strong,nonatomic) NSString * Url;
@property (strong,nonatomic) NSString * Title;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

//  --  Banner下面可配置的数据
@interface resMod_Mall_IndexMain : NSObject
@property (strong,nonatomic) NSString * TabId;
@property (strong,nonatomic) NSString * TabName;
@property (strong,nonatomic) NSMutableArray * TypeList;
@property (strong,nonatomic) NSMutableArray * TemplateList;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  --  类型列表
@interface resMod_Mall_IndexTypeData : NSObject
@property (assign,nonatomic) int TypeId;
@property (strong,nonatomic) NSString * TypeName;
@property (strong,nonatomic) NSString * TypeImg;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  --  模板类型
@interface resMod_Mall_IndexTemplate : NSObject
@property (assign,nonatomic) int TemplateType;
@property (strong,nonatomic) NSMutableArray * Template;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  --  ....
@interface resMod_Mall_IndexResponseData : NSObject
@property (strong,nonatomic) NSMutableArray * BannerList;
@property (strong,nonatomic) NSMutableArray * MainData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



/******************************************************
 ---------        return: call back
 ******************************************************
 */
@interface resMod_CallBackMall_IndexData: NSObject
@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) resMod_Mall_IndexResponseData * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



