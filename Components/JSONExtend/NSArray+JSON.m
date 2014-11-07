//
//  NSArray+JSON.m
//  JSONTest
//
//  Created by Jay on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+JSON.h"


@implementation NSArray(JSON)

/*
 convert array of object to array of dictionary
 */
- (NSMutableArray *) arrayToDictonaryArray
{
    NSInteger count = [self count];
    NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
    for(int i = 0; i < count; ++i)
    {
        id obj = [self objectAtIndex:i];
        // if obj is NSString,NSNumber, do nothing convert
        if([obj isKindOfClass:[NSString class]] ||
           [obj isKindOfClass:[NSNumber class]])
            [mutableArray addObject:obj];
        
        // if other obj, convert to dictionary
        else
            [mutableArray addObject:[obj objectToDictionary]];
    }
    
#if ! __has_feature(objc_arc)
    return [mutableArray autorelease];
#else
    return mutableArray;
#endif
}

/*
 Convert array of dictionary to array of object(include customize object)
 */
- (NSMutableArray *) dictionaryArrayToArray:(Class)genericType
{
    NSInteger count = [self count];
    NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
    for(int i = 0; i < count; ++i)
    {
        id obj = [self objectAtIndex:i];
        if([obj isKindOfClass:[NSString class]] ||
           [obj isKindOfClass:[NSNumber class]]);
        // do nothing converting.
        else 
        {
            if(genericType != nil)
                obj = [(NSDictionary *)obj dictionaryTo:genericType];
        }
        
        [mutableArray addObject:obj];
        
    }
#if ! __has_feature(objc_arc)
    return [mutableArray autorelease];
#else
    return mutableArray;
#endif
}

@end
