//
//  OrderPaymentController.m
//  BoqiiLife
//
//  Created by YSW on 14-6-6.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "OrderPaymentController.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "DataVerifier.h"
#import "AlixLibService.h"
#import "AlixPayResult.h"
#import "resMod_PayTypeInfo.h"
#import "BQBindTelephoneNumberView.h"
//#import <NZAlertViewDelegate.h>
#import "BQCustomBarButtonItem.h"
#import "EC_UICustomAlertView.h"



#define heightLine      8
#define heightPayRow    55
#define heightForConponButton 40
#define rowHeight       45
#define payButtonTag    8934

@interface OrderPaymentController ()<WXHandleDelegate>

@end

@implementation OrderPaymentController
@synthesize f_userUnitBalance;
@synthesize f_CouponPrice;
@synthesize f_UsedMyMoney;
@synthesize f_needPay;
@synthesize param_CouponCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        arrPayType = [[NSMutableArray alloc] initWithCapacity:0];
        b_isRightPayPwd = NO;
        isUsedBalance = NO;
        b_isFromUserCenter = NO;
        b_hasPayResult = NO;
        f_userUnitBalance = [[UserUnit userBalance] floatValue];
        selectPayType = -1000;
        [self initPayTypes];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"支付订单"];
 //   [self loadNavBarView:@"支付订单"];
    
    
    modOrderInfo  = [self.receivedParams objectForKey:@"param_orderinfo"];
    isUsedBalance = [[self.receivedParams objectForKey:@"param_isUsedBalance"] isEqualToString:@"100"] ? YES:NO;
    f_UsedMyMoney = [[self.receivedParams objectForKey:@"param_BalanceUsed"] floatValue];
    isUsedCoupon  = [[self.receivedParams objectForKey:@"param_isUsedCoupon"] isEqualToString:@"100"] ? YES:NO;
    f_CouponPrice = [[self.receivedParams objectForKey:@"param_CouponPrice"] floatValue];
    param_CouponCode = [self.receivedParams objectForKey:@"param_CouponCode"];
    f_needPay = modOrderInfo.OrderPrice-f_UsedMyMoney-f_CouponPrice;
    
    rootScrollView = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [rootScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:rootScrollView];
    
    [self initViewContent];

    b_isFromUserCenter = [[self.receivedParams objectForKey:@"param_isFromUserCenter"] isEqualToString:@"0"] ? NO : YES;
    if (!modOrderInfo) {
        [self HUDShow:@"未检测到任何订单信息" delay:1.5];
        [self goBack:nil];
        return ;
    }
    
    //  -- 算使用余额
    [self getUserMoney];
    
    //  -- appdelegate 通知支付宝回调结果
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(onAliPayResult:)
                                                 name: @"NotificationAliPayResult"
                                               object: nil];
}

- (void)goBack:(id)sender
{
    [super goBack:sender];
    [MobClick event:@"serviceOrderPay_return"];
    
}


//
//- (void)loadNavBarView:(NSString *)title
//{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = title;
//    [bgView addSubview:titleLabel];
//    [self.navBarView addSubview:bgView];
//}

#pragma mark    --  支付方式数据
- (void) initPayTypes{
    [arrPayType removeAllObjects];
    NSArray * types=[payTypeString componentsSeparatedByString:@"|"];
    for (NSString * skey in types) {
        NSArray * pays = [skey componentsSeparatedByString:@","];
        resMod_PayTypeInfo * tmppay = [[resMod_PayTypeInfo alloc]init];
        tmppay.payTypeId    = [pays[0] intValue];
        tmppay.payTitle     = pays[1];
        tmppay.payWarning   = pays[2];
        tmppay.payIcon      = pays[3];
        tmppay.payIsChecked = NO;
        [arrPayType addObject:tmppay];
    }
}

