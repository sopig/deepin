//
//  resMod_CheckCoupon.h
//  BoqiiLife
//
//  Created by YSW on 14-5-13.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

/******************************************************
 ---------        Check Coupon Info
 ******************************************************
 */
@interface resMod_CheckCoupon : NSObject{
   
    NSString *  CouponPrice;   //优惠券面值
    
}
@property (retain,nonatomic) NSString * CouponPrice;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end






/******************************************************
 ---------        CheckCoupon CallBack
 ******************************************************
 */
@interface resMod_CallBack_CheckCoupon : NSObject {
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_CheckCoupon * ResponseData;
}

@property (nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_CheckCoupon * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
