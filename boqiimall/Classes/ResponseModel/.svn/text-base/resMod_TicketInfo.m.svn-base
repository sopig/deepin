//
//  resMod_TicketInfo.m
//  BoqiiLife
//
//  Created by YSW on 14-5-12.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_TicketInfo.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

@implementation resMod_TicketInfo
@synthesize TicketId;
@synthesize TicketTitle;
@synthesize TicketImg;
@synthesize TicketPrice;
@synthesize TicketOriPrice;
@synthesize Distance;
@synthesize RoadName;
@synthesize BusinessArea;
@synthesize MerchantInfo;

/*******    下面是 Ticket Detail 添加的数据   *********/
@synthesize ImageList;
@synthesize TicketLimit;
@synthesize IsCollected;
@synthesize TicketLimitNumber;
@synthesize TicketDesc;
@synthesize TicketBuyed;
@synthesize TicketRemain;
@synthesize TicketMerchant;
@synthesize HasOtherMerchant;
@synthesize TicketDetail;
@synthesize TicketRemind;
@synthesize TicketShowUrl;
@synthesize TicketSale;
@synthesize CommentNum;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TicketId = [[dic ConvertStringForKey:@"TicketId"] intValue];
        self.TicketTitle = [dic ConvertStringForKey:@"TicketTitle"];
        self.TicketImg = [dic ConvertStringForKey:@"TicketImg"];
        self.TicketPrice = [[dic ConvertStringForKey:@"TicketPrice"] floatValue];
        self.TicketOriPrice = [[dic ConvertStringForKey:@"TicketOriPrice"] floatValue];
        self.Distance = [[dic ConvertStringForKey:@"Distance"] floatValue];
        self.RoadName = [dic ConvertStringForKey:@"RoadName"];
        self.BusinessArea = [dic ConvertStringForKey:@"BusinessArea"];
        self.MerchantInfo = [[resMod_MerchantInfo alloc] initWithDic:[dic ConvertDictForKey:@"MerchantInfo"]];
        self.HasOtherMerchant = [[dic ConvertStringForKey:@"HasOtherMerchant"] integerValue];
        self.ImageList = [dic ConvertStringForKey:@"ImageList"];
        self.TicketLimit = [dic ConvertStringForKey:@"TicketLimit"];
        self.IsCollected = [[dic ConvertStringForKey:@"IsCollected"] intValue];
        self.TicketLimitNumber = [[dic ConvertStringForKey:@"TicketLimitNumber"] intValue];
        self.TicketDesc = [dic ConvertStringForKey:@"TicketDesc"];
        self.TicketBuyed = [[dic ConvertStringForKey:@"TicketBuyed"] intValue];
        self.TicketRemain = [[dic ConvertStringForKey:@"TicketRemain"] intValue];
        self.TicketMerchant = [[resMod_MerchantInfo alloc] initWithDic:[dic ConvertDictForKey:@"TicketMerchant"]];
        
        self.TicketDetail = [dic ConvertStringForKey:@"TicketDetail"];
        self.TicketRemind = [dic ConvertStringForKey:@"TicketRemind"];
        self.TicketShowUrl = [dic ConvertStringForKey:@"TicketShowUrl"];
        self.TicketSale = [dic ConvertStringForKey:@"TicketSale"];
        self.CommentNum = [[dic ConvertStringForKey:@"CommentNum"] intValue];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [TicketTitle    release];
    [TicketImg      release];
    [RoadName       release];
    [BusinessArea   release];
    [MerchantInfo   release];
    
    [ImageList      release];
    [TicketLimit    release];
    [TicketDesc     release];
    [TicketMerchant release];
    [TicketDetail   release];
    [TicketRemind   release];
    [TicketShowUrl  release];
    [TicketSale     release];
    [super dealloc];
}
#endif
@end




//  call back.
@implementation resMod_CallBack_TicketList
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
            [ResponseData addObject:[[resMod_TicketInfo alloc] initWithDic:item]];
        }
    }
    return self;
}


//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_TicketInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_TicketInfo")]];
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
@implementation resMod_CallBack_TicketDetail
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_TicketInfo alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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








