//
//  resMod_UserInfo.h
//  BoqiiLife
//
//  Created by YSW on 14-5-5.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

/******************************************************
 ---------        User  info    :用户信息
 ******************************************************
 */
@interface resMod_UserInfo : NSObject{
    NSString * UserId;
    NSString * NickName;
    float  Balance;
    int AllOrderNum;
    int UnpayOrderNum;
    int PayedOrderNum;
    int ShoppingMallUnpayNum;
    int ShoppingMallDealingNum;
    NSString * Sex;
    NSString * Telephone;
}

@property (retain,nonatomic) NSString * UserId;
@property (retain,nonatomic) NSString * NickName;
@property (assign,nonatomic) float  Balance;
@property (assign,nonatomic) int    AllOrderNum;
@property (assign,nonatomic) int    UnpayOrderNum;
@property (assign,nonatomic) int    PayedOrderNum;
@property (assign,nonatomic) int    ShoppingMallUnpayNum;
@property (assign,nonatomic) int    ShoppingMallDealingNum;
@property (retain,nonatomic) NSString * Sex;
@property (retain,nonatomic) NSString * Telephone;

@property (nonatomic,readwrite,assign)int HasPayPassword;
@property (nonatomic,readwrite,strong)NSString*Token; //增加token字段

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        Login  info    :用户信息
 ******************************************************
 */
@interface resMod_CallBack_LoginOrRegister : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_UserInfo * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_UserInfo * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end





