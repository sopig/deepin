//
//  OrderSubmitController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-8.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "OrderSubmitController.h"
#import "resMod_MyOrders.h"
#import "BQCustomBarButtonItem.h"
#import "BQBindTelephoneNumberView.h"
#import "WXApi.h"
#import <pop/POP.h>
#import "resMod_Life_GetTicketLimitInfo.h"

#define heightTopView   60
#define heightRow 50


@interface OrderSubmitController (){
    NSString *backTelString;
    
    NSInteger currentNum;
    float price;
    float totalPrice;
}
@end

@implementation OrderSubmitController
@synthesize lbl_psTitle;
@synthesize lbl_perPrice;
@synthesize lbl_totalPrice;
@synthesize txt_phoneNum;
@synthesize txt_productNum;
@synthesize btn_discount;
@synthesize btn_sum;
@synthesize btn_submitOrder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self loadNavBarView];
    [self setTitle:@"提交订单"];
    [self.view setBackgroundColor: color_body];
    
   // [self loadNavBarView:@"提交订单"];
    
    ticketInfo = [self.receivedParams objectForKey:@"orderNeed"];
    if (!ticketInfo) {
        [self HUDShow:@"无商品信息" delay:1.5];
        return;
    }
    
    [self addViewData];
    [self initViewProperty];
    
    [self.lbl_psTitle setText:ticketInfo.TicketTitle];
    [self.lbl_perPrice setText: [self convertPrice:ticketInfo.TicketPrice]];
    [self.lbl_totalPrice setText: [self convertPrice:ticketInfo.TicketPrice*1]];
    [self.txt_productNum setText:@"1"];
    
    price = ticketInfo.TicketPrice;
    totalPrice = ticketInfo.TicketPrice*1;
    currentNum = 1;
    [self goApiRequest_GetTicketLimitInfo];
}

- (void)goBack:(id)sender
{
    [super goBack:sender];
    [MobClick event:@"submitOrderPage_return"];
}


//- (void)loadNavBarView:(NSString *)title
//{
//    
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


//  -- 初始化UI
- (void) initViewProperty{
    [self setBtnBackImg];
}

