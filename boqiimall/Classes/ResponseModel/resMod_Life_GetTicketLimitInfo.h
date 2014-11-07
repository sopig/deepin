//
//  resMod_Life_GetTicketLimitInfo.h
//  boqiimall
//
//  Created by 波奇-xiaobo on 14-9-1.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_Life_GetTicketLimitInfo : NSObject
@property(retain,nonatomic)NSString *currentNum;
@property(retain,nonatomic)NSString *totalPrice;
@property(retain,nonatomic)NSString *price;
@property(strong,nonatomic)NSString *Information;

-(instancetype)initWithDic:(NSDictionary*)dic;

@end



/******************************************************
 ---------        return  : call back
 ******************************************************
 */
@interface resMod_CallBackMall_Life_GetTicketLimitInfo: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_Life_GetTicketLimitInfo * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_Life_GetTicketLimitInfo * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end