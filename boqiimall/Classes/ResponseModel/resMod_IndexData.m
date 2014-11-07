//
//  resMod_IndexData.m
//  BoqiiLife
//
//  Created by YSW on 14-5-5.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_IndexData.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

//  --  BannerInfo
@implementation resMod_IndexBannerInfo
@synthesize BannerType;
@synthesize ImageUrl;
@synthesize Url;
@synthesize Title;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.BannerType = [[dic ConvertStringForKey:@"BannerType"] intValue];
        self.ImageUrl  = [dic ConvertStringForKey:@"ImageUrl"];
        self.Url = [dic ConvertStringForKey:@"Url"];
        self.Title = [dic ConvertStringForKey:@"Title"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [ImageUrl release];
    [Title release];
    [Url release];
    [super dealloc];
}
#endif
@end


//  --  HotInfo
@implementation resMod_IndexHotInfo
@synthesize TicketId;
@synthesize TicketImg;
@synthesize TicketOriPrice;
@synthesize TicketPrice;
@synthesize TicketTitle;
@synthesize TicketBuyed;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TicketId = [[dic ConvertStringForKey:@"TicketId"] intValue];
        self.TicketImg  = [dic ConvertStringForKey:@"TicketImg"];
        self.TicketOriPrice = [[dic ConvertStringForKey:@"TicketOriPrice"] floatValue];
        self.TicketPrice = [[dic ConvertStringForKey:@"TicketPrice"] floatValue];
        self.TicketTitle = [dic ConvertStringForKey:@"TicketTitle"];
        self.TicketBuyed = [[dic ConvertStringForKey:@"TicketBuyed"] intValue];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [TicketImg release];
    [TicketTitle release];
    [super dealloc];
}
#endif
@end

//  -- ServiceInfo
@implementation resMod_IndexServiceInfo
@synthesize TypeId;
@synthesize TypeImg;
@synthesize TypeName;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TypeId = [[dic ConvertStringForKey:@"TypeId"] intValue];
        self.TypeImg  = [dic ConvertStringForKey:@"TypeImg"];
        self.TypeName = [dic ConvertStringForKey:@"TypeName"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [TypeImg release];
    [TypeName release];
    [super dealloc];
}
#endif
@end

//  -- Service list
@implementation resMod_IndexServiceList
@synthesize ServiceId;
@synthesize ServiceName;
@synthesize ServiceTypeList;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ServiceId = [[dic ConvertStringForKey:@"ServiceId"] intValue];
        self.ServiceName  = [dic ConvertStringForKey:@"ServiceName"];
        
        NSArray * tmpServiceTypeList = [dic ConvertArrayForKey:@"ServiceTypeList"];
        self.ServiceTypeList = [[NSMutableArray alloc] initWithCapacity:tmpServiceTypeList.count];
        for (NSDictionary * item in tmpServiceTypeList) {
            [ServiceTypeList addObject:[[resMod_IndexServiceInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ServiceTypeList
//{
//    if (ServiceTypeList && [ServiceTypeList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ServiceTypeList.count; i++) {
//            if([[ServiceTypeList objectAtIndex:i] class] != [resMod_IndexServiceInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ServiceTypeList objectAtIndex:i];
//                [ServiceTypeList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_IndexServiceInfo")]];
//            }
//        }
//        return ServiceTypeList;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [ServiceName release];
    [ServiceTypeList release];
    [super dealloc];
}
#endif
@end


//  --  ResponseData
@implementation resMod_IndexResponseData
@synthesize BannerList;
@synthesize HotList;
@synthesize LowPriceList;
@synthesize ServiceList;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        NSArray * tmpBannerList = [dic ConvertArrayForKey:@"BannerList"];
        self.BannerList = [[NSMutableArray alloc] initWithCapacity:tmpBannerList.count];
        for (NSDictionary * item in tmpBannerList) {
            [BannerList addObject:[[resMod_IndexBannerInfo alloc] initWithDic:item]];
        }
        
        NSArray * tmpHotList = [dic ConvertArrayForKey:@"HotList"];
        self.HotList = [[NSMutableArray alloc] initWithCapacity:tmpHotList.count];
        for (NSDictionary * item in tmpHotList) {
            [HotList addObject:[[resMod_IndexHotInfo alloc] initWithDic:item]];
        }
        
        NSArray * tmpLowPriceList = [dic ConvertArrayForKey:@"LowPriceList"];
        self.LowPriceList = [[NSMutableArray alloc] initWithCapacity:tmpLowPriceList.count];
        for (NSDictionary * item in tmpLowPriceList) {
            [LowPriceList addObject:[[resMod_IndexHotInfo alloc] initWithDic:item]];
        }
        
        NSArray * tmpServiceList = [dic ConvertArrayForKey:@"ServiceList"];
        self.ServiceList = [[NSMutableArray alloc] initWithCapacity:tmpServiceList.count];
        for (NSDictionary * item in tmpServiceList) {
            [ServiceList addObject:[[resMod_IndexServiceList alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)BannerList
//{
//    if (BannerList && [BannerList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < BannerList.count; i++) {
//            if([[BannerList objectAtIndex:i] class] != [resMod_IndexBannerInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[BannerList objectAtIndex:i];
//                [BannerList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_IndexBannerInfo")]];
//            }
//        }
//        return BannerList;
//    }
//    else{
//        return nil;
//    }
//}
//
//- (NSMutableArray *)HotList
//{
//    if (HotList && [HotList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < HotList.count; i++) {
//            if([[HotList objectAtIndex:i] class] != [resMod_IndexHotInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[HotList objectAtIndex:i];
//                [HotList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_IndexHotInfo")]];
//            }
//        }
//        return HotList;
//    }
//    else{
//        return nil;
//    }
//}
//
//- (NSMutableArray *)ServiceList
//{
//    if (ServiceList && [ServiceList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ServiceList.count; i++) {
//            if([[ServiceList objectAtIndex:i] class] != [resMod_IndexServiceList class]){
//                NSDictionary * _dic = (NSDictionary *)[ServiceList objectAtIndex:i];
//                [ServiceList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_IndexServiceList")]];
//            }
//        }
//        return ServiceList;
//    }
//    else{
//        return nil;
//    }
//}
//
//- (NSMutableArray *)LowPriceList
//{
//    if (LowPriceList && [LowPriceList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < LowPriceList.count; i++) {
//            if([[LowPriceList objectAtIndex:i] class] != [resMod_IndexHotInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[LowPriceList objectAtIndex:i];
//                [LowPriceList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_IndexHotInfo")]];
//            }
//        }
//        return LowPriceList;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [BannerList release];
    [HotList release];
    [LowPriceList release];
    [ServiceList release];
    
    [super dealloc];
}
#endif
@end


//  --  CallBack
@implementation resMod_CallBack_IndexData
@synthesize ResponseStatus;
@synthesize ResponseData;
@synthesize ResponseMsg;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_IndexResponseData alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end