- (void) addViewData{
    
    rootScrollView = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight-kNavBarViewHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:rootScrollView];
    //  --  top
    UIView * viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, -1, __MainScreen_Width, heightTopView+1)];
    [viewTop setBackgroundColor:[UIColor whiteColor]];
    viewTop.layer.borderWidth = 0.5;
    viewTop.layer.borderColor = color_d1d1d1.CGColor;
    [rootScrollView addSubview:viewTop];
    
    self.lbl_psTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, def_WidthArea(10), 50)];
    self.lbl_psTitle.backgroundColor = [UIColor clearColor];
    self.lbl_psTitle.numberOfLines=0;
    self.lbl_psTitle.lineBreakMode=NSLineBreakByCharWrapping;
    [self.lbl_psTitle setText:ticketInfo.TicketTitle];
    [self.lbl_psTitle setFont:defFont16];
    [self.lbl_psTitle setTextColor:color_4e4e4e];
    [viewTop addSubview:self.lbl_psTitle];
    
    
    //  --  middle
    view_PriceAndProNum = [[UIView alloc] initWithFrame:CGRectMake(0, heightTopView+10, __MainScreen_Width, heightRow*3)];
    [view_PriceAndProNum setBackgroundColor:[UIColor whiteColor]];
    view_PriceAndProNum.layer.borderColor = color_d1d1d1.CGColor;
    view_PriceAndProNum.layer.borderWidth = 0.5f;
    [rootScrollView addSubview:view_PriceAndProNum];
    
    for (int i=1; i<4; i++) {
        [UICommon Common_line:CGRectMake(0, i*heightRow-0.5, __MainScreen_Width, 0.5)
                   targetView:view_PriceAndProNum backColor:color_d1d1d1];
    }

    //--单价
    [UICommon Common_UILabel_Add:CGRectMake(10, 0, 100, heightRow) targetView:view_PriceAndProNum
                         bgColor:[UIColor clearColor] tag:1001
                            text:@"单价" align:-1 isBold:NO fontSize:14 tColor:color_333333];
    //--单价金额
    self.lbl_perPrice = [[UILabel alloc] initWithFrame:CGRectMake(__MainScreen_Width-115, 0, 100, heightRow)];
    self.lbl_perPrice.backgroundColor = [UIColor clearColor];
    [self.lbl_perPrice setText:ticketInfo.TicketTitle];
    [self.lbl_perPrice setTextAlignment:NSTextAlignmentRight];
    [self.lbl_perPrice setFont:defFont15];
    [self.lbl_perPrice setTextColor:color_fc4a00];
    [view_PriceAndProNum addSubview:lbl_perPrice];
    
    //--数量
    [UICommon Common_UILabel_Add:CGRectMake(10, heightRow, 100, heightRow) targetView:view_PriceAndProNum
                         bgColor:[UIColor clearColor] tag:1001
                            text:@"数量" align:-1 isBold:NO fontSize:14 tColor:color_333333];
    //--数量 : 减
    self.btn_discount = [[UIButton alloc] initWithFrame:CGRectMake(__MainScreen_Width-150, heightRow+(heightRow-40)/2, 40,40)];
    [self.btn_discount setBackgroundColor:[UIColor clearColor]];
    [self.btn_discount setBackgroundImage:[UIImage imageNamed:@"icon_reduce_normal"] forState:UIControlStateNormal];
    [self.btn_discount setBackgroundImage:[UIImage imageNamed:@"icon_reduce_sel"] forState:UIControlStateHighlighted];
    [self.btn_discount setTag:597];
    [self.btn_discount setTitle:@"" forState:UIControlStateNormal];
    [self.btn_discount addTarget:self action:@selector(onProductNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [view_PriceAndProNum addSubview:btn_discount];
    
    //--数量 : 加
    self.btn_sum = [[UIButton alloc] initWithFrame:CGRectMake(__MainScreen_Width-50,btn_discount.frame.origin.y, 40, 40)];
    [self.btn_sum setBackgroundColor:[UIColor clearColor]];
    [self.btn_sum setBackgroundImage:[UIImage imageNamed:@"icon_add_highlight"] forState:UIControlStateNormal];
    [self.btn_sum setBackgroundImage:[UIImage imageNamed:@"icon_add_sel"] forState:UIControlStateHighlighted];
    [self.btn_sum setTag:598];
    [self.btn_sum setTitle:@"" forState:UIControlStateNormal];
    [self.btn_sum addTarget:self action:@selector(onProductNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [view_PriceAndProNum addSubview:btn_sum];
    
    //--数量
    self.txt_productNum = [[EC_UITextField alloc] initWithFrame:CGRectMake(__MainScreen_Width-103,btn_discount.frame.origin.y, 46, 40)];
    [self.txt_productNum setTag:8989];
    [self.txt_productNum setDelegate:self];
    [self.txt_productNum setBackgroundColor:[UIColor clearColor]];
    [self.txt_productNum setTextAlignment:NSTextAlignmentCenter];
    self.txt_productNum.keyboardType=UIKeyboardTypeNumberPad;
  //  self.txt_productNum.text = @"1";
    txt_productNum.layer.borderColor = color_d1d1d1.CGColor;
    txt_productNum.layer.borderWidth = 0.5;
    [view_PriceAndProNum addSubview:txt_productNum];
    
    //  --总价
    [UICommon Common_UILabel_Add:CGRectMake(10, heightRow*2, 100, heightRow) targetView:view_PriceAndProNum
                         bgColor:[UIColor clearColor] tag:1005
                            text:@"总价" align:-1 isBold:NO fontSize:14 tColor:color_333333];
    //  --
    self.lbl_totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(__MainScreen_Width-115, heightRow*2, 100, heightRow)];
    self.lbl_totalPrice.backgroundColor = [UIColor clearColor];
    [self.lbl_totalPrice setTextAlignment:NSTextAlignmentRight];
    [self.lbl_totalPrice setText:ticketInfo.TicketTitle];
    [self.lbl_totalPrice setFont:defFont15];
    [self.lbl_totalPrice setTextColor:color_fc4a00];
    [view_PriceAndProNum addSubview:self.lbl_totalPrice];
    
    //  --活动提醒  例: 活动公限购3件，超出需全部按非活动价购买
    lbl_ActivityWarn = [[UILabel alloc] initWithFrame:CGRectMake(0, heightRow*3, __MainScreen_Width, heightRow)];
    lbl_ActivityWarn.backgroundColor = [UIColor clearColor];
    [lbl_ActivityWarn setTextAlignment:NSTextAlignmentCenter];
    [lbl_ActivityWarn setText:@""];
    [lbl_ActivityWarn setFont:defFont15];
    [lbl_ActivityWarn setTextColor: color_fc4a00];
    [lbl_ActivityWarn setHidden:YES];
    [view_PriceAndProNum addSubview:lbl_ActivityWarn];
    
#pragma mark -#################################
    
    //  --  bottom
    viewbottom=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view_PriceAndProNum.frame)+10, __MainScreen_Width,90)];
    [viewbottom setBackgroundColor:[UIColor whiteColor]];
    viewbottom.layer.borderColor = color_dedede.CGColor;
    viewbottom.layer.borderWidth = 0.5f;
    [rootScrollView addSubview:viewbottom];

    //  --  如果手机号为空
    if (![NSString isPhoneNum:[UserUnit userMobile]]) {
        
        [viewbottom setFrame:CGRectMake(viewbottom.frame.origin.x, CGRectGetMaxY(view_PriceAndProNum.frame)+10, viewbottom.frame.size.width, 48)];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, 80, 40)];
        titleLabel.font = defFont14;
        titleLabel.text = @"填写手机号";
        [viewbottom addSubview:titleLabel];
        titleLabel.textColor = [UIColor convertHexToRGB:@"383838"];
        
        UILabel *midLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 4, 98, 40)];
        midLabel.font = defFont12;
        midLabel.text = @"为加强账户安全，";
        [viewbottom addSubview:midLabel];
        midLabel.textColor = [UIColor convertHexToRGB:@"989898"];
        
        BQCustomBarButtonItem *item = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(190, 4, 120, 40)];
        item.titleLabel.textColor = [UIColor convertHexToRGB:@"8fc31f"];
        item.titleRect = CGRectMake(0, 0, 120, 40);
        item.titleLabel.font = defFont12 ;
        item.titleLabel.text = @"请先绑定手机";
        item.delegate = self;
        item.selector = @selector(bindTelephoneNum:);
        [viewbottom addSubview:item];
    }
    else {
        [viewbottom setFrame:CGRectMake(viewbottom.frame.origin.x, CGRectGetMaxY(view_PriceAndProNum.frame)+10, viewbottom.frame.size.width, 90)];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 4, 80, 40)];
        titleLabel.font = defFont14;
        titleLabel.text = @"手机号";
        [viewbottom addSubview:titleLabel];
        titleLabel.textColor = [UIColor convertHexToRGB:@"383838"];
        
        UILabel *midLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 4, 220, 40)];
        midLabel.font = defFont12;
        midLabel.text = @"购买成功后，服务券凭证将发送到此手机";
        [viewbottom addSubview:midLabel];
        midLabel.textColor = [UIColor convertHexToRGB:@"989898"];

        [UICommon Common_line:CGRectMake(0, 41, 320, 0.5) targetView:viewbottom backColor:color_dedede];
        
        NSString*teleString = [NSString stringWithFormat:@"%@", [UserUnit userMobile]];
        
        txt_phoneNum = [[EC_UITextField alloc]initWithFrame:CGRectMake(10, 47, 300, 36)];
        txt_phoneNum.font = defFont16;
        txt_phoneNum.text = teleString;
        txt_phoneNum.delegate =  self;
        [txt_phoneNum setKeyboardType:UIKeyboardTypeNumberPad];
        txt_phoneNum.textColor = [UIColor convertHexToRGB:@"989898"];
        txt_phoneNum.layer.borderColor = color_dedede.CGColor;
        txt_phoneNum.layer.borderWidth = 0.5;
        txt_phoneNum.layer.cornerRadius = 5.0f;
        [viewbottom addSubview:txt_phoneNum];
        
        
