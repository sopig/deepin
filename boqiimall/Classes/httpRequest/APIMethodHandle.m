//
//  APIMethodHandle.m
//  boqiimall
//
//  Created by 张正超 on 14-8-28.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "APIMethodHandle.h"
#import "BqiAPI.h"
static APIMethodHandle *handle = nil;

@implementation APIMethodHandle

+ (instancetype)shareAPIMethodHandle
{
    if (handle == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            handle = [[[self class]alloc]init];
        });
    }
    return handle;
}

//直接URL请求
- (void)goApiRequestWithURL:(NSString *)url ModelClass:(NSString *)modelClass hudContent:(NSString *)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    NSParameterAssert(delegate);
    
    if (delegate && [delegate respondsToSelector:@selector(showLoadingAnimation:Content:)]) {
        [delegate showLoadingAnimation:YES Content:content];

    }
    
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:url,APP_ACTIONNAME, nil];
    InterfaceAPIExcute *inter = [[InterfaceAPIExcute alloc] initWithAPI:api_ONLYURL
                                                                apiPath:url
                                                               retClass:modelClass
                                                                 Params:dicParams setDelegate:delegate];
    [inter beginRequestWithUrl];
}


#pragma mark - 商城API

//商城
- (void)MALLAPIHandleApiMethod:(NSString*)method Params:(NSMutableDictionary*)params delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate ShowLoadingAnimation:(BOOL)show Content:(NSString*)content ModelClass:(NSString*)modelClass
{
    
    NSParameterAssert(delegate);
    if (![PMGlobal shared].isHttp){
        return;
    }
    EnvApiHost _envApiHost = api_BOQIIMALL;
    
    NSMutableDictionary *dicParams = [self paramsDictWithEnvApiHost:_envApiHost Params:params ApiMethod:method];
 
    if (delegate && [delegate respondsToSelector:@selector(showLoadingAnimation:Content:)]) {
        [delegate showLoadingAnimation:show Content:content];
    }
    InterfaceAPIExcute *inter = [[InterfaceAPIExcute alloc] initWithAPI:_envApiHost
                                                                apiPath:kApiUrl(_envApiHost)
                                                               retClass:modelClass
                                                                 Params:dicParams setDelegate:delegate];
    [inter beginRequest];
}
//生活馆
- (void)LIFEO2OAPIHandleApiMethod:(NSString*)method Params:(NSMutableDictionary*)params delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate ShowLoadingAnimation:(BOOL)show Content:(NSString*)content ModelClass:(NSString*)modelClass
{
     NSParameterAssert(delegate);
    if (![PMGlobal shared].isHttp){
        return;
    }
    EnvApiHost _envApiHost = api_BOQIILIFE;
    
    NSMutableDictionary *dicParams = [self paramsDictWithEnvApiHost:_envApiHost Params:params ApiMethod:method];
    
    if (delegate && [delegate respondsToSelector:@selector(showLoadingAnimation:Content:)]) {
        [delegate showLoadingAnimation:show Content:content];
    }
    
    InterfaceAPIExcute *inter = [[InterfaceAPIExcute alloc] initWithAPI:_envApiHost
                                                                apiPath:kApiUrl(_envApiHost)
                                                               retClass:modelClass
                                                                 Params:dicParams setDelegate:delegate];
    [inter beginRequest];
}


- (NSMutableDictionary*)paramsDictWithEnvApiHost:(EnvApiHost)_envApiHost Params:(NSMutableDictionary*)params ApiMethod:(NSString*)method //参数准备
{
    NSMutableDictionary * dicParams = [params mutableCopy];
    if (dicParams!=nil)
//        [dicParams setObject:method forKey:APP_ACTIONNAME];
        [dicParams setValue:method forKey:APP_ACTIONNAME];
    else
        dicParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:method,APP_ACTIONNAME, nil];
    
    if (_envApiHost == api_BOQIILIFE) {   //  --  生活馆接口，都加城市id
        NSDictionary * dicCity = [[PMGlobal shared] location_GetUserCheckedCity];
        NSString * cityid = [dicCity objectForKey:@"CityId"];
        [dicParams setObject: cityid.length>0?cityid:@"0" forKey:@"CityId"];
    }

    return dicParams;
}

#pragma maek - 商城API

- (void)goApiRequestGetShoppingMallHomeData:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_HomeData Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
    
}

- (void)goApiRequestGetShoppingMallCategoryType:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_Classification Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

