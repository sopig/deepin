//
//  WXErrorUtil.h
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-1.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#ifndef boqiimall_WXErrorUtil_h
#define boqiimall_WXErrorUtil_h

typedef NS_ENUM(NSUInteger, PayType){
    UserBalancePay, //用户余额支付
    AliAppPay ,     //支付宝客户端支付
    AliWebPay ,     //支付宝网页支付
    PayUnion,       //银联支付
    WXPay           //微信支付
};

typedef NS_ENUM(NSUInteger, WXPayResultCode) {
    WXPaySuccess = 1,    //服务器已收到微信支付成功的回调通知
    WXPayCommonError     //其他错误
};

typedef NS_ENUM(NSUInteger, WXOauthResultCode){
    ERR_OK = 0,//(用户同意)
    ERR_AUTH_DENIED = -4,//（用户拒绝授权）
    ERR_USER_CANCEL = -2//（用户取消）
};

#endif