//        UILabel *telephoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 300, 40)];
//        telephoneLabel.font = defFont16;
//        telephoneLabel.text = teleString;
//        [viewbottom addSubview:telephoneLabel];
//        telephoneLabel.textColor = [UIColor convertHexToRGB:@"989898"];
//        
//        telephoneLabel.layer.borderColor = color_dedede.CGColor;
//        telephoneLabel.layer.borderWidth = 0.5;
//        telephoneLabel.layer.cornerRadius = 5.0f;
    }
    
    self.btn_submitOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_submitOrder setFrame:CGRectMake(12, __ContentHeight_noTab-46, def_WidthArea(12), 38)];
    [self.btn_submitOrder setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.btn_submitOrder.titleLabel setFont:defFont15];
    [self.btn_submitOrder setBackgroundColor: color_fc4a00];
    self.btn_submitOrder.layer.cornerRadius = 2;
    [self.btn_submitOrder addTarget:self action:@selector(onSubmitOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollView addSubview:self.btn_submitOrder];
}

#pragma mark    --  事件区

- (void)bindTelephoneNum:(id)sender{

    BQBindTelephoneNumberView *bindView = [[BQBindTelephoneNumberView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreenFrame.size.height) titleString:@"绑定手机号" forState:authCodeState];
    bindView.tag = 1234;
    bindView.delegate = self;
    bindView.showTipsSelector = @selector(delegateHUDShow:);
    bindView.apiRequestSelector = @selector(apiRequest:);
    bindView.cancelButtonSelector = @selector(cancelbuttonClicked:);
    bindView.enterButtonSelector = @selector(enterButtonClicked:);
    
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    [keyWindow addSubview:bindView];
    [keyWindow sendSubviewToBack:self.view];

    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    bindView.alpha = 0;
    anim.toValue = @(1.0);
    [bindView pop_addAnimation:anim forKey:@"alpha"];
}

