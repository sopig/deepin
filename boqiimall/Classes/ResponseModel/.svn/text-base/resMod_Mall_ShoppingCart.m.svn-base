//
//  resMod_Mall_ShoppingCart.m
//  boqiimall
//
//  Created by YSW on 14-7-16.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_ShoppingCart.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

//  --
@implementation resMod_Mall_ShoppingCart
@synthesize TipFront;
@synthesize TipMiddle;
@synthesize TipMoneyBack;
@synthesize TipMoneyFront;
@synthesize NeedToPay;
@synthesize Preferential;
@synthesize GoodsList,GroupList;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.TipFront = [dic ConvertStringForKey:@"TipFront"];
        self.TipMiddle  = [dic ConvertStringForKey:@"TipMiddle"];
        self.TipMoneyBack = [[dic ConvertStringForKey:@"TipMoneyBack"] floatValue];
        self.TipMoneyFront = [[dic ConvertStringForKey:@"TipMoneyFront"] floatValue];
        self.NeedToPay = [[dic ConvertStringForKey:@"NeedToPay"] floatValue];
        self.Preferential = [[dic ConvertStringForKey:@"Preferential"] floatValue];
        
        //  -- 老
        NSArray * tmpGoodsList = [dic ConvertArrayForKey:@"GoodsList"];
        self.GoodsList = [[NSMutableArray alloc] initWithCapacity:tmpGoodsList.count];
        for (NSDictionary * item in tmpGoodsList ){
            [GoodsList addObject:[[resMod_Mall_ShoppingCartGoodsInfo alloc] initWithDic:item]];
        }
        
        //  -- 新
        NSArray * tmpGroupList = [dic ConvertArrayForKey:@"GroupList"];
        self.GroupList = [[NSMutableArray alloc] initWithCapacity:tmpGroupList.count];
        for (NSDictionary * item in tmpGroupList ){
            [GroupList addObject:[[resMod_Mall_ShoppingCartGroupList alloc] initWithDic:item]];
        }
    }
    return self;
}
@end


//  --
@implementation resMod_Mall_ShoppingCartGroupList
@synthesize GoodsList;
@synthesize PreferentialInfo;
@synthesize ActionResult;
@synthesize ActionId;
@synthesize GroupPrice;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        
        self.ActionResult  = [dic ConvertStringForKey:@"ActionResult"];
        
        NSArray * tmpGoodsList = [dic ConvertArrayForKey:@"GoodsList"];
        self.GoodsList = [[NSMutableArray alloc] initWithCapacity:tmpGoodsList.count];
        for (NSDictionary * item in tmpGoodsList ){
            [GoodsList addObject:[[resMod_Mall_ShoppingCartGoodsInfo alloc] initWithDic:item]];
        }
        
        NSArray * tmpPreferentialInfo = [dic ConvertArrayForKey:@"PreferentialInfo"];
        self.PreferentialInfo = [[NSMutableArray alloc] initWithCapacity:tmpPreferentialInfo.count];
        for (NSDictionary * item in tmpPreferentialInfo ){
            [PreferentialInfo addObject:[[resMod_Mall_CartPreferentialInfo alloc] initWithDic:item]];
        }
        
        self.ActionId   = [[dic ConvertStringForKey:@"ActionId"] intValue];
        self.GroupPrice = [[dic ConvertStringForKey:@"GroupPrice"] floatValue];
    }
    return self;
}
@end


//  --
@implementation resMod_GetShoppingCartNum
@synthesize Number;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.Number = [[dic ConvertStringForKey:@"Number"] intValue];
    }
    return self;
}
@end



//  --
@implementation resMod_Mall_ShoppingCartGoodsInfo
@synthesize GoodsId;
@synthesize GoodsImg;
@synthesize GoodsTitle;
@synthesize GoodsPrice;
@synthesize GoodsNum;
@synthesize GoodsLimit;
@synthesize GoodsSpec;
@synthesize GoodsPresents;
@synthesize GoodsType;
@synthesize GoodsSpecId;
@synthesize IsSelected;
@synthesize PreferentialInfo;
@synthesize ChangeBuyId;
@synthesize ActionId;
@synthesize IsChangeBuy;
@synthesize IsPreferential;
@synthesize IsClickable;
@synthesize ReasonForCannotOperate;
@synthesize ActionResult;
@synthesize TimeStamp;
@synthesize b_isChecked,b_isShowGift;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.GoodsId    = [[dic ConvertStringForKey:@"GoodsId"] intValue];
        self.GoodsImg   = [dic ConvertStringForKey:@"GoodsImg"];
        self.GoodsTitle = [dic ConvertStringForKey:@"GoodsTitle"];
        self.GoodsPrice = [[dic ConvertStringForKey:@"GoodsPrice"] floatValue];
        self.GoodsNum   = [[dic ConvertStringForKey:@"GoodsNum"] floatValue];
        self.GoodsLimit = [[dic ConvertStringForKey:@"GoodsLimit"] floatValue];
        
        NSArray * tmpGoodsSpec = [dic ConvertArrayForKey:@"GoodsSpec"];
        self.GoodsSpec = [[NSMutableArray alloc] initWithCapacity:tmpGoodsSpec.count];
        for (NSDictionary * item in tmpGoodsSpec) {
            [GoodsSpec addObject:[[resMod_Mall_CartGoodsProperty alloc] initWithDic:item]];
        }
        NSArray * tmpGoodsPresents = [dic ConvertArrayForKey:@"GoodsPresents"];
        self.GoodsPresents = [[NSMutableArray alloc] initWithCapacity:tmpGoodsPresents.count];
        for (NSDictionary * item in tmpGoodsPresents) {
            [GoodsPresents addObject:[[resMod_Mall_CartPresentInfo alloc] initWithDic:item]];
        }
        self.GoodsType = [[dic ConvertStringForKey:@"GoodsType"] intValue];
        self.GoodsSpecId = [dic ConvertStringForKey:@"GoodsSpecId"];
        
        NSArray * tmpPreferentialInfo = [dic ConvertArrayForKey:@"PreferentialInfo"];
        self.PreferentialInfo   = [[NSMutableArray alloc] initWithCapacity:tmpPreferentialInfo.count];
        for (NSDictionary * item in tmpPreferentialInfo) {
            [PreferentialInfo addObject:[[resMod_Mall_CartPreferentialInfo alloc] initWithDic:item]];
        }
        self.IsSelected         = [[dic ConvertStringForKey:@"IsSelected"] intValue];
        self.ChangeBuyId        = [[dic ConvertStringForKey:@"ChangeBuyId"] intValue];
        self.ActionId           = [[dic ConvertStringForKey:@"ActionId"] intValue];
        self.IsChangeBuy        = [[dic ConvertStringForKey:@"IsChangeBuy"] intValue];
        self.IsPreferential     = [[dic ConvertStringForKey:@"IsPreferential"] intValue];
        self.IsClickable        = [[dic ConvertStringForKey:@"IsClickable"] intValue];
        self.ReasonForCannotOperate   = [dic ConvertStringForKey:@"Reason"];
        self.ActionResult       = [dic ConvertStringForKey:@"ActionResult"];
        self.TimeStamp          = [[dic ConvertStringForKey:@"TimeStamp"] longLongValue];
        
        self.b_isChecked = NO;
        self.b_isShowGift = NO;
    }
    return self;
}
@end


