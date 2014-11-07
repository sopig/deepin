//
//  resMod_GetOpenCitys.m
//  boqiimall
//
//  Created by YSW on 14-7-23.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_GetOpenCitys.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

@implementation resMod_GetOpenCitys
@synthesize CityId;
@synthesize CityName;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.CityId = [dic ConvertStringForKey:@"CityId"];
        self.CityName = [dic ConvertStringForKey:@"CityName"];
    }
    return self;
}
#if ! __has_feature(objc_arc)
- (void) dealloc{
    [CityId release];
    [CityName release];
    [super dealloc];
}
#endif
@end



/******************************************************
 ---------       call back : 生活馆 开 通 城 市
 ******************************************************
 */
@implementation resMod_CallBack_GetOpenCitys
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray * tmpResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc] initWithCapacity:tmpResponseData.count];
        for (NSDictionary * item in tmpResponseData) {
            [ResponseData addObject:[[resMod_GetOpenCitys alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_GetOpenCitys class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_GetOpenCitys")]];
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