- (void)delegateHUDShow:(NSString *)text{
    [self HUDShow:text delay:2];
}

- (void)cancelbuttonClicked:(UIButton*)button{
    
    BQBindTelephoneNumberView *bindView = (BQBindTelephoneNumberView*)[[UIApplication sharedApplication].keyWindow viewWithTag:1234];
    
    [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        bindView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [bindView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0];
    }];
    
}

- (void)enterButtonClicked:(NSMutableDictionary*)dict{
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
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestBindTelephone:paraDict ModelClass:@"ResponseBase"
                                                   showLoadingAnimal:NO hudContent:@"" delegate:self];
}


//  --  数 量 加 减
- (void) onProductNumClick:(id) sender{
    [MobClick event:@"submitOrderPage_changeQuantity"];
    
    UIButton * btnTmp = (UIButton *)sender;
    int iNum= [self.txt_productNum.text intValue];
    switch (btnTmp.tag) {
        case 597:{  //减
            if (iNum==1||iNum<1) {
                self.txt_productNum.text = @"1";
            }else{
                self.txt_productNum.text = [NSString stringWithFormat:@"%d",--iNum];
            }
        }
            break;
        case 598: { //加
            ++iNum;
            [self checkTicketLimitNumber:iNum];
        }
            break;
            
        default:
            break;
    }
    
    [self goApiRequest_GetTicketLimitInfo];
//    self.lbl_totalPrice.text=[self convertPrice:[self.txt_productNum.text intValue]*ticketInfo.TicketPrice];
    [self setBtnBackImg];
}

- (void) checkTicketLimitNumber:(int) proNum{
   
    txt_productNum.text = [NSString stringWithFormat:@"%d",proNum];
    
    /*
    if (ticketInfo.TicketLimitNumber>0 && proNum > ticketInfo.TicketLimitNumber) {
        return;
        [self HUDShow:[NSString stringWithFormat:@"限购 %d 件",ticketInfo.TicketLimitNumber] delay:2];
        txt_productNum.text = [NSString stringWithFormat:@"%d",ticketInfo.TicketLimitNumber];
        
    }
    else{
        txt_productNum.text = [NSString stringWithFormat:@"%d",proNum];
    }
     */
}

