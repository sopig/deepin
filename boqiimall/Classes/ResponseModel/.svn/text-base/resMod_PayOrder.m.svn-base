//
//  resMod_PayOrder.m
//  BoqiiLife
//
//  Created by YSW on 14-5-14.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_PayOrder.h"
#import "NSDictionary+JudgeObj.h"

@implementation resMod_PayOrder
@synthesize Type;
@synthesize PayMessage;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.Type = [[dic ConvertStringForKey:@"Type"] intValue];
        
        if (self.Type == 4)//如果是微信支付
        {
//            NSDictionary*messageDic = [[BQUtil toDict:self.PayMessage] retain];
//            self.PayMessage = [dic ConvertDictForKey:@"PayMessage"];
            NSDictionary*messageDic = [dic ConvertDictForKey:@"PayMessage"];

            self.PrepayId = [messageDic objectForKey:@"PrepayId"];
            self.NonceStr = [messageDic objectForKey:@"NonceStr"];
            self.TimeStamp = [messageDic objectForKey:@"TimeStamp"];
            self.Package = [messageDic objectForKey:@"Package"];
            self.AppSignature = [messageDic objectForKey:@"AppSignature"];
        }
        else{
           self.PayMessage = [dic ConvertStringForKey:@"PayMessage"];
        }
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [PayMessage release];
    
    [_PrepayId release];
    _PrepayId = nil;
    [_NonceStr release];
    _NonceStr = nil;
    [_TimeStamp release];
    _TimeStamp = nil;
    [_Package release];
    _Package = nil;
    [_AppSignature release];
    _AppSignature = nil;
    
    [super dealloc];
}
#endif
@end



@implementation resMod_PayAmountDetail
@synthesize OrderPrice;
@synthesize CouponPrice;
@synthesize UseBalance;
@synthesize NeedPayPrice;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.OrderPrice  = [[dic ConvertStringForKey:@"OrderPrice"] floatValue];
        self.CouponPrice = [[dic ConvertStringForKey:@"CouponPrice"] floatValue];
        self.UseBalance  = [[dic ConvertStringForKey:@"UseBalance"] floatValue];
        self.NeedPayPrice= [[dic ConvertStringForKey:@"NeedPayPrice"] floatValue];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-  (void) dealloc{
    [super dealloc];
}
#endif
@end



@implementation resMod_CallBack_GetPayAmountDetail
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_PayAmountDetail alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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



@implementation resMod_CallBack_PayOrder
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_PayOrder alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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