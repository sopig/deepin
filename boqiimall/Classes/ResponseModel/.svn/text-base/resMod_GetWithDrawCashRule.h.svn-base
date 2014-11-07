//
//  resMod_GetWithDrawCashRule.h
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-22.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "ResponseBase.h"

@interface resMod_GetWithDrawCashRule : NSObject

@property(nonatomic,readwrite,assign)float AvailableCash;
@property(nonatomic,readwrite,strong)NSString *Rule;
@property(nonatomic,readwrite,assign)int IsWithDrawCash;

- (instancetype)initWithDic:(NSDictionary*)dic;

@end


@interface resMod_CallBack_GetWithDrawCashRule : NSObject {
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_GetWithDrawCashRule * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_GetWithDrawCashRule * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
