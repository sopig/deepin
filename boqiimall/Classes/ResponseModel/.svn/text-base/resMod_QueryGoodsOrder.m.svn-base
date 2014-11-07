//
//  resMod_QueryGoodsOrder.m
//  boqiimall
//
//  Created by 张正超 on 14-8-29.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_QueryGoodsOrder.h"
#import "NSDictionary+JudgeObj.h"
@implementation resMod_QueryGoodsOrder

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        self.ResultCode = [[dic ConvertStringForKey:@"ResultCode"]intValue];
        
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    
    [super dealloc];
}
#endif

@end


@implementation resMod_CallBack_QueryGoodsOrder
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_QueryGoodsOrder alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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
