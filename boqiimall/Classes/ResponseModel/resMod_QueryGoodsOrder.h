//
//  resMod_QueryGoodsOrder.h
//  boqiimall
//
//  Created by 张正超 on 14-8-29.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_QueryGoodsOrder : NSObject

@property (nonatomic,readwrite,assign)int ResultCode;

- (instancetype)initWithDic:(NSDictionary*)dic;

@end




@interface resMod_CallBack_QueryGoodsOrder : NSObject {
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_QueryGoodsOrder * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_QueryGoodsOrder * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
