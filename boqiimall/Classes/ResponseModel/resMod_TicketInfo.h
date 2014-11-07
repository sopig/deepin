//
//  resMod_TicketInfo.h
//  BoqiiLife
//
//  Created by YSW on 14-5-12.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "resMod_MerchantInfo.h"

/******************************************************
 ---------       ticket info    : 券列表
 ******************************************************
 */
@interface resMod_TicketInfo : NSObject{
    int TicketId;
    NSString * TicketTitle;
    NSString * TicketImg;
    float TicketPrice;          //现价.
    float TicketOriPrice;       //原价.
    float Distance;             //距离.
    NSString * RoadName;
    NSString * BusinessArea;    //商圈.
    resMod_MerchantInfo * MerchantInfo ;    //---1.0添加，用于服务点击时进入附近地图
    
    
    /*******    下面是 Ticket Detail 添加的数据   *********/
    NSString *  ImageList;      //图片地址列表  多个“,”分隔.
    NSString *  TicketLimit;    //服务券限购信息.
    int IsCollected;            //是否收藏
    int TicketLimitNumber;      //限购数量.
    NSString *  TicketDesc;     //服务券说明.
    int TicketBuyed;            //已购买人数.
    int TicketRemain;           //剩余时间.   单位为妙  返回时间差
    resMod_MerchantInfo * TicketMerchant;   //商户信息.
    NSString *  TicketDetail;   //服务券详情.
    NSString *  TicketRemind;   //特别提醒.
    NSString *  TicketShowUrl;  //项目展示页面url
    NSString *  TicketSale;     //折扣信息
    NSInteger HasOtherMerchant;
}
@property (assign,nonatomic) int TicketId;
@property (retain,nonatomic) NSString * TicketTitle;
@property (retain,nonatomic) NSString * TicketImg;
@property (assign,nonatomic) float TicketPrice;
@property (assign,nonatomic) float TicketOriPrice;
@property (assign,nonatomic) float Distance;
@property (retain,nonatomic) NSString * RoadName;
@property (retain,nonatomic) NSString * BusinessArea;
@property (retain,nonatomic) resMod_MerchantInfo * MerchantInfo;

/*******    下面是 Ticket detail 添加的数据   *********/
@property (retain,nonatomic) NSString * ImageList;
@property (retain,nonatomic) NSString * TicketLimit;
@property (assign,nonatomic) int    IsCollected;
@property (assign,nonatomic) int    TicketLimitNumber;
@property (retain,nonatomic) NSString * TicketDesc;
@property (assign,nonatomic) int    TicketBuyed;
@property (assign,nonatomic) int    TicketRemain;
@property (retain,nonatomic) resMod_MerchantInfo * TicketMerchant;
@property (nonatomic,assign) NSInteger HasOtherMerchant;
@property (retain,nonatomic) NSString * TicketDetail;
@property (retain,nonatomic) NSString * TicketRemind;
@property (retain,nonatomic) NSString * TicketShowUrl;
@property (retain,nonatomic) NSString * TicketSale;

@property (nonatomic,readwrite,assign)int CommentNum;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



/******************************************************
 ---------       Ticket List: response  data
 ******************************************************
 */
@interface resMod_CallBack_TicketList: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end




/******************************************************
 ---------       Ticket Detail: response  data
 ******************************************************
 */
@interface resMod_CallBack_TicketDetail: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_TicketInfo * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_TicketInfo * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
