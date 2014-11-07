//
//  UserUnit.m
//  BoqiiLife
//
//  Created by ysw on 14-4-18.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "UserUnit.h"
#import <ShareSDK/ShareSDK.h>

#define keySellUserData_isLogin             @"UserData_isLogin"
#define keySellUserData_isShareSdkLogin     @"UserData_isShareSdkLogin"
#define keySellUserData_userId              @"UserData_userId"
#define keySellUserData_userName            @"UserData_userName"
#define keySellUserData_userNick            @"UserData_userNick"
#define keySellUserData_userSex             @"UserData_userSex"
#define keySellUserData_userEmail           @"UserData_userEmail"
#define keySellUserData_userMobile          @"UserData_userMobile"

#define keySellUserData_CartNum             @"userData_cartNum"
#define keySellUserData_userBalance            @"UserData_userBalance"

#define keySellUserData_userAllOrder           @"UserData_userAllOrder"
#define keySellUserData_userUnpayOrder         @"UserData_userUnpayOrder"
#define keySellUserData_userPayedOrder         @"UserData_userPayedOrder"
#define keySellUserData_userUnpayMallOrder     @"UserData_UnpayMallOrder"
#define keySellUserData_userDealingMallOrder   @"UserData_userDealingMallOrder"
#define keySellUserData_userHasPayPassword   @"UserData_userHasPayPassword"

static UserUnit *mLoginUtility = nil;

@implementation UserUnit
@synthesize m_isLogin,m_isShareSdkLogin,m_userId,m_userName,m_userNick,m_userSex,m_userEmail,m_userMobile;
@synthesize m_userBalance,m_userAllOrder,m_userUnpayOrder,m_userPayedOrder,m_userMallDealingOrder,m_userMallUnpayOrder;
@synthesize m_userCartNum;
@synthesize m_userhasPayPassword;

- (id)init {
    if (self = [super init]) {
        
        // 是否登录
        self.m_isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:keySellUserData_isLogin];
        self.m_isShareSdkLogin = [[NSUserDefaults standardUserDefaults] boolForKey:keySellUserData_isShareSdkLogin];
        
        //*****************  用户信息  *************//
        // userId
        self.m_userId = [[NSUserDefaults standardUserDefaults] stringForKey:keySellUserData_userId];
        self.m_userId= self.m_userId ? self.m_userId : @"";
        
        // userName
        self.m_userName = [[NSUserDefaults standardUserDefaults] stringForKey:keySellUserData_userName];
        self.m_userName= self.m_userName ? self.m_userName : @"";
        
        // user Nick Name
        self.m_userNick = [[NSUserDefaults standardUserDefaults] stringForKey:keySellUserData_userNick];
        self.m_userNick= self.m_userNick ? self.m_userNick : @"";
        
        // user SEX
        self.m_userSex = [[NSUserDefaults standardUserDefaults] stringForKey:keySellUserData_userSex];
        self.m_userSex= self.m_userSex ? self.m_userSex : @"未知";
        
        // userEmail
        self.m_userEmail = [[NSUserDefaults standardUserDefaults] stringForKey:keySellUserData_userEmail];
        self.m_userEmail= self.m_userEmail ? self.m_userEmail : @"";
        
        // userMobile
        self.m_userMobile = [[NSUserDefaults standardUserDefaults] stringForKey:keySellUserData_userMobile];
        self.m_userMobile= self.m_userMobile ? self.m_userMobile : @"";
        
        // m_userBalance
        self.m_userBalance = [[NSUserDefaults standardUserDefaults] stringForKey:keySellUserData_userBalance];
        self.m_userBalance= self.m_userBalance ? self.m_userBalance : 0;
        
        // m_userAllOrder
        self.m_userAllOrder = [[NSUserDefaults standardUserDefaults] integerForKey:keySellUserData_userAllOrder];
        self.m_userAllOrder= self.m_userAllOrder ? self.m_userAllOrder : 0;
        
        // m_userUnpayOrder
        self.m_userUnpayOrder = [[NSUserDefaults standardUserDefaults] integerForKey:keySellUserData_userUnpayOrder];
        self.m_userUnpayOrder= self.m_userUnpayOrder ? self.m_userUnpayOrder : 0;
        
        // m_userPayedOrder
        self.m_userPayedOrder = [[NSUserDefaults standardUserDefaults] integerForKey:keySellUserData_userPayedOrder];
        self.m_userPayedOrder= self.m_userPayedOrder ? self.m_userPayedOrder : 0;
        
        //
        self.m_userMallUnpayOrder = [[NSUserDefaults standardUserDefaults] integerForKey:keySellUserData_userUnpayMallOrder];
        self.m_userMallUnpayOrder= self.m_userMallUnpayOrder ? self.m_userMallUnpayOrder : 0;
        
        //
        self.m_userMallDealingOrder = [[NSUserDefaults standardUserDefaults] integerForKey:keySellUserData_userDealingMallOrder];
        self.m_userMallDealingOrder= self.m_userMallDealingOrder ? self.m_userMallDealingOrder : 0;
        
        
        //  -- 购物车数量
        self.m_userCartNum = [[NSUserDefaults standardUserDefaults] integerForKey:keySellUserData_CartNum];
        self.m_userCartNum= self.m_userCartNum ? self.m_userCartNum : 0;
        
        //V1.0.1新增字段
        self.m_userhasPayPassword = [[NSUserDefaults standardUserDefaults] integerForKey:keySellUserData_userHasPayPassword];
        self.m_userhasPayPassword = self.m_userhasPayPassword ? self.m_userhasPayPassword : 0;

    }
    return self;
}

