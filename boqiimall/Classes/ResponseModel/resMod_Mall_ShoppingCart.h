//
//  resMod_Mall_ShoppingCart.h
//  boqiimall
//
//  Created by YSW on 14-7-16.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>


//  --  购物车数量
@interface resMod_GetShoppingCartNum : NSObject
@property   (assign, nonatomic) int Number;
-(instancetype)initWithDic:(NSDictionary*)dic;
@end




/******************************************************
 ---------        Cartinfo
 ******************************************************
 */
@interface resMod_Mall_ShoppingCart : NSObject
@property   (strong, nonatomic) NSString    *   TipFront;   //	String	运费说明前部分
@property   (strong, nonatomic) NSString    *   TipMiddle;  //	String	运费说明
@property   (assign, nonatomic) float   TipMoneyFront;  //	Float	运费说明金额前半部分
@property   (assign, nonatomic) float   TipMoneyBack;   //	Float	运费说明金额后半部分
@property   (assign, nonatomic) float   NeedToPay;      //	Float	应付金额
@property   (assign, nonatomic) float   Preferential;   //	Float	已优惠
@property   (strong, nonatomic) NSMutableArray  * GoodsList;    //	--  JsonArray	商品列表 (老数据格式)
@property   (strong, nonatomic) NSMutableArray  * GroupList;    //	--  JsonArray	组合商品列表 (包含活动新数据格式)

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



/******************************************************
 ---------        组合信息
 ******************************************************
 */
@interface resMod_Mall_ShoppingCartGroupList : NSObject
@property (strong, nonatomic) NSMutableArray    * GoodsList;        // 商品列表
@property (strong, nonatomic) NSMutableArray    * PreferentialInfo; // 优惠列表
@property (strong, nonatomic) NSString          * ActionResult;     // 活动结果
@property (assign, nonatomic) int   ActionId;       //	活动id	没有传0
@property (assign, nonatomic) float GroupPrice;     //	组合金额

-(instancetype)initWithDic:(NSDictionary*)dic;
@end




/******************************************************
 ---------        商品信息
 ******************************************************
 */
@interface resMod_Mall_ShoppingCartGoodsInfo : NSObject
@property (assign, nonatomic) int GoodsId;              //	Int	商品id
@property (strong, nonatomic) NSString  * GoodsImg;     //	String	商品图片
@property (strong, nonatomic) NSString  * GoodsTitle;   //	String	商品标题
@property (assign, nonatomic) float GoodsPrice;         //	Float	商品价格
@property (assign, nonatomic) int GoodsNum;             //	Int	商品数量
@property (assign, nonatomic) int GoodsLimit;           //  Int	商品限购数量
@property (strong, nonatomic) NSMutableArray  *GoodsSpec;//	JsonArray	商品规格	表2
@property (strong, nonatomic) NSMutableArray  *GoodsPresents;   //	JsonArray	赠品列表	表3
@property (assign, nonatomic) int GoodsType;                    //	Int	商品类型	普通商品\团购商品等
@property (strong, nonatomic) NSString  * GoodsSpecId;          //	String	商品规格

@property (assign, nonatomic) int   IsSelected;                 //	Int	是否选中	1：选中 0：未选中
@property (strong, nonatomic) NSMutableArray  *PreferentialInfo;//	JsonArray	优惠列表	表6
@property (assign, nonatomic) int   ChangeBuyId;                //	Int	已选中换购id	没有传0
@property (assign, nonatomic) int   ActionId;                   //	Int	已选中活动id	没有传0
@property (assign, nonatomic) int   IsChangeBuy;                //	Int	是否可换购	1：是 0：否
@property (assign, nonatomic) int   IsPreferential;             //	Int	是否可更换优惠	1：是 0：否
@property (assign, nonatomic) int   IsClickable;                //  是够可点,如商品因为下架，无库存，是不能下单的
@property (strong, nonatomic) NSString  *ReasonForCannotOperate;//  不可操作的理由
@property (strong, nonatomic) NSString  *ActionResult;          //	String	活动结果	1.00元换购…（活动为换购时，默认换购第一个）
@property (assign, nonatomic) long long  TimeStamp;             //  Long	时间戳

//  -- 购物车列表 操作扩展用到。。。。。。
@property   (assign, nonatomic) BOOL    b_isChecked;    // 用于标识 是否处于选中状态
@property   (assign, nonatomic) BOOL    b_isShowGift;   // 用于标识 是否展开赠品

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        商品属性
 ******************************************************
 */
@interface resMod_Mall_CartGoodsProperty : NSObject
@property   (strong, nonatomic) NSString * Key;
@property   (strong, nonatomic) NSString * Value;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end;



/******************************************************
 ---------        活动组优惠列表 or 单品优惠列表
 ******************************************************
 */
@interface resMod_Mall_CartPreferentialInfo : NSObject
@property   (assign, nonatomic) int ActionId;               //  活动类型	: 1满减 2折扣 3折扣价 4多买优惠 5赠品 6团购 7满赠
@property   (strong, nonatomic) NSString * ActionTitle;     //  活动说明

-(instancetype)initWithDic:(NSDictionary*)dic;
@end;





/******************************************************
 ---------        赠品
 ******************************************************
 */
@interface resMod_Mall_CartPresentInfo : NSObject
@property   (assign, nonatomic) int PresentId;                //  商品提示/促销信息
@property   (strong, nonatomic) NSString * PresentImg;
@property   (assign, nonatomic) int PresentNum;  //  商品参数

-(instancetype)initWithDic:(NSDictionary*)dic;
@end;



/******************************************************
 ---------        换购信息
 ******************************************************
 */
@interface resMod_Mall_CartChangeBuyInfo : NSObject
@property   (assign, nonatomic) int CurrentActionId;            //当先换购对应的活动id
@property   (assign, nonatomic) int ChangeBuyId;                //Int	换购id
@property   (strong, nonatomic) NSString * ChangeBuyTitle;      //String	换购标题
@property   (strong, nonatomic) NSString * ChangeBuyImg;        //String	换购图片地址
@property   (assign, nonatomic) float ChangeBuyPrice;           //Float	换购价
@property   (assign, nonatomic) float ChangeBuyOriPrice;        //Float	原价
@property   (assign, nonatomic) int   IsCanChange;              //int 是否可更换
@property   (strong, nonatomic) NSString * ReasonForNotChange;  //如果不能更换换购的理由，如下架，库存不足情况

-(instancetype)initWithDic:(NSDictionary*)dic;
@end;




/******************************************************
 ---------        换购及优惠列表
 ******************************************************
 */
@interface resMod_Mall_CartChangeBuyList : NSObject
@property   (strong, nonatomic) NSMutableArray * ChangeBuyList;     //JsonArray	换购列表
@property   (strong, nonatomic) NSMutableArray * ActionList;        //JsonArray	活动列表

-(instancetype)initWithDic:(NSDictionary*)dic;
@end;


/******************************************************
 ---------        return  : call back  获取换购及优惠列表
 ******************************************************
 */
@interface resMod_CallBackMall_CartChangeBuyList: NSObject
@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) resMod_Mall_CartChangeBuyList * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        return  : call back  购物车数量
 ******************************************************
 */
@interface resMod_CallBackMall_CartNum: NSObject
@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) resMod_GetShoppingCartNum * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



/******************************************************
 ---------        return  : call back  购物车
 ******************************************************
 */
@interface resMod_CallBackMall_ShoppingCart: NSObject
@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) resMod_Mall_ShoppingCart * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


