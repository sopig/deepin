//
//  resMod_Mall_Order.m
//  boqiimall
//
//  Created by YSW on 14-7-9.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_Order.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

//  --  .........................................................
@implementation resMod_Mall_OrderCommitBackInfo
@synthesize OrderExpressageId;
@synthesize OrderId;
@synthesize OrderPaymentId;
@synthesize OrderPrice;
@synthesize payType;
@synthesize deleveryType;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.OrderExpressageId = [[dic ConvertStringForKey:@"OrderExpressageId"] intValue];
        self.OrderId  = [[dic ConvertStringForKey:@"OrderId"] intValue];
        self.OrderPaymentId  = [[dic ConvertStringForKey:@"OrderPaymentId"] intValue];
        self.OrderPrice  = [[dic ConvertStringForKey:@"OrderPrice"] floatValue];
        self.payType  = [dic ConvertStringForKey:@"payType"];
        self.deleveryType  = [dic ConvertStringForKey:@"deleveryType"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [payType release];
    [deleveryType release];
    [super dealloc];
}
#endif
@end


//  --  .........................................................
@implementation resMod_Mall_OrderGoodsInfo
@synthesize GoodsId;
@synthesize GoodsImg;
@synthesize GoodsNum;
@synthesize GoodsTitle;
@synthesize IsCommented;
@synthesize IsDropShopping;
@synthesize GoodsSpec;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.GoodsId = [[dic ConvertStringForKey:@"GoodsId"] intValue];
        self.GoodsNum  = [[dic ConvertStringForKey:@"GoodsNum"] intValue];
        self.GoodsImg  = [dic ConvertStringForKey:@"GoodsImg"];
        self.GoodsTitle  = [dic ConvertStringForKey:@"GoodsTitle"];
        self.IsCommented  = [[dic ConvertStringForKey:@"IsCommented"] intValue];
        self.IsDropShopping  = [[dic ConvertStringForKey:@"IsDropShopping"] intValue];
        
        NSArray * arrGoodsSpec = [dic ConvertArrayForKey:@"GoodsSpec"];
        self.GoodsSpec  = [[NSMutableArray alloc] initWithCapacity:arrGoodsSpec.count];
        for (NSDictionary * item in arrGoodsSpec) {
            [GoodsSpec addObject:[[resMod_Mall_OrderGoodsSpec alloc] initWithDic:item]];
        }
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [GoodsTitle release];
    [GoodsImg release];
    [super dealloc];
}
#endif
@end


//  --  .........................................................
@implementation resMod_Mall_OrderGoodsSpec
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



//  --  .........................................................
@implementation resMod_Mall_MyGoodsOrderInfo
@synthesize OrderId;
@synthesize OrderPrice;
@synthesize OrderTime;
@synthesize OrderGoods;
@synthesize OrderStatusInt;
@synthesize OrderStatusString;
@synthesize OrderLogisticsUrl;
@synthesize OrderCanComment;
@synthesize OrderPaymentId;
@synthesize IsUseBalance;
@synthesize BalanceUsed;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.OrderId = [[dic ConvertStringForKey:@"OrderId"] intValue];
        self.OrderPrice  = [[dic ConvertStringForKey:@"OrderPrice"] floatValue];
        self.OrderTime  = [dic ConvertStringForKey:@"OrderTime"];
        
        NSArray * arrOrderGoods = [dic ConvertArrayForKey:@"OrderGoods"];
        self.OrderGoods  = [[NSMutableArray alloc] initWithCapacity:arrOrderGoods.count];
        for (NSDictionary * item in arrOrderGoods) {
            [OrderGoods addObject:[[resMod_Mall_OrderGoodsInfo alloc] initWithDic:item]];
        }
        
        self.OrderStatusInt  = [[dic ConvertStringForKey:@"OrderStatusInt"] intValue];
        self.OrderStatusString  = [dic ConvertStringForKey:@"OrderStatusString"];
        self.OrderLogisticsUrl  = [dic ConvertStringForKey:@"OrderLogisticsUrl"];
        self.OrderCanComment  = [[dic ConvertStringForKey:@"OrderCanComment"] intValue];
        self.OrderPaymentId  = [[dic ConvertStringForKey:@"OrderPaymentId"] intValue];
        self.IsUseBalance  = [[dic ConvertStringForKey:@"IsUseBalance"] intValue];
        self.BalanceUsed  = [[dic ConvertStringForKey:@"BalanceUsed"] floatValue];
    }
    return self;
}

//- (NSMutableArray *)OrderGoods {
//    if (OrderGoods && [OrderGoods isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < OrderGoods.count; i++) {
//            if([[OrderGoods objectAtIndex:i] class] != [resMod_Mall_OrderGoodsInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[OrderGoods objectAtIndex:i];
//                [OrderGoods replaceObjectAtIndex:i
//                                        withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_OrderGoodsInfo")]];
//            }
//        }
//        return OrderGoods;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [OrderTime release];
    [OrderGoods release];
    [OrderStatusString release];
    [OrderLogisticsUrl release];
    [super dealloc];
}
#endif
@end


