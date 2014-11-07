//
//  resMod_MyCollections.h
//  BoqiiLife
//
//  Created by YSW on 14-5-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

/******************************************************
 ---------       商城 商品 MyCollection Info
 ******************************************************
 */
@interface resMod_ProductCollectionInfo : NSObject{
    int GoodsId;        //	Int	商品id
    NSString * GoodsImg;        //	String	商品图片
    NSString * GoodsTitle;      //	String	商品标题
    int GoodsHasPresent; //	Int	是否有赠品	0：没有 1：有
    float GoodsPrice;      //	Float	现价
    float GoodsOriPrice;   //	Float	原价
    int GoodsCollected;  //	Int	收藏数量
    int IsUnderCarriage; //	Int	是否已下架	0：没有 1：有
}

@property (assign,nonatomic) int GoodsId;        //	Int	商品id
@property (retain,nonatomic) NSString * GoodsImg;        //	String	商品图片
@property (retain,nonatomic) NSString * GoodsTitle;      //	String	商品标题
@property (assign,nonatomic) int GoodsHasPresent; //	Int	是否有赠品	0：没有 1：有
@property (assign,nonatomic) float GoodsPrice;      //	Float	现价
@property (assign,nonatomic) float GoodsOriPrice;   //	Float	原价
@property (assign,nonatomic) int GoodsCollected;  //	Int	收藏数量
@property (assign,nonatomic) int IsUnderCarriage; //	Int	是否已下架	0：没有 1：有

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



/******************************************************
 ---------      生活馆 服务券  MyCollection Info
 ******************************************************
 */
@interface resMod_MyCollectionInfo : NSObject{
    int TicketId;
    NSString * TicketTitle;
    float TicketPrice;
    float TicketOriPrice;
    NSString *TicketImg;
    NSString *TicketStatus;
    NSString *msg;
}

@property (assign,nonatomic) int TicketId;
@property (retain,nonatomic) NSString * TicketTitle;
@property (assign,nonatomic) float TicketPrice;
@property (assign,nonatomic) float TicketOriPrice;
@property (retain,nonatomic) NSString * TicketImg;
@property (retain,nonatomic) NSString * TicketStatus;
@property (retain,nonatomic) NSString * msg;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end





/******************************************************
 ---------        商城 产品 CallBack
 ******************************************************
 */
@interface resMod_CallBack_ProductCollectionList : NSObject{
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
 ---------       生活馆 MyCollection CallBack
 ******************************************************
 */
@interface resMod_CallBack_GetMyCollectionList : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end





