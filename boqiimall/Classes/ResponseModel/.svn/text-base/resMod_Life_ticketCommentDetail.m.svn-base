//
//  resMod_Life_ticketCommentDetail.m
//  boqiimall
//
//  Created by 张正超 on 14-7-17.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Life_ticketCommentDetail.h"
#import "NSDictionary+JudgeObj.h"

@implementation resMod_Life_ticketCommentDetail
@synthesize ProfessionalScore;
@synthesize EnvironmentScore;
@synthesize AttitudeScore;
@synthesize PriceScore;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ProfessionalScore = [[dic ConvertStringForKey:@"ProfessionalScore"] floatValue];
        self.EnvironmentScore  = [[dic ConvertStringForKey:@"EnvironmentScore"] floatValue];
        self.AttitudeScore  = [[dic ConvertStringForKey:@"AttitudeScore"] floatValue];
        self.PriceScore  = [[dic ConvertStringForKey:@"PriceScore"] floatValue];
    }
    return self;
}


#if ! __has_feature(objc_arc)
-(void)dealloc {
    [super dealloc];
}
#endif
@end



@implementation resMod_CallBack_ticketCommentDetail
@synthesize ResponseStatus;
@synthesize ResponseMsg;
@synthesize ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] floatValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_Life_ticketCommentDetail alloc]initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}


#if ! __has_feature(objc_arc)
- (void)dealloc {
    self.ResponseData = nil;
    self.ResponseMsg = nil;
    [super dealloc];
}
#endif

@end