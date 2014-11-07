//
//  resMod_Mall_CheckCoupon.m
//  boqiimall
//
//  Created by YSW on 14-7-9.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_CheckCoupon.h"
#import "NSDictionary+JudgeObj.h"

@implementation resMod_Mall_CheckCoupon
@synthesize CouponPrice;
@synthesize GoodsToPay;
@synthesize Preferential;
@synthesize GoodsTotalMoney;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.CouponPrice = [[dic ConvertStringForKey:@"CouponPrice"] floatValue];
        self.GoodsToPay  = [[dic ConvertStringForKey:@"GoodsToPay"] floatValue];
        self.Preferential  = [[dic ConvertStringForKey:@"Preferential"] floatValue];
        self.GoodsTotalMoney  = [[dic ConvertStringForKey:@"GoodsTotalMoney"] floatValue];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [super dealloc];
}
#endif
@end






//  --..................
@implementation resMod_CallBackMall_CheckCoupon
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] floatValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_Mall_CheckCoupon alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end