- (void)goApiRequestGetShoppingMallGoodsList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
  [self MALLAPIHandleApiMethod:kApiMethod_Mall_GoodsList Params:params
                      delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
    
}

- (void)goApiRequestGetShoppingMallGoodsDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GoodsDetail Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


- (void)goApiRequestGetShoppingMallGoodsCommentList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GoodsCommentList Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetShoppingMallGoodsSpec:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GoodsSpec Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestGetShoppingCartNumber:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_CartNum Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetShoppingCartDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_CartDetailV2   //1.2之后 弃用kApiMethod_Mall_CartDetail
                          Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetShoppingCartMoneyInfo:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_CartMoney Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

- (void)goApiRequestAddToShoppingCart:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_AddCart Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

- (void)goApiRequestDeleteShoppingCartGoods:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_DeleteCartGoods Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestModifyShoppingCartGoodsNumber:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

    [self MALLAPIHandleApiMethod:kApiMethod_Mall_ModifyCartGoodsNumber Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestSettleAccounts:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_SettleAccounts Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestCheckCoupon:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_CheckCoupon Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}

- (void)goApiRequestGetPaymentAndExpressageListByAddress:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GetPaymentAndExpressageListByAddress Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


- (void)goApiRequestGetOrderAmountDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GetOrderAmountDetail Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

- (void)goApiRequestCommitGoodsOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_CreateOrder Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestPayGoodsOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_OrderPay Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetAreaData:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GetAreaData Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetMyGoodsOrderList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_OrderList Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetShoppingMallOrderDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_MallOrderDetail Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetMyBuyedGoodsList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GetMyBuyedGoodsList Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetMyGoodsOrderComment:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GetGoodsForOrderComment Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestCommitShoppingMallGoodsComment:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

    [self MALLAPIHandleApiMethod:kApiMethod_Mall_CommentGoods Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestShoppingMallOrderReBuy:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_BuyAgain Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestShoppingMallCancelOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

    [self MALLAPIHandleApiMethod:kApiMethod_Mall_OrderCancle Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}

//商城订单微信支付结果查询
- (void)goApiRequestQueryGoodsOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_QueryGoodsOrder Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


//商城订单物流查询
- (void)goApiRequestGetLogisticsContent:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GetLogisticsContent Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

//获取大家都在搜
- (void)goApiRequestGetShoppingMallKeyWords:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GetShoppingMallKeyWords Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}


//获取商城未使用的优惠券
- (void)goApiRequestGetShoppingMallCoupon:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GetCouponListCanUse Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


- (void)goApiRequestAddUserAddress:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_AddressAdd Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


- (void)goApiRequestGetProviceCityArea:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  
    [self MALLAPIHandleApiMethod:kApiMethod_GetProviceCityArea Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


- (void)goApiRequestGetUserAddressList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_AddressList Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

- (void)goApiRequestUpdateUserAddress:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_AddressUpdate Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestSetDefaultAddress:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_AddressSetDetault Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestDeleteAddress:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_AddressDel Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

- (void)goApiRequestGetMyCollectedGoodsList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    
    [self MALLAPIHandleApiMethod:kApiMethod_MyCollectedGoodsList Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


- (void)goApiRequestHandleGoodsCollection:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_HandleGoodsCollection Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


//获取离线购物车商品信息
- (void)goApiRequestGetOfflineShoppingCartDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_CartDetailV2 Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
    
    
}

//批量上传所有离线商品信息
- (void)goApiRequestBatchAddToShoppingCart:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_BatchAddToShoppingCart Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


//获取团购数据
- (void)goApiRequestGetShoppingMallGroupGoodsList:(NSMutableDictionary *)params ModelClass:(NSString *)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString *)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GetShoppingMallGroupGoodsList Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


//获取换购及优惠列表
- (void)goApiRequestGetChangeBuyList:(NSMutableDictionary *)params ModelClass:(NSString *)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString *)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_GetChangeBuyList Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

//更换换购或优惠
- (void)goApiRequestChangeBuyGoods:(NSMutableDictionary *)params ModelClass:(NSString *)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString *)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self MALLAPIHandleApiMethod:kApiMethod_Mall_ChangeBuyGoods Params:params
                        delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

#pragma mark - 生活馆API

- (void)goApiRequestUserLogin:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self LIFEO2OAPIHandleApiMethod:kApiMethod_Login Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestFastLogin:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_FastLogin Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

