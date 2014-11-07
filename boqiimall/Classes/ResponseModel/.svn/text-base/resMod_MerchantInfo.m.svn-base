//
//  resMod_MerchantInfo.m
//  BoqiiLife
//
//  Created by YSW on 14-5-12.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_MerchantInfo.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"
#import "resMod_TicketInfo.h"

@implementation resMod_MerchantInfo
@synthesize     MerchantId;
@synthesize     AverageComsume;
@synthesize     ScanNumbers;
@synthesize     MerchantImg;
@synthesize     MerchantTitle;
@synthesize     MerchantAddress;
@synthesize     MerchantTele;
@synthesize     MerchantLat;
@synthesize     MerchantLng;

@synthesize     Distance;
@synthesize     BusinessArea;
@synthesize     Characteristic;

@synthesize     MerchantDistance;
@synthesize     MerchantName;

@synthesize     ScanNumber;
@synthesize     ConsumePerPerson;    //人均消费
@synthesize     TicketList; //服务券列表
@synthesize     MerchantDesc;       //商户介绍
@synthesize     MerchantTraffic;    //交通信息
@synthesize     MerchantNear;       //周边小区
@synthesize     MerchantServeUrl;   //服务页面url

@synthesize     CommentNum;  //评论数

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.MerchantId = [[dic ConvertStringForKey:@"MerchantId"] intValue];
        self.AverageComsume = [[dic ConvertStringForKey:@"AverageComsume"] floatValue];
        self.ScanNumbers = [[dic ConvertStringForKey:@"ScanNumbers"] intValue];
        self.MerchantImg = [dic ConvertStringForKey:@"MerchantImg"];
        self.MerchantTitle = [dic ConvertStringForKey:@"MerchantTitle"];
        self.MerchantAddress = [dic ConvertStringForKey:@"MerchantAddress"];
        self.MerchantTele = [dic ConvertStringForKey:@"MerchantTele"];
        self.MerchantLat = [dic ConvertStringForKey:@"MerchantLat"];
        self.MerchantLng = [dic ConvertStringForKey:@"MerchantLng"];
        
        self.Distance = [dic ConvertStringForKey:@"Distance"];
        self.BusinessArea = [dic ConvertStringForKey:@"BusinessArea"];
        self.Characteristic = [dic ConvertStringForKey:@"Characteristic"];
        
        self.MerchantDistance = [[dic ConvertStringForKey:@"MerchantDistance"] floatValue];
        self.MerchantName = [dic ConvertStringForKey:@"MerchantName"];
        
        self.ScanNumber = [[dic ConvertStringForKey:@"ScanNumber"] intValue];
        self.ConsumePerPerson = [[dic ConvertStringForKey:@"ConsumePerPerson"] floatValue];
        
        NSArray * tmpTicketList = [dic ConvertArrayForKey:@"TicketList"];
        self.TicketList = [[NSMutableArray alloc] initWithCapacity:tmpTicketList.count];
        for (NSDictionary * item in tmpTicketList) {
            [TicketList addObject:[[resMod_TicketInfo alloc] initWithDic:item]];
        }
        
        self.MerchantDesc = [dic ConvertStringForKey:@"MerchantDesc"];
        self.MerchantTraffic = [dic ConvertStringForKey:@"MerchantTraffic"];
        self.MerchantNear = [dic ConvertStringForKey:@"MerchantNear"];
        self.MerchantServeUrl = [dic ConvertStringForKey:@"MerchantServeUrl"];
        self.CommentNum = [[dic ConvertStringForKey:@"CommentNum"] intValue];
        
    }
    return self;
}

//- (NSMutableArray *)TicketList{
//    if (TicketList && [TicketList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < TicketList.count; i++) {
//            if([[TicketList objectAtIndex:i] class] != [resMod_TicketInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[TicketList objectAtIndex:i];
//                [TicketList replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_TicketInfo")]];
//            }
//        }
//        return TicketList;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
-(void)dealloc{
    [MerchantImg release];
    [MerchantTitle release];
    [MerchantAddress release];
    [MerchantTele release];
    [MerchantLat release];
    [MerchantLng release];

    [Distance release];
    [BusinessArea release];
    [Characteristic release];
    
    
    [TicketList release];           //服务券列表
    [MerchantDesc release];         //商户介绍
    [MerchantTraffic release];      //交通信息
    [MerchantNear release];         //周边小区
    [MerchantServeUrl release];     //服务页面url
    [super dealloc];
}
#endif
@end







//  call back.
@implementation resMod_CallBack_MerchantList
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
            [ResponseData addObject:[[resMod_MerchantInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_MerchantInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_MerchantInfo")]];
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




//  call back.
@implementation resMod_CallBack_MerchantDetail
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_MerchantInfo alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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



