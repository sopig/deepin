//
//  resMod_MyCoupons.m
//  BoqiiLife
//
//  Created by YSW on 14-5-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_MyCoupons.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

/******************************************************
 ---------       return MyCouponInfo
 ******************************************************
 */
@implementation resMod_MyCouponInfo
@synthesize CouponId;
@synthesize CouponPrice,CouponDiscount;
@synthesize CouponTitle;
@synthesize CouponRange;
@synthesize CouponType;
@synthesize CouponNo;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.CouponId = [[dic ConvertStringForKey:@"CouponId"] intValue];
        self.CouponPrice = [[dic ConvertStringForKey:@"CouponPrice"] floatValue];
        self.CouponDiscount = [dic ConvertStringForKey:@"CouponDiscount"];
        self.CouponTitle = [dic ConvertStringForKey:@"CouponTitle"];
        self.CouponRange = [dic ConvertStringForKey:@"CouponRange"];
        self.CouponType = [[dic ConvertStringForKey:@"CouponType"] intValue];
        self.CouponNo = [dic ConvertStringForKey:@"CouponNo"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void)dealloc{
    [CouponTitle release];
    [CouponNo release];
    [CouponRange release];
    [super dealloc];
}
#endif
@end


/******************************************************
 ---------        MyCouponList CallBack
 ******************************************************
 */
@implementation resMod_CallBack_MyCouponList
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];

        NSArray * tmpResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc] initWithCapacity:tmpResponseData.count];
        for (NSDictionary * item in tmpResponseData) {
            [ResponseData addObject:[[resMod_MyCouponInfo alloc] initWithDic:item]];
        }
    }
    return self;
}
//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_MyCouponInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_MyCouponInfo")]];
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
    [ResponseData release];
    [ResponseMsg release];
    [super dealloc];
}
#endif
@end





/******************************************************
 ---------       return MyCouponInfo
 ******************************************************
 */
@implementation resMod_GetCouponDetail
@synthesize CouponStatus;
@synthesize CouponTitle;
@synthesize CouponPrice;
@synthesize CouponNo;
@synthesize CouponCondition;
@synthesize CouponStartTime;
@synthesize CouponEndTime;
@synthesize CouponDesc;
@synthesize CouponRange;
@synthesize CouponUsedOrder;
@synthesize CouponUsedTime;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.CouponStatus = [[dic ConvertStringForKey:@"CouponStatus"] intValue];
        self.CouponTitle = [dic ConvertStringForKey:@"CouponTitle"];
        self.CouponPrice = [[dic ConvertStringForKey:@"CouponPrice"] floatValue];
        self.CouponNo = [dic ConvertStringForKey:@"CouponNo"];
        self.CouponCondition = [dic ConvertStringForKey:@"CouponCondition"];
        self.CouponStartTime = [dic ConvertStringForKey:@"CouponStartTime"];
        self.CouponEndTime = [dic ConvertStringForKey:@"CouponEndTime"];
        self.CouponDesc = [dic ConvertStringForKey:@"CouponDesc"];
        self.CouponRange = [dic ConvertStringForKey:@"CouponRange"];
        self.CouponUsedOrder = [dic ConvertStringForKey:@"CouponUsedOrder"];
        self.CouponUsedTime = [dic ConvertStringForKey:@"CouponUsedTime"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void)dealloc{
    [CouponTitle release];
    [CouponNo release];
    [CouponCondition release];
    [CouponStartTime release];
    [CouponEndTime release];
    [CouponDesc release];
    [CouponRange release];
    [CouponUsedOrder release];
    [CouponUsedTime release];
    
    [super dealloc];
}
#endif
@end


/******************************************************
 ---------        MyCouponList CallBack
 ******************************************************
 */
@implementation resMod_CallBack_GetCoupon
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData= [[resMod_GetCouponDetail alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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




