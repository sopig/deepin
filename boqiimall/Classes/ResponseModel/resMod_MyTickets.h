//
//  resMod_MyTickets.h
//  BoqiiLife
//
//  Created by YSW on 14-5-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>


/******************************************************
 ---------        MyTicketList CallBack
 ******************************************************
 */
@interface resMod_MyTicketInfo : NSObject{
    int MyTicketId;
    NSString * MyTicketTitle;
    float MyTicketPrice;
    NSString * MyTicketImg;
    int MyTicketStatus;
    NSString * MyTicketNo;
}

@property (assign,nonatomic) int  MyTicketId;
@property (retain,nonatomic) NSString * MyTicketTitle;
@property (assign,nonatomic) float MyTicketPrice;
@property (retain,nonatomic) NSString * MyTicketImg;
@property (assign,nonatomic) int MyTicketStatus;
@property (retain,nonatomic) NSString * MyTicketNo;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        MyTicketList CallBack
 ******************************************************
 */
@interface resMod_CallBack_MyTicketList : NSObject {
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end