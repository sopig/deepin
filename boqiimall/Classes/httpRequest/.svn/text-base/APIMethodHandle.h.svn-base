//
//  APIMethodHandle.h
//  boqiimall
//
//  Created by 张正超 on 14-8-28.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BQIBaseViewController.h"

/*
 接口请求分为  生活馆接口和商城接口 
 
 请根据对应的接口请求方法调用  
 
 delegate 请用继承自BQIBaseViewController的自定义类
 
 如果新增接口，只需要添加接口名称即可  
 
 API请求的delegate 需要满足   InterfaceAPIDelegate （接口请求成功和错误的回调） 和  BaseViewLoadingAnimationDelegate （请求加载动画的显示） 和 MBProgressHUDDelegate  （HUD的回调）
*/

@interface APIMethodHandle : NSObject


+ (instancetype)shareAPIMethodHandle;


#pragma mark - 直接URL请求
//不用参数拼接的直接URL请求
- (void)goApiRequestWithURL:(NSString*)url ModelClass:(NSString*)modelClass hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

#pragma mark -  商城API
// 商城首页
- (void)goApiRequestGetShoppingMallHomeData:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//商城分类 一，二，三级分类
- (void)goApiRequestGetShoppingMallCategoryType:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//商城商品列表数据
- (void)goApiRequestGetShoppingMallGoodsList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//商城商品详细数据
- (void)goApiRequestGetShoppingMallGoodsDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

 //商城商品评论数据
- (void)goApiRequestGetShoppingMallGoodsCommentList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//商城商品规格组合详细数据
- (void)goApiRequestGetShoppingMallGoodsSpec:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//购物车商品数量
- (void)goApiRequestGetShoppingCartNumber:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//商城商品购物车商品信息
- (void)goApiRequestGetShoppingCartDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

 //购物车金额信息
- (void)goApiRequestGetShoppingCartMoneyInfo:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

 //添加商品到购物车
- (void)goApiRequestAddToShoppingCart:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

 //删除购物车商品
- (void)goApiRequestDeleteShoppingCartGoods:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

 //修改购物车商品数量
- (void)goApiRequestModifyShoppingCartGoodsNumber:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//订单结算信息
- (void)goApiRequestSettleAccounts:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//验证优惠券
- (void)goApiRequestCheckCoupon:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//收获地址获取支付和配送方式
- (void)goApiRequestGetPaymentAndExpressageListByAddress:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//商城订单结算，资金明细
- (void)goApiRequestGetOrderAmountDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//订单 提交
- (void)goApiRequestCommitGoodsOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//订单 支付
- (void)goApiRequestPayGoodsOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

 //省 市 区
- (void)goApiRequestGetAreaData:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//我的商城订单列表
- (void)goApiRequestGetMyGoodsOrderList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//商城订单详情
- (void)goApiRequestGetShoppingMallOrderDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//我购买的商品列表
- (void)goApiRequestGetMyBuyedGoodsList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//商城订单商品点评信息
- (void)goApiRequestGetMyGoodsOrderComment:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//提交商城点评
- (void)goApiRequestCommitShoppingMallGoodsComment:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//订单再次购买操作
- (void)goApiRequestShoppingMallOrderReBuy:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//取消订单
- (void)goApiRequestShoppingMallCancelOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;



//商城订单微信支付结果查询
- (void)goApiRequestQueryGoodsOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;



//商城订单物流查询
- (void)goApiRequestGetLogisticsContent:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//获取大家都在搜
- (void)goApiRequestGetShoppingMallKeyWords:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取商城未使用的优惠券
- (void)goApiRequestGetShoppingMallCoupon:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;



//添加或删除商品收藏
- (void)goApiRequestHandleGoodsCollection:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//获取收藏列表信息 : 商城
- (void)goApiRequestGetMyCollectedGoodsList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取省市区
- (void)goApiRequestGetProviceCityArea:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取地址列表
- (void)goApiRequestGetUserAddressList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//添加地址
- (void)goApiRequestAddUserAddress:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//更新地址
- (void)goApiRequestUpdateUserAddress:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//默认地址
- (void)goApiRequestSetDefaultAddress:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//删除地址
- (void)goApiRequestDeleteAddress:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;
//获取离线购物车商品信息
- (void)goApiRequestGetOfflineShoppingCartDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;
//批量上传所有离线商品信息
- (void)goApiRequestBatchAddToShoppingCart:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;
//获取团购商品数据
- (void)goApiRequestGetShoppingMallGroupGoodsList:(NSMutableDictionary *)params ModelClass:(NSString *)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString *)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取换购及优惠列表
- (void)goApiRequestGetChangeBuyList:(NSMutableDictionary *)params ModelClass:(NSString *)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString *)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//更换换购或优惠
- (void)goApiRequestChangeBuyGoods:(NSMutableDictionary *)params ModelClass:(NSString *)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString *)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


