//
//  resMod_QueryOrder.h
//  boqiimall
//
//  Created by 张正超 on 14-8-29.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_QueryOrder : NSObject

@property (nonatomic,readwrite,assign)int ResultCode;

- (instancetype)initWithDic:(NSDictionary*)dic;


@end



@interface resMod_CallBack_QueryOrder : NSObject {
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_QueryOrder * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_QueryOrder * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