//  --  ...........................        订单【详情】，orderinfo
@implementation resMod_Mall_GoodsOrderDetail
@synthesize OrderStatusInt;         //	Int	订单状态	2、待付款 3、处理中 4、已完成 5、已取消
@synthesize OrderStatusString;      //	String	订单状态文字说明
@synthesize OrderNo;                //	String	订单编号
@synthesize OrderPrice;             //	Float	订单金额
@synthesize GoodsPrice;             //	Float	商品金额
@synthesize ExpressagePrice;        //	Float	运费金额
@synthesize PreferentialPrice;      //	Float	优惠金额
@synthesize CouponPrice;            //	Float	优惠券金额
@synthesize GoodsList;                  //	JsonArray	商品列表	表1
@synthesize AddressInfo;                //	JsonObject	地址信息	表2
@synthesize PaymentId;                  //	Int	支付方式id	1、在线支付 2、货到付款
@synthesize PaymentTitle;               //	String	支付方式title
@synthesize ExpressageId;               //	Int	配送方式id
@synthesize ExpressageTitle;            //  String	配送方式title
@synthesize OrderCanComment;            //
@synthesize OrderLogisticsUrl;          //
@synthesize IsUseBalance;
@synthesize BalanceUsed;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.OrderStatusInt = [[dic ConvertStringForKey:@"OrderStatusInt"] intValue];
        self.OrderStatusString  = [dic ConvertStringForKey:@"OrderStatusString"];
        self.OrderNo  = [dic ConvertStringForKey:@"OrderNo"];
        self.OrderPrice  = [[dic ConvertStringForKey:@"OrderPrice"] floatValue];
        self.GoodsPrice  = [[dic ConvertStringForKey:@"GoodsPrice"] floatValue];
        self.ExpressagePrice  = [[dic ConvertStringForKey:@"ExpressagePrice"] floatValue];
        self.PreferentialPrice  = [[dic ConvertStringForKey:@"PreferentialPrice"] floatValue];
        self.CouponPrice= [[dic ConvertStringForKey:@"CouponPrice"] floatValue];
        
        NSArray * tmpGoodsList = [dic ConvertArrayForKey:@"GoodsList"];
        self.GoodsList  = [[NSMutableArray alloc] initWithCapacity:tmpGoodsList.count];
        for (NSDictionary * item in tmpGoodsList) {
            [GoodsList addObject:[[resMod_Mall_OrderGoodsInfo alloc] initWithDic:item]];
        }
        self.AddressInfo  = [[resMod_AddressInfo alloc] initWithDic:[dic ConvertDictForKey:@"AddressInfo"]];
        self.PaymentId  = [[dic ConvertStringForKey:@"PaymentId"] intValue];
        self.PaymentTitle  = [dic ConvertStringForKey:@"PaymentTitle"];
        self.ExpressageId  = [[dic ConvertStringForKey:@"ExpressageId"] intValue];
        self.ExpressageTitle  = [dic ConvertStringForKey:@"ExpressageTitle"];
        self.OrderCanComment  = [[dic ConvertStringForKey:@"OrderCanComment"] intValue];
        self.OrderLogisticsUrl  = [dic ConvertStringForKey:@"OrderLogisticsUrl"];
        self.IsUseBalance  = [[dic ConvertStringForKey:@"IsUseBalance"] intValue];
        self.BalanceUsed  = [[dic ConvertStringForKey:@"BalanceUsed"] floatValue];
    }
    return self;
}

//- (NSMutableArray *)GoodsList {
//    if (GoodsList && [GoodsList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < GoodsList.count; i++) {
//            if([[GoodsList objectAtIndex:i] class] != [resMod_Mall_OrderGoodsInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[GoodsList objectAtIndex:i];
//                [GoodsList replaceObjectAtIndex:i
//                                        withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_OrderGoodsInfo")]];
//            }
//        }
//        return GoodsList;
//    }
//    else{
//        return nil;
//    }
//}


#if ! __has_feature(objc_arc)
- (void) dealloc{
    
    [OrderStatusString release];
    [OrderNo release];
    [GoodsList release];
    [AddressInfo release];
    [PaymentTitle release];
    [ExpressageTitle release];
    [OrderLogisticsUrl release];
    
    [super dealloc];
}
#endif
@end




//  --  .........................................................
@implementation resMod_CallBackMall_OrderCommit
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] floatValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_Mall_OrderCommitBackInfo alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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


//  --  .........................................................
@implementation resMod_CallBackMall_GoodsOrderDetail
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] floatValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_Mall_GoodsOrderDetail alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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


//  --  .........................................................
@implementation resMod_CallBackMall_MyGoodsOrder
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] floatValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray * arrResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc] initWithCapacity:arrResponseData.count];
        for (NSDictionary * item in arrResponseData) {
            [ResponseData addObject:[[resMod_Mall_MyGoodsOrderInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData {
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_Mall_MyGoodsOrderInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i
//                                        withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_MyGoodsOrderInfo")]];
//            }
//        }
//        return ResponseData;
//    }
//    else{
//        return nil;
//    }
//}
//

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end


