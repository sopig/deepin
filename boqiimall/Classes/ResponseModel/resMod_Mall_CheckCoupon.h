//
//  resMod_Mall_CheckCoupon.h
//  boqiimall
//
//  Created by YSW on 14-7-9.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_Mall_CheckCoupon : NSObject
{
    float CouponPrice;      //	Float	优惠券面值
    float GoodsTotalMoney;  //	Float	商品总金额
    float Preferential;     //	Float	优惠金额
    float GoodsToPay;       //	Float	还需支付
}

@property (assign,nonatomic) float CouponPrice;      //	Float	优惠券面值
@property (assign,nonatomic) float GoodsTotalMoney;  //	Float	商品总金额
@property (assign,nonatomic) float Preferential;     //	Float	优惠金额
@property (assign,nonatomic) float GoodsToPay;       //	Float	还需支付

-(instancetype)initWithDic:(NSDictionary*)dic;
@end









/******************************************************
 ---------        return  : call back
 ******************************************************
 */
@interface resMod_CallBackMall_CheckCoupon: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_Mall_CheckCoupon * ResponseData;
}
@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_Mall_CheckCoupon * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end