- (void) initViewContent{
    
    //  --  第一部分内容  ***********************************************************
    
    viewContent_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, rowHeight*2+10+heightLine)];
    [viewContent_1 setBackgroundColor:[UIColor clearColor]];
    [rootScrollView addSubview:viewContent_1];
    
    [UICommon Common_UILabel_Add:CGRectMake(8,0,def_WidthArea(6),rowHeight+10) targetView:viewContent_1
                         bgColor:[UIColor clearColor] tag:1001
                            text: modOrderInfo.OrderTitle
                           align:-1 isBold:YES fontSize:16 tColor:color_4e4e4e];
    
    [UICommon Common_line:CGRectMake(0, rowHeight+10, __MainScreen_Width,0.5) targetView:viewContent_1 backColor:color_d1d1d1];
    
    [UICommon Common_UILabel_Add:CGRectMake(8, rowHeight+10, 100, rowHeight) targetView:viewContent_1
                         bgColor:[UIColor clearColor] tag:1002
                            text:@"总 价：" align:-1 isBold:NO fontSize:16 tColor:color_4e4e4e];
    //--订单总价
    [UICommon Common_UILabel_Add:CGRectMake(100, rowHeight+10, 210, rowHeight) targetView:viewContent_1
                         bgColor:[UIColor clearColor] tag:1003
                            text:[self convertPrice:modOrderInfo.OrderPrice]
                           align:1 isBold:YES fontSize:15 tColor:color_fc4a00];

    [UICommon Common_line:CGRectMake(0, viewContent_1.frame.size.height-heightLine, __MainScreen_Width,heightLine) targetView:viewContent_1 backColor:color_body];


    //  --  第二部分内容  ***********************************************************
    
    viewContent_2 = [[UIView alloc] initWithFrame:CGRectMake(0, viewContent_1.frame.size.height, __MainScreen_Width, rowHeight*4+heightLine*2)];
    [viewContent_2 setBackgroundColor:[UIColor clearColor]];
    [rootScrollView addSubview:viewContent_2];
    
    
    [UICommon Common_UILabel_Add:CGRectMake(8, 0, def_WidthArea(8), rowHeight) targetView:viewContent_2
                         bgColor:[UIColor clearColor] tag:2001
                            text:[NSString stringWithFormat:@"购买成功后，服务券凭证将发到：%@",modOrderInfo.OrderTel]
                           align:-1 isBold:NO fontSize:13 tColor:color_4e4e4e];
    [UICommon Common_line:CGRectMake(0,rowHeight,__MainScreen_Width,heightLine) targetView:viewContent_2 backColor:color_body];
    
    
    //  --  使用优惠券部分
    [UICommon Common_UILabel_Add:CGRectMake(8, rowHeight+heightLine, 150, rowHeight) targetView:viewContent_2 bgColor:[UIColor clearColor] tag:2001 text:@"使用优惠券" align:-1 isBold:NO fontSize:14 tColor:color_4e4e4e];
    txtCouponCode = [[EC_UITextField alloc] initWithFrame:CGRectMake(95, rowHeight+heightLine+5, isUsedCoupon?150:0, 35)];
    [txtCouponCode setTag:2005];
    [txtCouponCode setTextFieldState:ECTextFieldGary];
    [txtCouponCode setPlaceholder:@"输入11位优惠券码"];
    [txtCouponCode setText:self.param_CouponCode];
    [txtCouponCode setEnabled: isUsedCoupon?NO:YES];
    [txtCouponCode setDelegate:self];
    [txtCouponCode setFont:defFont14];
    [viewContent_2 addSubview:txtCouponCode];
    
    // --   使用优惠券开关
    btnSwitch_Coupon = [EC_UISwitch buttonWithType:UIButtonTypeCustom];
    [btnSwitch_Coupon setTag:2002];
    [btnSwitch_Coupon setOn: isUsedCoupon?YES:NO];
    [btnSwitch_Coupon setBackgroundColor:[UIColor clearColor]];
    [btnSwitch_Coupon setFrame: CGRectMake(__MainScreen_Width-62,rowHeight+heightLine+7, 102/2, 62/2)];
    [btnSwitch_Coupon addTarget:self action:@selector(onSwitchClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewContent_2 addSubview:btnSwitch_Coupon];
    
    //  --  优惠券列表
    view_couponlist = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(txtCouponCode.frame)+heightLine, __MainScreen_Width, 0)];
    [view_couponlist setBackgroundColor:[UIColor clearColor]];
    view_couponlist.delegate = self;
    view_couponlist.layer.borderColor = color_d1d1d1.CGColor;
    view_couponlist.layer.borderWidth = 0.5f;
    [viewContent_2 addSubview:view_couponlist];
    

    //  --  我的余额 & 使用余额 & 支付密码
    view_BalanceAndPayPwd = [[UIView alloc] initWithFrame:CGRectMake(0, rowHeight*2+heightLine, __MainScreen_Width, rowHeight*2)];
    [view_BalanceAndPayPwd setBackgroundColor:[UIColor clearColor]];
    [viewContent_2 addSubview:view_BalanceAndPayPwd];

    [UICommon Common_line:CGRectMake(0,0, __MainScreen_Width,heightLine) targetView:view_BalanceAndPayPwd backColor:color_body];

    //  --  我的账户余额.
    lbl_leftBalance = [[UILabel alloc] initWithFrame:CGRectMake(8, heightLine, def_WidthArea(10), rowHeight)];
    [lbl_leftBalance setBackgroundColor:[UIColor clearColor]];
    [lbl_leftBalance setText:[NSString stringWithFormat:@"我的余额：    %@",[self convertPrice:f_userUnitBalance]]];
    [lbl_leftBalance setFont:defFont14];
    [lbl_leftBalance setTextColor:color_4e4e4e];
    [view_BalanceAndPayPwd addSubview:lbl_leftBalance];
    [UICommon Common_line:CGRectMake(0, rowHeight+heightLine, __MainScreen_Width,0.5) targetView:view_BalanceAndPayPwd backColor:color_d1d1d1];
    
    //  --  使用余额.
    lbl_UserMyBalance = [[UILabel alloc] initWithFrame:CGRectMake(8, rowHeight+heightLine, 180, rowHeight)];
    [lbl_UserMyBalance setBackgroundColor:[UIColor clearColor]];
    [lbl_UserMyBalance setText:[NSString stringWithFormat:@"使用余额：    %@",[self convertPrice:f_UsedMyMoney]]];
    [lbl_UserMyBalance setFont:defFont14];
    [lbl_UserMyBalance setTextColor:color_4e4e4e];
    [view_BalanceAndPayPwd addSubview:lbl_UserMyBalance];
    
    // --   使用账户开关...
    btnSwitch_Balance = [EC_UISwitch buttonWithType:UIButtonTypeCustom];
    [btnSwitch_Balance setFrame: CGRectMake( __MainScreen_Width-61, rowHeight+heightLine+7, 102/2, 62/2)];
    [btnSwitch_Balance setTag:3003];
    [btnSwitch_Balance setOn: isUsedBalance?YES:NO];
    [btnSwitch_Balance setBackgroundColor:[UIColor clearColor]];
    [btnSwitch_Balance addTarget:self action:@selector(onSwitchClick:) forControlEvents:UIControlEventTouchUpInside];
    [view_BalanceAndPayPwd addSubview:btnSwitch_Balance];
    
    [UICommon Common_line:CGRectMake(0, rowHeight*2+heightLine,__MainScreen_Width,0.5) targetView:view_BalanceAndPayPwd backColor:color_d1d1d1];
    
    //  --  支付密码 视图
    view_userBalance = [[UIView alloc] initWithFrame:CGRectMake(0, rowHeight*2+heightLine, __MainScreen_Width, rowHeight)];
    [view_userBalance setBackgroundColor:[UIColor clearColor]];
    [view_userBalance setHidden:YES];
    view_userBalance.userInteractionEnabled = YES;
    [view_BalanceAndPayPwd addSubview:view_userBalance];
    
    [UICommon Common_UILabel_Add:CGRectMake(8, 0, 100, rowHeight) targetView:view_userBalance
                         bgColor:[UIColor clearColor] tag:3004
                            text:@"支付密码：" align:-1 isBold:NO fontSize:14 tColor:color_4e4e4e];
    
    /*  已设置支付密码 情况 */
    txtPayPwd = [[EC_UITextField alloc] initWithFrame:CGRectMake(93, 5, 175, 35)];
    [txtPayPwd setTextFieldState:ECTextFieldGary];
    [txtPayPwd setSecureTextEntry:YES];
    [txtPayPwd setPlaceholder:@"输入支付密码"];
    [txtPayPwd setDelegate:self];
    [txtPayPwd setFont:defFont14];
    [view_userBalance addSubview:txtPayPwd];
    
    btn_okPayPwd = [[UIButton alloc] initWithFrame:CGRectMake(__MainScreen_Width-60, 5, 50, 35)];
    [btn_okPayPwd setTag:3005];
    [btn_okPayPwd setTitle:@"确定" forState:UIControlStateNormal];
    [btn_okPayPwd setBackgroundImage:def_ImgStretchable(@"test_get_code_bg.png", 3, 3) forState:UIControlStateNormal];
    [btn_okPayPwd.titleLabel setFont: defFont(YES, 14)];
    [btn_okPayPwd addTarget:self action:@selector(onPayClick:) forControlEvents:UIControlEventTouchUpInside];
    [view_userBalance addSubview:btn_okPayPwd];

    /*  从未设置过支付密码 情况*/
    btn_setPayPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_setPayPwd setBackgroundColor:[UIColor clearColor]];
    [btn_setPayPwd setFrame:CGRectMake(93, 5, 200, 35)];
    [btn_setPayPwd setTitle:@"支付密码未设置," forState:UIControlStateNormal];
    [btn_setPayPwd setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn_setPayPwd.titleLabel setFont: defFont(NO, 14)];
    [btn_setPayPwd setTitleColor:color_989898 forState:UIControlStateNormal];
    [btn_setPayPwd addTarget:self action:@selector(onSetPayPwdClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lbl_setPwdWarn = [[UILabel alloc] initWithFrame:CGRectMake(105, 0, 70, CGRectGetHeight(btn_setPayPwd.frame))];
    [lbl_setPwdWarn setBackgroundColor:[UIColor clearColor]];
    [lbl_setPwdWarn setText:@"点击设置"];
    [lbl_setPwdWarn setTextColor:color_8fc31f];
    [lbl_setPwdWarn setFont:defFont14];
    [btn_setPayPwd addSubview:lbl_setPwdWarn];
    [view_userBalance addSubview:btn_setPayPwd];
    
    
    
//    BQCustomBarButtonItem
    
    
    
    //  --  第三部分内容  ***********************************************************
    
    viewContent_3 = [[UIView alloc] initWithFrame:CGRectMake(0, viewContent_1.frame.size.height+viewContent_2.frame.size.height, __MainScreen_Width, rowHeight*5 + heightPayRow*arrPayType.count + heightLine*4)];
    [viewContent_3 setBackgroundColor:[UIColor whiteColor]];
    [rootScrollView addSubview:viewContent_3];
    
    [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width,heightLine) targetView:viewContent_3 backColor:color_body];

    // -- 应付款.
    [UICommon Common_UILabel_Add:CGRectMake(8, heightLine, 150, rowHeight) targetView:viewContent_3 bgColor:[UIColor clearColor] tag:4001 text:@"应付金额：" align:-1 isBold:NO fontSize:14 tColor:color_4e4e4e];
    lbl_ShouldPay = [[UILabel alloc] initWithFrame:CGRectMake(8, heightLine, def_WidthArea(10), rowHeight)];
    [lbl_ShouldPay setBackgroundColor:[UIColor clearColor]];
    [lbl_ShouldPay setFont:defFont14];
    [lbl_ShouldPay setText:[self convertPrice:modOrderInfo.OrderPrice]];
    [lbl_ShouldPay setTextColor:color_4e4e4e];
    [lbl_ShouldPay setTextAlignment:NSTextAlignmentRight];
    [viewContent_3 addSubview:lbl_ShouldPay];
    [UICommon Common_line:CGRectMake(0, rowHeight+heightLine, __MainScreen_Width,0.5) targetView:viewContent_3 backColor:color_d1d1d1];
    
    // -- 优惠券.
    [UICommon Common_UILabel_Add:CGRectMake(8, rowHeight+heightLine, 150, rowHeight) targetView:viewContent_3 bgColor:[UIColor clearColor] tag:4003 text:@"使用优惠券：" align:-1 isBold:NO fontSize:14 tColor:color_4e4e4e];
    lbl_UsedCouponPrice = [[UILabel alloc] initWithFrame:CGRectMake(8, rowHeight+heightLine, def_WidthArea(10), rowHeight)];
    [lbl_UsedCouponPrice setBackgroundColor:[UIColor clearColor]];
    [lbl_UsedCouponPrice setTextAlignment:NSTextAlignmentRight];
    [lbl_UsedCouponPrice setText:[self convertPrice:f_CouponPrice]];
    [lbl_UsedCouponPrice setFont:defFont14];
    [lbl_UsedCouponPrice setTextColor:color_4e4e4e];
    [viewContent_3 addSubview:lbl_UsedCouponPrice];
    [UICommon Common_line:CGRectMake(0, rowHeight*2+heightLine, __MainScreen_Width,0.5) targetView:viewContent_3 backColor:color_d1d1d1];
    
    // -- 使用账户余额.
    [UICommon Common_UILabel_Add:CGRectMake(8, rowHeight*2+heightLine, 100, rowHeight) targetView:viewContent_3 bgColor:[UIColor clearColor] tag:4004 text:@"使用余额：" align:-1 isBold:NO fontSize:14 tColor:color_4e4e4e];
    lbl_UsedBalance = [[UILabel alloc]initWithFrame:CGRectMake(8,rowHeight*2+heightLine,def_WidthArea(10),rowHeight)];
    [lbl_UsedBalance setBackgroundColor:[UIColor clearColor]];
    [lbl_UsedBalance setTextAlignment:NSTextAlignmentRight];
    [lbl_UsedBalance setText:[self convertPrice:f_UsedMyMoney]];
    [lbl_UsedBalance setFont:defFont14];
    [lbl_UsedBalance setTextColor:color_4e4e4e];
    [viewContent_3 addSubview:lbl_UsedBalance];
    [UICommon Common_line:CGRectMake(0, rowHeight*3+heightLine, __MainScreen_Width,heightLine) targetView:viewContent_3 backColor:color_body];

    // -- 还需支付.
    [UICommon Common_UILabel_Add:CGRectMake(8, rowHeight*3+heightLine*2, 150, rowHeight) targetView:viewContent_3 bgColor:[UIColor clearColor] tag:5001 text:@"还需支付：" align:-1 isBold:NO fontSize:15 tColor:color_4e4e4e];
    float totalPrice = modOrderInfo.OrderPrice;
    lbl_needPay = [[UILabel alloc] initWithFrame:CGRectMake(8, rowHeight*3+heightLine*2, def_WidthArea(10), rowHeight)];
    [lbl_needPay setBackgroundColor:[UIColor clearColor]];
    [lbl_needPay setTextAlignment:NSTextAlignmentRight];
    [lbl_needPay setText:[self convertPrice: totalPrice-f_CouponPrice-f_UsedMyMoney]];
    [lbl_needPay setFont:defFont14];
    [lbl_needPay setTextColor:color_fc4a00];
    [viewContent_3 addSubview:lbl_needPay];
    [UICommon Common_line:CGRectMake(0, rowHeight*4+heightLine*2, __MainScreen_Width,heightLine) targetView:viewContent_3 backColor:color_body];

    
    //  --  选择支付方式
    [UICommon Common_UILabel_Add:CGRectMake(8, rowHeight*4+heightLine*3, 150, 40) targetView:viewContent_3 bgColor:[UIColor clearColor] tag:6001 text:@"选择支付方式" align:-1 isBold:NO fontSize:15 tColor:color_4e4e4e];
    [UICommon Common_line:CGRectMake(0, rowHeight*5+heightLine*3, __MainScreen_Width,0.5) targetView:viewContent_3 backColor:color_d1d1d1];
    
    int i=0;
    float yPoint = rowHeight*5+heightLine*3;
    for (resMod_PayTypeInfo * mpay in arrPayType) {
        yPoint += heightPayRow*i;
        [self addViewPayCell:viewContent_3 cgFrame:CGRectMake(0, yPoint, __MainScreen_Height, heightPayRow) payInfo:mpay];
        i++;
    }
    
    //  -- scroll frame Content
    [rootScrollView setContentSize:CGSizeMake(__MainScreen_Width, viewContent_1.frame.size.height+viewContent_2.frame.size.height+viewContent_3.frame.size.height+45)];
    
    //  --  确定支付按钮
    btn_pay = [[UIButton alloc] initWithFrame:CGRectMake(12, rootScrollView.contentSize.height - 46, def_WidthArea(12), 40)];
    [btn_pay setTag:7000];
    [btn_pay setTitle:@"确定支付" forState:UIControlStateNormal];
    [btn_pay setBackgroundColor: color_fc4a00];
    [btn_pay.titleLabel setFont: defFont(NO, 17)];
    btn_pay.layer.cornerRadius = 2.0f;
    [btn_pay addTarget:self action:@selector(onPayClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollView addSubview:btn_pay];
}

#pragma mark    --  支付密码设置
- (void)onSetPayPwdClick:(id) sender{
    
    //如果没有绑定手机号
    if ([[UserUnit userMobile] isEqualToString: @""]) {
        BQBindTelephoneNumberView *bindView = [[BQBindTelephoneNumberView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreenFrame.size.height) titleString:@"绑定手机号" forState:authCodeState];
        bindView.tag = 1234;
        bindView.delegate = self;
        bindView.apiRequestSelector = @selector(goApiRequest_GetCode:);
        bindView.cancelButtonSelector = @selector(cancelbuttonClicked:);
        bindView.enterButtonSelector = @selector(enterButtonClicked:);
        
        UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
        [keyWindow addSubview:bindView];
        [keyWindow sendSubviewToBack:self.view];
        
        bindView.alpha = 0.0f;
        [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            bindView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
        }];
    }
    //如果已绑定手机号
    else {
        BQBindTelephoneNumberView *bindView = [[BQBindTelephoneNumberView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreenFrame.size.height) titleString:@"设置支付密码" forState:setPayPwdState];
        bindView.tag = 1234;
        bindView.delegate = self;
        bindView.cancelButtonSelector = @selector(cancelbuttonClicked:);
        bindView.enterButtonSelector = @selector(enterButtonClicked:);
        
        UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
        [keyWindow addSubview:bindView];
        [keyWindow sendSubviewToBack:self.view];
        
        bindView.alpha = 0.0f;
        [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            bindView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)cancelbuttonClicked:(UIButton*)button{
    BQBindTelephoneNumberView *bindView = (BQBindTelephoneNumberView*)[[UIApplication sharedApplication].keyWindow viewWithTag:1234];
    
    [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        bindView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:1234] performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0];
    }];
}