- (void) onSubmitOrderClick:(id) sender{

    [MobClick event:@"serviceDetails_buyNow_submitOrder"];
    
    if (self.txt_productNum.text.length==0) {
        [self HUDShow:@"请输入购买数量" delay:kShowMsgAfterDelay];
        return;
    }
    else {
        int proNum = [self.txt_productNum.text intValue];
        if (proNum<1) {
            [self HUDShow:@"该商品1件起售" delay:1.5];
            return;
        }
        if (ticketInfo.TicketLimitNumber>0 && proNum>ticketInfo.TicketLimitNumber) {
            [self HUDShow:[NSString stringWithFormat:@"限购 %d 件",ticketInfo.TicketLimitNumber] delay:1.5];
            return;
        }
    }
    
    if (![NSString isPhoneNum:[UserUnit userMobile]]) {
        [self HUDShow:@"请您先绑定手机号" delay:kShowMsgAfterDelay];
        return;
    }
    
    if (![NSString isPhoneNum:self.txt_phoneNum.text]) {
        [self HUDShow:@"请输入正确的手机号" delay:kShowMsgAfterDelay];
        return;
    }

    if (![UserUnit isUserLogin]) {
        [self goLogin:@"ordersubmitcontroller" param:nil delegate:self];
        return;
    }
    
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:[NSString stringWithFormat:@"%d",ticketInfo.TicketId] forKey:@"TicketId"];
    [dicParams setObject:self.txt_productNum.text forKey:@"Number"];
    [dicParams setObject:self.txt_phoneNum.text forKey:@"Mobile"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestCommitOrder:dicParams ModelClass:@"resMod_CallBack_CommitOrder" showLoadingAnimal:NO hudContent:@"正在提交" delegate:self];
}

- (void)LoginSuccessPushViewController:(NSString *)m_str param:(id)m_param{
    if ([m_str isEqualToString:@"ordersubmitcontroller"]) {
        [self onSubmitOrderClick:nil];
    }
}

#pragma mark    --  api 请 求 && 回 调
//  查询服务券限购信息
- (void)goApiRequest_GetTicketLimitInfo {
    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc] init];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:[NSString stringWithFormat:@"%d",ticketInfo.TicketId] forKey:@"TicketId"];
    [dicParams setValue: self.txt_productNum.text forKey:@"Number"];
    
    [[APIMethodHandle shareAPIMethodHandle] goApiRequestGetTicketBuyInfo:dicParams ModelClass:@"resMod_CallBackMall_Life_GetTicketLimitInfo" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
}

