//
//  MallOrderPaymentVC.m
//  boqiimall
//
//  Created by YSW on 14-6-26.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "MallOrderPaymentVC.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "DataVerifier.h"
#import "AlixLibService.h"
#import "AlixPayResult.h"

#import "resMod_PayTypeInfo.h"
#import "resMod_PayOrder.h"
#import "BQCustomBarButtonItem.h"
#import "BQBindTelephoneNumberView.h"



#define heightViewTop   50
#define heightPayRow    118/2
#define payButtonTag    8934


@interface MallOrderPaymentVC ()<WXHandleDelegate>
{
    UIView *_hasNoPayPasswordView;
    NSString *backTelString;
}

@end


@implementation MallOrderPaymentVC
@synthesize b_isFromOrderList;
@synthesize payOrderID,OrderTotalPrice;
@synthesize isUsedBalance,BalanceUsed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        arrPayType = [[NSMutableArray alloc] initWithCapacity:0];
        f_userUnitBalance = [[UserUnit userBalance] floatValue];
        
        isUsedBalance = NO;
        BalanceUsed=0.0;
    }
    return self;
}

- (void)goBack:(id)sender {
    if (b_isFromOrderList) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{   // 前面说返回到个人中心，后面改了
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self resetFrame];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:color_bodyededed];
    //[self loadNavBarView];
    [self setTitle:@"在线支付"];
   // [self loadNavBarView:@"在线支付"];
    self.payOrderID = [self.receivedParams objectForKey:@"param_orderid"];
    self.OrderTotalPrice = [[self.receivedParams objectForKey:@"param_orderprice"] floatValue];
    self.isUsedBalance= [[self.receivedParams objectForKey:@"param_isUsedBalance"] isEqualToString:@"100"] ? YES:NO;
    self.BalanceUsed  = [[self.receivedParams objectForKey:@"param_BalanceUsed"] floatValue];
    b_isFromOrderList = [[self.receivedParams objectForKey:@"param_isFromOrderList"] isEqualToString:@"100"] ? YES:NO;
    
    [self initPayTypes];
    
    rootScrollView = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight-kNavBarViewHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [rootScrollView setDelegate:self];
    [rootScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:rootScrollView];
    
    //  -- 头部
    viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, -1, __MainScreen_Width, heightViewTop)];
    [viewTop setBackgroundColor:color_fbf7f7];
    viewTop.layer.borderWidth = 0.5;
    viewTop.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]].CGColor;
    [rootScrollView addSubview:viewTop];
    
    [UICommon Common_UILabel_Add:CGRectMake(10, 0, 100, heightViewTop)
                      targetView:viewTop bgColor:[UIColor clearColor] tag:1112
                            text:@"应付金额:" align:-1 isBold:NO fontSize:16 tColor:color_333333];
    //  --  订单总额.
    lbl_OrderPrice = [[UILabel alloc] initWithFrame:CGRectMake(__MainScreen_Width-150, 0, 140, heightViewTop)];
    [lbl_OrderPrice setBackgroundColor:[UIColor clearColor]];
    [lbl_OrderPrice setText: [self convertPrice:self.OrderTotalPrice]];
    [lbl_OrderPrice setFont:defFont(YES, 17)];
    [lbl_OrderPrice setTextColor:color_fc4a00];
    [lbl_OrderPrice setTextAlignment:NSTextAlignmentRight];
    [viewTop addSubview:lbl_OrderPrice];
    
    //  -- .账户与支付.
    viewContent = [[UIView alloc] init];
    [viewContent setFrame:CGRectMake(0, heightViewTop+10, __MainScreen_Width, heightPayRow*4)];
    [viewContent setBackgroundColor:[UIColor whiteColor]];
    viewContent.layer.borderWidth = 0.5;
    viewContent.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]].CGColor;
    [rootScrollView addSubview:viewContent];
    
    [self loadContentView];
    
    [self getUserMoney];
    
    //  --  确定支付按钮
    btn_pay = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_pay setFrame:CGRectMake(12, __ContentHeight_noTab-65, def_WidthArea(12), 45)];
    [btn_pay setTag:7000];
    [btn_pay setTitle:@"提交支付" forState:UIControlStateNormal];
    [btn_pay setBackgroundColor: color_fc4a00];
    [btn_pay.titleLabel setFont: defFont(NO, 17)];
    btn_pay.layer.cornerRadius = 2.0f;
    [btn_pay addTarget:self action:@selector(goApiRequest_PaymentOrder) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollView addSubview:btn_pay];
    
    //  -- appdelegate 通知支付宝回调结果
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(onAliPayResult:)
                                                 name: @"NotificationAliPayResult"
                                               object: nil];
}

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


