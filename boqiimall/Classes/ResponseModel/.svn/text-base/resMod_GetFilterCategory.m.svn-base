//
//  resMod_GetFilterCategory.m
//  BoqiiLife
//
//  Created by YSW on 14-5-9.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_GetFilterCategory.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

//--......................................................................
@implementation resMod_CategoryInfo
@synthesize SubTypeId;
@synthesize SubTypeName;
@synthesize Type;
@synthesize isChecked;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.SubTypeId = [[dic ConvertStringForKey:@"SubTypeId"] intValue];
        self.SubTypeName = [dic ConvertStringForKey:@"SubTypeName"];
        self.Type = [dic ConvertStringForKey:@"Type"];
        self.isChecked = NO;
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [SubTypeName    release];
    [Type release];
    [super dealloc];
}
#endif
@end


//--......................................................................
@implementation resMod_CategoryList
@synthesize CategoryId;
@synthesize TypeList;
@synthesize TypeId;
@synthesize TypeName;
@synthesize isSelect_parent;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.CategoryId = [dic ConvertStringForKey:@"CategoryId"];
        
        NSArray * tmpTypeList = [dic ConvertArrayForKey:@"TypeList"];
        self.TypeList = [[NSMutableArray alloc] initWithCapacity:tmpTypeList.count];
        for (NSDictionary * item in tmpTypeList) {
            [TypeList addObject:[[resMod_CategoryInfo alloc] initWithDic:item]];
        }
        
        self.TypeId = [[dic ConvertStringForKey:@"TypeId"] intValue];
        self.TypeName = [dic ConvertStringForKey:@"TypeName"];
        self.isSelect_parent = NO;
    }
    return self;
}

//- (NSMutableArray *)TypeList{
//    
//    if (TypeList && [TypeList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < TypeList.count; i++) {
//            if([[TypeList objectAtIndex:i] class] != [resMod_CategoryInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[TypeList objectAtIndex:i];
//                [TypeList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_CategoryInfo")]];
//            }
//        }
//        return TypeList;
//    }
//    else{
//        return nil;
//    }
//}


#if ! __has_feature(objc_arc)
-(void) dealloc{
    [CategoryId release];
    [TypeList    release];
    [TypeName    release];
    [super dealloc];
}
#endif
@end


@implementation resMod_filterWhere
@synthesize parentTableId;
@synthesize parentTableValue;
@synthesize subTableId;
@synthesize subTableVlaue;
@synthesize subTableProperty1;
@synthesize subTableProperty2;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.parentTableId = [dic ConvertStringForKey:@"parentTableId"];
        self.parentTableValue = [dic ConvertStringForKey:@"parentTableValue"];
        self.subTableId = [dic ConvertStringForKey:@"subTableId"];
        self.subTableVlaue = [dic ConvertStringForKey:@"subTableVlaue"];
        self.subTableProperty1 = [dic ConvertStringForKey:@"subTableProperty1"];
        self.subTableProperty2 = [dic ConvertStringForKey:@"subTableProperty2"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [parentTableId   release];
    [parentTableValue    release];
    [subTableId    release];
    [subTableVlaue    release];
    [subTableProperty1    release];
    [subTableProperty2    release];
    [super dealloc];
}
#endif
@end


//--......................................................................
//@implementation resMod_AreaTypeInfo
//@synthesize SubAreaId;
//@synthesize SubAreaName;
//
//-(void) dealloc{
//    [SubAreaName    release];
//    [super dealloc];
//}
//@end



//--......................................................................
//@implementation resMod_AreaTypeList
//@synthesize AreaList;
//@synthesize AreaName;
//
//- (NSMutableArray *)AreaList{
//    for (int i = 0; i < AreaList.count; i++) {
//        if([[AreaList objectAtIndex:i] class] != [resMod_AreaTypeInfo class]){
//            NSDictionary * _dic = (NSDictionary *)[AreaList objectAtIndex:i];
//            [AreaList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_AreaTypeInfo")]];
//        }
//    }
//    return AreaList;
//}
//
//-(void) dealloc{
//    [AreaName    release];
//    [AreaList    release];
//    [super dealloc];
//}
//@end


//--......................................................................
//@implementation resMod_MerchantSortTypeInfo
//@synthesize TypeId;
//@synthesize TypeName;
//
//-(void) dealloc{
//    [TypeName release];
//    [super dealloc];
//}
//@end


//--......................................................................
@implementation resMod_CallBack_FilterCategory
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray * tmpResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc] initWithCapacity:tmpResponseData.count];
        for (NSDictionary * item in tmpResponseData) {
            [ResponseData addObject:[[resMod_CategoryList alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_CategoryList class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_CategoryList")]];
//            }
//        }
//        return ResponseData;
//    }
//    else{
//        return nil;
//    }
//}
//
#if ! __has_feature(objc_arc)
-(void) dealloc{
    [ResponseData   release];
    [ResponseMsg    release];
    [super dealloc];
}
#endif
@end



//--......................................................................
//@implementation resMod_CallBack_AreaType
//@synthesize ResponseData;
//@synthesize ResponseMsg;
//@synthesize ResponseStatus;
//
//- (NSMutableArray *)ResponseData{
//    for (int i = 0; i < ResponseData.count; i++) {
//        if([[ResponseData objectAtIndex:i] class] != [resMod_AreaTypeList class]){
//            NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//            [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_AreaTypeList")]];
//        }
//    }
//    return ResponseData;
//}
//
//-(void) dealloc{
//    [ResponseData   release];
//    [ResponseMsg    release];
//    [super dealloc];
//}
//@end


//--......................................................................

//@implementation resMod_CallBack_MerchantSort
//@synthesize ResponseData;
//@synthesize ResponseMsg;
//@synthesize ResponseStatus;
//- (NSMutableArray *)ResponseData{
//    for (int i = 0; i < ResponseData.count; i++) {
//        if([[ResponseData objectAtIndex:i] class] != [resMod_MerchantSortTypeInfo class]){
//            NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//            [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_MerchantSortTypeInfo")]];
//        }
//    }
//    return ResponseData;
//}
//
//-(void) dealloc{
//    [ResponseData   release];
//    [ResponseMsg    release];
//    [super dealloc];
//}
//@end






