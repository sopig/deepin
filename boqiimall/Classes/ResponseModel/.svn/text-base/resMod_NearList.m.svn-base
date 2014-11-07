//
//  resMod_NearList.m
//  BoqiiLife
//
//  Created by YSW on 14-5-5.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_NearList.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

//  --  Ticket Info
@implementation resMod_NearTicketInfo
@synthesize TicketId;
@synthesize TicketTitle;
@synthesize TicketImg;
@synthesize TicketPrice;
@synthesize TicketOriPrice;
@synthesize Distance;
@synthesize RoadName;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TicketId = [[dic ConvertStringForKey:@"TicketId"] intValue];
        self.TicketTitle = [dic ConvertStringForKey:@"TicketTitle"];
        self.TicketImg = [dic ConvertStringForKey:@"TicketImg"];
        self.TicketPrice = [[dic ConvertStringForKey:@"TicketPrice"] floatValue];
        self.TicketOriPrice = [[dic ConvertStringForKey:@"TicketOriPrice"] floatValue];
        self.Distance = [dic ConvertStringForKey:@"Distance"];
        self.RoadName = [dic ConvertStringForKey:@"RoadName"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [TicketTitle    release];
    [TicketImg      release];
    [Distance       release];
    [RoadName       release];
    [super dealloc];
}
#endif
@end


//  --  Merchant Info
@implementation resMod_NearMerchantInfo
@synthesize MerchantId;
@synthesize MerchantTitle;
@synthesize MerchantAddress;
@synthesize MerchantTele;
@synthesize MerchantLat;
@synthesize MerchantLng;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.MerchantId = [dic ConvertStringForKey:@"MerchantId"];
        self.MerchantTitle = [dic ConvertStringForKey:@"MerchantTitle"];
        self.MerchantAddress = [dic ConvertStringForKey:@"MerchantAddress"];
        self.MerchantTele = [dic ConvertStringForKey:@"MerchantTele"];
        self.MerchantLat = [dic ConvertStringForKey:@"MerchantLat"];
        self.MerchantLng = [dic ConvertStringForKey:@"MerchantLng"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [MerchantId release];
    [MerchantTitle release];
    [MerchantAddress release];
    [MerchantTele release];
    [MerchantLat release];
    [MerchantLng release];
    [super dealloc];
}
#endif
@end

//  --  Near ResponseData
@implementation resMod_NearResponseData
@synthesize Ticketlist;
@synthesize MerchantList;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        NSArray * tmpTicketlist = [dic ConvertArrayForKey:@"Ticketlist"];
        self.Ticketlist = [[NSMutableArray alloc] initWithCapacity:tmpTicketlist.count];
        for (NSDictionary * item in tmpTicketlist) {
            [Ticketlist addObject:[[resMod_NearTicketInfo alloc] initWithDic:item]];
        }
        
        NSArray * tmpMerchantList = [dic ConvertArrayForKey:@"MerchantList"];
        self.MerchantList = [[NSMutableArray alloc] initWithCapacity:tmpMerchantList.count];
        for (NSDictionary * item in tmpMerchantList) {
            [MerchantList addObject:[[resMod_NearTicketInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)Ticketlist{
//    if (Ticketlist && [Ticketlist isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < Ticketlist.count; i++) {
//            if([[Ticketlist objectAtIndex:i] class] != [resMod_NearTicketInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[Ticketlist objectAtIndex:i];
//                [Ticketlist replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_NearTicketInfo")]];
//            }
//        }
//        return Ticketlist;
//    }
//    else{
//        return nil;
//    }
//}
//
//- (NSMutableArray *)MerchantList{
//    if (MerchantList && [MerchantList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < MerchantList.count; i++) {
//            if([[MerchantList objectAtIndex:i] class] != [resMod_NearMerchantInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[MerchantList objectAtIndex:i];
//                [MerchantList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_NearMerchantInfo")]];
//            }
//        }
//        return MerchantList;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [Ticketlist release];
    [MerchantList release];
    [super dealloc];
}
#endif
@end


//  --  TicketListByMerchant
@implementation resMod_CallBack_TicketListByMerchant
@synthesize ResponseStatus;
@synthesize ResponseData;
@synthesize ResponseMsg;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray * tmpResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc] initWithCapacity:tmpResponseData.count];
        for (NSDictionary * item in tmpResponseData) {
            [ResponseData addObject:[[resMod_NearTicketInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_NearTicketInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_NearTicketInfo")]];
//            }
//        }
//        return ResponseData;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end


//  --  CallBack
@implementation resMod_CallBack_NearList
@synthesize ResponseStatus;
@synthesize ResponseData;
@synthesize ResponseMsg;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_NearResponseData alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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




