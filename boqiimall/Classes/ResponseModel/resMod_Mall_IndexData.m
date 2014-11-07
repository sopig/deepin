//
//  resMod_Mall_IndexData.m
//  boqiimall
//
//  Created by YSW on 14-6-30.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_IndexData.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

//  --  .....................
@implementation resMod_Mall_IndexBanner
@synthesize Type;
@synthesize ImageUrl;
@synthesize Url;
@synthesize Title;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.Type  = [[dic ConvertStringForKey:@"Type"] intValue];
        self.ImageUrl  = [dic ConvertStringForKey:@"ImageUrl"];
        self.Url = [dic ConvertStringForKey:@"Url"];
        self.Title = [dic ConvertStringForKey:@"Title"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void)dealloc{
    [ImageUrl release];
    [Url release];
    [Title release];
    [super dealloc];
}
#endif
@end


//  --  .....................
@implementation resMod_Mall_IndexMain
@synthesize TabId;
@synthesize TabName;
@synthesize TypeList;
@synthesize TemplateList;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TabId  = [dic ConvertStringForKey:@"TabId"];
        self.TabName  = [dic ConvertStringForKey:@"TabName"];

        NSArray * tmpTypeList = [dic ConvertArrayForKey:@"TypeList"];
        self.TypeList = [[NSMutableArray alloc] initWithCapacity:tmpTypeList.count];
        for (NSDictionary *item in tmpTypeList) {
            [TypeList addObject:[[resMod_Mall_IndexTypeData alloc]initWithDic:item]];
        }
        
        NSArray * tmpTemplateList = [dic ConvertArrayForKey:@"TemplateList"];
        self.TemplateList = [[NSMutableArray alloc] initWithCapacity:tmpTemplateList.count];
        for (NSDictionary *item in tmpTemplateList) {
            [TemplateList addObject:[[resMod_Mall_IndexTemplate alloc]initWithDic:item]];
        }
    }
    return self;
}


//- (NSMutableArray *)TypeList {
//    if (TypeList && [TypeList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < TypeList.count; i++) {
//            if([[TypeList objectAtIndex:i] class] != [resMod_Mall_IndexTypeData class]){
//                NSDictionary * _dic = (NSDictionary *)[TypeList objectAtIndex:i];
//                [TypeList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_IndexTypeData")]];
//            }
//        }
//        return TypeList;
//    }
//    else{
//        return nil;
//    }
//}
//
//- (NSMutableArray *)TemplateList
//{
//    if (TemplateList && [TemplateList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < TemplateList.count; i++) {
//            if([[TemplateList objectAtIndex:i] class] != [resMod_Mall_IndexTemplate class]){
//                NSDictionary * _dic = (NSDictionary *)[TemplateList objectAtIndex:i];
//                [TemplateList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_IndexTemplate")]];
//            }
//        }
//        return TemplateList;
//    }
//    else{
//        return nil;
//    }
//}


#if ! __has_feature(objc_arc)
- (void)dealloc{
    [TabName release];
    [TypeList release];
    [TemplateList release];
    [super dealloc];
}
#endif
@end



//  --  .....................
@implementation resMod_Mall_IndexTypeData
@synthesize TypeId;
@synthesize TypeName;
@synthesize TypeImg;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TypeId  = [[dic ConvertStringForKey:@"TypeId"] intValue];
        self.TypeName  = [dic ConvertStringForKey:@"TypeName"];
        self.TypeImg  = [dic ConvertStringForKey:@"TypeImg"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void)dealloc{
    [TypeName release];
    [TypeImg release];
    [super dealloc];
}
#endif
@end




//  --  .....................
@implementation resMod_Mall_IndexTemplate
@synthesize TemplateType;
@synthesize Template;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TemplateType  = [[dic ConvertStringForKey:@"TemplateType"] intValue];
        
        NSArray * tmpTemplate = [dic ConvertArrayForKey:@"Template"];
        self.Template  = [[NSMutableArray alloc] initWithCapacity:tmpTemplate.count];
        for (NSDictionary * item in tmpTemplate) {
            [Template addObject:[[resMod_Mall_IndexBanner alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)Template {
//    if (Template && [Template isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < Template.count; i++) {
//            if([[Template objectAtIndex:i] class] != [resMod_Mall_IndexBanner class]){
//                NSDictionary * _dic = (NSDictionary *)[Template objectAtIndex:i];
//                [Template replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_IndexBanner")]];
//            }
//        }
//        return Template;
//    }
//    else{
//        return nil;
//    }
//}


#if ! __has_feature(objc_arc)
- (void) dealloc{
    [Template release];
    [super dealloc];
}
#endif
@end



//  --  .....................
@implementation resMod_Mall_IndexResponseData
@synthesize BannerList;
@synthesize MainData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        NSArray * tmpBannerList = [dic ConvertArrayForKey:@"BannerList"];
        self.BannerList  = [[NSMutableArray alloc] initWithCapacity:tmpBannerList.count];
        for (NSDictionary * item in tmpBannerList) {
            [BannerList addObject:[[resMod_Mall_IndexBanner alloc] initWithDic:item]];
        }
        
        NSArray * tmpMainData = [dic ConvertArrayForKey:@"MainData"];
        self.MainData  = [[NSMutableArray alloc] initWithCapacity:tmpMainData.count];
        for (NSDictionary * item in tmpMainData) {
            [MainData addObject:[[resMod_Mall_IndexMain alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)BannerList {
//    if (BannerList && [BannerList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < BannerList.count; i++) {
//            if([[BannerList objectAtIndex:i] class] != [resMod_Mall_IndexBanner class]){
//                NSDictionary * _dic = (NSDictionary *)[BannerList objectAtIndex:i];
//                [BannerList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_IndexBanner")]];
//            }
//        }
//        return BannerList;
//    }
//    else{
//        return nil;
//    }
//}
//
//- (NSMutableArray *)MainData {
//    if (MainData && [MainData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < MainData.count; i++) {
//            if([[MainData objectAtIndex:i] class] != [resMod_Mall_IndexMain class]){
//                NSDictionary * _dic = (NSDictionary *)[MainData objectAtIndex:i];
//                [MainData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_IndexMain")]];
//            }
//        }
//        return MainData;
//    }
//    else{
//        return nil;
//    }
//}


#if ! __has_feature(objc_arc)
- (void) dealloc{
    [BannerList release];
    [MainData release];
    [super dealloc];
}
#endif
@end




/******************************************************
 ---------        return: call back
 ******************************************************
 */

@implementation resMod_CallBackMall_IndexData
@synthesize ResponseStatus;
@synthesize ResponseMsg;
@synthesize ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData= [[resMod_Mall_IndexResponseData alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}


#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end





