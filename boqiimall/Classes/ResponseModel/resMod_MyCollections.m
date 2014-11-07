//
//  resMod_MyCollections.m
//  BoqiiLife
//
//  Created by YSW on 14-5-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_MyCollections.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

/******************************************************
 ---------          商品
 ******************************************************
 */
@implementation resMod_ProductCollectionInfo
@synthesize GoodsId;        //	Int	商品id
@synthesize GoodsImg;        //	String	商品图片
@synthesize GoodsTitle;      //	String	商品标题
@synthesize GoodsHasPresent; //	Int	是否有赠品	0：没有 1：有
@synthesize GoodsPrice;      //	Float	现价
@synthesize GoodsOriPrice;   //	Float	原价
@synthesize GoodsCollected;  //	Int	收藏数量
@synthesize IsUnderCarriage; //	Int	是否已下架	0：没有 1：有

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.GoodsId = [[dic ConvertStringForKey:@"GoodsId"] intValue];
        self.GoodsImg = [dic ConvertStringForKey:@"GoodsImg"];
        self.GoodsTitle = [dic ConvertStringForKey:@"GoodsTitle"];
        self.GoodsHasPresent = [[dic ConvertStringForKey:@"GoodsHasPresent"] intValue];
        self.GoodsPrice = [[dic ConvertStringForKey:@"GoodsPrice"] floatValue];
        self.GoodsOriPrice = [[dic ConvertStringForKey:@"GoodsOriPrice"] floatValue];
        self.GoodsCollected = [[dic ConvertStringForKey:@"GoodsCollected"] intValue];
        self.IsUnderCarriage = [[dic ConvertStringForKey:@"IsUnderCarriage"] intValue];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void)dealloc{
    [GoodsTitle release];
    [GoodsImg release];
    
    [super dealloc];
}
#endif
@end

/******************************************************
 ---------       服务券
 ******************************************************
 */
@implementation resMod_MyCollectionInfo
@synthesize TicketId;
@synthesize TicketTitle;
@synthesize TicketPrice;
@synthesize TicketOriPrice;
@synthesize TicketImg;
@synthesize TicketStatus;
@synthesize msg;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TicketId = [[dic ConvertStringForKey:@"TicketId"] intValue];
        self.TicketTitle = [dic ConvertStringForKey:@"TicketTitle"];
        self.TicketPrice = [[dic ConvertStringForKey:@"TicketPrice"] floatValue];
        self.TicketOriPrice = [[dic ConvertStringForKey:@"TicketOriPrice"] floatValue];
        self.TicketImg = [dic ConvertStringForKey:@"TicketImg"];
        self.TicketStatus = [dic ConvertStringForKey:@"TicketStatus"];
        self.msg = [dic ConvertStringForKey:@"msg"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void)dealloc{
    [TicketTitle release];
    [TicketImg release];
    [TicketStatus release];
    [msg release];
    
    [super dealloc];
}
#endif
@end


/******************************************************
 ---------        return 商品
 ******************************************************
 */
@implementation resMod_CallBack_ProductCollectionList
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
            [ResponseData addObject:[[resMod_ProductCollectionInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_ProductCollectionInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_ProductCollectionInfo")]];
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


/******************************************************
 ---------        return 服务券
 ******************************************************
 */
@implementation resMod_CallBack_GetMyCollectionList
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
            [ResponseData addObject:[[resMod_MyCollectionInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_MyCollectionInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_MyCollectionInfo")]];
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