+ (UserUnit*)shareLogin {
    @synchronized(self) {
        if (!mLoginUtility) {
            mLoginUtility = [[UserUnit alloc] init];
        }
    }
    return mLoginUtility;
}

//  --.....
+ (void)saveCartNum:(int) cartNum{
    [[NSUserDefaults standardUserDefaults] setInteger:cartNum     forKey:keySellUserData_CartNum];
    [UserUnit shareLogin].m_userCartNum = cartNum;
}

//+(void)saveUserName:(NSString *)userName {
//    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:keySellUserData_userName];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [UserUnit shareLogin].m_userName = userName;
//}

//  --.....
+ (void)saveUserSex:(NSString*) sex{
    [[NSUserDefaults standardUserDefaults] setObject:sex forKey:keySellUserData_userSex];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UserUnit shareLogin].m_userSex = sex;
}

//  --.....
+ (void)saveUserNick:(NSString*) nickName{
    [[NSUserDefaults standardUserDefaults] setObject:nickName forKey:keySellUserData_userNick];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UserUnit shareLogin].m_userNick = nickName;
}

////  --.....
//+ (void)saveCartNum:(int) cartNum{
//    [[NSUserDefaults standardUserDefaults] setInteger:cartNum     forKey:keySellUserData_CartNum];
//    [UserUnit shareLogin].m_userCartNum = cartNum;
//}


+ (BOOL)isUserLogin {
    return [UserUnit shareLogin].m_isLogin;
}
+ (BOOL)isShareSDKLogin {
    return [UserUnit shareLogin].m_isShareSdkLogin;
}
+ (NSString*)userId {
    return [UserUnit shareLogin].m_userId;
}
+ (NSString*)userName {
    return [UserUnit shareLogin].m_userName;
}
+ (NSString*)userNick {
    return [UserUnit shareLogin].m_userNick;
}
+ (NSString*)userSex {
    return [UserUnit shareLogin].m_userSex;
}
+ (NSString*)userMobile {
    return [UserUnit shareLogin].m_userMobile;
}
+ (NSString*)userEmail {
    return [UserUnit shareLogin].m_userEmail;
}
+ (NSString*)userBalance {
    return [UserUnit shareLogin].m_userBalance;
}
+ (int)userOrder_all {
    return [UserUnit shareLogin].m_userAllOrder;
}
+ (int)userOrder_unpay {
    return [UserUnit shareLogin].m_userUnpayOrder;
}
+ (int)userOrder_payed {
    return [UserUnit shareLogin].m_userPayedOrder;
}
+ (int)userOrder_mallUnpay {
    return [UserUnit shareLogin].m_userMallUnpayOrder;
}
+ (int)userOrder_mallDealing {
    return [UserUnit shareLogin].m_userMallDealingOrder;
}
+ (int)userCarNum {
    
    return [UserUnit shareLogin].m_userCartNum;
}

+ (int)userHasPayPassword{
    return [UserUnit shareLogin].m_userhasPayPassword;
}

//  --.....
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
           HasPayPassword:(int) hasPayPassword
{
    [[NSUserDefaults standardUserDefaults] setBool:YES          forKey:keySellUserData_isLogin];
    [[NSUserDefaults standardUserDefaults] setBool:pUserShareSDKLogin          forKey:keySellUserData_isShareSdkLogin];
    
    [[NSUserDefaults standardUserDefaults] setObject:pUserId    forKey:keySellUserData_userId];
    [[NSUserDefaults standardUserDefaults] setObject:pUserName  forKey:keySellUserData_userName];
    [[NSUserDefaults standardUserDefaults] setObject:pUserNick  forKey:keySellUserData_userNick];
    [[NSUserDefaults standardUserDefaults] setObject:pUserSex   forKey:keySellUserData_userSex];
    [[NSUserDefaults standardUserDefaults] setObject:pUserMobile    forKey:keySellUserData_userMobile];
    [[NSUserDefaults standardUserDefaults] setObject:pUserEmail     forKey:keySellUserData_userEmail];
    [[NSUserDefaults standardUserDefaults] setObject:pBalance       forKey:keySellUserData_userBalance];
    [[NSUserDefaults standardUserDefaults] setInteger:pAllOrder     forKey:keySellUserData_userAllOrder];
    [[NSUserDefaults standardUserDefaults] setInteger:pUnpayOrder   forKey:keySellUserData_userUnpayOrder];
    [[NSUserDefaults standardUserDefaults] setInteger:pPayedOrder   forKey:keySellUserData_userPayedOrder];
    [[NSUserDefaults standardUserDefaults] setInteger:pUnpayMall    forKey:keySellUserData_userUnpayMallOrder];
    [[NSUserDefaults standardUserDefaults] setInteger:pDealingMall  forKey:keySellUserData_userDealingMallOrder];
    
    [[NSUserDefaults standardUserDefaults] setInteger:hasPayPassword  forKey:keySellUserData_userHasPayPassword];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UserUnit shareLogin].m_isLogin = YES;
    [UserUnit shareLogin].m_isShareSdkLogin = pUserShareSDKLogin;
    
    [UserUnit shareLogin].m_userId = pUserId;
    [UserUnit shareLogin].m_userName = pUserName;
    [UserUnit shareLogin].m_userNick = pUserNick;
    [UserUnit shareLogin].m_userSex = pUserSex;
    [UserUnit shareLogin].m_userMobile = pUserMobile;
    [UserUnit shareLogin].m_userEmail = pUserEmail;
    [UserUnit shareLogin].m_userBalance = pBalance;
    [UserUnit shareLogin].m_userAllOrder = pAllOrder;
    [UserUnit shareLogin].m_userUnpayOrder = pUnpayOrder;
    [UserUnit shareLogin].m_userPayedOrder = pPayedOrder;
    [UserUnit shareLogin].m_userMallUnpayOrder = pUnpayMall;
    [UserUnit shareLogin].m_userMallDealingOrder = pDealingMall;
    [UserUnit shareLogin].m_userhasPayPassword = hasPayPassword;
}


