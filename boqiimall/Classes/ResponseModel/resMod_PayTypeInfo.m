//
//  resMod_PayTypeInfo.m
//  boqiimall
//
//  Created by YSW on 14-7-1.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_PayTypeInfo.h"
#import "NSDictionary+JudgeObj.h"

@implementation resMod_PayTypeInfo
@synthesize payIcon;
@synthesize payIsChecked;
@synthesize payTitle;
@synthesize payTypeId;
@synthesize payWarning;

//-(instancetype)initWithDic:(NSDictionary*)dic{
//    if (self=[super init]) {
//        self.payTypeId  = [[dic ConvertStringForKey:@"payTypeId"] intValue];
//        self.payIsChecked  = [[dic ConvertStringForKey:@"payIsChecked"] intValue] == 1 ? YES:NO;
// 
//        self.payIcon = [dic ConvertStringForKey:@"payIcon"];
//        self.payTitle  = [dic ConvertStringForKey:@"payTitle"];
//        self.payWarning  = [dic ConvertStringForKey:@"payWarning"];
//    }
//    return self;
//}

@end