- (void) loadContentView{
    
    [UICommon Common_UILabel_Add:CGRectMake(10, 0, 120, 50)
                      targetView:viewContent bgColor:[UIColor clearColor] tag:2110
                            text:@"选择支付方式" align:-1 isBold:NO fontSize:16 tColor:color_fc4a00];
    
    [UICommon Common_line:CGRectMake(110, 25, __MainScreen_Width-120, 0.5) targetView:viewContent backColor:color_d1d1d1];
    
    //  --  账户余额信息
    viewAccountBalance = [[UIView alloc] initWithFrame:CGRectMake(12, 50, 592/2, b_UsedBalance?120:70)];
    [viewAccountBalance setBackgroundColor:[UIColor clearColor]];
    [viewContent addSubview:viewAccountBalance];
    
    //  --  我的余额
    lbl_MyBalance = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, def_WidthArea(30), 20)];
    [lbl_MyBalance setBackgroundColor:[UIColor clearColor]];
    [lbl_MyBalance setText:[NSString stringWithFormat:@"我的波奇账户余额：%@",[self convertPrice:f_userUnitBalance]]];
    [lbl_MyBalance setFont:defFont15];
    [lbl_MyBalance setTextColor:color_333333];
    [lbl_MyBalance setTextAlignment:NSTextAlignmentLeft];
    [viewAccountBalance addSubview:lbl_MyBalance];
    
    btn_selUseBalance = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_selUseBalance setFrame:CGRectMake(0, 33, 40, 30)];
    [btn_selUseBalance setImage:[UIImage imageNamed:self.isUsedBalance?@"checkbox_greensel.png":@"checkbox_greenUnsel.png"]
                       forState:UIControlStateNormal];
    if (!self.isUsedBalance) {
      [btn_selUseBalance addTarget:self action:@selector(onUseBalanceClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [viewAccountBalance addSubview:btn_selUseBalance];
    
    //  --  使用余额
    lbl_UsedMyBalance = [[UILabel alloc] initWithFrame:CGRectMake(40, 39, 150, 20)];
    [lbl_UsedMyBalance setBackgroundColor:[UIColor clearColor]];
    [lbl_UsedMyBalance setText:[NSString stringWithFormat:@"使用余额: %@",[self convertPrice:self.BalanceUsed]]];
    [lbl_UsedMyBalance setFont:defFont14];
    [lbl_UsedMyBalance setTextColor:color_989898];
    [lbl_UsedMyBalance setTextAlignment:NSTextAlignmentLeft];
    [viewAccountBalance addSubview:lbl_UsedMyBalance];
    
    //  --  输支付密码
    viewPWD = [[UIView alloc] initWithFrame:CGRectMake(0, 60, viewAccountBalance.frame.size.width, 60)];
    [viewPWD setBackgroundColor:[UIColor clearColor]];
    [viewPWD setHidden:!b_UsedBalance];
    [viewAccountBalance addSubview:viewPWD];
    [UICommon Common_UILabel_Add:CGRectMake(40, 10, 80, 30)
                      targetView:viewPWD bgColor:[UIColor clearColor] tag:2112
                            text:@"支付密码:"
                           align:-1 isBold:NO fontSize:14 tColor:color_4e4e4e];
    
    txtPayPwd = [[EC_UITextField alloc] initWithFrame:CGRectMake(108, 10, 120, 33)];
    [txtPayPwd setTextFieldState:ECTextFieldBorder];
    [txtPayPwd setSecureTextEntry:YES];
    [txtPayPwd setPlaceholder:@"输入支付密码"];
    [txtPayPwd setDelegate:self];
    [txtPayPwd setFont:defFont14];
    [viewPWD addSubview:txtPayPwd];
    
    UIButton * btn_Buy = [[UIButton alloc] initWithFrame:CGRectMake(viewPWD.frame.size.width-60, 10, 50, 33)];
    [btn_Buy setBackgroundColor:color_fc4a00];
    [btn_Buy setTitle:@"确 认" forState:UIControlStateNormal];
    [btn_Buy.titleLabel setFont: defFont(YES, 14)];
    [btn_Buy addTarget:self action:@selector(onPayPWDClick:) forControlEvents:UIControlEventTouchUpInside];
    btn_Buy.layer.cornerRadius = 3.0f;
    [viewPWD addSubview:btn_Buy];
    
    //  -- 未设置支付密码或手机时
    if ([UserUnit userHasPayPassword] == 0){
        _hasNoPayPasswordView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, viewAccountBalance.frame.size.width, 60)];
        _hasNoPayPasswordView.backgroundColor = [UIColor clearColor];
        [_hasNoPayPasswordView setHidden:!b_UsedBalance];
        [viewAccountBalance addSubview:_hasNoPayPasswordView];
        [UICommon Common_UILabel_Add:CGRectMake(40, 10, 180, 30)
                          targetView:_hasNoPayPasswordView bgColor:[UIColor clearColor] tag:2113
                                text:@"支付密码: 支付密码未设置,"
                               align:-1 isBold:NO fontSize:14 tColor:color_989898];
        
        //
        BQCustomBarButtonItem *item = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(215, 10, viewAccountBalance.frame.size.width - 225, 30)];
        item.Color = [UIColor clearColor];
        item.titleLabel.textColor = [UIColor convertHexToRGB:@"8fc31f"];
        item.titleRect = CGRectMake(0, 0, 120, 30);
        item.titleLabel.font = defFont14 ;
        item.titleLabel.text = @"点此设置";
        item.delegate = self;
        item.selector = @selector(setPayPassword:);
        
        [_hasNoPayPasswordView addSubview:item];
    }
    
    //  --  需支付
    viewNeedPay = [[UIView alloc] initWithFrame:CGRectMake(0, viewAccountBalance.frame.origin.y+viewAccountBalance.frame.size.height, __MainScreen_Width, 55)];
    [viewNeedPay setBackgroundColor:[UIColor clearColor]];
    [viewContent addSubview:viewNeedPay];

    //  --  need pay
    [UICommon Common_UILabel_Add:CGRectMake(13, 0, 100, viewNeedPay.frame.size.height)
                      targetView:viewNeedPay bgColor:[UIColor clearColor] tag:2113
                            text:@"还需支付:"
                           align:-1 isBold:NO fontSize:16 tColor:color_4e4e4e];
    
    //  --  还需支付
    lbl_needPay = [[UILabel alloc] init];
    [lbl_needPay setFrame:CGRectMake(90, 1, 120, viewNeedPay.frame.size.height)];
    [lbl_needPay setBackgroundColor:[UIColor clearColor]];
    [lbl_needPay setText:@""];
    [lbl_needPay setFont:defFont16];
    [lbl_needPay setTextColor:color_fc4a00];
    [lbl_needPay setTextAlignment:NSTextAlignmentLeft];
    [viewNeedPay addSubview:lbl_needPay];
    
    //  --  支付方式
    viewPayType = [[UIView alloc] initWithFrame:CGRectMake(0, viewNeedPay.frame.origin.y+viewNeedPay.frame.size.height, __MainScreen_Width, heightPayRow*arrPayType.count)];
    [viewPayType setBackgroundColor:[UIColor clearColor]];
    [viewContent addSubview:viewPayType];
    
    [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width, 0.5) targetView:viewPayType backColor:color_d1d1d1];
    
    int i=0;
    for (resMod_PayTypeInfo * mpay in arrPayType) {
        [self addViewPayCell:viewPayType cgFrame:CGRectMake(0, heightPayRow*i, __MainScreen_Height, heightPayRow) payInfo:mpay];
        
        if (i>0) {
            UILabel * lbl_dotLine = [[UILabel alloc] initWithFrame:CGRectMake(10, heightPayRow*i-0.5, def_WidthArea(10), 0.5)];
            [lbl_dotLine setBackgroundColor:[UIColor clearColor]];
            lbl_dotLine.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line"]].CGColor;
            lbl_dotLine.layer.borderWidth = 0.5f;
            [viewPayType addSubview:lbl_dotLine];
        }
        i++;
    }
}

