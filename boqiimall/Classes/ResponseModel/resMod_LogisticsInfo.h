//
//  resMod_LogisticsInfo.h
//  boqiimall
//
//  Created by ysw on 14-8-29.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//  ......
@interface resMod_LogisticsContent : NSObject
@property (retain,nonatomic) NSString * Content;
@end





/******************************************************
 ---------       call back : 物 流 信 息
 ******************************************************
 */
@interface resMod_CallBack_LogisticsContent : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_LogisticsContent * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_LogisticsContent * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end