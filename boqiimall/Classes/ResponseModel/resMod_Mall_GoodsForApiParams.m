//
//  resMod_Mall_GoodsForApiParams.m
//  boqiimall
//
//  Created by YSW on 14-7-17.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_GoodsForApiParams.h"
#import "NSDictionary+JudgeObj.h"

@implementation resMod_Mall_GoodsForApiParams
@synthesize GoodsId;
@synthesize GoodsNum;
@synthesize limitNum;
@synthesize GoodsType;
@synthesize GoodsSpecId;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.GoodsId = [[dic ConvertStringForKey:@"GoodsId"] intValue];
        self.GoodsNum  = [[dic ConvertStringForKey:@"GoodsNum"] intValue];
        self.limitNum = [[dic ConvertStringForKey:@"limitNum"] intValue];
        self.GoodsType  = [[dic ConvertStringForKey:@"GoodsType"] intValue];
        self.GoodsSpecId  = [dic ConvertStringForKey:@"GoodsSpecId"];
    }
    return self;
}


#if ! __has_feature(objc_arc)
- (void) dealloc{
    [GoodsSpecId release];
    [super dealloc];
}
#endif
@end
