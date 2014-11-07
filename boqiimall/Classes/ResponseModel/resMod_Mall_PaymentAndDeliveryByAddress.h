//
//  resMod_Mall_PaymentAndDeliveryByAddress.h
//  boqiimall
//
//  Created by YSW on 14-7-9.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_Mall_PaymentTypeByAddress : NSObject{
    BOOL isCheckedPayment;
    int PaymentId;                  //	Int	支付方式id
    NSString * PaymentTitle;        //	String	支付方式title
    NSString * PaymentDescription;  //	String	支付方式详细说明
    NSMutableArray * ExpressageList;//	JsonArray	该支付方式对应的配送方式
}
@property (assign,nonatomic) BOOL isCheckedPayment;          //	是否选中的支付方式
@property (assign,nonatomic) int PaymentId;                  //	Int	支付方式id
@property (retain,nonatomic) NSString * PaymentTitle;        //	String	支付方式title
@property (retain,nonatomic) NSString * PaymentDescription;  //	String	支付方式详细说明
@property (retain,nonatomic) NSMutableArray * ExpressageList;//	JsonArray	该支付方式对应的配送方式

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



@interface resMod_Mall_DeliveryTypeByAddress : NSObject{
    BOOL isCheckedDelivery;
    int ExpressageId;                   //	Int	配送方式id
    NSString * ExpressageTitle;         //	String	配送方式title
    NSString * ExpressageDescription;   //	String	配送方式详细说明
    float ExpressageMoney;              //	Float	配送方式对应运费
    int ExpressageMustChose;            //	Int	是否必选	1：是 0：不是
}
@property (assign,nonatomic) BOOL isCheckedDelivery;    //  是否选中的配送方式
@property (assign,nonatomic) int ExpressageId;          //	Int	配送方式id
@property (retain,nonatomic) NSString * ExpressageTitle;        //	String	配送方式title
@property (retain,nonatomic) NSString * ExpressageDescription;  //	String	配送方式详细说明
@property (assign,nonatomic) float ExpressageMoney;     //	Float	配送方式对应运费
@property (assign,nonatomic) int ExpressageMustChose;   //	Int	是否必选	1：是 0：不是

-(instancetype)initWithDic:(NSDictionary*)dic;
@end




@interface resMod_CallBackMall_PaymentAndDeliveryByAddress : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}
@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

