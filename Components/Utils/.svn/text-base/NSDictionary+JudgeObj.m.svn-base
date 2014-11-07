//
//  NSDictionary+JudgeObj.m
//  boqiimall
//
//  Created by ysw on 14-8-21.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "NSDictionary+JudgeObj.h"

@implementation NSDictionary (JudgeObj)

-(NSString*)ConvertStringForKey:(NSString*)key {
    if ([[self objectForKey:key] isKindOfClass:[NSNull class]]) {
        return @"";
    }
    else if ([self objectForKey:key] == nil){
        return @"";
    }
    else if ([[self objectForKey:key] isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    else {
        return [NSString stringWithFormat:@"%@",[self objectForKey:key]];
    }
    
    return @"";
}


-(NSArray*)ConvertArrayForKey:(NSString*)key {
    if ([[self objectForKey:key] isKindOfClass:[NSArray class]])
    {
        return [self objectForKey:key];
    }
    else {
        return [NSArray array];
    }
}

-(NSDictionary*)ConvertDictForKey:(NSString*)key {
    if ([[self objectForKey:key] isKindOfClass:[NSDictionary class]]) {
        return [self objectForKey:key];
    }
    else {
        return [NSDictionary dictionary];
    }
}


@end