- (void) resetFrame{

    BOOL bIsOpenViewPwd = b_PayPwdRight ? NO : b_UsedBalance;
    
    //  --  虚线背景  不能放在动画里，不然会闪。。。
    [viewDottedCornerRadiusBg removeFromSuperview];
    viewDottedCornerRadiusBg = [UICommon Common_DottedCornerRadiusView:CGRectMake(0, 0, 592/2, bIsOpenViewPwd?120:70) targetView:viewAccountBalance tag:2111 dottedImgName:@""];
    [viewAccountBalance sendSubviewToBack:viewDottedCornerRadiusBg];
    
    [UIView animateWithDuration:0.2 animations:^{
        [viewAccountBalance setFrame:CGRectMake(12, 50, 592/2, bIsOpenViewPwd?120:70)];
        
        if ([UserUnit userHasPayPassword] == 1) {
            [viewPWD setHidden:!bIsOpenViewPwd];
            [_hasNoPayPasswordView setHidden:YES];
        }
        else{
            [_hasNoPayPasswordView setHidden:!b_UsedBalance];
        }
        
        [viewNeedPay setFrame:CGRectMake(0, viewAccountBalance.frame.origin.y+viewAccountBalance.frame.size.height, __MainScreen_Width, 55)];
        
        [viewPayType setFrame:CGRectMake(0, viewNeedPay.frame.origin.y+viewNeedPay.frame.size.height, __MainScreen_Width, heightPayRow*arrPayType.count)];
        
        float contentCount = 3+arrPayType.count + (bIsOpenViewPwd?1:0);
        [viewContent setFrame:CGRectMake(0, heightViewTop+10, __MainScreen_Width, heightPayRow*contentCount)];
        [btn_pay setFrame:CGRectMake(12, viewTop.frame.size.height+viewContent.frame.size.height+30,def_WidthArea(12),45)];
        [rootScrollView setContentSize:CGSizeMake(__MainScreen_Width, viewTop.frame.size.height+viewContent.frame.size.height+85)];
    }];
}