- (void)goApiRequestGetUserData:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetUserData Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestSendAuthCode:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_SendAuthCodeForRegister Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestBindTelephone:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_BindTelephone Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestSetPayPassword:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_SetPayPassword Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestGetRegAgreement:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetRegAgreement Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestUserRegister:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_UserRegister Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestModifyPassword:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_ModifyPassword Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestCheckAuthCode:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_CheckAuthCode Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestCheckNickName:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_CheckNickName Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestModifyNickName:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_ModifyNickName Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestModifySex:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_ModifySex Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestModifyPayPassword:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_ModifyPayPassword Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestModifyBindTelephone:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

  [self LIFEO2OAPIHandleApiMethod:kApiMethod_ModifyBindTelephone Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}




- (void)goApiRequestGetCityList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

  [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetOpenCityList Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestGetHomeData:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetHomeData Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestGetSortType:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetSortType Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestGetAreaType:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

  [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetAreaType Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestGetMerchantSortType:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

  [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetMerchantSortType Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestSearchTicketList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

  [self LIFEO2OAPIHandleApiMethod:kApiMethod_TicketList Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestSearchMerchantList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_MerchantList Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetMerchantTicketList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_TicketListByMerchant Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetTicketDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_TicketDetail Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetMerchantDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

    [self LIFEO2OAPIHandleApiMethod:kApiMethod_MerchantDetail Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

- (void)goApiRequestGetTicketBuyInfo:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    
    [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetTicketBuyInfo Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

- (void)goApiRequestCommitOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_CommitOrder Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestLifeO2OCheckCoupon:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_CheckCoupon Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestCheckPayPassword:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_CheckPayPwd Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetPayAmountDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

  [self LIFEO2OAPIHandleApiMethod:kApiMethod_PayAmountDetail Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestPayOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

  [self LIFEO2OAPIHandleApiMethod:kApiMethod_PayOrder Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


- (void)goApiRequestGetMyOrderList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_MyOrderList Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetMyTicketsInOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_MyTicketsInOrder Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestGetMyTicketList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

  [self LIFEO2OAPIHandleApiMethod:kApiMethod_MyTicketList Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestGetMyTicketDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_MyTicketDetail Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetMyCouponList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_MyCouponList Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetCouponDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_CouponDetail Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetCouponDetailV2:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_CouponDetailV2 Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

- (void)goApiRequestGetMyCollectionList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

  [self LIFEO2OAPIHandleApiMethod:kApiMethod_MyCollectionList Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

- (void)goApiRequestHandleCollection:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_HandleCollection Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}
- (void)goApiRequestGetLastIOSVersion:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetVersionInfo Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestCommitTicketComment:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

  [self LIFEO2OAPIHandleApiMethod:kApiMethod_CommitTicketComment Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestGetTicketCommentDetail:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

  [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetTicketCommentDetail Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestGetTicketCommentList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetTicketCommentList Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}
- (void)goApiRequestGetMerchantCommentList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
  [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetMerchantCommentList Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}

- (void)goApiRequestQueryOrder:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    [self LIFEO2OAPIHandleApiMethod:kApiMethod_QueryOrder Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


//生活馆搜索关键字推荐
- (void)goApiRequestGetKeyWords:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetKeyWords Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

//生活馆订单取消
- (void)goApiRequestLifeCancelOrderO2O:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
        [self LIFEO2OAPIHandleApiMethod:kApiMethod_CancelOrderO2O Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}

//生活馆未使用的优惠券（支付页面用）
- (void)goApiRequestLifeGetPetLifeHouseCouponO2O:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{

    [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetPetLifeHouseCoupon Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
    
}


//获取一券多商户列表信息
- (void)goApiRequestGetTicketOtherMerchantList:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
     [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetTicketOtherMerchantList Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
}


- (void)goApiRequestLifeGetWithDrawCashHistory:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate
{
    [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetWithDrawCashHistory Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}

- (void)goApiRequestLifeGetWithDrawCashRule:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self LIFEO2OAPIHandleApiMethod:kApiMethod_GetWithDrawCashRule Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}

- (void)goApiRequestLifeWithDrawCashToAlipay:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self LIFEO2OAPIHandleApiMethod:kApiMethod_WithDrawCashToAlipay Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];

}

- (void)goApiRequestLifeWithDrawCashToCreditCard:(NSMutableDictionary*)params ModelClass:(NSString*)modelClass showLoadingAnimal:(BOOL)show hudContent:(NSString*)content delegate:(id<InterfaceAPIDelegate,MBProgressHUDDelegate,BaseViewLoadingAnimationDelegate>)delegate{
    [self LIFEO2OAPIHandleApiMethod:kApiMethod_WithDrawCashToCreditCard Params:params delegate:delegate ShowLoadingAnimation:show Content:content ModelClass:modelClass];
 
}


@end
