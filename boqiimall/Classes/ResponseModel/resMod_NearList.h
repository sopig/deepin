//
//  resMod_NearList.h
//  BoqiiLife
//
//  Created by YSW on 14-5-5.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

/******************************************************
 ---------       ticket info    : 券列表
 ******************************************************
 */
@interface resMod_NearTicketInfo : NSObject{

    int TicketId;
    NSString * TicketTitle;
    NSString * TicketImg;
    float TicketPrice;
    float TicketOriPrice;
    NSString * Distance;
    NSString * RoadName;

}
@property (assign,nonatomic) int TicketId;
@property (retain,nonatomic) NSString * TicketTitle;
@property (retain,nonatomic) NSString * TicketImg;
@property (assign,nonatomic) float TicketPrice;
@property (assign,nonatomic) float TicketOriPrice;
@property (retain,nonatomic) NSString * Distance;
@property (retain,nonatomic) NSString * RoadName;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

/******************************************************
 ---------        Merchant  info    :商户列表
 ******************************************************
 */
@interface resMod_NearMerchantInfo : NSObject{
    
    NSString * MerchantId;
    NSString * MerchantTitle;
    NSString * MerchantAddress;
    NSString * MerchantTele;
    NSString * MerchantLat;
    NSString * MerchantLng;
}
@property (strong,nonatomic) NSString * MerchantId;
@property (strong,nonatomic) NSString * MerchantTitle;
@property (strong,nonatomic) NSString * MerchantAddress;
@property (strong,nonatomic) NSString * MerchantTele;
@property (strong,nonatomic) NSString * MerchantLat;
@property (strong,nonatomic) NSString * MerchantLng;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

/******************************************************
 ---------        responseData
 ******************************************************
 */
@interface resMod_NearResponseData : NSObject{
    
    NSMutableArray * Ticketlist;
    NSMutableArray * MerchantList;
}
@property (strong,nonatomic) NSMutableArray * Ticketlist;
@property (strong,nonatomic) NSMutableArray * MerchantList;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

/******************************************************
 ---------       return: response  data
 ******************************************************
 */
@interface resMod_CallBack_TicketListByMerchant: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

/******************************************************
 ---------       return: response  data
 ******************************************************
 */
@interface resMod_CallBack_NearList: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_NearResponseData * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) resMod_NearResponseData * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end




