//
//  resMod_Mall_SettleAccounts.h
//  boqiimall
//
//  Created by YSW on 14-7-8.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "resMod_Address.h"

@interface resMod_Mall_SettleAccounts : NSObject
@property (strong,nonatomic) resMod_AddressInfo * AddressInfo;
@property (assign,nonatomic) float GoodsTotalMoney;
@property (assign,nonatomic) float Preferential;

@property (strong,nonatomic) NSString *DropShoppingInfoTop;     //	String	代发货信息(上半部)
@property (strong,nonatomic) NSString *DropShoppingInfoBottom;  //	String	代发货信息(下半部)
@property (strong,nonatomic) NSString *DropShoppingInfoTitle;   //	String	代发货

-(instancetype)initWithDic:(NSDictionary*)dic;
@end








/******************************************************
 ---------        return  : call back
 ******************************************************
 */
@interface resMod_CallBackMall_SettleAccounts: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_Mall_SettleAccounts * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_Mall_SettleAccounts * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end