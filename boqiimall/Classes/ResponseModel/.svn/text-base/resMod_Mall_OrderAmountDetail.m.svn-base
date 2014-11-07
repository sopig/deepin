//
//  resMod_Mall_OrderAmountDetail.m
//  boqiimall
//
//  Created by ysw on 14-9-11.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_OrderAmountDetail.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

@implementation resMod_Mall_OrderAmountDetail
@synthesize GoodsPrice;
@synthesize ExpressagePrice;
@synthesize PreferentialPrice;
@synthesize CouponPrice;
@synthesize NeedToPay;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.GoodsPrice = [[dic ConvertStringForKey:@"GoodsPrice"] floatValue];
        self.ExpressagePrice = [[dic ConvertStringForKey:@"ExpressagePrice"] floatValue];
        self.PreferentialPrice = [[dic ConvertStringForKey:@"PreferentialPrice"] floatValue];
        self.CouponPrice = [[dic ConvertStringForKey:@"CouponPrice"] floatValue];
        self.NeedToPay = [[dic ConvertStringForKey:@"NeedToPay"] floatValue];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void)dealloc{
     [super dealloc];
}
#endif
@end




@implementation resMod_CallBackMall_OrderAmountDetail
@synthesize ResponseStatus;
@synthesize ResponseMsg;
@synthesize ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData= [[resMod_Mall_OrderAmountDetail alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void)dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end