- (void)setPayPassword:(id)sender{
    
    //如果没有绑定手机号
    if ([[UserUnit userMobile]  isEqual: @""]) {
        
        BQBindTelephoneNumberView *bindView = [[BQBindTelephoneNumberView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreenFrame.size.height) titleString:@"绑定手机号" forState:authCodeState];
        bindView.tag = 1234;
        
        bindView.delegate = self;
        bindView.showTipsSelector = @selector(delegateHUDShow:);
        bindView.apiRequestSelector = @selector(goApiRequest_SendAuthCode:);
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
    else{
        
        BQBindTelephoneNumberView *bindView = [[BQBindTelephoneNumberView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreenFrame.size.height) titleString:@"设置支付密码" forState:setPayPwdState];
        bindView.tag = 1234;
        
        bindView.delegate = self;
        bindView.showTipsSelector = @selector(delegateHUDShow:);
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

- (void)delegateHUDShow:(NSString *)text{
    [self HUDShow:text delay:2];
}


- (void)cancelbuttonClicked:(UIButton*)button{
    BQBindTelephoneNumberView *bindView = (BQBindTelephoneNumberView*) [[UIApplication sharedApplication].keyWindow viewWithTag:1234];
    
    [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        bindView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:1234] performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0];
        
    }];

}

