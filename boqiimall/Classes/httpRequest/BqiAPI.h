//
//  ULeAPI.h
//  Ule
//
//  Created by ysw on 14-04-21.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

//--    请求环境：商城或生活馆
//typedef enum {
//    api_ONLYURL,
//    api_BOQIIMALL,
//    api_BOQIILIFE
//} EnvApiHost;



// modify by tolly
typedef NS_ENUM(NSUInteger, EnvApiHost) {
    api_ONLYURL,
    api_BOQIIMALL,
    api_BOQIILIFE,
};

/*************************  host Url  *************************/

#define kApiUrl(envApiHost)        (envApiHost==api_BOQIILIFE ? @"mobileApi":@"")


/***********************************************************************
 *
 *                  接 口 方 法 名   :   波奇商城
 *
 ***********************************************************************/

//  ------------    商城首页...........
#define kApiMethod_Mall_HomeData                @"GetShoppingMallHomeData"              //--商城首页

//  ------------    商品 分类...........
#define kApiMethod_Mall_Classification          @"GetShoppingMallCategoryType"          //--商城分类 一，二，三级分类

#define kApiMethod_Mall_GoodsList               @"GetShoppingMallGoodsList"             //--商城商品列表数据

#define kApiMethod_Mall_GoodsDetail             @"GetShoppingMallGoodsDetail"           //--商城商品详细数据

#define kApiMethod_Mall_GoodsCommentList        @"GetShoppingMallGoodsCommentList"      //--商城商品评论数据

#define kApiMethod_Mall_GoodsSpec               @"GetShoppingMallGoodsSpec"             //--获取商城商品规格组合详细数据

//  ------------    购物车.
#define kApiMethod_Mall_CartNum                 @"GetShoppingCartNumber"                //--获取购物车商品数量

#define kApiMethod_Mall_CartDetail              @"GetShoppingCartDetail"                //--商城购物车商品信息
#define kApiMethod_Mall_CartDetailV2            @"GetShoppingCartDetailV2"              //--商城购物车商品信息(活动组合)

#define kApiMethod_Mall_CartMoney               @"GetShoppingCartMoneyInfo"             //--购物车金额信息

#define kApiMethod_Mall_AddCart                 @"AddToShoppingCart"                    //--添加商品到购物车

#define kApiMethod_Mall_DeleteCartGoods         @"DeleteShoppingCartGoods"              //--删除购物车商品

#define kApiMethod_Mall_ModifyCartGoodsNumber   @"ModifyShoppingCartGoodsNumber"        //--修改购物车商品数量

#define kApiMethod_Mall_GetChangeBuyList        @"GetChangeBuyList"                     //--获取换购及优惠列表

#define kApiMethod_Mall_ChangeBuyGoods          @"ChangeBuyGoods"                       //--更换换购或优惠

#define kApiMethod_Mall_GetChangeBuyList        @"GetChangeBuyList"                     //--获取换购及优惠列表

#define kApiMethod_Mall_ChangeBuyGoods          @"ChangeBuyGoods"                       //--更换换购或优惠



//  ------------    订单.
#define kApiMethod_Mall_SettleAccounts          @"SettleAccounts"                       //--订单结算信息

#define kApiMethod_Mall_GetCouponListCanUse     @"GetShoppingMallCoupon"                //--获取商城未使用的优惠券

#define kApiMethod_Mall_CheckCoupon             @"CheckCoupon"                          //--接口说明：验证优惠券

#define kApiMethod_Mall_GetPaymentAndExpressageListByAddress @"GetPaymentAndExpressageListByAddress" //--收获地址获取支付和配送方式

#define kApiMethod_Mall_GetOrderAmountDetail    @"GetOrderAmountDetail"                 //--订单 结算 资金明细

#define kApiMethod_Mall_CreateOrder             @"CommitGoodsOrder"                     //--订单 提交

#define kApiMethod_Mall_OrderPay                @"PayGoodsOrder"                        //--订单 支付

#define kApiMethod_Mall_GetAreaData             @"GetAreaData"                          //--省 市 区

#define kApiMethod_Mall_OrderList               @"GetMyGoodsOrderList"                  //--获取我的商城订单列表

