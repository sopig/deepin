//
//  resMod_Life_ticketCommentDetail.h
//  boqiimall
//
//  Created by 张正超 on 14-7-17.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_Life_ticketCommentDetail : NSObject
@property(nonatomic,readwrite,assign)float ProfessionalScore;
@property(nonatomic,readwrite,assign)float EnvironmentScore;
@property(nonatomic,readwrite,assign)float AttitudeScore;
@property(nonatomic,readwrite,assign)float PriceScore;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end





/******************************************************
 ---------       call back
 ******************************************************
 */
@interface resMod_CallBack_ticketCommentDetail : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_Life_ticketCommentDetail * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_Life_ticketCommentDetail * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end