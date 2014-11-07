//
//  resMod_MyTicketDetail.m
//  BoqiiLife
//
//  Created by YSW on 14-5-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_MyTicketDetail.h"
#import "NSDictionary+JudgeObj.h"


//  --  .............................
@implementation resMod_MyTicketDetailInfo
@synthesize TicketID;
@synthesize TicketTitle;
@synthesize TicketImg;
@synthesize MyTicketDetail;
@synthesize MyTicketRemind;
@synthesize TicketPrice;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TicketID = [[dic ConvertStringForKey:@"TicketID"] intValue];
        self.TicketTitle = [dic ConvertStringForKey:@"TicketTitle"];
        self.TicketImg = [dic ConvertStringForKey:@"TicketImg"];
        self.MyTicketDetail = [dic ConvertStringForKey:@"MyTicketDetail"];
        self.MyTicketRemind = [dic ConvertStringForKey:@"MyTicketRemind"];
        self.TicketPrice = [[dic ConvertStringForKey:@"TicketPrice"] floatValue];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [TicketTitle release];
    [TicketImg release];
    [MyTicketDetail release];
    [MyTicketRemind release];
    [super dealloc];
}
#endif
@end


//  --  .............................
@implementation resMod_MyTicketDetailMerchantInfo
@synthesize MerchantId;
@synthesize MerchantName;
@synthesize MerchantAddress;
@synthesize MerchantDistance;
@synthesize MerchantTele;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.MerchantId = [[dic ConvertStringForKey:@"MerchantId"] intValue];
        self.MerchantName = [dic ConvertStringForKey:@"MerchantName"];
        self.MerchantAddress = [dic ConvertStringForKey:@"MerchantAddress"];
        self.MerchantDistance = [[dic ConvertStringForKey:@"MerchantDistance"] floatValue];
        self.MerchantTele = [dic ConvertStringForKey:@"MerchantTele"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [MerchantName release];
    [MerchantAddress release];
    [MerchantTele release];
    [super dealloc];
}
#endif
@end


//  --  .............................
@implementation resMod_MyTicketDetail
@synthesize TicketInfo;
@synthesize MyTicketNo;
@synthesize MyTicketStatus;
@synthesize TicketMerchant;
@synthesize MyTicketRemind;
@synthesize HasOtherMerchant;
@synthesize IsCommented;
@synthesize IsUsed;
@synthesize MyTicketPrice;


-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TicketInfo = [[resMod_MyTicketDetailInfo alloc] initWithDic:[dic ConvertDictForKey:@"TicketInfo"]];
        self.MyTicketNo = [dic ConvertStringForKey:@"MyTicketNo"];
        self.MyTicketStatus = [dic ConvertStringForKey:@"MyTicketStatus"];
        self.TicketMerchant = [[resMod_MyTicketDetailMerchantInfo alloc]initWithDic:[dic ConvertDictForKey:@"TicketMerchant"]];
        self.MyTicketRemind = [dic ConvertStringForKey:@"MyTicketRemind"];
        self.HasOtherMerchant = [[dic ConvertStringForKey:@"HasOtherMerchant"] integerValue];
        self.IsCommented = [[dic ConvertStringForKey:@"IsCommented"] intValue];
        self.IsUsed = [[dic ConvertStringForKey:@"IsUsed"] intValue];
        self.MyTicketPrice = [[dic ConvertStringForKey:@"MyTicketPrice"] floatValue];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [TicketInfo release];
    [MyTicketNo release];
    [MyTicketStatus release];
    [TicketMerchant release];
    [super dealloc];
}
#endif
@end



//  --  .............................
@implementation resMod_CallBack_GetMyTicketDetail
@synthesize ResponseStatus;
@synthesize ResponseData;
@synthesize ResponseMsg;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData= [[resMod_MyTicketDetail alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void)dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end