- (void)enterButtonClicked:(NSMutableDictionary*)dict{
    if (![NSString isPhoneNum:[UserUnit userMobile]])
    {
        //绑定手机号接口
        NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
        if ([[UserUnit userId] isEqualToString:@""]) {
            BQBindTelephoneNumberView *bindView = (BQBindTelephoneNumberView*) [[UIApplication sharedApplication].keyWindow viewWithTag:1234];
            [bindView HUDShow:@"请您先登录后再绑定手机号" delay:2];
            return;
        }
        
        backTelString = [dict objectForKey:@"tel"];
        
        [paraDict setValue:[UserUnit userId] forKey:@"UserId"];
        [paraDict setValue: backTelString forKey:@"Telephone"];
        [paraDict setValue:[dict objectForKey:@"code"] forKey:@"AuthCode"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestBindTelephone:paraDict ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在绑定" delegate:self];
        
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_BindTelephone class:@"ResponseBase"
//                  params:paraDict  isShowLoadingAnimal:NO hudShow:@"正在绑定"];
    }
    else
    {
        NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
        [paraDict setValue:[UserUnit userId] forKey:@"UserId"];
        [paraDict setValue: [dict objectForKey:@"password"]forKey:@"Password"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestSetPayPassword:paraDict ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在设置支付密码" delegate:self];

//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_SetPayPassword class:@"ResponseBase"
//                  params:paraDict  isShowLoadingAnimal:NO hudShow:@"正在设置支付密码"];
    }
}

#pragma mark    --  event
//  -- 确认支付
- (void)onPayClick:(id)sender{
    UIButton * btnTmp = (UIButton*)sender;
    if (btnTmp.tag==3005) {
        if (txtPayPwd.text.length>0) {
            [txtPayPwd resignFirstResponder];
            [self  goApi_PayAmountDetail:@""];
        }
        else{
            [self HUDShow:@"请输入支付密码" delay:1.5];
        }
    }
    else if(btnTmp.tag==7000){
        [self goPayOrder];
    }
}

//  --选择支付类型
-(void)onPayTypeCheckClick:(id) sender{
    UIButton * tmpBtn = (UIButton*) sender;
    resMod_PayTypeInfo * pinfo;
    
    for (resMod_PayTypeInfo * spay in arrPayType) {
        UIButton * btn = (UIButton*)[viewContent_3 viewWithTag: payButtonTag+spay.payTypeId];
        if (btn.tag!=tmpBtn.tag) {
            spay.payIsChecked = NO;
            [btn setImage:[UIImage imageNamed:@"checkbox_greenUnsel"] forState:UIControlStateNormal];
        }
        else{
            pinfo = spay;
        }
    }
    pinfo.payIsChecked = !pinfo.payIsChecked;
    selectPayType = pinfo.payIsChecked ? pinfo.payTypeId : -1000;
    [tmpBtn setImage:[UIImage imageNamed:pinfo.payIsChecked?@"checkbox_greensel":@"checkbox_greenUnsel"] forState:UIControlStateNormal];
}

//  --选择优惠券
- (void) OnCouponChecked:(id) sender{
    [txtCouponCode resignFirstResponder];
    if (txtCouponCode.enabled) {
        UIButton * btntmp = (UIButton*) sender;
        for (UIButton * btn in view_couponlist.subviews) {
            UIImageView * imgcheck = (UIImageView*)[btn viewWithTag:222333];
            if (imgcheck) {
                [imgcheck setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"]];
            }
        }
        
        UIImageView * imgcheck = (UIImageView*)[btntmp viewWithTag:222333];
        [imgcheck setImage:[UIImage imageNamed:@"checkbox_greensel.png"]];
        
        UILabel * lblCouponNO = (UILabel*)[btntmp viewWithTag:444555];
        txtCouponCode.text = lblCouponNO.text;
        [self goApi_PayAmountDetail:@""];
    }
}

#pragma mark - switch Method
-(void)onSwitchClick:(EC_UISwitch *)sender {

    if (sender.tag == 2002) {       //-- 打开使用优惠券
        
        [txtCouponCode resignFirstResponder];
        if (isUsedCoupon) {
            return;
        }
        
        sender.on = !sender.on;
        [UIView animateWithDuration:0.3 animations:^{
            if (sender.on) {
                [MobClick event:@"serviceOrderPay_useTicket"];
                [txtCouponCode setFrame: CGRectMake(txtCouponCode.frame.origin.x, txtCouponCode.frame.origin.y, 150, txtCouponCode.frame.size.height)];
                [self goApiRequest_GetCoupons];
            }
            else{
                [MobClick event:@"serviceOrderPay_removeTicket"];
                txtCouponCode.text = @"";
                f_CouponPrice = 0.0;
                
                [self goApi_PayAmountDetail:@""];
                [txtCouponCode setFrame: CGRectMake(txtCouponCode.frame.origin.x, txtCouponCode.frame.origin.y, 0, txtCouponCode.frame.size.height)];
                [self showView_Coupons:NO];
            }
        }];
    }
    else if(sender.tag == 3003){    //--使用余额
        
        [txtPayPwd resignFirstResponder];
        if (isUsedBalance) {
            return;
        }
        
        sender.on = !sender.on;
        [MobClick event: sender.on ? @"serviceOrderPay_useBalance":@"serviceOrderPay_removeBalance"];
        
        BOOL isSetPwd = [UserUnit shareLogin].m_userhasPayPassword;
        if (isSetPwd) {
            if (f_userUnitBalance==0) {
                sender.on = NO;
                f_UsedMyMoney = 0.0;
                [self HUDShow:@"您账户暂无可用余额" delay:2];
                return;
            }
            //  -- 不使用余额时清掉
            if (!sender.on) {
                txtPayPwd.text =@"";
                f_UsedMyMoney = 0.0;
                b_isRightPayPwd = NO;
                [self goApi_PayAmountDetail:@""];
            }
        }
        
        //  -- 显示是否使用余额
        [self showView_userBalance:sender.on];
    }
}

//  --  展开 or 收起 可用优惠券列表
- (void) showView_Coupons:(BOOL) b_show{
    if (view_couponlist.hidden && !b_show) {
        return;
    }
    
    if (self.arrCoupons.count>0) {
        float fCouponListHeight = heightForConponButton*(self.arrCoupons.count>3?3:self.arrCoupons.count);
        [UIView animateWithDuration:0.2 animations:^{
            if (b_show) {
                [viewContent_2 setFrame:CGRectMake(viewContent_2.frame.origin.x, viewContent_2.frame.origin.y, viewContent_2.frame.size.width, viewContent_2.frame.size.height + fCouponListHeight)];
                
                [view_couponlist setFrame:CGRectMake(0,view_couponlist.frame.origin.y, __MainScreen_Width, fCouponListHeight)];
                [view_couponlist setContentSize:CGSizeMake(__MainScreen_Width, heightForConponButton*self.arrCoupons.count)];
                [view_BalanceAndPayPwd setFrame:CGRectMake(0, view_BalanceAndPayPwd.frame.origin.y+fCouponListHeight, __MainScreen_Width, view_BalanceAndPayPwd.frame.size.height)];
                
                [viewContent_3 setFrame:CGRectMake(viewContent_3.frame.origin.x, viewContent_3.frame.origin.y+fCouponListHeight, viewContent_3.frame.size.width, viewContent_3.frame.size.height + fCouponListHeight)];
                [rootScrollView setContentSize:CGSizeMake(__MainScreen_Width, rootScrollView.contentSize.height+fCouponListHeight)];
            }
            else{
                [view_couponlist setFrame:CGRectMake(0,view_couponlist.frame.origin.y, __MainScreen_Width, 0)];
                [view_BalanceAndPayPwd setFrame:CGRectMake(0, view_BalanceAndPayPwd.frame.origin.y-fCouponListHeight, __MainScreen_Width, view_BalanceAndPayPwd.frame.size.height)];
                [viewContent_2 setFrame:CGRectMake(viewContent_2.frame.origin.x, viewContent_2.frame.origin.y, viewContent_2.frame.size.width, viewContent_2.frame.size.height - fCouponListHeight)];
                
                [viewContent_3 setFrame:CGRectMake(viewContent_3.frame.origin.x, viewContent_3.frame.origin.y-fCouponListHeight, viewContent_3.frame.size.width, viewContent_3.frame.size.height - fCouponListHeight)];
                [rootScrollView setContentSize:CGSizeMake(__MainScreen_Width, rootScrollView.contentSize.height-fCouponListHeight)];
            }
            
            [btn_pay setFrame: CGRectMake(12, rootScrollView.contentSize.height - 46, def_WidthArea(12), 40)];
        }];
    }
}
//  --  展开 or 收起 余额支付密码区
- (void) showView_userBalance:(BOOL) b_show{
    
    //  -- 如果本来是隐藏的，现在还要隐藏，就不隐藏
    
    
    
    if (view_userBalance.hidden && !b_show) {
        return;
    }
    
    BOOL isSetPwd = [UserUnit shareLogin].m_userhasPayPassword;
    [txtPayPwd setHidden:!isSetPwd];
    [btn_okPayPwd setHidden:!isSetPwd];
    [btn_setPayPwd setHidden:isSetPwd];
    
    [UIView animateWithDuration:0.2 animations:^{
        if (b_show) {
            [MobClick event:@"serviceOrderPay_useBalance"];
            [view_userBalance setHidden:NO];
            [viewContent_3 setFrame:CGRectMake(viewContent_3.frame.origin.x, viewContent_3.frame.origin.y+rowHeight, viewContent_3.frame.size.width, viewContent_3.frame.size.height)];
            [view_BalanceAndPayPwd setFrame:CGRectMake(0, view_BalanceAndPayPwd.frame.origin.y, __MainScreen_Width, view_BalanceAndPayPwd.frame.size.height+rowHeight)];
            [viewContent_2 setFrame:CGRectMake(viewContent_2.frame.origin.x, viewContent_2.frame.origin.y, viewContent_2.frame.size.width, viewContent_2.frame.size.height + rowHeight)];
            [rootScrollView setContentSize:CGSizeMake(__MainScreen_Width, rootScrollView.contentSize.height+rowHeight)];
        }
        else{
            [MobClick event:@"serviceOrderPay_removeBalance"];
            [view_BalanceAndPayPwd setFrame:CGRectMake(0, view_BalanceAndPayPwd.frame.origin.y, __MainScreen_Width, view_BalanceAndPayPwd.frame.size.height-(view_userBalance.hidden?0:rowHeight))];
            [viewContent_2 setFrame:CGRectMake(viewContent_2.frame.origin.x, viewContent_2.frame.origin.y, viewContent_2.frame.size.width, viewContent_2.frame.size.height - (view_userBalance.hidden?0:rowHeight))];
            [viewContent_3 setFrame:CGRectMake(viewContent_3.frame.origin.x, viewContent_3.frame.origin.y-rowHeight, viewContent_3.frame.size.width, viewContent_3.frame.size.height)];
            [rootScrollView setContentSize:CGSizeMake(__MainScreen_Width, rootScrollView.contentSize.height-rowHeight)];
            
            [view_userBalance setHidden:YES];
        }
        [btn_pay setFrame: CGRectMake(12, rootScrollView.contentSize.height - 46, def_WidthArea(12), 40)];
    }];
}

//  -- 算使用余额
- (void) getUserMoney{
//    f_UsedMyMoney = 0.0;
//    float RemovalCouponMoney=0;
//    if (f_userUnitBalance>0 && btnSwitch_Balance.on) {
//        RemovalCouponMoney = modOrderInfo.OrderPrice - f_CouponPrice;
//        f_UsedMyMoney = f_userUnitBalance>=RemovalCouponMoney ? RemovalCouponMoney : f_userUnitBalance;
//    }
    lbl_UserMyBalance.text = [NSString stringWithFormat:@"使用余额：    %@",[self convertPrice:f_UsedMyMoney]];
    [lbl_UsedCouponPrice setText:[self convertPrice:f_CouponPrice]];
    [lbl_UsedBalance     setText:[self convertPrice:f_UsedMyMoney]];
    [lbl_needPay setText:[self convertPrice:f_needPay]];
}
#pragma mark    --  api 请 求 & 回 调
//--发送验证码
- (void)goApiRequest_GetCode:(NSMutableDictionary*)dicParams{
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestSendAuthCode:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在获取" delegate:self];
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_SendAuthCodeForRegister class:@"ResponseBase"
//              params:dicParams  isShowLoadingAnimal:NO hudShow:@"正在获取"];
    
}

- (void)goApiRequest_GetCoupons{
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
    [pms setValue:[NSString stringWithFormat:@"%d",modOrderInfo.OrderId] forKeyPath:@"OrderId"];
    [pms setValue:[UserUnit userId] forKeyPath:@"UserId"];
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestLifeGetPetLifeHouseCouponO2O:pms ModelClass:@"resMod_CallBack_MyCouponList" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
}

////--验证coupon
//-(void)goApi_CheckCoupon:(NSString *) code{
//    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [pms setValue:[NSString stringWithFormat:@"%d",modOrderInfo.OrderId] forKeyPath:@"OrderId"];
//    [pms setValue:[UserUnit userId] forKeyPath:@"UserId"];
//    [pms setValue:txtCouponCode.text forKeyPath:@"CouponNo"];
//    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_CheckCoupon class:@"resMod_CallBack_CheckCoupon"
//              params:pms hudShow:@"正在验证"];
//}
//
////--验证支付密码
//-(void)goApi_CheckPayPwd{
//    if (txtPayPwd.text.length>0) {
//        NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
//        [pms setValue:[UserUnit userId] forKeyPath:@"UserId"];
//        [pms setValue:[NSString YKMD5:txtPayPwd.text] forKeyPath:@"Password"];
//        
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_CheckPayPwd class:@"ResponseBase"
//                  params:pms hudShow:@"正在验证"];
//    }
//}
//--验证coupon 或 支付密码 并返回支付明细
- (void) goApi_PayAmountDetail:(NSString *) code{
    
    NSString * couponcode = code.length==0 ? txtCouponCode.text:code;
    
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
    [pms setValue:[NSString stringWithFormat:@"%d",modOrderInfo.OrderId] forKeyPath:@"OrderId"];
    [pms setValue:[UserUnit userId] forKeyPath:@"UserId"];
    if (couponcode.length>0) {
        [pms setValue:couponcode forKeyPath:@"CouponNo"];
    }
    if (txtPayPwd.text.length>0) {
        [pms setValue:[NSString YKMD5:txtPayPwd.text] forKeyPath:@"Password"];
    }
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetPayAmountDetail:pms ModelClass:@"resMod_CallBack_GetPayAmountDetail" showLoadingAnimal:NO hudContent:@"正在验证" delegate:self];
    
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_PayAmountDetail class:@"resMod_CallBack_GetPayAmountDetail"
//              params:pms  isShowLoadingAnimal:NO hudShow:@"正在验证"];
}


#pragma mark -######
//  -- 订单支付
- (void) goPayOrder{
    
    [MobClick event:@"serviceOrderPay_ensurePay"];
    
    if (selectPayType<0) {
        if(!btnSwitch_Balance.on){
            [self HUDShow:@"请选择支付方式" delay:2];
            return;
        }
        if (btnSwitch_Balance.on && txtPayPwd.text.length==0) {
            [self HUDShow:@"余额支付需输入支付密码" delay:2];
            return;
        }
        if (f_needPay>0) {
            [self HUDShow:@"余额不足,需选择支付方式" delay:2];
            return;
        }
    }
    
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
    [pms setValue:[UserUnit userId] forKeyPath:@"UserId"];
    [pms setValue:[NSString stringWithFormat:@"%d",modOrderInfo.OrderId] forKeyPath:@"OrderId"];
    [pms setValue:[NSString stringWithFormat:@"%.2f",modOrderInfo.OrderPrice] forKeyPath:@"OrderAmount"];
    if (selectPayType>0) {
        [pms setValue:[NSString stringWithFormat:@"%d",selectPayType] forKeyPath:@"Type"];
    }
    [pms setValue:txtCouponCode.text forKeyPath:@"DiscountCode"];
    [pms setValue:[NSString stringWithFormat:@"%@",(b_isRightPayPwd&&!isUsedBalance)?@"1":@"0"] forKeyPath:@"IsBalance"];
    [pms setValue:txtPayPwd.text forKeyPath:@"PayPassword"];
    
    if (selectPayType == WXPay) {
        [MobClick event:@"serviceOrderPay_WechatPay"];
    }
    else if (selectPayType == AliAppPay)    {
        [MobClick event:@"serviceOrderPay_Alipay"];
    }
    
    
    if (selectPayType == WXPay && ![WXApi isWXAppInstalled])
    {
        [self alert:@"温馨提示" msg:@"您还没有安装微信,是否现在去安装微信?"];
        return;
    }
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestPayOrder:pms ModelClass:@"resMod_CallBack_PayOrder" showLoadingAnimal:NO hudContent:@"支付请求..." delegate:self];
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_PayOrder class:@"resMod_CallBack_PayOrder"
//              params:pms  isShowLoadingAnimal:NO hudShow:@"支付请求..."];
    
    // -- 如使用账户余额，进入第三方之后会扣除，所以这里要更新下
    f_userUnitBalance = [[UserUnit userBalance] floatValue];
    [lbl_leftBalance setText:[NSString stringWithFormat:@"我的余额：    %@",[self convertPrice:f_userUnitBalance]]];
}

//  -- 成功支付
-(void)HUDdelayDo {
    
    //  -- 支付成功 更新本地用户信息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updataUserInfo" object:nil];
    
    if (b_isFromUserCenter) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"payok" object:nil];
        [self goBack:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoRootNotification" object:@"goBoqiiLifeOrder"];
    }
}


