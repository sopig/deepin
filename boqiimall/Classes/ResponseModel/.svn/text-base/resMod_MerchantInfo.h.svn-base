//
//  resMod_MerchantInfo.h
//  BoqiiLife
//
//  Created by YSW on 14-5-12.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>


/******************************************************
 ---------        Merchant  info    :商户信息
 ******************************************************
 */
@interface resMod_MerchantInfo : NSObject{
    
    int   MerchantId;
    float AverageComsume;           // 人均消费.
    int   ScanNumbers;              // 浏览次数.
    NSString * MerchantImg;
    NSString * MerchantTitle;
    NSString * MerchantAddress;
    NSString * MerchantTele;    //商户电话.
    NSString * MerchantLat;     //商户纬度.
    NSString * MerchantLng;     //商户经度.
    
    NSString * Distance;        //距离.
    NSString * BusinessArea;    //商圈.
    NSString * Characteristic;  //是否有券，是否检疫     0,无，1,券，2,疫，如果1,2都有，用“，“隔开，即返回“1,2”

    
    //  --  detail 扩展属情
    int ScanNumber;
    NSString * MerchantName;        //商户名字
    float      MerchantDistance;    //商户距离
    float      ConsumePerPerson;    //人均消费
    NSMutableArray *    TicketList; //服务券列表
    NSString *  MerchantDesc;       //商户介绍
    NSString *  MerchantTraffic;    //交通信息
    NSString *  MerchantNear;       //周边小区
    NSString *  MerchantServeUrl;   //服务页面url
}

@property (assign,nonatomic) int MerchantId;
@property (assign,nonatomic) float  AverageComsume;
@property (assign,nonatomic) int    ScanNumbers;
@property (retain,nonatomic) NSString * MerchantImg;
@property (retain,nonatomic) NSString * MerchantTitle;
@property (retain,nonatomic) NSString * MerchantAddress;
@property (retain,nonatomic) NSString * MerchantTele;
@property (retain,nonatomic) NSString * MerchantLat;
@property (retain,nonatomic) NSString * MerchantLng;

@property (retain,nonatomic) NSString * Distance;
@property (retain,nonatomic) NSString * BusinessArea;
@property (retain,nonatomic) NSString * Characteristic;


@property (retain,nonatomic) NSString * MerchantName;
@property (assign,nonatomic) float  MerchantDistance;
@property (assign,nonatomic) float  ConsumePerPerson;       //人均消费
@property (assign,nonatomic) int    ScanNumber;       //人均消费
@property (retain,nonatomic) NSMutableArray * TicketList;   //服务券列表
@property (retain,nonatomic) NSString * MerchantDesc;       //商户介绍
@property (retain,nonatomic) NSString * MerchantTraffic;    //交通信息
@property (retain,nonatomic) NSString * MerchantNear;       //周边小区
@property (retain,nonatomic) NSString * MerchantServeUrl;   //服务页面url

@property (nonatomic,assign)int CommentNum; // 评论数


-(instancetype)initWithDic:(NSDictionary*)dic;
@end






/******************************************************
 ---------       CallBack Merchant List: response  data
 ******************************************************
 */
@interface resMod_CallBack_MerchantList: NSObject{
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
 ---------       CallBack Ticket Detail: response  data
 ******************************************************
 */
@interface resMod_CallBack_MerchantDetail: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_MerchantInfo * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_MerchantInfo * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end





