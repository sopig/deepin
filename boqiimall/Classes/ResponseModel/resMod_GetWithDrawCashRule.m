//
//  resMod_GetWithDrawCashRule.m
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-22.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_GetWithDrawCashRule.h"
#import "NSDictionary+JudgeObj.h"
@implementation resMod_GetWithDrawCashRule
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
    
        self.AvailableCash = [[dic ConvertStringForKey:@"AvailableCash"]floatValue];
        self.Rule = [dic ConvertStringForKey:@"Rule"];
        self.IsWithDrawCash = [[dic ConvertStringForKey:@"IsWithDrawCash"]intValue];
        
    }
    return self;
}



#if ! __has_feature(objc_arc)
- (void) dealloc{
    [_Rule release];
    _Rule = nil;
    [super dealloc];
}
#endif
@end


@implementation resMod_CallBack_GetWithDrawCashRule
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_GetWithDrawCashRule alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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
