//
//  resMod_MyOrders.h
//  BoqiiLife
//
//  Created by YSW on 14-5-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_MyOrderInfo : NSObject
@property (assign,nonatomic) int OrderId;
@property (assign,nonatomic) int TicketId;
@property (assign,nonatomic) int TicketNumber;
@property (assign,nonatomic) float OrderPrice;
@property (retain,nonatomic) NSString * OrderTicketId;
@property (retain,nonatomic) NSString * OrderTitle;
@property (retain,nonatomic) NSString * OrderImg;
@property (assign,nonatomic) int OrderStatus;
@property (retain,nonatomic) NSString * OrderStatusText;
@property (retain,nonatomic) NSString * OrderTicketNo;
@property (retain,nonatomic) NSString * OrderTel;
@property (retain,nonatomic) NSString * OrderCouponNo;
@property (assign,nonatomic) int IsUseBalance;               //  该订单是否使用过余额支付  1：是  0：否
@property (assign,nonatomic) float BalanceUsed;              //  使用的余额
@property (assign,nonatomic) int IsUsedCoupon;               //  该订单是否使用过优惠券   1：是  0：否
@property (assign,nonatomic) float CouponPrice;              //  优惠券金额
@property (retain,nonatomic) NSString * CouponCode;          //  本单使用的优惠券号

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



/******************************************************
 ---------        MyOrderList CallBack
 ******************************************************
 */
@interface resMod_CallBack_MyOrderList : NSObject {
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