+ (void)writeTelephoneNum:(NSString*)mobileNum{
    [[NSUserDefaults standardUserDefaults] setObject:mobileNum forKey:keySellUserData_userMobile];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UserUnit shareLogin].m_userMobile = mobileNum;
}

+ (void)clearTelePhoneNum
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keySellUserData_userMobile];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UserUnit shareLogin].m_userMobile = @"";
}

+ (void)writeUserHasPayPassword:(NSInteger)num{
    [[NSUserDefaults standardUserDefaults] setInteger:num  forKey:keySellUserData_userHasPayPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UserUnit shareLogin].m_userhasPayPassword = num;

}
+ (void)clearUserHasPayPassword{
    [[NSUserDefaults standardUserDefaults] setInteger:0  forKey:keySellUserData_userHasPayPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UserUnit shareLogin].m_userhasPayPassword = 0;
}

// 注销清除相关信息
+ (void)logoutSuccess {
    
    if (self.isShareSDKLogin) {
        [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
        [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:keySellUserData_isLogin];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:keySellUserData_isShareSdkLogin];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keySellUserData_userId];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keySellUserData_userName];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keySellUserData_userNick];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keySellUserData_userSex];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keySellUserData_userMobile];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:keySellUserData_userEmail];
    [[NSUserDefaults standardUserDefaults] setInteger:0    forKey:keySellUserData_CartNum];
    [[NSUserDefaults standardUserDefaults] setFloat:0    forKey:keySellUserData_userBalance];
    [[NSUserDefaults standardUserDefaults] setInteger:0    forKey:keySellUserData_userAllOrder];
    [[NSUserDefaults standardUserDefaults] setInteger:0    forKey:keySellUserData_userUnpayOrder];
    [[NSUserDefaults standardUserDefaults] setInteger:0    forKey:keySellUserData_userPayedOrder];
    [[NSUserDefaults standardUserDefaults] setInteger:0    forKey:keySellUserData_userUnpayMallOrder];
    [[NSUserDefaults standardUserDefaults] setInteger:0    forKey:keySellUserData_userDealingMallOrder];
    
    [[NSUserDefaults standardUserDefaults] setInteger:0    forKey:keySellUserData_userHasPayPassword];

    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UserUnit shareLogin].m_isLogin = NO;
    [UserUnit shareLogin].m_isShareSdkLogin = NO;
    [UserUnit shareLogin].m_userId = @"";
    [UserUnit shareLogin].m_userName = @"";
    [UserUnit shareLogin].m_userNick = @"";
    [UserUnit shareLogin].m_userSex = @"";
    [UserUnit shareLogin].m_userMobile = @"";
    [UserUnit shareLogin].m_userEmail = @"";
    [UserUnit shareLogin].m_userBalance = @"";
    [UserUnit shareLogin].m_userAllOrder = 0;
    [UserUnit shareLogin].m_userUnpayOrder = 0;
    [UserUnit shareLogin].m_userPayedOrder = 0;
    [UserUnit shareLogin].m_userMallUnpayOrder = 0;
    [UserUnit shareLogin].m_userMallDealingOrder = 0;
    [UserUnit shareLogin].m_userCartNum = 0;
    
    [UserUnit shareLogin].m_userhasPayPassword = 0;
}

#if ! __has_feature(objc_arc)
- (void)dealloc{
    
    [m_userEmail release];
    [m_userMobile release];
    [m_userName release];
    [m_userNick release];
    [m_userSex release];
    [m_userBalance release];
    [m_userId release];
    
    [super dealloc];
}
#endif

@end
