//
//  resMod_UserInfo.m
//  BoqiiLife
//
//  Created by YSW on 14-5-5.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "resMod_UserInfo.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h" 

@implementation resMod_UserInfo
@synthesize UserId;
@synthesize NickName;
@synthesize Balance;
@synthesize AllOrderNum;
@synthesize UnpayOrderNum;
@synthesize PayedOrderNum;
@synthesize ShoppingMallDealingNum;
@synthesize ShoppingMallUnpayNum;
@synthesize Sex;
@synthesize Telephone,HasPayPassword;
@synthesize Token;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.UserId = [dic ConvertStringForKey:@"UserId"];
        self.NickName = [dic ConvertStringForKey:@"NickName"];
        self.Balance = [[dic ConvertStringForKey:@"Balance"] floatValue];
        self.AllOrderNum = [[dic ConvertStringForKey:@"AllOrderNum"] intValue];
        self.UnpayOrderNum = [[dic ConvertStringForKey:@"UnpayOrderNum"] intValue];
        self.PayedOrderNum = [[dic ConvertStringForKey:@"PayedOrderNum"] intValue];
        self.ShoppingMallDealingNum = [[dic ConvertStringForKey:@"ShoppingMallDealingNum"] intValue];
        self.ShoppingMallUnpayNum = [[dic ConvertStringForKey:@"ShoppingMallUnpayNum"] intValue];
        self.Sex = [dic ConvertStringForKey:@"Sex"];
        self.Telephone = [dic ConvertStringForKey:@"Telephone"];
        self.HasPayPassword = [[dic ConvertStringForKey:@"HasPayPassword"] intValue];
        self.Token = [dic ConvertStringForKey:@"Token"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void)dealloc{
    [UserId    release];
    [NickName  release];
    [Sex       release];
    [Telephone release];
    [Token release];
    [super dealloc];
}
#endif
@end


@implementation resMod_CallBack_LoginOrRegister
@synthesize ResponseStatus;
@synthesize ResponseMsg;
@synthesize ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_UserInfo alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}


#if ! __has_feature(objc_arc)
-(void)dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end




