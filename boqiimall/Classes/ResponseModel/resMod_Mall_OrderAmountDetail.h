//
//  resMod_Mall_OrderAmountDetail.h
//  boqiimall
//
//  Created by ysw on 14-9-11.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_Mall_OrderAmountDetail : NSObject

@property (assign,nonatomic) float GoodsPrice;
@property (assign,nonatomic) float ExpressagePrice;
@property (assign,nonatomic) float PreferentialPrice;
@property (assign,nonatomic) float CouponPrice;
@property (assign,nonatomic) float NeedToPay;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end




/******************************************************
 ---------        return  : call back
 ******************************************************
 */
@interface resMod_CallBackMall_OrderAmountDetail: NSObject

@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) resMod_Mall_OrderAmountDetail * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end