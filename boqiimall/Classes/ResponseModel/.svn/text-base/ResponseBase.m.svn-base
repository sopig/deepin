//
//  ResponseBase.m
//  ule_specSale
//
//  Created by ysw.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "ResponseBase.h"
#import "NSDictionary+JudgeObj.h"

@implementation ResponseBase
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;
@synthesize code;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] floatValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [dic ConvertStringForKey:@"ResponseData"];
        
        self.code = [dic ConvertStringForKey:@"code"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void)dealloc{
    [ResponseData release];
    [ResponseMsg release];
    [code release];
    [super dealloc];
}
#endif
@end
