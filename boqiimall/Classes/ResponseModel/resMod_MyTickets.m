//
//  resMod_MyTickets.m
//  BoqiiLife
//
//  Created by YSW on 14-5-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_MyTickets.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

///.............................
@implementation resMod_MyTicketInfo
@synthesize MyTicketId;
@synthesize MyTicketTitle;
@synthesize MyTicketPrice;
@synthesize MyTicketImg;
@synthesize MyTicketStatus;
@synthesize MyTicketNo;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.MyTicketId = [[dic ConvertStringForKey:@"MyTicketId"] intValue];
        self.MyTicketTitle = [dic ConvertStringForKey:@"MyTicketTitle"];
        self.MyTicketPrice = [[dic ConvertStringForKey:@"MyTicketPrice"] floatValue];
        self.MyTicketImg = [dic ConvertStringForKey:@"MyTicketImg"];
        self.MyTicketStatus = [[dic ConvertStringForKey:@"MyTicketStatus"] intValue];
        self.MyTicketNo = [dic ConvertStringForKey:@"MyTicketNo"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [MyTicketTitle release];
    [MyTicketImg release];
    [MyTicketNo release];
    
    [super dealloc];
}
#endif
@end


///.............................

@implementation resMod_CallBack_MyTicketList
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
            [ResponseData addObject:[[resMod_MyTicketInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_MyTicketInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_MyTicketInfo")]];
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
    [ResponseData release];
    [ResponseMsg release];
    [super dealloc];
}
#endif
@end



