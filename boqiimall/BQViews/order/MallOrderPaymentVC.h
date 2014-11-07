//
//  MallOrderPaymentVC.h
//  boqiimall
//
//  Created by YSW on 14-6-26.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "EC_UIScrollView.h"
#import "EC_UITextField.h"
#import "WXErrorUtil.h"
#import "resMod_QueryGoodsOrder.h"

@interface MallOrderPaymentVC : BQIBaseViewController<UIScrollViewDelegate,UITextFieldDelegate>{
    EC_UIScrollView * rootScrollView;
    
    UIView * viewTop;
    UIView * viewContent;
    
    UIView * viewAccountBalance;
    UIView * viewDottedCornerRadiusBg;
    UIView * viewPWD;
    UIView * viewNeedPay;
    EC_UITextField * txtPayPwd;
    
    UILabel * lbl_OrderPrice;
    UILabel * lbl_MyBalance;
    UILabel * lbl_UsedMyBalance;
    UILabel * lbl_needPay;
    
    UIButton * btn_selUseBalance;
    UIButton * btn_pay;
    
    UIView * viewPayType;
    NSMutableArray * arrPayType;

    BOOL     b_UsedBalance;
    BOOL     b_PayPwdRight;
    BOOL     b_hasPayResult;
    NSInteger  selectPayType;
    
    float f_userUnitBalance;    //用户余额
    float f_UsedMyMoney;
    
    
    resMod_QueryGoodsOrder *WXPayResult;
}

@property (nonatomic,assign) BOOL   b_isFromOrderList;
@property (nonatomic,strong) NSString * payOrderID;
@property (nonatomic,assign) float OrderTotalPrice;     //--订单总额
@property (nonatomic,assign) BOOL  isUsedBalance;       //--是否使用过余额支付
@property (nonatomic,assign) float BalanceUsed;         //--使用余额支付
@end



