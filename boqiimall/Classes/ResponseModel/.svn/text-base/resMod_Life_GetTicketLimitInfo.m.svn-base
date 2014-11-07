//
//  resMod_Life_GetTicketLimitInfo.m
//  boqiimall
//
//  Created by 波奇-xiaobo on 14-9-1.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Life_GetTicketLimitInfo.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"


@implementation resMod_Life_GetTicketLimitInfo
@synthesize currentNum;
@synthesize totalPrice;
@synthesize price;
@synthesize Information;

#define kRemainLimitNumber @"CurrentNum"
#define kLimitPrice @"TotalPrice"
#define kOriPrice @"Price"

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        self.currentNum = [dic ConvertStringForKey:kRemainLimitNumber];
        self.totalPrice = [dic ConvertStringForKey:kLimitPrice];
        self.price = [dic ConvertStringForKey:kOriPrice];
        self.Information = [dic ConvertStringForKey:@"Information"];
    }
    return self;
}
#if ! __has_feature(objc_arc)
- (void) dealloc{
    [currentNum release];
    [totalPrice release];
    [price release];
    [Information release];
    [super dealloc];
}
#endif
@end



@implementation resMod_CallBackMall_Life_GetTicketLimitInfo
@synthesize ResponseStatus;
@synthesize ResponseMsg;
@synthesize ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_Life_GetTicketLimitInfo alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];    }
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
