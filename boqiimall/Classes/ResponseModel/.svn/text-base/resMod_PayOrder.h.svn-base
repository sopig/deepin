//
//  resMod_PayOrder.h
//  BoqiiLife
//
//  Created by YSW on 14-5-14.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_PayOrder : NSObject{
    NSString * PayMessage;
    int Type;
}
@property (assign,nonatomic) int Type;
@property (retain,nonatomic) NSString * PayMessage;



/*以下参数在PayMessage中，用于微信支付请求*/

@property (nonatomic,readwrite,strong)NSString* PrepayId;
@property (nonatomic,readwrite,strong)NSString* NonceStr;
@property (nonatomic,readwrite,strong)NSString* TimeStamp;
@property (nonatomic,readwrite,strong)NSString* Package;
@property (nonatomic,readwrite,strong)NSString* AppSignature;


-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  --  生活馆 支付金额明细
@interface resMod_PayAmountDetail : NSObject
@property (assign,nonatomic) float OrderPrice;
@property (assign,nonatomic) float CouponPrice;
@property (assign,nonatomic) float UseBalance;
@property (assign,nonatomic) float NeedPayPrice;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



/******************************************************
 ---------        GetPayAmountDetail CallBack
 ******************************************************
 */
@interface resMod_CallBack_GetPayAmountDetail : NSObject
@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_PayAmountDetail * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        PayOrder CallBack
 ******************************************************
 */
@interface resMod_CallBack_PayOrder : NSObject {
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_PayOrder * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_PayOrder * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
