//
//  resMod_MyTicketDetail.h
//  BoqiiLife
//
//  Created by YSW on 14-5-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>


//  -- my ticket info   ：适用于个人中心
@interface  resMod_MyTicketDetailInfo : NSObject{
    int TicketID;
    NSString * TicketTitle;
    NSString * TicketImg;
    NSString * MyTicketDetail;
    NSString * MyTicketRemind;
    float TicketPrice;
}

@property (assign,nonatomic) int TicketID;
@property (retain,nonatomic) NSString * TicketTitle;
@property (retain,nonatomic) NSString * TicketImg;
@property (retain,nonatomic) NSString * MyTicketDetail;
@property (retain,nonatomic) NSString * MyTicketRemind;
@property (assign,nonatomic) float TicketPrice;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  -- my ticketMerchant info   ：适用于个人中心
@interface  resMod_MyTicketDetailMerchantInfo : NSObject{
    int MerchantId;
    NSString * MerchantName;
    NSString * MerchantAddress;
    float MerchantDistance;
    NSString * MerchantTele;
}

@property (assign,nonatomic) int MerchantId;
@property (retain,nonatomic) NSString * MerchantName;
@property (retain,nonatomic) NSString * MerchantAddress;
@property (assign,nonatomic) float MerchantDistance;
@property (retain,nonatomic) NSString * MerchantTele;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  -- my ticketDetail
@interface resMod_MyTicketDetail : NSObject{
    resMod_MyTicketDetailInfo * TicketInfo;
    NSString * MyTicketNo;
    NSString * MyTicketStatus;
    resMod_MyTicketDetailMerchantInfo *TicketMerchant;
    NSString * MyTicketRemind;
    NSInteger HasOtherMerchant;
    
    
}
@property(nonatomic,assign)NSInteger HasOtherMerchant;
@property (retain,nonatomic) resMod_MyTicketDetailInfo * TicketInfo;
@property (retain,nonatomic) NSString * MyTicketNo;
@property (retain,nonatomic) NSString * MyTicketStatus;
@property (retain,nonatomic) resMod_MyTicketDetailMerchantInfo * TicketMerchant;
@property (retain,nonatomic) NSString * MyTicketRemind;

@property (nonatomic,readwrite,assign)int IsCommented;      //增加字段
@property (nonatomic,readwrite,assign)int IsUsed; //增加字段 是否使用过
@property (nonatomic,readwrite,assign)float MyTicketPrice;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end







/******************************************************
 ---------        MyTicketDetail CallBack
 ******************************************************
 */
@interface resMod_CallBack_GetMyTicketDetail : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_MyTicketDetail * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_MyTicketDetail * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