#pragma mark - 生活馆API

 //用户登录
- (void)goApiRequestUserLogin:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


 //第三方快捷登陆
- (void)goApiRequestFastLogin:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//用户信息（每次进个人中心时调用，不然钱或订单数不对）
- (void)goApiRequestGetUserData:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


 //发送验证码
- (void)goApiRequestSendAuthCode:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//绑定手机号
- (void)goApiRequestBindTelephone:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


  //设置支付密码
- (void)goApiRequestSetPayPassword:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


 //波奇用户协议
- (void)goApiRequestGetRegAgreement:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//注册
- (void)goApiRequestUserRegister:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


 //重设密码
- (void)goApiRequestModifyPassword:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//校验验证码
- (void)goApiRequestCheckAuthCode:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


 //检查昵称
- (void)goApiRequestCheckNickName:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//修改昵称
- (void)goApiRequestModifyNickName:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

 //性别
- (void)goApiRequestModifySex:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;



//修改支付密码
- (void)goApiRequestModifyPayPassword:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//修改绑定手机
- (void)goApiRequestModifyBindTelephone:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;



//生活馆开通的城市
- (void)goApiRequestGetCityList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取首页信息
- (void)goApiRequestGetHomeData:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取猫狗分类信息
- (void)goApiRequestGetSortType:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//获取区域分类信息
- (void)goApiRequestGetAreaType:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

 //获取商户分类信息
- (void)goApiRequestGetMerchantSortType:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

 //获取搜索券列表信息
- (void)goApiRequestSearchTicketList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


 //获取搜索商户列表信息
- (void)goApiRequestSearchMerchantList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//获取商户所有服务券列表
- (void)goApiRequestGetMerchantTicketList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取服务券详情
- (void)goApiRequestGetTicketDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//获取商户详情
- (void)goApiRequestGetMerchantDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//提交订单 : 查询服务券限购信息
- (void)goApiRequestGetTicketBuyInfo:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

 //提交服务券订单
- (void)goApiRequestCommitOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//验证优惠券
- (void)goApiRequestLifeO2OCheckCoupon:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//验证支付密码
- (void)goApiRequestCheckPayPassword:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//验证优惠券或支付密码，并返回支付信息
- (void)goApiRequestGetPayAmountDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;



//支付服务券订单
- (void)goApiRequestPayOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


 //获取服务券订单列表信息
- (void)goApiRequestGetMyOrderList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取获取订单内服务券列表
- (void)goApiRequestGetMyTicketsInOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取服务券列表信息
- (void)goApiRequestGetMyTicketList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


 //获取我的服务券详情
- (void)goApiRequestGetMyTicketDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取优惠券列表信息
- (void)goApiRequestGetMyCouponList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


 //获取优惠券详情信息
- (void)goApiRequestGetCouponDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


 //获取优惠券详情信息 用于1.0后
- (void)goApiRequestGetCouponDetailV2:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;



//获取收藏列表信息 ：生活馆
- (void)goApiRequestGetMyCollectionList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//添加或删除收藏
- (void)goApiRequestHandleCollection:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//IOS客户端最新版本检测
- (void)goApiRequestGetLastIOSVersion:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


 //服务券点评提交
- (void)goApiRequestCommitTicketComment:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取服务券点评信息
- (void)goApiRequestGetTicketCommentDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//获取服务券用户点评列表
- (void)goApiRequestGetTicketCommentList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取商户用户点评列表
- (void)goApiRequestGetMerchantCommentList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取一券多商户列表信息
- (void)goApiRequestGetTicketOtherMerchantList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;



//生活馆订单微信支付结果查询
- (void)goApiRequestQueryOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//生活馆搜索关键字推荐
- (void)goApiRequestGetKeyWords:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//生活馆订单取消
- (void)goApiRequestLifeCancelOrderO2O:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//生活馆未使用的优惠券（支付页面用）
- (void)goApiRequestLifeGetPetLifeHouseCouponO2O:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

//获取提现记录
- (void)goApiRequestLifeGetWithDrawCashHistory:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//获取提现规则
- (void)goApiRequestLifeGetWithDrawCashRule:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//提现到支付宝
- (void)goApiRequestLifeWithDrawCashToAlipay:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;


//提现到银行卡
- (void)goApiRequestLifeWithDrawCashToCreditCard:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate;

@end