-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];

    if ([ApiName isEqualToString:kApiMethod_SendAuthCodeForRegister]) {
        ResponseBase *backObject = [[ResponseBase alloc] initWithDic:retObj];
        [self showTips:backObject.ResponseMsg];
    }
    else if ([ApiName isEqualToString:kApiMethod_BindTelephone]){
        ResponseBase *backObject = [[ResponseBase alloc] initWithDic:retObj];
        [self showTips:backObject.ResponseMsg];
        
        [UserUnit writeTelephoneNum:backTelString];
    
        [self updateUserInfo];
        
        [self performSelector:@selector(cancelbuttonClicked:) withObject:nil afterDelay:0.5];
        
        [self onSetPayPwdClick:nil];
    }
    else if ([ApiName isEqualToString:kApiMethod_SetPayPassword]){
        ResponseBase *backObject = [[ResponseBase alloc] initWithDic:retObj];
        [self showTips:backObject.ResponseMsg];
        [UserUnit writeUserHasPayPassword:1];
        
        [self updateUserInfo];
        
        [self performSelector:@selector(cancelbuttonClicked:) withObject:nil afterDelay:0.5];

        //  --先关闭下在打开， 不然frame会算错
        btnSwitch_Balance.on = NO;
        [self showView_userBalance:NO];
        if (f_userUnitBalance>0) {
            btnSwitch_Balance.on = YES;
            [self showView_userBalance:YES];
        }
    }
    else if ([ApiName isEqualToString:kApiMethod_GetPetLifeHouseCoupon]){
        resMod_CallBack_MyCouponList * backObj = [[resMod_CallBack_MyCouponList alloc] initWithDic:retObj];
        if (backObj.ResponseData.count>0) {
            self.arrCoupons = backObj.ResponseData;
            
            for (UIButton * btntmp in view_couponlist.subviews) {
                [btntmp removeFromSuperview];
            }
            
            int i=0;
            for (resMod_MyCouponInfo * coupon in self.arrCoupons) {
                UIButton * btnCouponInfo = [UIButton buttonWithType:UIButtonTypeCustom];
                [btnCouponInfo setTag:coupon.CouponId];
                [btnCouponInfo setBackgroundColor:[UIColor clearColor]];
                [btnCouponInfo setFrame:CGRectMake(0, heightForConponButton*i, __MainScreen_Width, heightForConponButton)];
                [btnCouponInfo setTitle:coupon.CouponTitle forState:UIControlStateNormal];
                [btnCouponInfo setTitleColor:color_989898 forState:UIControlStateNormal];
                [btnCouponInfo.titleLabel setFont:defFont14];
                [btnCouponInfo setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                [btnCouponInfo setTitleEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
                [btnCouponInfo addTarget:self action:@selector(OnCouponChecked:) forControlEvents:UIControlEventTouchUpInside];
                [view_couponlist addSubview:btnCouponInfo];
                
                UIImageView * imgCheck = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 18, 18)];
                [imgCheck setTag:222333];
                [imgCheck setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"]];
                [btnCouponInfo addSubview:imgCheck];
                
                UILabel * lblCouponNo = [[UILabel alloc] initWithFrame:CGRectZero];
                [lblCouponNo setHidden:YES];
                [lblCouponNo setTag:444555];
                [lblCouponNo setText:coupon.CouponNo];
                [btnCouponInfo addSubview:lblCouponNo];
                
                [UICommon Common_UILabel_Add:CGRectMake(btnCouponInfo.frame.size.width-120, 10, 100, 20)
                                  targetView:btnCouponInfo bgColor:[UIColor clearColor] tag:111222
                                        text:coupon.CouponDiscount
                                       align:1 isBold:NO fontSize:15 tColor:color_fc4a00];
                i++;
            }
            
            [self showView_Coupons:YES];
        }
    }
    else if ([ApiName isEqualToString:kApiMethod_PayAmountDetail]){
        resMod_CallBack_GetPayAmountDetail * backObj = [[resMod_CallBack_GetPayAmountDetail alloc] initWithDic:retObj];
        resMod_PayAmountDetail * payAmountDetail = backObj.ResponseData;
        if (payAmountDetail) {
            f_CouponPrice = payAmountDetail.CouponPrice;
            f_UsedMyMoney = payAmountDetail.UseBalance;
            f_needPay     = payAmountDetail.NeedPayPrice;

            if(payAmountDetail.UseBalance>0){
                b_isRightPayPwd = YES;
                [self showView_userBalance:NO];
            }
        }
        
        [self getUserMoney];
    }
//    else if ([ApiName isEqualToString:kApiMethod_CheckCoupon]) {
//        resMod_CallBack_CheckCoupon * backObj = retObj;
//        resMod_CheckCoupon * couponInfo = backObj.ResponseData;
//        f_CouponPrice = [couponInfo.CouponPrice floatValue];
//        
//        [self getUserMoney];
//        [self hudWasHidden:HUD];
//    }
//    else if([ApiName isEqualToString:kApiMethod_CheckPayPwd]){
//        b_isRightPayPwd = YES;
//        //  -- 显示是否使用余额
//        [self showView_userBalance:NO];
//        [self getUserMoney];
//        
//        if (b_gopay) {
//            [self goPayOrder];
//        }
//        else{
//            [self HUDShow:@"验证成功" delay:1.5];
//        }
//    }
    else if([ApiName isEqualToString:kApiMethod_PayOrder]){
        resMod_CallBack_PayOrder * backObj=[[resMod_CallBack_PayOrder alloc] initWithDic:retObj];
        payinfo = backObj.ResponseData;
        
        if (payinfo) {
            
            if(payinfo.Type == UserBalancePay)  {   //余额支付
                [self HUDShow:@"支付成功" delay:1.5 dothing:YES];
            }
            else if (payinfo.Type == AliAppPay) {   //支付宝客户端支付
                [self extraParamForPay];
                //  --  支付宝支付结果
                b_hasPayResult = NO;
                //  --  调起支付宝支付
                [AlixLibService payOrder:payinfo.PayMessage AndScheme:Alipay_UrlSchemes
                                 seletor:@selector(paymentResult:) target:self];
            }
            else if (payinfo.Type == WXPay) {       //微信支付
                [self extraParamForPay];
                //调起微信支付
                 NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
                [paramsDic setValue:payinfo.PrepayId forKey:@"PrepayId"];
                [paramsDic setValue:payinfo.NonceStr forKey:@"NonceStr"];
                [paramsDic setValue:payinfo.TimeStamp forKey:@"TimeStamp"];
                [paramsDic setValue:@"Sign=WXPay" forKey:@"Package"];
                [paramsDic setValue:payinfo.AppSignature forKey:@"AppSignature"];
                
                WXHandle *handle = [WXHandle shareWXHandle];
                handle.delegate = self;
                [handle sendPayWithParamDict:paramsDic];
            }
        }
    }
    else if ([ApiName isEqualToString:kApiMethod_QueryOrder])  //查询服务器微信支付结果
    {
        
        resMod_CallBack_QueryOrder *responseObject = [[resMod_CallBack_QueryOrder alloc]initWithDic:retObj];
        WXPayResult = responseObject.ResponseData;
        
        if (WXPayResult.ResultCode == WXPaySuccess) {
            [self showNZAlertView:@"支付状态" message:@"您的订单已支付成功！"];
        }
        else{
              [self showNZAlertView:@"支付状态" message:@"您的订单支付失败！"];
        }
        
    }
}

