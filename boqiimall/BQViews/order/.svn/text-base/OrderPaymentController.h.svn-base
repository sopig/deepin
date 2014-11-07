//
//  OrderPaymentController.h
//  BoqiiLife
//
//  Created by YSW on 14-6-6.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "EC_UITextField.h"
#import "EC_UIScrollView.h"
#import "EC_UISwitch.h"

#import "resMod_MyOrders.h"
#import "resMod_MyCoupons.h"
#import "resMod_CheckCoupon.h"
#import "ResponseBase.h"
#import "resMod_PayOrder.h"
#import "resMod_QueryOrder.h"

#import "WXErrorUtil.h"


//  -- 支付
@interface OrderPaymentController : BQIBaseViewController<UIScrollViewDelegate,UITextFieldDelegate>{
    
    EC_UIScrollView * rootScrollView;
    
    UIView * viewContent_1;
    UIView * viewContent_2;
    UIScrollView * view_couponlist;    //  --  优惠券列表
    UIView * view_BalanceAndPayPwd;    //  --  我的余额&支付密码
    UIView * view_userBalance;
    UIView * viewContent_3;

    EC_UITextField * txtCouponCode;
    EC_UITextField * txtPayPwd;
    
    EC_UISwitch * btnSwitch_Coupon;
    EC_UISwitch * btnSwitch_Balance;
    
    UILabel * lbl_leftBalance;
    UILabel * lbl_UserMyBalance;
    UILabel * lbl_ShouldPay;
    UILabel * lbl_UsedCouponPrice;
    UILabel * lbl_UsedBalance;
    UILabel * lbl_needPay;
    
    NSMutableArray * arrPayType;
    
    UIButton * btn_setPayPwd;
    UIButton * btn_okPayPwd;    //  --  确认支付密码
    UIButton * btn_pay;         //  --  支付按钮
    
    resMod_MyOrderInfo * modOrderInfo;
    
    BOOL b_isFromUserCenter;  //--是否从个人中心跳入
    BOOL b_isRightPayPwd;     //--支付密码正确
    BOOL isUsedBalance;       //--是否使用过余额支付
    BOOL isUsedCoupon;        //--是否使用过 优惠券
    resMod_PayOrder * payinfo;
    NSInteger  selectPayType;
    
    BOOL b_hasPayResult;
    NSString *backTelString;
    
    resMod_QueryOrder *WXPayResult;
    
}

@property (assign ,nonatomic) float f_userUnitBalance;
@property (assign ,nonatomic) float f_CouponPrice;
@property (assign ,nonatomic) float f_UsedMyMoney;
@property (assign ,nonatomic) float f_needPay;
@property (strong ,nonatomic) NSString * param_CouponCode;
@property (strong ,nonatomic) NSMutableArray * arrCoupons;


// -- wap 支付结果
-(void)paymentResult:(NSString *)result;
@end
