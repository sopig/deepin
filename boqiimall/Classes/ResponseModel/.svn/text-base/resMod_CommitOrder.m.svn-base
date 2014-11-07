//
//  resMod_CommitOrder.m
//  BoqiiLife
//
//  Created by YSW on 14-5-13.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_CommitOrder.h"
#import "NSDictionary+JudgeObj.h"

@implementation resMod_CommitOrderInfo
@synthesize OrderId;
@synthesize CanUseCoupon;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.OrderId = [[dic ConvertStringForKey:@"OrderId"] intValue];
        self.CanUseCoupon  = NO;
    }
    return self;
}

//@synthesize OrderTeleNum;
//@synthesize OrderTotalPrice;
//@synthesize ProductId;
//@synthesize ProductName;

#if ! __has_feature(objc_arc)
-(void) dealloc{
    
//    [OrderTeleNum release];
//    [OrderTotalPrice release];
//    [ProductId release];
//    [ProductName release];
    [super dealloc];
}
#endif
@end



@implementation resMod_CallBack_CommitOrder
@synthesize ResponseStatus;
@synthesize ResponseMsg;
@synthesize ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_CommitOrderInfo alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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