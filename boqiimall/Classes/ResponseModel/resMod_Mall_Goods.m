//
//  resMod_Mall_Goods.m
//  boqiimall
//
//  Created by YSW on 14-6-30.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//
#import "resMod_Mall_Goods.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"


//-----------...............
@implementation resMod_Mall_GoodsInfo
@synthesize     GoodsId;
@synthesize     GoodsActionList;    //--商品标签 ：1满减 2折扣 3满减+折扣 4包邮 5赠品 6团购 7代发货
@synthesize     GoodsSaledNum;      //--已售数量
@synthesize     GoodsPrice;         //--现价
@synthesize     GoodsOriPrice;      //--原价
@synthesize     GoodsTitle;
@synthesize     GoodsImg;
@synthesize     TypeId;             //--分类id
@synthesize     TypeName;           //--分类名
@synthesize     BrandId;
@synthesize     BrandName;
@synthesize     GoodsCommentNum;    //  商品评论数

//--------------         goodDetail 添加         ---------------//
@synthesize     GoodsImgList;       //  商品图片
@synthesize     GoodsIsCollected;   //  商品是否已收藏	0：没有 1：有
@synthesize     GoodsTip;           //  商品提示/促销信息
@synthesize     GoodsSupport;
@synthesize     GoodsPresents;      //  赠品列表
@synthesize     GoodsDetailUrl;     //  商品详情链接
@synthesize     GoodsParams;        //  商品参数
@synthesize     GoodsCommentScore;  //  商品评论分数
@synthesize     GoodsStockNum;  //  商品库存数
@synthesize     GoodsLimitNum;  //  商品限购数
@synthesize     GoodsCanBuy;    //  商品能够购买	0：不能 1：能
@synthesize     GoodsType;      //  商品类型	: 普通商品\团购商品等
@synthesize     CannotBuyReason;//  无法购买理由
@synthesize     IsGroup;        //  是否是团购商品	1：是 0否
@synthesize     IsDropShopping; //  是否是代发货	1：是 0否

