//
//  resMod_LogisticsInfo.m
//  boqiimall
//
//  Created by ysw on 14-8-29.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_LogisticsInfo.h"
#import "NSDictionary+JudgeObj.h"

@implementation resMod_LogisticsContent
@synthesize Content;
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.Content = [dic ConvertStringForKey:@"Content"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [Content release];
    [super dealloc];
}
#endif
@end



@implementation resMod_CallBack_LogisticsContent
@synthesize ResponseStatus;
@synthesize ResponseMsg;
@synthesize ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_LogisticsContent alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end