//
//  MallOrderSubmitController.h
//  boqiimall
//
//  Created by YSW on 14-6-25.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "EC_UIScrollView.h"
#import "EC_UITextField.h"
#import "MyAddressListController.h"

#import "resMod_Mall_SettleAccounts.h"
#import "resMod_Address.h"
#import "resMod_Mall_Goods.h"
#import "resMod_Mall_GoodsSpec.h"
#import "resMod_Mall_CheckCoupon.h"
#import "resMod_Mall_PaymentAndDeliveryByAddress.h"

//  -- button扩展 .........................
@interface EC_OrderSubmitButton : UIImageView
@property (assign,nonatomic) int selRowInArray;
@property (assign,nonatomic) int chectTypeID;
@property (assign,nonatomic) int type_paymentOrDelevery;
@property (strong,nonatomic) NSString * iconName;
@end


@interface MallOrderSubmitController : BQIBaseViewController<MyAddressListDelegate,UITextFieldDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{

    EC_UIScrollView * rootScrollview;
    UITableView * tableviewPDType;
    UIButton * btnAddress;
    
    UIView * view_coupon;
    UIScrollView * view_couponlist;
    EC_UITextField * txtCoupon;
    
    UIView * view_PayDetail;
    UIButton * btn_ok;
    
    float heightTopAddress;
    float heightPaytypeAndDeleverytype;
    
    NSMutableArray * paramGoodsList;
    resMod_Mall_SettleAccounts * settleAccountsInfo;
    resMod_AddressInfo * myAddressInfo;
    resMod_Mall_CheckCoupon * checkCouponInfo;
    NSMutableArray * m_Payments;
    NSMutableArray * m_Deleverys;
    
    EC_OrderSubmitButton * selPaymentType;
    EC_OrderSubmitButton * selDeleveryType;
    
    BOOL isUseCoupon;
}

@property (strong ,nonatomic) NSMutableArray * arrCoupons;
@property (strong ,nonatomic) NSString       * addressInfo;
@end