-(void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName {
    
    [super interfaceExcuteError:error apiName:ApiName];
    
    if ([ApiName isEqual:kApiMethod_PayOrder]) {
    }
    
    if ([ApiName isEqual:kApiMethod_BindTelephone]
        || [ApiName isEqual:kApiMethod_SetPayPassword]
        || [ApiName isEqual:kApiMethod_SendAuthCodeForRegister]) {
        
        NSString *errorString = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        [self showTips:errorString];
    }
}


- (void)extraParamForPay {
    isUsedCoupon   = (isUsedCoupon||txtCouponCode.text.length>0) ? YES:NO;
    isUsedBalance  = (isUsedBalance||txtPayPwd.text.length>0) ? YES:NO;
    [txtCouponCode setEnabled: isUsedCoupon ? NO:YES];
    [txtPayPwd setEnabled: isUsedBalance ? NO:YES];
}

#pragma mark - WXHandleDelegate
- (void)responseFromPayHandle:(id)object{
    //微信返回成功，需要重新查询服务器支付结果，以服务器查询结果为准
#if 0
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[UserUnit userId] forKey:@"UserId"];
    [params setValue:[NSString stringWithFormat:@"%d",modOrderInfo.OrderId] forKeyPath:@"OrderId"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestQueryOrder:params ModelClass:@"resMod_CallBack_QueryOrder" showLoadingAnimal:YES hudContent:@"" delegate: self];
#endif
    
    //暂时不查询服务器回调结果
    
    [self showNZAlertView:@"支付状态" message:@"您的订单已支付成功！"];

}

