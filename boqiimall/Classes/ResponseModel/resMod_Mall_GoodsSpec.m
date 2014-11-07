//
//  resMod_Mall_GoodsSpec.m
//  boqiimall
//
//  Created by YSW on 14-7-4.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_GoodsSpec.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"


//  --  属性信息
@implementation resMod_Mall_GoodsSpecPropertyInfo
@synthesize Id;
@synthesize Name;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.Id = [[dic ConvertStringForKey:@"Id"] intValue];
        self.Name = [dic ConvertStringForKey:@"Name"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [Name release];
    [super dealloc];
}
#endif
@end

//  --  属性类别
@implementation resMod_Mall_GoodsSpecProperties
@synthesize PropertyID;
@synthesize PropertyName;
@synthesize Properties;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.PropertyID = [[dic ConvertStringForKey:@"PropertyID"] intValue];
        self.PropertyName = [dic ConvertStringForKey:@"PropertyName"];
        
        NSArray * tmpProperties = [dic ConvertArrayForKey:@"Properties"];
        self.Properties = [[NSMutableArray alloc] initWithCapacity:tmpProperties.count];
        for (NSDictionary * item in tmpProperties) {
            [Properties addObject:[[resMod_Mall_GoodsSpecPropertyInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)Properties {
//    if (Properties && [Properties isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < Properties.count; i++) {
//            if([[Properties objectAtIndex:i] class] != [resMod_Mall_GoodsSpecPropertyInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[Properties objectAtIndex:i];
//                [Properties replaceObjectAtIndex:i
//                                        withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_GoodsSpecPropertyInfo")]];
//            }
//        }
//        return Properties;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [PropertyName release];
    [Properties release];
    [super dealloc];
}
#endif
@end


//  --  .................
@implementation resMod_Mall_GoodsSpecGroups
@synthesize SpecId;
@synthesize SpecPrice;
@synthesize SpecOriPrice;
@synthesize SpecLimit;
@synthesize SpecSotck;
@synthesize SpecProperties;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.SpecId = [dic ConvertStringForKey:@"SpecId"];
        self.SpecPrice = [[dic ConvertStringForKey:@"SpecPrice"] floatValue];
        self.SpecOriPrice = [[dic ConvertStringForKey:@"SpecOriPrice"] floatValue];
        self.SpecLimit = [[dic ConvertStringForKey:@"SpecLimit"] intValue];
        self.SpecSotck = [[dic ConvertStringForKey:@"SpecSotck"] intValue];
        self.SpecProperties = [dic ConvertStringForKey:@"SpecProperties"];
    }
    return self;
}


#if ! __has_feature(objc_arc)
-(void) dealloc{
    [SpecId release];
    [SpecProperties release];
    [super dealloc];
}
#endif
@end


//  --..................
@implementation resMod_Mall_GoodsSpecList
@synthesize GoodsProperties;
@synthesize GoodsSpecs;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        NSArray * tmpGoodsProperties = [dic ConvertArrayForKey:@"GoodsProperties"];
        self.GoodsProperties = [[NSMutableArray alloc] initWithCapacity:tmpGoodsProperties.count];
        for (NSDictionary * item in tmpGoodsProperties) {
            [GoodsProperties addObject:[[resMod_Mall_GoodsSpecProperties alloc] initWithDic:item]];
        }
        
        NSArray * tmpGoodsSpecs = [dic ConvertArrayForKey:@"GoodsSpecs"];
        self.GoodsSpecs = [[NSMutableArray alloc] initWithCapacity:tmpGoodsSpecs.count];
        for (NSDictionary * item in tmpGoodsSpecs) {
            [GoodsSpecs addObject:[[resMod_Mall_GoodsSpecGroups alloc] initWithDic:item]];
        }
    }
    return self;
}
//- (NSMutableArray *)GoodsProperties {
//    if (GoodsProperties && [GoodsProperties isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < GoodsProperties.count; i++) {
//            if([[GoodsProperties objectAtIndex:i] class] != [resMod_Mall_GoodsSpecProperties class]){
//                NSDictionary * _dic = (NSDictionary *)[GoodsProperties objectAtIndex:i];
//                [GoodsProperties replaceObjectAtIndex:i
//                                           withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_GoodsSpecProperties")]];
//            }
//        }
//        return GoodsProperties;
//    }
//    else{
//        return nil;
//    }
//}

//- (NSMutableArray *)GoodsSpecs {
//    if (GoodsSpecs) {
//        for (int i = 0; i < GoodsSpecs.count; i++) {
//            if([[GoodsSpecs objectAtIndex:i] class] != [resMod_Mall_GoodsSpecGroups class]){
//                NSDictionary * _dic = (NSDictionary *)[GoodsSpecs objectAtIndex:i];
//                [GoodsSpecs replaceObjectAtIndex:i
//                                      withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_GoodsSpecGroups")]];
//            }
//        }
//        return GoodsSpecs;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [GoodsProperties release];
    [GoodsSpecs release];
    [super dealloc];
}
#endif
@end


//  --..................
@implementation resMod_CallBackMall_GoodsSpec
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_Mall_GoodsSpecList alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}
//
//- (NSMutableArray *)ResponseData {
//    for (int i = 0; i < ResponseData.count; i++) {
//        if([[ResponseData objectAtIndex:i] class] != [resMod_Mall_GoodsSpecList class]){
//            NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//            [ResponseData replaceObjectAtIndex:i
//                                    withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_GoodsSpecList")]];
//        }
//    }
//    return ResponseData;
//}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end
