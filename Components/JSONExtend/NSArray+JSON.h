//
//  NSArray+JSON.h
//  JSONTest
//
//  Created by Jay on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+JSON.h"
#import "NSDictionary+JSON.h"
#import <objc/runtime.h>

@interface NSArray(JSON)

- (NSMutableArray *) arrayToDictonaryArray;
- (NSMutableArray *) dictionaryArrayToArray:(Class) genericType;

@end
