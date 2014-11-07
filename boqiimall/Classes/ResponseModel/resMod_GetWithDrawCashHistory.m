//
//  resMod_GetWithDrawCashHistory.m
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-22.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_GetWithDrawCashHistory.h"
#import "NSDictionary+JudgeObj.h"
@implementation resMod_GetWithDrawCashHistory
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        self.AccountType = [dic ConvertStringForKey:@"AccountType"];
        self.Cash = [dic ConvertStringForKey:@"Cash"];
        self.Time = [dic ConvertStringForKey:@"Time"];
        self.Status = [dic ConvertStringForKey:@"Status"];
        self.Remarks = [dic ConvertStringForKey:@"Remarks"];
        
    }
    return self;
}



#if ! __has_feature(objc_arc)
- (void) dealloc{
    self.AccountType = nil;
    self.Cash = nil;
    self.Time = nil;
    self.Status = nil;
    self.Remarks = nil;
    [super dealloc];
}
#endif
@end


@implementation resMod_CallBack_GetWithDrawCashHistory
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        NSArray *tmpResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc] initWithCapacity:tmpResponseData.count];
        
        for (NSDictionary *item in tmpResponseData) {
            [ResponseData addObject:[[resMod_GetWithDrawCashHistory alloc]initWithDic:item]];
        }
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