- (void)requestFromPayHandle:(id)object
{
    
}


- (void)showNZAlertView:(NSString*)title message:(NSString*)msg
{
    NZAlertView *alert = [[NZAlertView alloc]initWithStyle:NZAlertStyleInfo title:title message:msg delegate:self];
    [self HUDdelayDo];
    [alert showWithCompletion:^{
        [alert removeFromSuperview];
    }];
}

//- (void)postNotificationCenterToResignKeyBoard{
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"resignkeyBoard" object:nil];
//}

#pragma  mark - showtips
- (void)showTips:(NSString*)warnstring{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    BQBindTelephoneNumberView *bindView = (BQBindTelephoneNumberView*)[keyWindow viewWithTag:1234];
    [bindView HUDShow:warnstring delay:2];
}

- (void)updateUserInfo{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    BQBindTelephoneNumberView *bindView = (BQBindTelephoneNumberView*)[keyWindow viewWithTag:1234];
    [bindView postNotificationToUpdateUserInfo];
}


#pragma mark    --  支付宝结果处理   begin
//  -- 支付宝 app delegate 支付回调.
-(void)onAliPayResult:(NSNotification *) loginStatus{
    NSString * ntfMsg = (NSString*) loginStatus.object;
    [self onPayResult:ntfMsg];
}