//  -- 属性
@implementation resMod_Mall_CartGoodsProperty
@synthesize Key;
@synthesize Value;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.Key = [dic ConvertStringForKey:@"Key"];
        self.Value  = [dic ConvertStringForKey:@"Value"];
    }
    return self;
}
@end


//  --优惠信息（活动说明）
@implementation resMod_Mall_CartPreferentialInfo
@synthesize ActionId;
@synthesize ActionTitle;

- (instancetype) initWithDic:(NSDictionary *)dic{
    if (self=[super init]) {
        self.ActionId     = [[dic ConvertStringForKey:@"ActionId"] intValue];
        self.ActionTitle  = [dic ConvertStringForKey:@"ActionTitle"];
    }
    return self;
}
@end


//  --赠品
@implementation resMod_Mall_CartPresentInfo
@synthesize PresentId;
@synthesize PresentImg;
@synthesize PresentNum;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.PresentId   = [[dic ConvertStringForKey:@"PresentId"] intValue];
        self.PresentImg  = [dic ConvertStringForKey:@"PresentImg"];
        self.PresentNum  = [[dic ConvertStringForKey:@"PresentNum"] intValue];
    }
    return self;
}
@end


//  --换购信息
@implementation resMod_Mall_CartChangeBuyInfo
@synthesize CurrentActionId;
@synthesize ChangeBuyId;
@synthesize ChangeBuyImg;
@synthesize ChangeBuyOriPrice;
@synthesize ChangeBuyPrice;
@synthesize ChangeBuyTitle;
@synthesize IsCanChange;
@synthesize ReasonForNotChange;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.CurrentActionId    = [[dic ConvertStringForKey:@"CurrentActionId"] intValue];
        self.ChangeBuyId        = [[dic ConvertStringForKey:@"ChangeBuyId"] intValue];
        self.ChangeBuyImg       = [dic ConvertStringForKey:@"ChangeBuyImg"];
        self.ChangeBuyOriPrice  = [[dic ConvertStringForKey:@"ChangeBuyOriPrice"] floatValue];
        self.ChangeBuyPrice     = [[dic ConvertStringForKey:@"ChangeBuyPrice"] floatValue];
        self.ChangeBuyTitle     = [dic ConvertStringForKey:@"ChangeBuyTitle"];
        self.IsCanChange        = [[dic ConvertStringForKey:@"IsCanChange"] intValue];
        self.ReasonForNotChange = [dic ConvertStringForKey:@"ReasonForNotChange"];
    }
    return self;
}
@end


//  --换购列表
@implementation resMod_Mall_CartChangeBuyList
@synthesize ChangeBuyList;
@synthesize ActionList;
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        NSArray * tmpChangeBuyList = [dic ConvertArrayForKey:@"ChangeBuyList"];
        self.ChangeBuyList   = [[NSMutableArray alloc] initWithCapacity:tmpChangeBuyList.count];
        for (NSDictionary * item in tmpChangeBuyList) {
            [ChangeBuyList addObject:[[resMod_Mall_CartChangeBuyInfo alloc] initWithDic:item]];
        }
        
        NSArray * tmpActionList = [dic ConvertArrayForKey:@"ActionList"];
        self.ActionList   = [[NSMutableArray alloc] initWithCapacity:tmpActionList.count];
        for (NSDictionary * item in tmpActionList) {
            [ActionList addObject:[[resMod_Mall_CartPreferentialInfo alloc] initWithDic:item]];
        }
    }
    return self;
}
@end


//  --  .....................
@implementation resMod_CallBackMall_CartChangeBuyList
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_Mall_CartChangeBuyList alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}
@end


//  --  .....................
@implementation resMod_CallBackMall_CartNum
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_GetShoppingCartNum alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}
@end



//  --  .....................
@implementation resMod_CallBackMall_ShoppingCart
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_Mall_ShoppingCart alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}
@end

