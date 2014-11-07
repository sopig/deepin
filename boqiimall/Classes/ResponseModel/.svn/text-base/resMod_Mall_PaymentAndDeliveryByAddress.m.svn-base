//
//  resMod_Mall_PaymentAndDeliveryByAddress.m
//  boqiimall
//
//  Created by YSW on 14-7-9.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_PaymentAndDeliveryByAddress.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

@implementation resMod_Mall_PaymentTypeByAddress
@synthesize isCheckedPayment;
@synthesize PaymentId;
@synthesize PaymentTitle;
@synthesize PaymentDescription;
@synthesize ExpressageList;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.isCheckedPayment = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.PaymentId  = [[dic ConvertStringForKey:@"PaymentId"] intValue];
        self.PaymentTitle  = [dic ConvertStringForKey:@"PaymentTitle"];
        self.PaymentDescription  = [dic ConvertStringForKey:@"PaymentDescription"];
        
        NSArray * tmpExpressageList = [dic ConvertArrayForKey:@"ExpressageList"];
        self.ExpressageList  = [[NSMutableArray alloc] initWithCapacity:tmpExpressageList.count];
        for (NSDictionary * item in tmpExpressageList) {
            [ExpressageList addObject:[[resMod_Mall_DeliveryTypeByAddress alloc] initWithDic:item]];
        }
    }
    return self;
}


//- (NSMutableArray *)ExpressageList {
//    if (ExpressageList && [ExpressageList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ExpressageList.count; i++) {
//            if([[ExpressageList objectAtIndex:i] class] != [resMod_Mall_DeliveryTypeByAddress class]){
//                NSDictionary * _dic = (NSDictionary *)[ExpressageList objectAtIndex:i];
//                [ExpressageList replaceObjectAtIndex:i
//                                        withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_DeliveryTypeByAddress")]];
//            }
//        }
//        return ExpressageList;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [PaymentTitle release];
    [PaymentDescription release];
    [ExpressageList release];
    [super dealloc];
}
#endif
@end




@implementation resMod_Mall_DeliveryTypeByAddress
@synthesize isCheckedDelivery;
@synthesize ExpressageId;
@synthesize ExpressageTitle;
@synthesize ExpressageDescription;
@synthesize ExpressageMoney;
@synthesize ExpressageMustChose;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.isCheckedDelivery = [[dic ConvertStringForKey:@"isCheckedDelivery"] intValue];
        self.ExpressageId  = [[dic ConvertStringForKey:@"ExpressageId"] intValue];
        self.ExpressageTitle  = [dic ConvertStringForKey:@"ExpressageTitle"];
        self.ExpressageDescription  = [dic ConvertStringForKey:@"ExpressageDescription"];
        self.ExpressageMoney  = [[dic ConvertStringForKey:@"ExpressageMoney"] intValue];
        self.ExpressageMustChose  = [[dic ConvertStringForKey:@"ExpressageMustChose"] intValue];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [ExpressageTitle release];
    [ExpressageDescription release];
    [super dealloc];
}
#endif
@end





@implementation resMod_CallBackMall_PaymentAndDeliveryByAddress
@synthesize ResponseStatus;
@synthesize ResponseMsg;
@synthesize ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray * tmpResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData  = [[NSMutableArray alloc] initWithCapacity:tmpResponseData.count];
        for (NSDictionary * item in tmpResponseData) {
            [ResponseData addObject: [[resMod_Mall_PaymentTypeByAddress alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData {
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_Mall_PaymentTypeByAddress class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i
//                                          withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_PaymentTypeByAddress")]];
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
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end