- (void)enterButtonClicked:(NSMutableDictionary*)dict{
    
    if (![NSString isPhoneNum:[UserUnit userMobile]]){
        //绑定手机号接口
        NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
        if ([[UserUnit userId] isEqualToString:@""]) {
            BQBindTelephoneNumberView *bindView = (BQBindTelephoneNumberView*) [[UIApplication sharedApplication].keyWindow viewWithTag:1234];
            [bindView HUDShow:@"请您先登录后再绑定手机号" delay:2];
            return;
        }
        backTelString = [[dict objectForKey:@"tel"] copy];
        [paraDict setValue:[UserUnit userId] forKey:@"UserId"];
        [paraDict setValue: [dict objectForKey:@"tel"]forKey:@"Telephone"];
        [paraDict setValue:[dict objectForKey:@"code"] forKey:@"AuthCode"];
        
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_BindTelephone class:@"ResponseBase"
//                  params:paraDict  isShowLoadingAnimal:NO hudShow:@"正在绑定"];

        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestBindTelephone:paraDict ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在绑定" delegate:self];
        
        
    }
    else{
        NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
        
        [paraDict setValue:[UserUnit userId] forKey:@"UserId"];
        
        [paraDict setValue: [dict objectForKey:@"password"]forKey:@"Password"];
        
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_SetPayPassword class:@"ResponseBase"
//                  params:paraDict  isShowLoadingAnimal:NO hudShow:@"正在设置支付密码"];

        [[APIMethodHandle shareAPIMethodHandle]goApiRequestSetPayPassword:paraDict ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在设置支付密码" delegate:self];
        
    }
    
}

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

#pragma mark    --  click || event

//  -- 算使用余额
- (void) getUserMoney{
    
    f_UsedMyMoney = 0.0;
    if (f_userUnitBalance>0 && b_UsedBalance) {
        f_UsedMyMoney = f_userUnitBalance>=OrderTotalPrice ? OrderTotalPrice : f_userUnitBalance;
    }
    [lbl_UsedMyBalance setText:[NSString stringWithFormat:@"使用金额:  %@",[self convertPrice:f_UsedMyMoney+self.BalanceUsed]]];
    float fneedpay;
    if (self.isUsedBalance) {
        fneedpay = OrderTotalPrice - self.BalanceUsed;
    }
    else{
        fneedpay = OrderTotalPrice-(b_PayPwdRight ? f_UsedMyMoney:0);
    }
    [lbl_needPay setText:[self convertPrice: fneedpay]];
}

- (void) onUseBalanceClick:(id) sender{
    if (!b_PayPwdRight) {
        b_UsedBalance = !b_UsedBalance;
        [btn_selUseBalance setImage:[UIImage imageNamed:b_UsedBalance?@"checkbox_greensel.png":@"checkbox_greenUnsel.png"]
                           forState:UIControlStateNormal];
        if (!b_UsedBalance) {
            b_PayPwdRight = NO;
            txtPayPwd.text = @"";
            [self getUserMoney];
        }
        [self resetFrame];
    }
}

- (void) onPayPWDClick:(id) sender{
    [self goApiRequest_CheckPWD];
}

//  --选择支付类型
-(void)onPayTypeCheckClick:(id) sender{
    
    UIButton * tmpBtn = (UIButton*) sender;
    resMod_PayTypeInfo * pinfo;
    
    for (resMod_PayTypeInfo * spay in arrPayType) {
        UIButton * btn = (UIButton*)[viewPayType viewWithTag: payButtonTag+spay.payTypeId];
        if (btn.tag!=tmpBtn.tag) {
            spay.payIsChecked = NO;
            [btn setImage:[UIImage imageNamed:@"checkbox_greenUnsel"] forState:UIControlStateNormal];
        }
        else{
            pinfo = spay;
        }
    }
    
    pinfo.payIsChecked = !pinfo.payIsChecked;
    selectPayType = pinfo.payIsChecked ? pinfo.payTypeId : 0;
    [tmpBtn setImage:[UIImage imageNamed:pinfo.payIsChecked?@"checkbox_greensel":@"checkbox_greenUnsel"]
            forState:UIControlStateNormal];
}

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
    [UICommon Common_UILabel_Add:CGRectMake(65, 23, 200, heightPayRow/2) targetView:viewcell bgColor:[UIColor clearColor]
                             tag:6002 text:_payinfo.payWarning align:-1 isBold:NO fontSize:12 tColor:color_717171];
    
    UIButton * btnCheck = [[UIButton alloc]initWithFrame:CGRectMake(__MainScreen_Width-50, 9, 40, 40)];
    [btnCheck setTag: payButtonTag+_payinfo.payTypeId];
    [btnCheck setBackgroundColor:[UIColor clearColor]];
    [btnCheck setImage:[UIImage imageNamed:_payinfo.payIsChecked ? @"checkbox_greensel":@"checkbox_greenUnsel"]
              forState:UIControlStateNormal];
    [btnCheck addTarget:self action:@selector(onPayTypeCheckClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewcell addSubview:btnCheck];
}

//- (void)postNotificationCenterToResignKeyBoard{
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"resignkeyBoard" object:nil];
//}
#pragma mark    --  api 请 求 & 回 调.

