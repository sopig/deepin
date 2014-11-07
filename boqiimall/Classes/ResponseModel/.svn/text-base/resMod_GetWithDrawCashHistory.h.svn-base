//
//  resMod_GetWithDrawCashHistory.h
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-22.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_GetWithDrawCashHistory : NSObject

@property(nonatomic,readwrite,strong)NSString *AccountType;
@property(nonatomic,readwrite,strong)NSString *Cash;
@property(nonatomic,readwrite,strong)NSString *Time;
@property(nonatomic,readwrite,strong)NSString *Status;
@property(nonatomic,readwrite,strong)NSString *Remarks;

- (instancetype)initWithDic:(NSDictionary*)dic;

@end



@interface resMod_CallBack_GetWithDrawCashHistory : NSObject {
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
