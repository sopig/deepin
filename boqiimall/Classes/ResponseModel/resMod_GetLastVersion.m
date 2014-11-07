//
//  resMod_GetLastVersion.m
//  BoqiiLife
//
//  Created by YSW on 14-5-5.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_GetLastVersion.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

@implementation resMod_LastVersionInfo
@synthesize VersionStatus;
@synthesize UpdateMsg;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.VersionStatus = [[dic ConvertStringForKey:@"VersionStatus"] intValue];
        self.UpdateMsg = [dic ConvertStringForKey:@"UpdateMsg"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [UpdateMsg release];
    [super dealloc];
}
#endif
@end


@implementation resMod_CallBack_LastVersion
@synthesize ResponseStatus;
@synthesize ResponseData;
@synthesize ResponseMsg;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_LastVersionInfo alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end