//  -- 支付宝 wap回调函数.
-(void)paymentResult:(NSString *)resultd {
    #if ! __has_feature(objc_arc)
        AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
    #else
        AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
    #endif
    
    [self onPayResult:[NSString stringWithFormat:@"%d",result.statusCode]];
    //	if (result){
    //		if (result.statusCode == 9000){
    //            //交易成功
    //用公钥验证签名 严格验证请使用result.resultString与result.signString验签
    //            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
    //			  id<DataVerifier> verifier;
    //            verifier = CreateRSADataVerifier(key);
    //
    //			if ([verifier verifyString:result.resultString withSign:result.signString]) {
    //                //验证签名成功，交易结果无篡改
    //			}
    //        }
    //        else {
    //            [self HUDShow:@"支付失败" delay:1.5];
    //        }
    //    }
    //    else {
    //        [self HUDShow:@"支付失败" delay:1.5];
    //    }
}

//  -- 支付结果处理 与提示.
-(void)onPayResult:(NSString *) resultCode {
//    NSLog(@"---- 支付宝: %@",resultCode);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updataUserInfo" object:nil];
    if (!b_hasPayResult) {
        if ([resultCode isEqualToString: @"9000"]){
            [self HUDShow:@"支付成功" delay:2 dothing:YES];
        } else if([resultCode isEqualToString: @"8000"]){
            [self HUDShow:@"处理中"   delay:2 dothing:YES];
        } else if([resultCode isEqualToString: @"4000"]){
            [self HUDShow:@"支付失败" delay:2];
        } else if([resultCode isEqualToString: @"6001"]){
            [self HUDShow:@"取消支付" delay:2];
        } else if([resultCode isEqualToString: @"6002"]){
            [self HUDShow:@"网络连接出错" delay:2];
        }
        else{
            [self HUDShow:@"支付出错" delay:1.5];
        }
        b_hasPayResult = YES;
    }
}
#pragma mark    --  支付宝结果处理   end



