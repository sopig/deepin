//
//  resMod_Mall_Classification.m
//  boqiimall
//
//  Created by YSW on 14-6-30.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_Classification.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

@implementation resMod_Mall_Class1th
@synthesize TypeId;
@synthesize TypeName;
@synthesize TypeList;
@synthesize TypeImg;
@synthesize HotKeyword;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TypeId = [[dic ConvertStringForKey:@"TypeId"] intValue];
        self.TypeName = [dic ConvertStringForKey:@"TypeName"];
        self.TypeImg = [dic ConvertStringForKey:@"TypeImg"];
        self.HotKeyword = [dic ConvertStringForKey:@"HotKeyword"];
        
        NSArray * tmpTypeList = [dic ConvertArrayForKey:@"TypeList"];
        self.TypeList= [[NSMutableArray alloc] initWithCapacity:tmpTypeList.count];
        for (NSDictionary * item in tmpTypeList) {
            [TypeList addObject:[[resMod_Mall_Class2th alloc] initWithDic:item]];
        }
    }
    return self;
}
//- (NSMutableArray *)TypeList {
//    if (TypeList && [TypeList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < TypeList.count; i++) {
//            if([[TypeList objectAtIndex:i] class] != [resMod_Mall_Class2th class]){
//                NSDictionary * _dic = (NSDictionary *)[TypeList objectAtIndex:i];
//                [TypeList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_Class2th")]];
//            }
//        }
//        return TypeList;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [TypeName release];
    [TypeList release];
    [TypeImg release];
    [HotKeyword release];
    [super dealloc];
}
#endif
@end



@implementation resMod_Mall_Class2th
@synthesize SubTypeId;
@synthesize SubTypeName;
@synthesize SubTypeList;
@synthesize SubTypeImg;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.SubTypeId = [[dic ConvertStringForKey:@"SubTypeId"] intValue];
        self.SubTypeName = [dic ConvertStringForKey:@"SubTypeName"];
        self.SubTypeImg = [dic ConvertStringForKey:@"SubTypeImg"];
        
        NSArray * tmpSubTypeList = [dic ConvertArrayForKey:@"SubTypeList"];
        self.SubTypeList= [[NSMutableArray alloc] initWithCapacity:tmpSubTypeList.count];
        for (NSDictionary * item in tmpSubTypeList) {
            [SubTypeList addObject:[[resMod_Mall_Class3th alloc] initWithDic:item]];
        }
    }
    return self;
}


//- (NSMutableArray *)SubTypeList {
//    if (SubTypeList && [SubTypeList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < SubTypeList.count; i++) {
//            if([[SubTypeList objectAtIndex:i] class] != [resMod_Mall_Class3th class]){
//                NSDictionary * _dic = (NSDictionary *)[SubTypeList objectAtIndex:i];
//                [SubTypeList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_Class3th")]];
//            }
//        }
//        return SubTypeList;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [SubTypeImg release];
    [SubTypeList release];
    [SubTypeName release];
    [super dealloc];
}
#endif
@end



@implementation resMod_Mall_Class3th
@synthesize ThirdTypeId;
@synthesize ThirdTypeName;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ThirdTypeId = [[dic ConvertStringForKey:@"ThirdTypeId"] intValue];
        self.ThirdTypeName = [dic ConvertStringForKey:@"ThirdTypeName"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ThirdTypeName release];
    [super dealloc];
}
#endif
@end



/******************************************************
 ---------        return: call back
 ******************************************************
 */
@implementation resMod_CallBackMall_Classification
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray * tmpResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData= [[NSMutableArray alloc] initWithCapacity:tmpResponseData.count];
        for (NSDictionary * item in tmpResponseData) {
            [ResponseData addObject:[[resMod_Mall_Class1th alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData {
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_Mall_Class1th class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i
//                                        withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_Class1th")]];
//            }
//        }
//        return ResponseData;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end


