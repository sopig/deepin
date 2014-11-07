//
//  resMod_Mall_SettleAccounts.m
//  boqiimall
//
//  Created by YSW on 14-7-8.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_SettleAccounts.h"
#import "NSDictionary+JudgeObj.h"

@implementation resMod_Mall_SettleAccounts
@synthesize AddressInfo;
@synthesize GoodsTotalMoney;
@synthesize Preferential;
@synthesize DropShoppingInfoTitle;
@synthesize DropShoppingInfoTop;
@synthesize DropShoppingInfoBottom;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
 
        self.AddressInfo = [[resMod_AddressInfo alloc] initWithDic:[dic ConvertDictForKey:@"AddressInfo"]];
        self.GoodsTotalMoney  = [[dic ConvertStringForKey:@"GoodsTotalMoney"] floatValue];
        self.Preferential = [[dic ConvertStringForKey:@"Preferential"] floatValue];
        
        self.DropShoppingInfoTitle  = [dic ConvertStringForKey:@"DropShoppingInfoTitle"];
        self.DropShoppingInfoTop    = [dic ConvertStringForKey:@"DropShoppingInfoTop"];
        self.DropShoppingInfoBottom = [dic ConvertStringForKey:@"DropShoppingInfoBottom"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [AddressInfo release];
    [DropShoppingInfoTitle release];
    [DropShoppingInfoTop release];
    [DropShoppingInfoBottom release];
    [super dealloc];
}
#endif
@end







//  --..................
@implementation resMod_CallBackMall_SettleAccounts
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_Mall_SettleAccounts  alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
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
