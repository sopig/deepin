//
//  resMod_Mall_Goods.h
//  boqiimall
//
//  Created by YSW on 14-6-30.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//  --  ...................
@interface resMod_Mall_GoodsInfo : NSObject{
    int     GoodsId;
    int     GoodsSaledNum;      //--已售数量
    float   GoodsPrice;         //--现价
    float   GoodsOriPrice;      //--原价
    NSString    *   GoodsTitle;
    NSString    *   GoodsImg;
    int TypeId;                 //--分类id
    NSString    *   TypeName;   //--分类名
    int BrandId;
    NSString    *   BrandName;
    NSString    *   GoodsActionList;    //--活动列表：1，满赠 2，换购 3，满减 4，包邮 5，套餐 7折扣
    int     GoodsCommentNum;            //  商品评论数
    
    //--------------         goodDetail 添加         ---------------//
    
    NSString  *   GoodsImgList;         //  商品图片
    int GoodsIsCollected;               //  商品是否已收藏	0：没有 1：有
    NSString * GoodsTip;                //  商品提示/促销信息
    NSString * GoodsSupport;            //  商品支持类型	1、允许开箱验货    2、支持信用卡   3、上海南宁货到付款 支持多个用“，”隔开
    NSMutableArray  * GoodsPresents;    //  赠品
    NSString        * GoodsDetailUrl;   //  商品详情链接
    NSMutableArray  * GoodsParams;  //  商品参数
    float   GoodsCommentScore;      //  商品评论分数
    int     GoodsStockNum;  //  商品库存数
    int     GoodsLimitNum;  //  商品限购数
    
    int     GoodsCanBuy;    //  商品能够购买	0：不能 1：能
    int     GoodsType;      //  商品类型	: 普通商品\团购商品等
    
    NSString * CannotBuyReason; //   无法购买理由
    int     IsGroup;            //   是否为团购商品    0: 否  1: 是
    int     IsDropShopping;     //   是否为代发货商品   0: 否  1: 是

    
    //--------------         BuyedGoods 添加         ---------------//
    NSString * GoodsStatus;
    NSMutableArray * GoodsSpec;
    
    NSString *GoodsActionType;  //商品参加的活动
    
}

@property   (assign, nonatomic) int     GoodsId;
@property   (assign, nonatomic) int     GoodsSaledNum;      //--已售数量
@property   (assign, nonatomic) float   GoodsPrice;         //--现价
@property   (assign, nonatomic) float   GoodsOriPrice;      //--原价
@property   (strong, nonatomic) NSString    *   GoodsTitle;
@property   (strong, nonatomic) NSString    *   GoodsImg;
@property   (assign, nonatomic) int TypeId;                 //--分类id
@property   (strong, nonatomic) NSString    *   TypeName;   //--分类名
@property   (assign, nonatomic) int BrandId;
@property   (strong, nonatomic) NSString    *   BrandName;
@property   (strong, nonatomic) NSString    *   GoodsActionList;    //--是否有赠品
@property   (assign, nonatomic) int     GoodsCommentNum;        //  商品评论数


//--------------         goodDetail 添加         ---------------//
@property   (strong, nonatomic) NSString  *   GoodsImgList;   //  商品图片
@property   (assign, nonatomic) int GoodsIsCollected;               //  商品是否已收藏	0：没有 1：有
@property   (strong, nonatomic) NSString * GoodsTip;                //  商品提示/促销信息
@property   (strong, nonatomic) NSString * GoodsSupport;
@property   (strong, nonatomic) NSMutableArray  * GoodsPresents;    //  赠品
@property   (strong, nonatomic) NSString        * GoodsDetailUrl;   //  商品详情链接
@property   (strong, nonatomic) NSMutableArray  * GoodsParams;  //  商品参数
@property   (assign, nonatomic) float   GoodsCommentScore;      //  商品评论分数
@property   (assign, nonatomic) int     GoodsStockNum;  //  商品库存数
@property   (assign, nonatomic) int     GoodsLimitNum;  //  商品限购数
@property   (assign, nonatomic) int     GoodsCanBuy;    //  商品能够购买	0：不能 1：能
@property   (assign, nonatomic) int     GoodsType;      //  商品类型	: 普通商品\团购商品等
@property   (strong, nonatomic) NSString * CannotBuyReason; //   无法购买理由
@property   (assign, nonatomic) int     IsGroup;            //   是否为团购商品    0: 否  1: 是
@property   (assign, nonatomic) int     IsDropShopping;     //   是否为代发货商品   0: 否  1: 是
@property   (strong,nonatomic) NSString *GoodsActionType;

//--------------         BuyedGoods 添加         ---------------//
@property   (strong, nonatomic) NSString * GoodsStatus;         //商品状态
@property   (strong, nonatomic) NSMutableArray * GoodsSpec;     //商品规格

-(instancetype)initWithDic:(NSDictionary*)dic;
@end




/******************************************************
 ---------        商品属性
 ******************************************************
 */
@interface resMod_Mall_ProductProperty : NSObject{
    NSString    * Key;
    NSString    * Value;
}
@property   (strong, nonatomic) NSString * Key;
@property   (strong, nonatomic) NSString * Value;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end;

/******************************************************
 ---------        赠品
 ******************************************************
 */
@interface resMod_Mall_PresentInfo : NSObject{
    int PresentId;                  //Int	赠品id
    NSString    * PresentImg;       //String	赠品图片
    NSString    * PresentTitle;     //String	赠品标题
    int PresentNum;                 //Int	赠品数量
}
@property   (assign, nonatomic) int PresentId;                //  商品提示/促销信息
@property   (strong, nonatomic) NSString * PresentImg;
@property   (strong, nonatomic) NSString * PresentTitle; //  赠品
@property   (assign, nonatomic) int PresentNum;  //  商品参数

-(instancetype)initWithDic:(NSDictionary*)dic;
@end;



/******************************************************
 ---------        return    list : call back
 ******************************************************
 */
@interface resMod_CallBackMall_GoodsList: NSObject{
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
 ---------        return    Detail : call back
 ******************************************************
 */
@interface resMod_CallBackMall_GoodsDetail: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_Mall_GoodsInfo * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) resMod_Mall_GoodsInfo * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