- (void)goApiRequest_SendAuthCode:(NSMutableDictionary*)dicParams{
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_SendAuthCodeForRegister class:@"ResponseBase"
//              params:dicParams  isShowLoadingAnimal:NO hudShow:@"正在获取"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestSendAuthCode:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在获取验证码" delegate:self];
    
}
-(void)goApiRequest_CheckPWD{
    [txtPayPwd resignFirstResponder];
    if (txtPayPwd.text.length>0) {
        NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
        [pms setValue:[UserUnit userId] forKeyPath:@"UserId"];
        [pms setValue:[NSString YKMD5:txtPayPwd.text] forKeyPath:@"Password"];
        
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_CheckPayPwd class:@"ResponseBase"
//                  params:pms  isShowLoadingAnimal:NO hudShow:@"正在验证"];
     
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestCheckPayPassword:pms ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在验证" delegate:self];
        
    }
}
-(void)goApiRequest_PaymentOrder{
    [txtPayPwd resignFirstResponder];
    
    if (selectPayType==0) {
        if (f_UsedMyMoney==0) {
            [self HUDShow:@"请选择支付方式,或使用余额支付" delay:2];
            return;
        }
        if (OrderTotalPrice > f_UsedMyMoney) {
            [self HUDShow:@"余额不足,需选择支付方式" delay:2];
            return;
        }
    }
    
    f_userUnitBalance = [[UserUnit userBalance] floatValue];
    [lbl_MyBalance setText:[NSString stringWithFormat:@"我的波奇账户余额：%@",[self convertPrice:f_userUnitBalance]]];
    
    NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
    [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
    [apiParams setObject:self.payOrderID forKey:@"OrderId"];
    [apiParams setObject:(b_PayPwdRight&&!isUsedBalance)?@"1":@"0" forKey:@"IsUseBalance"];
    [apiParams setObject:[NSString stringWithFormat:@"%d",selectPayType] forKey:@"PayType"];
    [apiParams setObject:txtPayPwd.text.length>0 ? txtPayPwd.text:@"" forKey:@"PayPassword"];

    
    if (selectPayType == WXPay && ![WXApi isWXAppInstalled]) {
   
        [self alert:@"温馨提示" msg:@"您还没有安装微信,是否现在去安装微信?"];
        
        return;
    }
    
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_OrderPay class:@"resMod_CallBack_PayOrder"
//              params:apiParams  isShowLoadingAnimal:NO hudShow:@"支付中..."];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestPayGoodsOrder:apiParams ModelClass:@"resMod_CallBack_PayOrder" showLoadingAnimal:NO hudContent:@"正在准备支付" delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName {
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    
    if ([ApiName isEqualToString:kApiMethod_CheckPayPwd]) {
        b_PayPwdRight = YES;
        [self resetFrame];
        [self getUserMoney];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_OrderPay]) {
        resMod_CallBack_PayOrder * backObj=[[resMod_CallBack_PayOrder alloc] initWithDic:retObj];
        resMod_PayOrder * payinfo = backObj.ResponseData;
        
        if (payinfo) {
            if(payinfo.Type == UserBalancePay)  //余额支付
            {
                [self HUDShow:@"支付成功" delay:1.5 dothing:YES];
            }
            else if (payinfo.Type == AliAppPay) //支付宝客户端支付
            {
                b_hasPayResult = NO;
                isUsedBalance = YES;
                [AlixLibService payOrder:payinfo.PayMessage AndScheme:Alipay_UrlSchemes
                                 seletor:@selector(paymentResult:) target:self];
            }
            else if (payinfo.Type == WXPay){
                b_hasPayResult = NO;
                isUsedBalance = YES;
                
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
    
    if ([ApiName isEqualToString:kApiMethod_SetPayPassword]) {
        [UserUnit writeUserHasPayPassword:1];
        
        [self updateUserInfo];
        
        ResponseBase *backObj = [[ResponseBase alloc] initWithDic:retObj];
        [self showTips:backObj.ResponseMsg];
        [self cancelbuttonClicked:nil];
        
        [self resetFrame];
    }
    
    if ([ApiName isEqualToString:kApiMethod_BindTelephone]) {
        ResponseBase *backObj = [[ResponseBase alloc] initWithDic:retObj];
        [self showTips:backObj.ResponseMsg];
        [self cancelbuttonClicked:nil];

        [self updateUserInfo];
        
        [UserUnit writeTelephoneNum:backTelString];
        [self setPayPassword:nil];
    }
    
    if ([ApiName isEqualToString:kApiMethod_SendAuthCodeForRegister]) {
        ResponseBase *backObj = [[ResponseBase alloc] initWithDic:retObj];
        [self showTips:backObj.ResponseMsg];
    }
    
    
    if ([ApiName isEqualToString:kApiMethod_QueryGoodsOrder]) {
        resMod_CallBack_QueryGoodsOrder *responseObject = [[resMod_CallBack_QueryGoodsOrder alloc]initWithDic:retObj];
        WXPayResult = responseObject.ResponseData;
        
        if (WXPayResult.ResultCode == WXPaySuccess) {
            [self showNZAlertView:@"支付状态" message:@"您的订单已支付成功！"];
            [self HUDdelayDo];
        }
        else{
            [self showNZAlertView:@"支付状态" message:@"您的订单支付失败！"];
//            [self HUDdelayDo];
        }

    }
    
}


#pragma mark -WXHandleDelegate
- (void)responseFromPayHandle:(id)object{
    //微信返回成功，需要重新查询服务器支付结果，以服务器查询结果为准
#if 0
    NSMutableDictionary *params = (NSMutableDictionary*)@{
        @"UserId":[UserUnit userId],
        @"OrderId":self.payOrderID
    };
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValue:[UserUnit userId] forKey:@"UserId"];
//    [params setValue:self.payOrderID forKeyPath:@"OrderId"];
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestQueryGoodsOrder:params ModelClass:@"resMod_CallBack_QueryGoodsOrder" showLoadingAnimal:YES hudContent:@"" delegate:self];
#endif
    
    [self showNZAlertView:@"支付状态" message:@"您的订单已支付成功！"];

}

- (void)requestFromPayHandle:(id)object{

    
}

- (void)showNZAlertView:(NSString*)title message:(NSString*)msg
{
    NZAlertView *alert = [[NZAlertView alloc]initWithStyle:NZAlertStyleInfo title:title message:msg delegate:self];
    [self HUDdelayDo];
    [alert showWithCompletion:^{
        [alert removeFromSuperview];
    }];
}

-(void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName {
    
    [super interfaceExcuteError:error apiName:ApiName];
    
    if ([ApiName isEqual:kApiMethod_CheckPayPwd]
        || [ApiName isEqual:kApiMethod_Mall_OrderPay]) {
    }
    if ([ApiName isEqual:kApiMethod_BindTelephone]
        || [ApiName isEqual:kApiMethod_SetPayPassword]
        || [ApiName isEqual:kApiMethod_SendAuthCodeForRegister]) {
    
        NSString *errorString = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        [self showTips:errorString];
    }
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

//  -- 成功支付 处理
-(void)HUDdelayDo {
    
    //  -- 支付成功 更新本地用户信息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updataUserInfo" object:nil];
    
    if (b_isFromOrderList) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"payok" object:nil];
        [self goBack:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoRootNotification" object:@"goMallOrder"];
    }
}

//  -- 点击支付

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

#pragma mark - TextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
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