#define kApiMethod_Mall_MallOrderDetail         @"GetShoppingMallOrderDetail"           //--获取商城订单详情

#define kApiMethod_Mall_GetMyBuyedGoodsList     @"GetMyBuyedGoodsList"                  //--获取我购买的商品列表

#define kApiMethod_Mall_GetGoodsForOrderComment @"GetMyGoodsOrderComment"               //--获取商城订单商品点评信息

#define kApiMethod_Mall_CommentGoods            @"CommitShoppingMallGoodsComment"       //--提交商城点评

#define kApiMethod_Mall_BuyAgain                @"ShoppingMallOrderReBuy"               //--订单再次购买操作

#define kApiMethod_Mall_OrderCancle             @"ShoppingMallCancelOrder"              //--取消订单


#define kApiMethod_QueryGoodsOrder @"QueryGoodsOrder"  //订单微信支付结果查询

//  ------------    物流.
#define kApiMethod_Mall_GetLogisticsContent     @"GetLogisticsContent"                  //--获取物流信息


#define kApiMethod_Mall_GetShoppingMallKeyWords @"GetShoppingMallKeyWords"              //获取大家都在搜

#define kApiMethod_Mall_BatchAddToShoppingCart  @"BatchAddToShoppingCart"              //添加所有离线商品

//#define kApiMethod_Mall_GetOfflineShoppingCartDetail @"GetShoppingCartDetailV2"   //获取离线购物车商品信息


#define kApiMethod_Mall_GetShoppingMallGroupGoodsList  @"GetShoppingMallGroupGoodsList" //获取商城团购列表数据



/***********************************************************************
 *
 *                  接 口 方 法 名   :   波奇生活馆
 *
 ***********************************************************************/

//  ------------    用户信息.
#define kApiMethod_Login            @"UserLogin"
#define kApiMethod_FastLogin        @"FastLogin"
#define kApiMethod_GetUserData      @"GetUserData"          //--用户信息（每次进个人中心时调用，不然钱或订单数不对）

#define kApiMethod_SendAuthCodeForRegister  @"SendAuthCode" //--验证码

#define kApiMethod_BindTelephone  @"BindTelephone" //  绑定手机号
#define kApiMethod_SetPayPassword  @"SetPayPassword" //  设置支付密码

#define kApiMethod_GetRegAgreement      @"GetRegAgreement"      //--波奇用户协议
#define kApiMethod_UserRegister         @"UserRegister"         //--注册

//#define kApiMethod_FindPassword     @"FindPassword"       //--找回密码
#define kApiMethod_ModifyPassword       @"ModifyPassword"     //--重设密码

#define kApiMethod_CheckAuthCode        @"CheckAuthCode"      //--校验验证码

#define kApiMethod_CheckNickName        @"CheckNickName"      //--检查昵称

#define kApiMethod_ModifyNickName       @"ModifyNickName"     //--修改昵称

#define kApiMethod_ModifySex            @"ModifySex"          //--性别

#define kApiMethod_ModifyPayPassword    @"ModifyPayPassword"  //--修改支付密码

#define kApiMethod_ModifyBindTelephone    @"ModifyBindTelephone"  //--修改绑定手机


//  ------------    用户 地址 相关.  //商城api
#define kApiMethod_GetProviceCityArea   @"GetAreaData"              //--获取省市区

#define kApiMethod_AddressList          @"GetUserAddressList"       //--获取地址列表

#define kApiMethod_AddressAdd           @"AddUserAddress"           //--添加地址

#define kApiMethod_AddressUpdate        @"UpdateUserAddress"        //--更新地址

#define kApiMethod_AddressSetDetault    @"SetDefaultAddress"        //--默认

#define kApiMethod_AddressDel           @"DeleteAddress"            //--删除


//  ------------    ...........
#define kApiMethod_GetOpenCityList  @"GetCityList"      //--生活馆开通的城市

#define kApiMethod_GetHomeData      @"GetHomeData"      //--获取首页信息

#define kApiMethod_GetSortType      @"GetSortType"      //--获取猫狗分类信息

#define kApiMethod_GetAreaType      @"GetAreaType"      //--获取区域分类信息

