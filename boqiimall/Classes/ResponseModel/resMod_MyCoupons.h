//
//  resMod_MyCoupons.h
//  BoqiiLife
//
//  Created by YSW on 14-5-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

/******************************************************
 ---------       return MyCouponInfo
 ******************************************************
 */
@interface resMod_MyCouponInfo : NSObject{
    int CouponId;
    NSString * CouponTitle;
    NSString * CouponRange;
    int CouponType;
    NSString * CouponNo;
    
    float CouponPrice;    //  --优惠券面值
    NSString * CouponDiscount; //  --优惠券折扣或价格
}

@property (strong,nonatomic) NSString * CouponTitle;
@property (strong,nonatomic) NSString * CouponRange;
@property (assign,nonatomic) int CouponId;
@property (assign,nonatomic) int CouponType;
@property (strong,nonatomic) NSString * CouponNo;

@property (assign,nonatomic) float CouponPrice;     //  --优惠券面值
@property (strong,nonatomic) NSString * CouponDiscount;  //  --优惠券折扣或价格

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        MyCouponList CallBack
 ******************************************************
 */
@interface resMod_CallBack_MyCouponList : NSObject {
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end





/******************************************************
 ---------       return GetCouponDetail
 ******************************************************
 */
@interface resMod_GetCouponDetail : NSObject{
    int CouponStatus;
    NSString * CouponTitle;
    float CouponPrice;
    NSString * CouponNo;
    NSString * CouponCondition;
    NSString * CouponStartTime;
    NSString * CouponEndTime;
    NSString * CouponDesc;
    NSString * CouponRange;
    NSString * CouponUsedOrder;
    NSString * CouponUsedTime;
}
@property (assign,nonatomic) int CouponStatus;
@property (strong,nonatomic) NSString * CouponTitle;
@property (assign,nonatomic) float CouponPrice;
@property (strong,nonatomic) NSString * CouponNo;
@property (strong,nonatomic) NSString * CouponCondition;
@property (strong,nonatomic) NSString * CouponStartTime;
@property (strong,nonatomic) NSString * CouponEndTime;
@property (strong,nonatomic) NSString * CouponDesc;
@property (strong,nonatomic) NSString * CouponRange;
@property (strong,nonatomic) NSString * CouponUsedOrder;
@property (strong,nonatomic) NSString * CouponUsedTime;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        GetCouponDetail CallBack
 ******************************************************
 */
@interface resMod_CallBack_GetCoupon : NSObject {
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_GetCouponDetail * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) resMod_GetCouponDetail * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end




