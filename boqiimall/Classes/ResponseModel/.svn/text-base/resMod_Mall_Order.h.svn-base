//
//  resMod_Mall_Order.h
//  boqiimall
//
//  Created by YSW on 14-7-9.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "resMod_Address.h"

//  -- 提交订单返回 orderinfo
@interface resMod_Mall_OrderCommitBackInfo : NSObject

@property (assign,nonatomic) int OrderId;                //	Int	订单id
@property (assign,nonatomic) float OrderPrice;           //	Float	订单应付金额
@property (assign,nonatomic) int OrderPaymentId;         //	Int	支付方式
@property (assign,nonatomic) int OrderExpressageId;      //	Int	配送方式
@property (strong,nonatomic) NSString * payType;         //	Int	配送方式
@property (strong,nonatomic) NSString * deleveryType;    //	Int	配送方式

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



//  -- 订单商品信息
@interface resMod_Mall_OrderGoodsInfo : NSObject
@property (assign,nonatomic) int GoodsId;           //Int	商品id
@property (strong,nonatomic) NSString * GoodsImg;   //String	商品图片
@property (strong,nonatomic) NSString * GoodsTitle; //String	商品标题
@property (assign,nonatomic) int GoodsNum;          //Int	商品数量
@property (assign,nonatomic) int IsCommented;       //0：没有 1：有
@property (assign,nonatomic) int IsDropShopping;    //是否为代发货  1:是  0:否
@property (strong,nonatomic) NSMutableArray * GoodsSpec;    //JsonArray
-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  -- 商品规格信息
@interface resMod_Mall_OrderGoodsSpec : NSObject
@property (strong,nonatomic) NSString * Key;
@property (strong,nonatomic) NSString * Value;
-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  -- 订单【列表】，orderinfo
@interface resMod_Mall_MyGoodsOrderInfo : NSObject
@property (assign,nonatomic) int OrderId;                   //	Int	订单id
@property (assign,nonatomic) float OrderPrice;              //	Float	订单金额
@property (strong,nonatomic) NSString * OrderTime;          //	String	下单时间
@property (strong,nonatomic) NSMutableArray * OrderGoods;    //	JsonArray	订单商品列表	表2
@property (assign,nonatomic) int OrderStatusInt;             //	Int	订单状态枚举值	2待付款 3处理中 4已完成  5已取消
@property (strong,nonatomic) NSString * OrderStatusString;   //	String	订单状态文字说明
@property (strong,nonatomic) NSString * OrderLogisticsUrl;   //	String	物流信息URL
@property (assign,nonatomic) int OrderCanComment;            //  是否可评论
@property (assign,nonatomic) int OrderPaymentId;             //  支付方式id
@property (assign,nonatomic) int IsUseBalance;               //  该订单是否使用过余额支付  1：是  0：否
@property (assign,nonatomic) float BalanceUsed;                //  使用的余额

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



//  -- 订单【详情】，orderinfo
@interface resMod_Mall_GoodsOrderDetail : NSObject
@property (assign,nonatomic) int OrderStatusInt;//	Int	订单状态	2、待付款 3、处理中 4、已完成 5、已取消
@property (strong,nonatomic) NSString * OrderStatusString;//	String	订单状态文字说明
@property (strong,nonatomic) NSString * OrderNo;//	String	订单编号
@property (assign,nonatomic) float OrderPrice;  //	Float	订单金额
@property (assign,nonatomic) float GoodsPrice;  //	Float	商品金额
@property (assign,nonatomic) float ExpressagePrice;     //	Float	运费金额
@property (assign,nonatomic) float PreferentialPrice;   //	Float	优惠金额
@property (assign,nonatomic) float CouponPrice;         //	Float	优惠券金额
@property (strong,nonatomic) NSMutableArray * GoodsList;//	JsonArray	商品列表	表1
@property (strong,nonatomic) resMod_AddressInfo * AddressInfo;  //	JsonObject	地址信息	表2
@property (assign,nonatomic) int PaymentId;                 //	Int	支付方式id	1、在线支付 2、货到付款
@property (strong,nonatomic) NSString * PaymentTitle;       //	String	支付方式title
@property (assign,nonatomic) int ExpressageId;              //	Int	配送方式id
@property (strong,nonatomic) NSString * ExpressageTitle;    //  String	配送方式title
@property (strong,nonatomic) NSString * OrderLogisticsUrl;  //  String	订单物流页面链接
@property (assign,nonatomic) int OrderCanComment;           //int	订单是否可评论	1：是 0：否
@property (assign,nonatomic) int IsUseBalance;              //  该订单是否使用过余额支付  1：是  0：否
@property (assign,nonatomic) float BalanceUsed;             //  使用的余额

-(instancetype)initWithDic:(NSDictionary*)dic;
@end







/******************************************************
 ---------        return  : call back  提交订单返回
 ******************************************************
 */
@interface resMod_CallBackMall_OrderCommit: NSObject
@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) resMod_Mall_OrderCommitBackInfo * ResponseData;


-(instancetype)initWithDic:(NSDictionary*)dic;
@end

/******************************************************
 ---------        return  : call back  订单详情
 ******************************************************
 */
@interface resMod_CallBackMall_GoodsOrderDetail: NSObject
@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) resMod_Mall_GoodsOrderDetail * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        return  : call back  我的订单列表
 ******************************************************
 */
@interface resMod_CallBackMall_MyGoodsOrder: NSObject
@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