#define kApiMethod_GetMerchantSortType @"GetMerchantSortType"   //--获取商户分类信息

#define kApiMethod_TicketList       @"SearchTicketList"         //--获取搜索券列表信息

#define kApiMethod_MerchantList     @"SearchMerchantList"       //--获取搜索商户列表信息

#define kApiMethod_TicketListByMerchant @"GetMerchantTicketList"//--获取商户所有服务券列表

#define kApiMethod_TicketDetail     @"GetTicketDetail"          //--获取服务券详情

#define kApiMethod_MerchantDetail   @"GetMerchantDetail"        //--获取商户详情

//  ------        生活馆订单，支付。。。

#define kApiMethod_CommitOrder      @"CommitOrder"              //--提交服务券订单

#define kApiMethod_CheckCoupon      @"CheckCoupon"              //--验证优惠券

#define kApiMethod_GetPetLifeHouseCoupon    @"GetPetLifeHouseCoupon"    //--获取生活馆未使用的优惠券（支付页面用）

#define kApiMethod_CheckPayPwd      @"CheckPayPassword"        //--验证支付密码

#define kApiMethod_PayAmountDetail  @"GetPayAmountDetail"      //--验证优惠券或支付密码，并返回支付信息

#define kApiMethod_PayOrder         @"PayOrder"                //--支付服务券订单

#define kApiMethod_CancelOrderO2O   @"CancelOrder"             //--取消订单

#define kApiMethod_GetTicketBuyInfo @"GetTicketBuyInfo"        //查询服务券限购信息



//  ------        个人中心.

#define kApiMethod_MyOrderList      @"GetMyOrderList"          //--获取服务券订单列表信息

#define kApiMethod_MyTicketsInOrder @"GetMyTicketsInOrder"     //--获取获取订单内服务券列表

#define kApiMethod_MyTicketList     @"GetMyTicketList"         //--获取服务券列表信息

#define kApiMethod_MyTicketDetail   @"GetMyTicketDetail"       //--获取我的服务券详情

#define kApiMethod_MyCouponList     @"GetMyCouponList"         //--获取优惠券列表信息

#define kApiMethod_CouponDetail     @"GetCouponDetail"         //--获取优惠券详情信息

#define kApiMethod_CouponDetailV2   @"GetCouponDetailV2"       //--获取优惠券详情信息 用于1.0后

#define kApiMethod_MyCollectedGoodsList @"GetMyCollectedGoodsList"     //--获取收藏列表信息 : 商城

#define kApiMethod_MyCollectionList @"GetMyCollectionList"     //--获取收藏列表信息 ：生活馆

#define kApiMethod_HandleGoodsCollection @"HandleGoodsCollection"   //--添加或删除商品收藏    //商城api

#define kApiMethod_HandleCollection @"HandleCollection"             //--添加或删除收藏      //生活馆api

#define kApiMethod_GetVersionInfo   @"GetLastIOSVersion"       //--IOS客户端最新版本检测

#define kApiMethod_CommitTicketComment @"CommitTicketComment" //--服务券点评提交

// ---
#define kApiMethod_GetTicketCommentDetail @"GetTicketCommentDetail"  //获取服务券点评信息
#define kApiMethod_GetTicketCommentList @"GetTicketCommentList"      //获取服务券用户点评列表
#define kApiMethod_GetMerchantCommentList @"GetMerchantCommentList"  //获取商户用户点评列表

#define kApiMethod_GetTicketOtherMerchantList @"GetTicketOtherMerchantList" //获取已券多商户列表信息




#define kApiMethod_QueryOrder @"QueryOrder"  //生活馆订单微信支付结果查询

#define kApiMethod_GetKeyWords @"GetKeyWords"     //获取大家都在搜关键字


#define kApiMethod_GetWithDrawCashHistory @"GetWithDrawCashHistory" //获取提现记录
#define kApiMethod_GetWithDrawCashRule @"GetWithDrawCashRule" //获取提现规则
#define kApiMethod_WithDrawCashToAlipay @"WithDrawCashToAlipay" //提现到支付宝
#define kApiMethod_WithDrawCashToCreditCard @"WithDrawCashToCreditCard"  //提现到银行卡
