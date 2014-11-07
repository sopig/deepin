//
//  resMod_Mall_GetShoppingMallGroupGoodsList.m
//  boqiimall
//
//  Created by iXiaobo on 14-9-24.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_GetShoppingMallGroupGoodsList.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"



#define kGoodsId @"GoodsId"
#define kGoodsImg @"GoodsImg"
#define kGoodsTitle @"GoodsTitle"
#define kGoodsPrice @"GoodsPrice"
#define kGoodsOriPrice @"GoodsOriPrice"
#define kGoodsSaledNum @"GoodsSaledNum"
#define kGoodsScale @"GoodsScale"
#define kRemainTime @"RemainTime"

@implementation resMod_Mall_GetShoppingMallGroupGoods
@synthesize goodsId;
@synthesize goodsImgUrl;
@synthesize goodsOriPrice;
@synthesize goodsPrice;
@synthesize goodsSaledNum;
@synthesize goodsScale;
@synthesize goodsTitle;
@synthesize remainTime;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        self.goodsId = [[dic objectForKey:kGoodsId] integerValue];
        self.goodsImgUrl = [dic ConvertStringForKey:kGoodsImg];
        self.goodsTitle = [dic ConvertStringForKey:kGoodsTitle];
        self.goodsOriPrice = [[dic objectForKey:kGoodsOriPrice] floatValue];
        self.goodsPrice = [[dic objectForKey:kGoodsPrice] floatValue];
        self.goodsSaledNum = [[dic objectForKey:kGoodsSaledNum] integerValue];
        self.goodsScale = [dic ConvertStringForKey:kGoodsScale] ;
        self.remainTime = [[dic objectForKey:kRemainTime] integerValue];
    }
    return self;
}

@end

@implementation resMod_CallbackMall_GetShoppingMallGroupGoodsList
@synthesize ResponseStatus;
@synthesize ResponseMsg;
@synthesize ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray * arrResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc] initWithCapacity:arrResponseData.count];
        for ( NSDictionary * item in arrResponseData ) {
            [self.ResponseData addObject:[[resMod_Mall_GetShoppingMallGroupGoods alloc] initWithDic:item]];
        }
        
        
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
