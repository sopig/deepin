//
//  NSObject+JSON.h
//  JSONTest
//
//  Created by Jay on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+JSON.h"
#import <objc/runtime.h>

@interface NSObject (JSON)
//@property (nonatomic, retain) NSDictionary* genericType;
- (NSMutableDictionary *) objectToDictionary;
+ (void) setGenericType:(NSDictionary *) type;
+ (NSDictionary *) getGenericType;
@end
