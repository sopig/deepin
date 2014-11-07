//
//  resMod_CheckCoupon.m
//  BoqiiLife
//
//  Created by YSW on 14-5-13.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_CheckCoupon.h"
#import "NSDictionary+JudgeObj.h"

@implementation resMod_CheckCoupon
@synthesize CouponPrice;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.CouponPrice = [dic ConvertStringForKey:@"CouponPrice"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [CouponPrice release];
    [super dealloc];
}
#endif
@end


@implementation resMod_CallBack_CheckCoupon
@synthesize ResponseMsg;
@synthesize ResponseData;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_CheckCoupon alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}


#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ResponseData release];
    [ResponseMsg release];
    [super dealloc];
}
#endif
@end