- (void)apiRequest:(NSMutableDictionary*)dicParams{
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestSendAuthCode:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在获取" delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    
    if ([ApiName isEqualToString:kApiMethod_CommitOrder]) {
        resMod_CallBack_CommitOrder * backObj = [[resMod_CallBack_CommitOrder alloc] initWithDic:retObj];
        returnOrderInfo = backObj.ResponseData;
        
        if (returnOrderInfo && returnOrderInfo.OrderId>0) {
            
            resMod_MyOrderInfo * orderInfo = [[resMod_MyOrderInfo alloc] init];
            orderInfo.OrderId = returnOrderInfo.OrderId;
            orderInfo.OrderPrice = [self.txt_productNum.text intValue]*ticketInfo.TicketPrice;
            orderInfo.OrderTitle = ticketInfo.TicketTitle;
            orderInfo.OrderTel = txt_phoneNum.text;
            
            NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
            [pms setValue:orderInfo forKeyPath:@"param_orderinfo"];
            [pms setValue:@"0" forKeyPath:@"param_isFromUserCenter"];
            [self pushNewViewController:@"OrderPaymentController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
        }
    }
    
    if ([ApiName isEqualToString:kApiMethod_SendAuthCodeForRegister]) {
        
        ResponseBase *backObj = [[ResponseBase alloc] initWithDic:retObj];
        NSString* tipString = backObj.ResponseMsg;
        
        [self showTips:tipString];
        [UserUnit writeTelephoneNum:backTelString];
    }

    if ([ApiName isEqualToString:kApiMethod_BindTelephone]) {
        
        ResponseBase *backObj = [[ResponseBase alloc] initWithDic:retObj];
        NSString* tipString = backObj.ResponseMsg;
        
        [self showTips:tipString];
        
        [UserUnit writeTelephoneNum:backTelString];
        
        [self refreshUI];
        [self cancelbuttonClicked:nil];
    }
    
    if ([ApiName isEqualToString:kApiMethod_GetTicketBuyInfo]) {
        resMod_CallBackMall_Life_GetTicketLimitInfo *backObj = [[resMod_CallBackMall_Life_GetTicketLimitInfo alloc]initWithDic:retObj];
        resMod_Life_GetTicketLimitInfo *ticketLimitInfo = backObj.ResponseData;
        if (ticketLimitInfo) {
            
            currentNum = [ticketLimitInfo.currentNum integerValue];
            totalPrice = [ticketLimitInfo.totalPrice floatValue];
            price = [ticketLimitInfo.price floatValue];
            [self.lbl_perPrice   setText: [NSString stringWithFormat:@"%.2f元",price]];
            [self.lbl_totalPrice setText: [NSString stringWithFormat:@"%.2f元",totalPrice]];
            [self.txt_productNum setText: [NSString stringWithFormat:@"%d",currentNum]];
            
            [self resetFrame:ticketLimitInfo.Information];
        }
    }
}

- (void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    
    if ([ApiName isEqual:kApiMethod_BindTelephone]) {
        NSString *errorString = [NSString stringWithFormat:@"%@",error];
        [self showTips:errorString];
    }
    else{
        [super interfaceExcuteError:error apiName:ApiName];
    }
}

#pragma  mark - showtips
- (void)showTips:(NSString*)warnstring{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    BQBindTelephoneNumberView *bindView = (BQBindTelephoneNumberView*)[keyWindow viewWithTag:1234];
    [bindView HUDShow:warnstring delay:2];
}

- (void) resetFrame:(NSString *) limitInfo{
    
    CGRect _cframe = view_PriceAndProNum.frame;
    float fviewHeight = limitInfo.length>0 ? heightRow*4 :heightRow*3;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [view_PriceAndProNum setFrame:CGRectMake(_cframe.origin.x, _cframe.origin.y, _cframe.size.width, fviewHeight)];
                         [viewbottom setFrame:CGRectMake(viewbottom.frame.origin.x, CGRectGetMaxY(view_PriceAndProNum.frame)+10, viewbottom.frame.size.width, viewbottom.frame.size.height)];
                         
                         [btn_submitOrder setFrame:CGRectMake(12, CGRectGetMaxY(viewbottom.frame)+50, def_WidthArea(12), 38)];
                         
                         [rootScrollView setContentSize:CGSizeMake(rootScrollView.frame.size.width, CGRectGetMaxY(btn_submitOrder.frame)+10)];
                         
                         [lbl_ActivityWarn setText:limitInfo];
                         [lbl_ActivityWarn setHidden: limitInfo.length==0];
                     }
                     completion:^(BOOL finished){}];
}

- (void) setBtnBackImg{
    int iNum= [self.txt_productNum.text intValue];
    if (iNum<2) {
        [self.btn_discount setBackgroundImage:[UIImage imageNamed:@"icon_reduce_normal.png"] forState:UIControlStateNormal];
        [self.btn_sum setBackgroundImage:[UIImage imageNamed:@"icon_add_highlight.png"] forState:UIControlStateNormal];
    }
    else{
        [self.btn_discount setBackgroundImage:[UIImage imageNamed:@"icon_reduce_highlight.png"]forState:UIControlStateNormal];
        [self.btn_sum setBackgroundImage:[UIImage imageNamed:@"icon_add_highlight.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - TextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField.tag==8989) {
//        [self checkTicketLimitNumber:[txt_productNum.text intValue]];
        [self goApiRequest_GetTicketLimitInfo];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.tag==8989) {
//        [self checkTicketLimitNumber:[txt_productNum.text intValue]];
        [self goApiRequest_GetTicketLimitInfo];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *tmpTxt = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger Length = tmpTxt.length - range.length + string.length;
    if(textField.tag == 2005){
        if ( Length == 11 ){
            [txt_phoneNum resignFirstResponder];
            [txt_phoneNum setText:[NSString stringWithFormat:@"%@%@",tmpTxt,string]];
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 刷新界面

- (void)refreshUI{
    for (int i = 0; i < self.view.subviews.count; i++) {
        UIView *view = [self.view.subviews objectAtIndex:i];
        [view removeFromSuperview];
    }
    [self viewDidLoad];
}

@end
