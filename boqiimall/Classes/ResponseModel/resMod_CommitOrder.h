//
//  resMod_CommitOrder.h
//  BoqiiLife
//
//  Created by YSW on 14-5-13.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>


/******************************************************
 ---------        Commit Order Info
 ******************************************************
 */
@interface resMod_CommitOrderInfo : NSObject{
    int     OrderId;
    BOOL    CanUseCoupon;   //是否可以使用优惠券
    
    //  --方便传入支付页 添加数据.
//    NSString * OrderTotalPrice;
//    NSString * ProductName;
//    NSString * ProductId;
//    NSString * OrderTeleNum;     //-- 接收服务券手机号
}
@property (assign,nonatomic) int  OrderId;
@property (assign,nonatomic) BOOL CanUseCoupon;

//@property (retain,nonatomic) NSString * OrderTotalPrice;
//@property (retain,nonatomic) NSString * ProductName;
//@property (retain,nonatomic) NSString * ProductId;
//@property (retain,nonatomic) NSString * OrderTeleNum;
-(instancetype)initWithDic:(NSDictionary*)dic;
@end





/******************************************************
 ---------        CallBack: response  data
 ******************************************************
 */
@interface resMod_CallBack_CommitOrder : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_CommitOrderInfo * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_CommitOrderInfo * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