//--------------         BuyedGoods 添加         ---------------//
@synthesize     GoodsStatus;
@synthesize     GoodsSpec;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        self.GoodsId = [[dic ConvertStringForKey:@"GoodsId"] intValue];
        self.GoodsActionList = [dic ConvertStringForKey:@"GoodsActionList"];
        self.GoodsSaledNum   = [[dic ConvertStringForKey:@"GoodsSaledNum"] intValue];
        self.GoodsPrice = [[dic ConvertStringForKey:@"GoodsPrice"] floatValue];
        self.GoodsOriPrice = [[dic ConvertStringForKey:@"GoodsOriPrice"] floatValue];
        self.GoodsTitle = [dic ConvertStringForKey:@"GoodsTitle"];
        self.GoodsImg = [dic ConvertStringForKey:@"GoodsImg"];
        self.TypeId   = [[dic ConvertStringForKey:@"TypeId"] intValue];
        self.TypeName = [dic ConvertStringForKey:@"TypeName"];
        self.BrandId  = [[dic ConvertStringForKey:@"BrandId"] intValue];
        self.BrandName= [dic ConvertStringForKey:@"BrandName"];
        
        
        self.GoodsImgList = [dic ConvertStringForKey:@"GoodsImgList"];
        self.GoodsIsCollected = [[dic ConvertStringForKey:@"GoodsIsCollected"] intValue];
        self.GoodsTip = [dic ConvertStringForKey:@"GoodsTip"];
        self.GoodsSupport = [dic ConvertStringForKey:@"GoodsSupport"];

        NSArray * tmpGoodsPresents = [dic ConvertArrayForKey:@"GoodsPresents"];
        self.GoodsPresents = [[NSMutableArray alloc] initWithCapacity:tmpGoodsPresents.count];
        for (NSDictionary * item in tmpGoodsPresents) {
            [GoodsPresents addObject:[[resMod_Mall_PresentInfo alloc] initWithDic:item]];
        }
        
        self.GoodsDetailUrl = [dic ConvertStringForKey:@"GoodsDetailUrl"];
        
        NSArray * tmpGoodsParams = [dic ConvertArrayForKey:@"GoodsParams"];
        self.GoodsParams= [[NSMutableArray alloc] initWithCapacity:tmpGoodsParams.count];
        for (NSDictionary * item in tmpGoodsParams) {
            [GoodsParams addObject:[[resMod_Mall_ProductProperty alloc] initWithDic:item]];
        }
        self.GoodsCommentNum = [[dic ConvertStringForKey:@"GoodsCommentNum"] intValue];
        self.GoodsCommentScore = [[dic ConvertStringForKey:@"GoodsCommentScore"] floatValue];
        self.GoodsStockNum = [[dic ConvertStringForKey:@"GoodsStockNum"] intValue];
        self.GoodsLimitNum = [[dic ConvertStringForKey:@"GoodsLimitNum"] intValue];
        self.GoodsCanBuy   = [[dic ConvertStringForKey:@"GoodsCanBuy"] intValue];
        self.GoodsType     = [[dic ConvertStringForKey:@"GoodsType"] intValue];
        self.CannotBuyReason= [dic ConvertStringForKey:@"CannotBuyReason"];
        self.IsGroup        = [[dic ConvertStringForKey:@"IsGroup"] intValue];
        self.IsDropShopping = [[dic ConvertStringForKey:@"IsDropShopping"] intValue];
        self.GoodsActionType = [dic ConvertStringForKey:@"GoodsActionType"];
        self.GoodsStatus   = [dic ConvertStringForKey:@"GoodsStatus"];
        NSArray * tmpGoodsSpec = [dic ConvertArrayForKey:@"GoodsSpec"];
        self.GoodsSpec= [[NSMutableArray alloc] initWithCapacity:tmpGoodsSpec.count];
        for (NSDictionary * item in tmpGoodsSpec) {
            [GoodsSpec addObject:[[resMod_Mall_ProductProperty alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)GoodsParams {
//    
//    if (GoodsParams && [GoodsParams isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < GoodsParams.count; i++) {
//            if([[GoodsParams objectAtIndex:i] class] != [resMod_Mall_ProductProperty class]){
//                NSDictionary * _dic = (NSDictionary *)[GoodsParams objectAtIndex:i];
//                [GoodsParams replaceObjectAtIndex:i
//                                        withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_ProductProperty")]];
//            }
//        }
//        return GoodsParams;
//    }
//    else{
//        return nil;
//    }
//}
//
//- (NSMutableArray *)GoodsPresents {
//    if (GoodsPresents && [GoodsPresents isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < GoodsPresents.count; i++) {
//            if([[GoodsPresents objectAtIndex:i] class] != [resMod_Mall_PresentInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[GoodsPresents objectAtIndex:i];
//                [GoodsPresents replaceObjectAtIndex:i
//                                       withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_PresentInfo")]];
//            }
//        }
//        return GoodsPresents;
//    }
//    else{
//        return nil;
//    }
//}


#if ! __has_feature(objc_arc)
-(void) dealloc{
    [GoodsTitle release];
    [GoodsImg release];
    [TypeName release];
    [BrandName release];
    [GoodsActionList release];
    [GoodsImgList release];
    [GoodsTip release];
    [GoodsSupport release];
    [GoodsPresents release];
    [GoodsDetailUrl release];
    [GoodsParams release];
    [GoodsStatus release];
    [super dealloc];
}
#endif
@end

//  --.................. 商品属性
@implementation resMod_Mall_ProductProperty
@synthesize Key;
@synthesize Value;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        self.Key = [dic ConvertStringForKey:@"Key"];
        self.Value = [dic ConvertStringForKey:@"Value"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [Key release];
    [Value release];
    [super dealloc];
}
#endif
@end

//  --.................. 赠品信息
@implementation resMod_Mall_PresentInfo
@synthesize PresentId;                //  商品提示/促销信息
@synthesize PresentImg;
@synthesize PresentTitle;   //  赠品
@synthesize PresentNum;     //  商品参数

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.PresentId = [[dic ConvertStringForKey:@"PresentId"] intValue];
        self.PresentImg = [dic ConvertStringForKey:@"PresentImg"];
        self.PresentTitle = [dic ConvertStringForKey:@"PresentTitle"];
        self.PresentNum = [[dic ConvertStringForKey:@"PresentNum"] intValue];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void) dealloc{
    [PresentImg release];
    [PresentTitle release];
    [super dealloc];
}
#endif
@end


//  --..................
@implementation resMod_CallBackMall_GoodsList
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray * arrResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc] initWithCapacity:arrResponseData.count];
        for (NSDictionary * item in arrResponseData) {
            [ResponseData addObject:[[resMod_Mall_GoodsInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end


//  --..................
@implementation resMod_CallBackMall_GoodsDetail
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData= [[resMod_Mall_GoodsInfo alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end;