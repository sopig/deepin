//
//  UserUnit.h
//  BoqiiLife
//
//  Created by ysw on 14-4-18.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserUnit : NSObject

@property (nonatomic, assign)BOOL               m_isLogin;
@property (nonatomic, assign)BOOL               m_isShareSdkLogin;  //是否第三方登录
@property (nonatomic, retain)NSString *         m_userId;
@property (nonatomic, retain)NSString *         m_userName;         //用户名
@property (nonatomic, retain)NSString *         m_userNick;         //用户昵称
@property (nonatomic, retain)NSString *         m_userSex;          //用户性别
@property (nonatomic, retain)NSString *         m_userEmail;        //用户邮箱
@property (nonatomic, retain)NSString *         m_userMobile;       //用户手机

@property (nonatomic, retain)NSString *  m_userBalance;         //账户余额
@property (nonatomic, assign)int    m_userCartNum;         //购物车数量
@property (nonatomic, assign)int    m_userAllOrder;        //全部订单数
@property (nonatomic, assign)int    m_userUnpayOrder;      //待付费订单数
@property (nonatomic, assign)int    m_userPayedOrder;      //已付款订单数
@property (nonatomic, assign)int    m_userMallUnpayOrder;  //待付费商城订单数
@property (nonatomic, assign)int    m_userMallDealingOrder;//处理中商城

@property (nonatomic,readwrite,assign)int m_userhasPayPassword; //V1.0.1新增字段 是否设置过支付密码



+ (UserUnit*)shareLogin;

// 是否登录
+ (BOOL)isUserLogin;
// 是否用shareSDK第三方登录
+ (BOOL)isShareSDKLogin;
//注销登录
+ (void)logoutSuccess;


//userid  usertoken  userName  userMobile  userEmail
+ (NSString *)userId;               //用户id
+ (NSString *)userName;             //用户昵称
+ (NSString *)userNick;             //用户昵称
+ (NSString *)userSex;              //用户性别
+ (NSString *)userMobile;           //用户手机
+ (NSString *)userEmail;            //用户邮箱
+ (NSString *)userBalance;          //余额

+ (int)userCarNum;                  //购物车产品数
+ (int)userOrder_all ;
+ (int)userOrder_unpay ;
+ (int)userOrder_payed ;
+ (int)userOrder_mallUnpay;
+ (int)userOrder_mallDealing;


+ (int)userHasPayPassword;  //新增字段
+ (void)writeTelephoneNum:(NSString*)mobileNum;//
+ (void)clearTelePhoneNum;

+ (void)writeUserHasPayPassword:(NSInteger)num;//
+ (void)clearUserHasPayPassword;

// 保存购物车数量
+ (void)saveCartNum:(int) cartNum;
// 性别
+ (void)saveUserSex:(NSString*) sex;
// 昵称
+ (void)saveUserNick:(NSString*) nickName;

// 保存用户登录信息
+ (void)saveUserLoginInfo:(NSString *)pUserId
          isSharesdkLogin:(BOOL)      pUserShareSDKLogin
                 userName:(NSString *)pUserName
                 userNick:(NSString *)pUserNick
                  userSex:(NSString *)pUserSex
               userMobile:(NSString *)pUserMobile
                userEmail:(NSString *)pUserEmail
                  balance:(NSString *) pBalance
                 allorder:(int) pAllOrder
               unpayOrder:(int) pUnpayOrder
               payedOrder:(int) pPayedOrder
                unpayMall:(int) pUnpayMall
              DealingMall:(int) pDealingMall
           HasPayPassword:(int) hasPayPassword;

@end

