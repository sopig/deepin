//
//  resMod_MyOrders.m
//  BoqiiLife
//
//  Created by YSW on 14-5-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_MyOrders.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

@implementation resMod_MyOrderInfo
@synthesize OrderId;
@synthesize OrderTicketId;
@synthesize OrderTitle;
@synthesize OrderPrice;
@synthesize OrderImg;
@synthesize OrderStatus;
@synthesize OrderStatusText;
@synthesize OrderTicketNo;
@synthesize OrderTel;
@synthesize OrderCouponNo;
@synthesize TicketId;
@synthesize TicketNumber;
@synthesize IsUseBalance;
@synthesize BalanceUsed;
@synthesize IsUsedCoupon;
@synthesize CouponPrice;
@synthesize CouponCode;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.OrderId = [[dic ConvertStringForKey:@"OrderId"] intValue];
        self.OrderTicketId = [dic ConvertStringForKey:@"OrderTicketId"];
        self.OrderTitle = [dic ConvertStringForKey:@"OrderTitle"];
        self.OrderPrice = [[dic ConvertStringForKey:@"OrderPrice"] floatValue];
        self.OrderImg = [dic ConvertStringForKey:@"OrderImg"];
        self.OrderStatus = [[dic ConvertStringForKey:@"OrderStatus"] intValue];
        self.OrderStatusText = [dic ConvertStringForKey:@"OrderStatusText"];
        self.OrderTicketNo = [dic ConvertStringForKey:@"OrderTicketNo"];
        self.OrderTel = [dic ConvertStringForKey:@"OrderTel"];
        self.OrderCouponNo = [dic ConvertStringForKey:@"OrderCouponNo"];
        self.TicketId = [[dic ConvertStringForKey:@"TicketId"] intValue];
        self.TicketNumber = [[dic ConvertStringForKey:@"TicketNumber"] intValue];
        self.IsUseBalance = [[dic ConvertStringForKey:@"IsUseBalance"] intValue];
        self.BalanceUsed = [[dic ConvertStringForKey:@"BalanceUsed"] floatValue];
        self.IsUsedCoupon = [[dic ConvertStringForKey:@"IsUsedCoupon"] intValue];
        self.CouponPrice = [[dic ConvertStringForKey:@"CouponPrice"] floatValue];
        self.CouponCode = [dic ConvertStringForKey:@"CouponCode"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [OrderTicketId  release];
    [OrderTitle     release];
    [OrderImg       release];
    [OrderStatusText release];
    [OrderTicketNo  release];
    [OrderTel       release];
    [OrderCouponNo  release];
    [CouponCode     release];
    [super dealloc];
}
#endif
@end




//  -- callback
@implementation resMod_CallBack_MyOrderList
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray * tmpResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData= [[NSMutableArray alloc] initWithCapacity:tmpResponseData.count];
        for (NSDictionary * item in tmpResponseData) {
            [ResponseData addObject:[[resMod_MyOrderInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData{
//    if(ResponseData && [ResponseData isKindOfClass:[NSArray class]]){
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_MyOrderInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_MyOrderInfo")]];
//            }
//        }
//        return ResponseData;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ResponseData   release];
    [ResponseMsg    release];
    [super dealloc];
}
#endif
@end