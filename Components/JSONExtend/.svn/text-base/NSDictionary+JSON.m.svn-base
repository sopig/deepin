//
//  NSDictionary+JSON.m
//  JSONTest
//
//  Created by Jay on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+JSON.h"

#import "MemoryData.h"


@implementation NSDictionary (JSON)

- (id) dictionaryTo:(Class) responseType
{
    id object = [[responseType alloc]init];
    
    u_int count;
    Ivar* ivars = class_copyIvarList(responseType, &count);
    for (int i = 0; i < count ; i++)
    {
        // get variable's name and type
        const char* ivarCName = ivar_getName(ivars[i]);
        const char* ivarCType = ivar_getTypeEncoding(ivars[i]);
        
        // convert to NSString
        NSString *ivarName = [NSString stringWithCString:ivarCName encoding:NSUTF8StringEncoding];
        NSString *ivarType = [NSString stringWithCString:ivarCType encoding:NSUTF8StringEncoding];
        
        id value = [self valueForKey:[ivarName isEqualToString:@"_id"] ? @"id" : ivarName];
       
        //特殊处理下，因为返回的key是动态的
        /*if ([object isKindOfClass:[PFS_indexListingCommentGet class] ]) {
            
            if ([ivarName isEqualToString:@"special_renzhe"]) {
                
                //接收传送过来的key
                 NSString *key= [MemoryData commonParam:@"recommendId"];
                value = [self valueForKey:key];
               //  value = [self valueForKey:@"special_renzhe"];
            }
        }*/
        
        

        if([value isKindOfClass:[NSString class]] ||
           [value isKindOfClass:[NSNumber class]] ||
           value == nil){
//            NSLog(@"--json number");
        }
            // do nothing converting.
        else if([value isKindOfClass:[NSNull class]])
            value = nil;
        else if([value isKindOfClass:[NSArray class]] )
        {
            Class genericClass = [[responseType getGenericType] valueForKey:ivarName];
            value = [(NSArray *)value dictionaryArrayToArray:genericClass];
        }
            
        else if([value isKindOfClass:[NSDictionary class]] )
        {
            // convert to NSDictionary
            value = (NSDictionary *)value;
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            value = [value dictionaryTo: NSClassFromString(ivarType)];
        }
        else
            NSLog(@"[NSDictionary+JSON] unknown type: %@",NSStringFromClass([value class]));
        
        
        // set the value into object
        if (value!=nil) {
            
//            @try{
//                
//                ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//                ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
//                
//                Class retClass = NSClassFromString(ivarType);
//                if ( [ivarType isEqualToString:@"i"]
//                    || [ivarType isEqualToString:@"f"]
//                    || [retClass isKindOfClass:[NSString class]]
//                    || [retClass isKindOfClass:[NSNumber class]]
//                    || [retClass isKindOfClass:[NSNull class]]
//                    || [retClass isKindOfClass:[NSArray class]]
//                    || [retClass isKindOfClass:[NSDictionary class]] )
//                {
                    [object setValue:value forKey:ivarName];
//                }
//                else{
//                    if ([value isKindOfClass:retClass]) {
//                        [object setValue:value forKey:ivarName];
//                    }
//                    else{
//                        [object setValue:nil forKey:ivarName];
//                    }
//                }
//            }
//            @catch(NSException * e){
//            }
        }
    }
    free(ivars);
    return [object autorelease];
        
}
    
@end