#pragma mark    --  add common view
- (void) addViewPayCell:(UIView*) cell cgFrame:(CGRect) _frame payInfo:(resMod_PayTypeInfo*) _payinfo{
    
    UIView * viewcell = [[UIView alloc]initWithFrame:_frame];
    [viewcell setBackgroundColor:[UIColor clearColor]];
    [cell addSubview:viewcell];
    
    UIImageView * imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
    [imgIcon setImage:[UIImage imageNamed:_payinfo.payIcon]];
    [viewcell addSubview:imgIcon];
    
    [UICommon Common_UILabel_Add:CGRectMake(65, 4, 200, heightPayRow/2) targetView:viewcell bgColor:[UIColor clearColor]
                             tag:6001 text:_payinfo.payTitle align:-1 isBold:NO fontSize:12 tColor:color_4e4e4e];
    [UICommon Common_line:CGRectMake(8, heightPayRow-1, __MainScreen_Width,1) targetView:viewcell backColor:color_ededed];
    [UICommon Common_UILabel_Add:CGRectMake(65, 23, 200, heightPayRow/2) targetView:viewcell bgColor:[UIColor clearColor]
                             tag:6002 text:_payinfo.payWarning align:-1 isBold:NO fontSize:12 tColor:color_717171];
    
    UIButton * btnCheck = [[UIButton alloc]initWithFrame:CGRectMake(__MainScreen_Width-50, 5, 40, 40)];
    [btnCheck setTag: payButtonTag+_payinfo.payTypeId];
    [btnCheck setBackgroundColor:[UIColor clearColor]];
    [btnCheck setImage:[UIImage imageNamed:_payinfo.payIsChecked ? @"checkbox_greensel":@"checkbox_greenUnsel"]
              forState:UIControlStateNormal];
    [btnCheck addTarget:self action:@selector(onPayTypeCheckClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewcell addSubview:btnCheck];
}

#pragma mark - TextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (textField.tag==2005) {
        [self selectCheckCoupon];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.tag==2005) {
        [self selectCheckCoupon];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *tmpTxt = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger Length = tmpTxt.length - range.length + string.length;
    if(textField.tag == 2005){
        
        if ( Length == 11 ){
            NSString * coup = [NSString stringWithFormat:@"%@%@",textField.text,string];
            if (string.length==0) {
                coup = [coup substringToIndex:coup.length-1];
            }
            textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
            [textField resignFirstResponder];
            
            [self goApi_PayAmountDetail:coup];
        }
        
        [self selectCheckCoupon];
    }
    return YES;
}

- (void) selectCheckCoupon{
    for (resMod_MyCouponInfo * coupon in self.arrCoupons) {
        UIButton * btntmp = (UIButton*)[view_couponlist viewWithTag:coupon.CouponId];
        UIImageView * imgcheck = (UIImageView*)[btntmp viewWithTag:222333];
        if ([coupon.CouponNo isEqualToString:txtCouponCode.text])
            [imgcheck setImage:[UIImage imageNamed:@"checkbox_greensel.png"]];
        else
            [imgcheck setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 消息提示

- (void)alert:(NSString *)title msg:(NSString *)msg
{
    EC_UICustomAlertView *alertView = [[EC_UICustomAlertView alloc]initWithTitle:title message:msg cancelButtonTitle:@"取消" okButtonTitle:@"确定"];
    alertView.delegate1 = self;
    [alertView showInView:[UIApplication sharedApplication].keyWindow];

}


-(void)alertView:(EC_UICustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        [alertView hide];
    }
    else if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        [alertView hide];
    }
}



@end
