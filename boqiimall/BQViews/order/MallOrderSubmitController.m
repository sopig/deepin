//
//  MallOrderSubmitController.m
//  boqiimall
//
//  Created by YSW on 14-6-25.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "MallOrderSubmitController.h"
#import "EC_UISwitch.h"
#import "resMod_Mall_Order.h"
#import "resMod_MyCoupons.h"
#import "resMod_Mall_OrderAmountDetail.h"

#define payMoneyDetail @"商品金额|运费金额|优惠金额|使用优惠券|还需支付"

#define des_COD             @"使用快递,限上海（除崇明岛外）地区、广西南宁外环道以内地区"
#define des_OnlinePayment   @"提交完订单以后可选择适合您的支付渠道，比如余额支付、支付宝支付等"

#define initCheckTypeID     -1000
#define paddingTop  10
#define heightRowHeader  36
#define heightRow     68
#define heightForConponButton 45
#define heightRowPayDetail 45
#define tagPayMoneyDetail   989746

/// --  ..................
@implementation EC_OrderSubmitButton
@synthesize type_paymentOrDelevery,chectTypeID,selRowInArray;
@synthesize iconName;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selRowInArray = initCheckTypeID;
        self.chectTypeID = initCheckTypeID;
    }
    return self;
}
@end


/// --  ..................
@implementation MallOrderSubmitController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        heightTopAddress = 50;
        paramGoodsList = [[NSMutableArray alloc] initWithCapacity:0];
        m_Payments = [[NSMutableArray alloc] initWithCapacity:0];
        m_Deleverys = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:color_bodyededed];
    [self setTitle:@"结算订单"];
    paramGoodsList = [self.receivedParams objectForKey:@"param_proinfo"];
    [self loadContentView];
    [self goApiRequest_SettleAccounts];
}
-(void)goBack:(id)sender {
    [MobClick event:@"orderCheckout_return"];
    [super goBack:sender];
}

- (void) loadContentView{
    
    rootScrollview = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight-kNavBarViewHeight)];
    [rootScrollview setBackgroundColor:[UIColor clearColor]];
    [rootScrollview setDelegate:self];
    [rootScrollview setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:rootScrollview];
    
    btnAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAddress setFrame:CGRectMake(0, 0, __MainScreen_Width, heightTopAddress)];
    [btnAddress setBackgroundColor:color_fbf7f7];
    [btnAddress setTitle:@"" forState:UIControlStateNormal];
    [btnAddress setTitleColor:color_fc4a00 forState:UIControlStateNormal];
    [btnAddress addTarget:self action:@selector(onEditAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollview addSubview:btnAddress];
    
    tableviewPDType = [[UITableView alloc] initWithFrame:CGRectMake(0, heightTopAddress, __MainScreen_Width, 0) style:UITableViewStylePlain];
    [tableviewPDType setBackgroundColor:[UIColor convertHexToRGB:@"f0f0f0"]];
    tableviewPDType.delegate = self;
    tableviewPDType.dataSource = self;
    tableviewPDType.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableviewPDType.showsHorizontalScrollIndicator= NO;
    tableviewPDType.showsVerticalScrollIndicator  = NO;
    [rootScrollview addSubview:tableviewPDType];
    
    [self loadView_couponAndPayDetail];
    
    [rootScrollview setContentSize:CGSizeMake(__MainScreen_Width, heightTopAddress+heightPaytypeAndDeleverytype+view_coupon.frame.size.height+view_PayDetail.frame.size.height + 70)];
    
    btn_ok = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_ok setFrame:CGRectMake(10, rootScrollview.contentSize.height-50, def_WidthArea(10), 40)];
    [btn_ok setBackgroundColor:color_fc4a00];
    btn_ok.layer.cornerRadius = 2.0;
    [btn_ok setTitle:@"提交订单" forState:UIControlStateNormal];
    [btn_ok addTarget:self action:@selector(onSubmitOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollview addSubview:btn_ok];
}

- (void) resetViewFrame{
    
    [UIView animateWithDuration:0.4
                     animations:^{
        
        [btnAddress setFrame:CGRectMake(-1, -1, __MainScreen_Width+2, heightTopAddress)];

        [tableviewPDType setFrame:CGRectMake(0, heightTopAddress-0.5, __MainScreen_Width, heightPaytypeAndDeleverytype)];
        
        [view_coupon setFrame:CGRectMake(0, heightTopAddress+heightPaytypeAndDeleverytype+10, __MainScreen_Width, (heightRow-10)+view_couponlist.frame.size.height)];
        
        [view_PayDetail setFrame:CGRectMake(0, heightTopAddress+heightPaytypeAndDeleverytype+view_coupon.frame.size.height+10, __MainScreen_Width, heightRowPayDetail*5+20)];


        [rootScrollview setContentSize:CGSizeMake(__MainScreen_Width, heightTopAddress+heightPaytypeAndDeleverytype+view_coupon.frame.size.height+view_PayDetail.frame.size.height + 70)];
        [btn_ok setFrame:CGRectMake(10, rootScrollview.contentSize.height-50, def_WidthArea(10), 40)];
    }];
}

#pragma mark    --  event

- (void) onPaymentDeleveryTypeCheck:(UITableViewCell*) cell{
    
    NSIndexPath* indexPath = [tableviewPDType indexPathForCell:cell];
    EC_OrderSubmitButton * btntmp = (EC_OrderSubmitButton*)[cell viewWithTag:2001];

    //  --支付方式.....
    if (btntmp.type_paymentOrDelevery==99) {
        
        [MobClick event:@"orderCheckout_onlinePayment"];
        if (btntmp.chectTypeID==selPaymentType.chectTypeID) {
            return;
        }
        selPaymentType.chectTypeID = initCheckTypeID;
        selPaymentType.selRowInArray = initCheckTypeID;
        [selPaymentType setImage:[UIImage imageNamed:@"check_icon_unpoint.png"]];
        
        int i=0;
        for (resMod_Mall_PaymentTypeByAddress * paytype in m_Payments) {
            if (i==indexPath.row) {
                paytype.isCheckedPayment = YES;
                btntmp.chectTypeID = paytype.PaymentId;
                btntmp.selRowInArray = indexPath.row;
            }
            else{
                paytype.isCheckedPayment = NO;
            }
            i++;
        }

        [btntmp setImage:[UIImage imageNamed:@"check_icon_point.png"]];
        selPaymentType = btntmp;
        
        
        // 刷新第二个section
        m_Deleverys = [m_Payments[indexPath.row] ExpressageList];
        int j=0;
        for (resMod_Mall_DeliveryTypeByAddress * deliverytype in m_Deleverys) {
            deliverytype.isCheckedDelivery = j==0 ? YES:NO;
            j++;
        }
        NSIndexSet * nset=[[NSIndexSet alloc]initWithIndex:1];
        [tableviewPDType reloadSections:nset withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // ...
        heightPaytypeAndDeleverytype = (heightRowHeader+paddingTop)*2 + heightRow*(m_Payments.count + m_Deleverys.count);
        [self resetViewFrame];
    }
    //  --配送方式....
    if (btntmp.type_paymentOrDelevery==100) {
        
        [MobClick event:@"orderCheckout_cashOnDelivery"];
        selDeleveryType.chectTypeID = initCheckTypeID;
        selDeleveryType.selRowInArray = initCheckTypeID;
        [selDeleveryType setImage:[UIImage imageNamed:@"check_icon_unpoint.png"]];
        
        int i=0;
        for (resMod_Mall_DeliveryTypeByAddress * deliverytype in m_Deleverys) {
            if (i==indexPath.row) {
                deliverytype.isCheckedDelivery = YES;
                btntmp.chectTypeID = deliverytype.ExpressageId;
                btntmp.selRowInArray = indexPath.row;
            }
            else{
                deliverytype.isCheckedDelivery = NO;
            }
            i++;
        }
        [btntmp setImage:[UIImage imageNamed:@"check_icon_point.png"]];
        selDeleveryType = btntmp;
    }
    
    //  --  。。。。。。。
    [self updatePayMoneyDetail];
}

- (void)onButtonCouponClick:(EC_UISwitch *)sender{

    sender.on = !sender.on;
    isUseCoupon = !isUseCoupon;
    
    if (isUseCoupon) {
        [MobClick event:@"orderCheckout_useTicket"];
        [txtCoupon setTextFieldState:ECTextFieldBorder];
        [self goApiRequest_GetMallCoupons];
    }
    else{
        [MobClick event:@"orderCheckout_removeTicket"];
        [txtCoupon resignFirstResponder];
        [txtCoupon setTextFieldState:ECTextFieldGary];
        txtCoupon.text = @"";
        checkCouponInfo = nil;
        [self updatePayMoneyDetail];
        
        [view_couponlist setFrame:CGRectMake(view_couponlist.frame.origin.x, view_couponlist.frame.origin.y, view_couponlist.frame.size.width, 0)];
        [self resetViewFrame];
    }
}

//  --选择优惠券
- (void) OnCouponChecked:(id) sender{
    [txtCoupon resignFirstResponder];
    
    if ([self ValidateOperate]) {
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
        txtCoupon.text = lblCouponNO.text;
        [self goApiRequest_CheckCoupon];
    }
}

- (void)onEditAddressClick:(id)sener{
    
    if (myAddressInfo!=nil) {
        [self pushNewViewController:@"MyAddressListController" isNibPage:NO hideTabBar:YES setDelegate:YES
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                     @"1",@"param_isFromSubmitOrder",
                                     [NSString stringWithFormat:@"%d",myAddressInfo.AddressId],@"param_AddressId",nil]];
    }
    else{
        [self pushNewViewController:@"EditAddressViewController" isNibPage:NO hideTabBar:YES setDelegate:YES
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"param_isFromSubmitOrder", nil]];
    }
}

- (void) OnDelegateSelectedAddress:(resMod_AddressInfo *)selAddress{
    [self OnDelegateEditAddress:selAddress];
}

- (void) OnDelegateEditAddress:(resMod_AddressInfo*) _backAddressInfo{

    if (_backAddressInfo!=nil) {
        myAddressInfo = _backAddressInfo;
        [self loadView_topAddress];
        [self goApiRequest_PaymentAndDeleveryTypeByAddress];
    }
    else
    {
        myAddressInfo.AddressId = -1;
        [self loadView_topAddress];
        [self resetViewFrame];
    }
}

- (void)onSubmitOrderClick:(id)sender{
    
    [self goApiRequest_CreateOrder];
}

- (void)updatePayMoneyDetail{
    [self goApiRequest_OrderAmountDetail];
    
//    float cost_delevery = 0;
//    if (selDeleveryType!=nil) {
//        cost_delevery = selDeleveryType.selRowInArray==initCheckTypeID ? 0:[m_Deleverys[selDeleveryType.selRowInArray] ExpressageMoney];
//    }
//    float cost_Preferential = checkCouponInfo!=nil ? checkCouponInfo.Preferential : settleAccountsInfo.Preferential;
//    float cost_Coupon = checkCouponInfo!=nil ? checkCouponInfo.CouponPrice : 0.0;
//    float needPay = settleAccountsInfo.GoodsTotalMoney+cost_delevery-cost_Preferential-cost_Coupon;
//    
//    UILabel * lbl_0 =(UILabel*)[view_PayDetail viewWithTag:tagPayMoneyDetail];
//    UILabel * lbl_1 =(UILabel*)[view_PayDetail viewWithTag:tagPayMoneyDetail+1];
//    UILabel * lbl_2 =(UILabel*)[view_PayDetail viewWithTag:tagPayMoneyDetail+2];
//    UILabel * lbl_3 =(UILabel*)[view_PayDetail viewWithTag:tagPayMoneyDetail+3];
//    UILabel * lbl_4 =(UILabel*)[view_PayDetail viewWithTag:tagPayMoneyDetail+4];
//    
//    [lbl_0 setText:[self convertPrice:settleAccountsInfo.GoodsTotalMoney]];
//    [lbl_1 setText:[self convertPrice:cost_delevery]];
//    [lbl_2 setText:[self convertPrice:cost_Preferential]];
//    [lbl_3 setText:[self convertPrice:cost_Coupon]];
//    [lbl_4 setText:[self convertPrice:needPay]];
}


#pragma mark    --  load ui :   address
- (void)loadView_topAddress{

    BOOL isExistAddress = (myAddressInfo!=nil && myAddressInfo.AddressId>0) ? YES:NO;
    for (UIView * subviews in btnAddress.subviews) {
        if (subviews.tag == 96785) {
            [subviews removeFromSuperview];
        }
    }
    
    CGSize tsize = CGSizeMake(0, 0);
    if (isExistAddress)
    {
        NSString * sAddressDetail = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",myAddressInfo.AddressProvince,myAddressInfo.AddressCity,myAddressInfo.AddressArea,myAddressInfo.AddressDetail,myAddressInfo.ZipCode];
        tsize= [sAddressDetail sizeWithFont:defFont14 constrainedToSize:CGSizeMake(__MainScreen_Width-60, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    }
  
    heightTopAddress = isExistAddress ? tsize.height+50 : 50;
    [btnAddress setTitle:isExistAddress ? @"":@"新建收货地址" forState:UIControlStateNormal];
    
    UIImageView * iconRight = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width-18, heightTopAddress/2-7,15,15)];
    [iconRight setTag:96785];
    [iconRight setImage:[UIImage imageNamed:@"right_icon.png"]];
    [iconRight setBackgroundColor:[UIColor clearColor]];
    [btnAddress addSubview:iconRight];
    
    if (isExistAddress) {
        float ypoint = 0;
        for (int i=0; i<2; i++) {
            ypoint = i==0 ? 0 :30;
           // ypoint = 0;
            UIImageView * iconAddressPerson = [[UIImageView alloc] initWithFrame:CGRectMake(9, ypoint+7, 25, 25)];
            [iconAddressPerson setTag:96785];
            [iconAddressPerson setImage:[UIImage imageNamed:i==0 ? @"recipient_icon.png":@"myaddress_icon.png"]];
            [iconAddressPerson setBackgroundColor:[UIColor clearColor]];
            [btnAddress addSubview:iconAddressPerson];
            
            NSString * sName = [NSString stringWithFormat:@"%@   %@",myAddressInfo.UserName,myAddressInfo.Mobile];
            NSString * sAddressDetail = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",myAddressInfo.AddressProvince,myAddressInfo.AddressCity,myAddressInfo.AddressArea,myAddressInfo.AddressDetail,myAddressInfo.ZipCode];
            
            tsize= [sAddressDetail sizeWithFont:defFont14 constrainedToSize:CGSizeMake(__MainScreen_Width-60, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
            [UICommon Common_UILabel_Add:CGRectMake(38, ypoint+(i==0?12:10),(i == 0?__MainScreen_Width-60:tsize.width), i==0?18:tsize.height)
                              targetView:btnAddress bgColor:[UIColor clearColor] tag:96785
                                    text:i==0 ? sName:sAddressDetail
                                   align:-1 isBold:NO fontSize:i==0?16:14 tColor:color_4e4e4e];
        }
    }
}

#pragma mark    --  load ui :   优惠券 & 支付明细
- (void)loadView_couponAndPayDetail{
    
    //  --  优惠券
    view_coupon = [[UIView alloc] initWithFrame:CGRectMake(0, heightTopAddress+heightPaytypeAndDeleverytype+8, __MainScreen_Width, heightRow-8)];
    [view_coupon setBackgroundColor:[UIColor whiteColor]];
    view_coupon.layer.borderColor = color_d1d1d1.CGColor;
    view_coupon.layer.borderWidth = 0.5f;
    [rootScrollview addSubview:view_coupon];
    
    // --   使用优惠券开关
    EC_UISwitch * btnCheckCoupon = [EC_UISwitch buttonWithType:UIButtonTypeCustom];
    [btnCheckCoupon setOn: NO];
    [btnCheckCoupon setBackgroundColor:[UIColor clearColor]];
    [btnCheckCoupon setFrame: CGRectMake(view_coupon.frame.size.width-62, 14.0f, 102/2, 62/2)];
    [btnCheckCoupon addTarget:self action:@selector(onButtonCouponClick:) forControlEvents:UIControlEventTouchUpInside];
    [view_coupon addSubview:btnCheckCoupon];
    
    [UICommon Common_UILabel_Add:CGRectMake(12, 13, 80, 30)
                      targetView:view_coupon bgColor:[UIColor clearColor] tag:3002
                            text:@"使用优惠券" align:-1 isBold:NO fontSize:14 tColor:color_333333];
    
    txtCoupon = [[EC_UITextField alloc] initWithFrame:CGRectMake(98, 11, 150, 35)];
    [txtCoupon setTag:787879];
    [txtCoupon setBackgroundColor:[UIColor clearColor]];
    [txtCoupon setTextFieldState:ECTextFieldGary];
    [txtCoupon setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtCoupon setPlaceholder:@"输入优惠券码"];
    [txtCoupon setDelegate:self];
    [txtCoupon setFont:defFont14];
    [txtCoupon setReturnKeyType:UIReturnKeyDone];
    [view_coupon addSubview:txtCoupon];
    
    //  --  优惠券列表
    view_couponlist = [[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(txtCoupon.frame)+12,__MainScreen_Width,0)];
    [view_couponlist setBackgroundColor:[UIColor clearColor]];
    view_couponlist.delegate = self;
    view_couponlist.layer.borderColor = color_d1d1d1.CGColor;
    view_couponlist.layer.borderWidth = 0.5f;
    [view_coupon addSubview:view_couponlist];
    
    //  --  支付明细
    view_PayDetail = [[UIView alloc] initWithFrame:CGRectMake(0, heightTopAddress+heightPaytypeAndDeleverytype+view_coupon.frame.size.height, __MainScreen_Width, heightRowPayDetail*5+20)];
    [view_PayDetail setBackgroundColor:[UIColor clearColor]];
    [rootScrollview addSubview:view_PayDetail];
    
    UIImageView * bgTop = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, def_WidthArea(10), view_PayDetail.frame.size.height-10)];
    [bgTop setBackgroundColor:[UIColor clearColor]];
    [bgTop setImage:def_ImgStretchable(@"green_bg.png", 11, 10)];
    [view_PayDetail addSubview:bgTop];
    
    UIImageView * bgFoot = [[UIImageView alloc] initWithFrame:CGRectMake(15, view_PayDetail.frame.size.height, view_PayDetail.frame.size.width-30, 7/2)];
    [bgFoot setBackgroundColor:[UIColor clearColor]];
    [bgFoot setImage:[UIImage imageNamed:@"misumi_ine.png"]];
    [view_PayDetail addSubview:bgFoot];
    
    float ypoint = 0;
    NSArray * arrPays = [payMoneyDetail componentsSeparatedByString:@"|"];
    for (int i=0; i<arrPays.count; i++) {
        ypoint = 14 + heightRowPayDetail*i;
        [UICommon Common_UILabel_Add:CGRectMake(26, ypoint, 80, heightRowPayDetail)
                          targetView:view_PayDetail bgColor:[UIColor clearColor] tag:4002
                                text:[NSString stringWithFormat:@"%@:",arrPays[i]]
                               align:-1 isBold:NO
                            fontSize:14
                              tColor: i<arrPays.count ? color_4e4e4e : color_fc4a00];
        
        [UICommon Common_UILabel_Add:CGRectMake(__MainScreen_Width-106, ypoint, 80, heightRowPayDetail)
                          targetView:view_PayDetail bgColor:[UIColor clearColor]
                                 tag:tagPayMoneyDetail+i
                                text:@"0.00元"
                               align:1 isBold: i<arrPays.count ? NO:YES
                            fontSize:i<arrPays.count ? 14:15
                              tColor:i<arrPays.count ? color_4e4e4e : color_fc4a00];
        if (i>0) {
            UILabel * dotLine = [[UILabel alloc] initWithFrame:CGRectMake(21, ypoint, def_WidthArea(21), 0.5)];
            [dotLine setBackgroundColor:[UIColor clearColor]];
            dotLine.layer.borderColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]].CGColor;
            dotLine.layer.borderWidth=0.5f;
            [view_PayDetail addSubview:dotLine];
        }
    }
}
//  --  加载可使用优惠券列表
- (void) LoadData_CouponList{
    int irows = self.arrCoupons.count>3 ? 3:self.arrCoupons.count;
    [view_couponlist setFrame:CGRectMake(0,view_couponlist.frame.origin.y,__MainScreen_Width,heightForConponButton*irows)];
    [view_couponlist setContentSize:CGSizeMake(__MainScreen_Width, heightForConponButton*self.arrCoupons.count)];
    [self resetViewFrame];
    
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
        
        UIImageView * imgCheck = [[UIImageView alloc] initWithFrame:CGRectMake(15, 13, 18, 18)];
        [imgCheck setTag:222333];
        [imgCheck setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"]];
        [btnCouponInfo addSubview:imgCheck];
        
        UILabel * lblCouponNo = [[UILabel alloc] initWithFrame:CGRectZero];
        [lblCouponNo setHidden:YES];
        [lblCouponNo setTag:444555];
        [lblCouponNo setText:coupon.CouponNo];
        [btnCouponInfo addSubview:lblCouponNo];
        
        [UICommon Common_UILabel_Add:CGRectMake(btnCouponInfo.frame.size.width-116, 12, 100, 20)
                          targetView:btnCouponInfo bgColor:[UIColor clearColor] tag:111222
                                text:coupon.CouponDiscount
                               align:1 isBold:NO fontSize:15 tColor:color_fc4a00];
        i++;
    }
}

#pragma mark    --  Table view : 最下面推荐商品
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section==0 ? m_Payments.count : m_Deleverys.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  heightRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return heightRowHeader+paddingTop;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * viewHeader = [[UIView alloc] init];
    [viewHeader setFrame:CGRectMake(0, 0, __MainScreen_Width, heightRowHeader)];
    [viewHeader setBackgroundColor:[UIColor whiteColor]];
    
    UILabel * dotLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width+1, paddingTop)];
    [dotLine setBackgroundColor: color_bodyededed];
    dotLine.layer.borderColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]].CGColor;
    dotLine.layer.borderWidth=0.5f;
    [viewHeader addSubview:dotLine];
    
    [UICommon Common_UILabel_Add:CGRectMake(10, paddingTop+4, 100, heightRowHeader)
                      targetView:viewHeader bgColor:[UIColor clearColor] tag:2001
                            text:section==0 ? @"支付方式" : @"配送方式"
                           align:-1 isBold:NO fontSize:16 tColor:color_fc4a00];
    [UICommon Common_line:CGRectMake(100, 4+paddingTop+heightRowHeader/2, __MainScreen_Width-108, 1)
               targetView:viewHeader backColor:color_dedede];

    return viewHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *cellIdentifier = @"PaymentTypeAndDeleveryTypeCell";
    
    UITableViewCell * cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        EC_OrderSubmitButton * btnCheck = [[EC_OrderSubmitButton alloc] initWithFrame:CGRectMake(10, 9, 20, 20)];
        [btnCheck setTag:2001];
        [btnCheck setImage:[UIImage imageNamed:@"check_icon_unpoint.png"]];
        [btnCheck setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:btnCheck];
        
        [UICommon Common_UILabel_Add:CGRectMake(35, 9, 60, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:2002
                                text:@"货到付款" align:-1 isBold:NO fontSize:14 tColor:color_333333];
        
        [UICommon Common_UILabel_Add:CGRectMake(100, 9, __MainScreen_Width-110, 22)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:2003
                                text:@"说明11" align:-1 isBold:NO fontSize:14 tColor:color_717171];
        
        [UICommon Common_UILabel_Add:CGRectMake(100, 30, __MainScreen_Width-110, 22)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:2004
                                text:@"说明22" align:-1 isBold:NO fontSize:13 tColor:color_fc4a00];
        
        UILabel * lblLine = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, def_WidthArea(12), 0.5)];
        [lblLine setTag:1111111];
        [lblLine setBackgroundColor:[UIColor clearColor]];
        lblLine.layer.borderColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]].CGColor;
        lblLine.layer.borderWidth=0.5f;
        [cell.contentView addSubview:lblLine];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    
    EC_OrderSubmitButton * btn_2001 = (EC_OrderSubmitButton*)[cell viewWithTag:2001];
    UILabel * lbl_2002 = (UILabel*)[cell viewWithTag:2002];
    UILabel * lbl_2003 = (UILabel*)[cell viewWithTag:2003];
    UILabel * lbl_2004 = (UILabel*)[cell viewWithTag:2004];
    UILabel * lbl_line = (UILabel*)[cell viewWithTag:1111111];
    
    [btn_2001 setHidden:NO];
    [lbl_2004 setText:@""];
    [lbl_line setHidden:YES];
    [lbl_line setFrame:CGRectMake(12, 0, def_WidthArea(12), 0.5)];
    
    if (indexPath.section==0) {
        
        if (indexPath.row>0) { [lbl_line setHidden:NO]; }
        
        resMod_Mall_PaymentTypeByAddress * payment = m_Payments[indexPath.row];
        NSString * payTypeDes = @"";
        
        if ([payment.PaymentTitle isEqualToString:@"货到付款"]) {
            payTypeDes = payment.PaymentDescription.length==0 ? des_COD : payment.PaymentDescription;
        }
        if ([payment.PaymentTitle isEqualToString:@"在线支付"]) {
            payTypeDes = payment.PaymentDescription.length==0 ? des_OnlinePayment : payment.PaymentDescription;
        }

        btn_2001.type_paymentOrDelevery = 99;
        [btn_2001 setImage:[UIImage imageNamed: payment.isCheckedPayment ? @"check_icon_point.png":@"check_icon_unpoint.png"]];
        if (payment.isCheckedPayment) {
            btn_2001.chectTypeID = payment.PaymentId;
            btn_2001.selRowInArray = indexPath.row;
            selPaymentType = btn_2001;
        }
        else{
            btn_2001.chectTypeID = initCheckTypeID;
            btn_2001.selRowInArray = initCheckTypeID;
        }
        
        [lbl_2002 setText:payment.PaymentTitle];
        CGSize tsize = [payTypeDes sizeWithFont:defFont14 constrainedToSize:CGSizeMake(__MainScreen_Width-110, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        [lbl_2003 setText: payTypeDes];
        [lbl_2003 setFrame:CGRectMake(lbl_2003.frame.origin.x,lbl_2003.frame.origin.y,lbl_2003.frame.size.width,tsize.height)];
    }
    else{
        
        if (indexPath.row>0) { [lbl_line setHidden:NO]; }
        
        resMod_Mall_DeliveryTypeByAddress * delevery = m_Deleverys[indexPath.row];
        NSString * des = [NSString stringWithFormat:@"费用: %@ (%@)",[self convertPrice:delevery.ExpressageMoney],delevery.ExpressageDescription];
        CGSize desSize = [des sizeWithFont:defFont14 constrainedToSize:CGSizeMake(__MainScreen_Width-110, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        
        if (delevery.ExpressageId == -9999) { //  -- 代发货情况
            
            des = delevery.ExpressageDescription;
            desSize = [des sizeWithFont:defFont14 constrainedToSize:CGSizeMake(__MainScreen_Width-110, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
            
            [btn_2001 setHidden:YES];
            [lbl_2004 setTextColor:color_fc4a00];
            [lbl_2004 setText:settleAccountsInfo.DropShoppingInfoBottom];
            [lbl_2004 setFrame:CGRectMake(130,lbl_2003.frame.origin.y+15, lbl_2004.frame.size.width,lbl_2004.frame.size.height)];
            
            [lbl_line setFrame:CGRectMake(0, 0, __MainScreen_Width, 0.5)];
            [cell.contentView setBackgroundColor: [UIColor convertHexToRGB:@"F9F9F9"]];
            
        } else {                               //  -- 非代发货
            
            btn_2001.type_paymentOrDelevery = 100;
            [btn_2001 setImage:[UIImage imageNamed:delevery.isCheckedDelivery ? @"check_icon_point.png":@"check_icon_unpoint.png"]];
            
            if (delevery.isCheckedDelivery) {
                btn_2001.chectTypeID = delevery.ExpressageId;
                btn_2001.selRowInArray = indexPath.row;
                selDeleveryType = btn_2001;
            }
            else{
                btn_2001.chectTypeID = initCheckTypeID;
                btn_2001.selRowInArray = initCheckTypeID;
            }
        }
        
        [lbl_2002 setText:delevery.ExpressageTitle];
        [lbl_2003 setText:des];
        [lbl_2003 setFrame:CGRectMake(lbl_2003.frame.origin.x,lbl_2003.frame.origin.y,lbl_2003.frame.size.width,desSize.height)];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //  -- 代发货不能点击，
    if (indexPath.section==1) {
        resMod_Mall_DeliveryTypeByAddress * rowDelevery = m_Deleverys[indexPath.row];
        if(rowDelevery.ExpressageId==-9999)
            return;
    }
    
    [self onPaymentDeleveryTypeCheck:[tableviewPDType cellForRowAtIndexPath:indexPath]];
}



#pragma mark    --  api 请 求 & 回 调.
//--    结算信息.
-(void)goApiRequest_SettleAccounts{
    
    NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
    [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
    [apiParams setObject:[self convertGoodsInfoForApiParams:paramGoodsList] forKey:@"GoodsInfo"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestSettleAccounts:apiParams ModelClass:@"resMod_CallBackMall_SettleAccounts" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
}

//--    地址改变时 获取对应 支付方式，配送方式.
-(void)goApiRequest_PaymentAndDeleveryTypeByAddress{
    
    int iaddressid = myAddressInfo!=nil ? myAddressInfo.AddressId : 0;
    NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
    [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
    [apiParams setObject:[NSString stringWithFormat:@"%d",iaddressid] forKey:@"AddressId"];
    [apiParams setObject:[self convertGoodsInfoForApiParams:paramGoodsList] forKey:@"GoodsInfo"];
    
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_GetPaymentAndExpressageListByAddress
//               class:@"resMod_CallBackMall_PaymentAndDeliveryByAddress"
//              params:apiParams isShowLoadingAnimal:NO hudShow:@"获取支付、配送方式中..."];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetPaymentAndExpressageListByAddress:apiParams ModelClass:@"resMod_CallBackMall_PaymentAndDeliveryByAddress" showLoadingAnimal:NO hudContent:@"获取支付、配送方式中..." delegate:self];
    
}
//--    获取可用优惠券列表
- (void)goApiRequest_GetMallCoupons{
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:1];
    [pms setValue:[UserUnit userId] forKeyPath:@"UserId"];
//    
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_GetCouponListCanUse class:@"resMod_CallBack_MyCouponList"
//              params:pms isShowLoadingAnimal:NO hudShow:@"正在加载"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingMallCoupon:pms ModelClass:@"resMod_CallBack_MyCouponList" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
}

//--    检查优惠券.
-(void)goApiRequest_CheckCoupon{
    
    if ([self ValidateOperate]) {
        if (txtCoupon.text.length==0) {
            [self HUDShow:@"请输入优惠券码" delay:1.5];
            return;
        }
        
        NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
        [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
        [apiParams setObject:[self convertGoodsInfoForApiParams:paramGoodsList] forKey:@"GoodsInfo"];
        [apiParams setObject:[NSString stringWithFormat:@"%d",myAddressInfo.AddressId] forKey:@"AddressId"];
        [apiParams setObject:[NSString stringWithFormat:@"%d",selPaymentType.chectTypeID] forKey:@"PaymentId"];
        [apiParams setObject:[NSString stringWithFormat:@"%d",selDeleveryType.chectTypeID] forKey:@"ExpressageId"];
        [apiParams setObject:txtCoupon.text forKey:@"CouponNo"];
        
//        [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_CheckCoupon class:@"resMod_CallBackMall_CheckCoupon"
//                  params:apiParams isShowLoadingAnimal:NO hudShow:@"验证中..."];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestCheckCoupon:apiParams ModelClass:@"resMod_CallBackMall_CheckCoupon" showLoadingAnimal:NO hudContent:@"正在验证" delegate:self];
    }
}

//--    结算 支付明细.
-(void)goApiRequest_OrderAmountDetail{
    
    if ([self ValidateOperate]) {
        NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
        [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
        [apiParams setObject:[self convertGoodsInfoForApiParams:paramGoodsList] forKey:@"GoodsInfo"];
        [apiParams setObject:[NSString stringWithFormat:@"%d",myAddressInfo.AddressId] forKey:@"AddressId"];
        [apiParams setObject:[NSString stringWithFormat:@"%d",selPaymentType.chectTypeID] forKey:@"PaymentId"];
        [apiParams setObject:[NSString stringWithFormat:@"%d",selDeleveryType.chectTypeID] forKey:@"ExpressageId"];
        if (txtCoupon.text.length>0) {
            [apiParams setObject:txtCoupon.text forKey:@"CouponNo"];
        }
        
        [[APIMethodHandle shareAPIMethodHandle] goApiRequestGetOrderAmountDetail:apiParams ModelClass:@"resMod_CallBackMall_OrderAmountDetail" showLoadingAnimal:NO hudContent:@"" delegate:self];
    }
}

//--    下单.
-(void)goApiRequest_CreateOrder{
    
    if ([self ValidateOperate]) {
        NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
        [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
        [apiParams setObject:[self convertGoodsInfoForApiParams:paramGoodsList] forKey:@"GoodsInfo"];
        [apiParams setObject:[NSString stringWithFormat:@"%d",myAddressInfo.AddressId]forKey:@"AddressId"];
        [apiParams setObject:[NSString stringWithFormat:@"%d",selPaymentType.chectTypeID] forKey:@"PaymentId"];
        [apiParams setObject:[NSString stringWithFormat:@"%d",selDeleveryType.chectTypeID] forKey:@"ExpressageId"];
        if (txtCoupon.text.length>0) {
            [apiParams setObject:txtCoupon.text forKey:@"CouponNo"];
        }
//        [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_CreateOrder class:@"resMod_CallBackMall_OrderCommit"
//                  params:apiParams  isShowLoadingAnimal:NO hudShow:@"正在下单"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestCommitGoodsOrder:apiParams ModelClass:@"resMod_CallBackMall_OrderCommit" showLoadingAnimal:NO hudContent:@"正在下单" delegate:self];
    }
}


-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    
    if ([ApiName isEqualToString:kApiMethod_Mall_SettleAccounts]) {
        resMod_CallBackMall_SettleAccounts * backObj = [[resMod_CallBackMall_SettleAccounts alloc] initWithDic:retObj];
        settleAccountsInfo = backObj.ResponseData;
        myAddressInfo = settleAccountsInfo.AddressInfo;
        
        [self loadView_topAddress];
        [self resetViewFrame];
        [self updatePayMoneyDetail];
        [self goApiRequest_PaymentAndDeleveryTypeByAddress];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_GetPaymentAndExpressageListByAddress]){
        resMod_CallBackMall_PaymentAndDeliveryByAddress * backObj = [[resMod_CallBackMall_PaymentAndDeliveryByAddress alloc] initWithDic:retObj];
        m_Payments = backObj.ResponseData;
//        if (m_Payments && m_Payments.count>0) {
//            m_Deleverys = [m_Payments[0] ExpressageList];
//        }
        
        //  --  默认选择第一个支付方式和第一个配送方式
        int i=0;
        for (resMod_Mall_PaymentTypeByAddress * keyPayment in m_Payments) {
            if (i==0) {
                keyPayment.isCheckedPayment = YES;
                for (int j=0; j<[keyPayment ExpressageList].count ;j++) {
                    if (j==0) {
                        resMod_Mall_DeliveryTypeByAddress * keyDelivery = [keyPayment ExpressageList][i];
                        keyDelivery.isCheckedDelivery = YES;
                    }
                }
                m_Deleverys = [keyPayment ExpressageList];
                
                //  -- 如果是代发货商品
                if (settleAccountsInfo && settleAccountsInfo.DropShoppingInfoTitle.length>0) {
                    resMod_Mall_DeliveryTypeByAddress * tmpDTB = [resMod_Mall_DeliveryTypeByAddress alloc];
                    tmpDTB.ExpressageId = -9999;
                    tmpDTB.ExpressageTitle = settleAccountsInfo.DropShoppingInfoTitle;
                    tmpDTB.ExpressageDescription = settleAccountsInfo.DropShoppingInfoTop;
                    [m_Deleverys addObject:tmpDTB];
                }
            }
            i++;
        }
        
        heightPaytypeAndDeleverytype = (heightRowHeader+paddingTop)*2 + heightRow*(m_Payments.count + m_Deleverys.count);
        [tableviewPDType reloadData];

        [self resetViewFrame];
        [self performSelector:@selector(updatePayMoneyDetail) withObject:nil afterDelay:0.5];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_GetCouponListCanUse]) {
        resMod_CallBack_MyCouponList * backObj = [[resMod_CallBack_MyCouponList alloc] initWithDic:retObj];
        
        [self.arrCoupons removeAllObjects];
        if (backObj.ResponseData.count>0) {
            self.arrCoupons = backObj.ResponseData;
        }
        [self LoadData_CouponList];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_CheckCoupon]) {
        resMod_CallBackMall_CheckCoupon * backObj = [[resMod_CallBackMall_CheckCoupon alloc] initWithDic:retObj];
        checkCouponInfo = backObj.ResponseData;
        //  --  。。。。。。。
        [self updatePayMoneyDetail];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_GetOrderAmountDetail]) {
        
        resMod_CallBackMall_OrderAmountDetail * backObj = [[resMod_CallBackMall_OrderAmountDetail alloc]initWithDic:retObj];
        resMod_Mall_OrderAmountDetail * amountDetail = backObj.ResponseData;
        
        UILabel * lbl_0 =(UILabel*)[view_PayDetail viewWithTag:tagPayMoneyDetail];
        UILabel * lbl_1 =(UILabel*)[view_PayDetail viewWithTag:tagPayMoneyDetail+1];
        UILabel * lbl_2 =(UILabel*)[view_PayDetail viewWithTag:tagPayMoneyDetail+2];
        UILabel * lbl_3 =(UILabel*)[view_PayDetail viewWithTag:tagPayMoneyDetail+3];
        UILabel * lbl_4 =(UILabel*)[view_PayDetail viewWithTag:tagPayMoneyDetail+4];
        
        [lbl_0 setText:[self convertPrice:amountDetail.GoodsPrice]];
        [lbl_1 setText:[self convertPrice:amountDetail.ExpressagePrice]];
        [lbl_2 setText:[self convertPrice:amountDetail.PreferentialPrice]];
        [lbl_3 setText:[self convertPrice:amountDetail.CouponPrice]];
        [lbl_4 setText:[self convertPrice:amountDetail.NeedToPay]];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_CreateOrder]) {
        resMod_CallBackMall_OrderCommit * backObj = [[resMod_CallBackMall_OrderCommit alloc] initWithDic:retObj];
        resMod_Mall_OrderCommitBackInfo * commitOrderinfo = backObj.ResponseData;
        commitOrderinfo.payType = [m_Payments[selPaymentType.selRowInArray] PaymentTitle];
        commitOrderinfo.deleveryType = [m_Deleverys[selDeleveryType.selRowInArray] ExpressageTitle];
        
        if (commitOrderinfo) {
            //  -- 支付成功  更新本地用户信息
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updataUserInfo" object:nil];

            [self pushNewViewController:@"MallOrderSubmitSuccessController" isNibPage:NO hideTabBar:YES setDelegate:NO
                          setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:commitOrderinfo,@"pOrderInfo",nil]];
        }
    }
}

//-- 请求出错时
-(void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName {
    
    [super interfaceExcuteError:error apiName:ApiName];
    
    if ([ApiName isEqualToString:kApiMethod_Mall_SettleAccounts]) {
        [self loadView_topAddress];
        [self resetViewFrame];
//        [self updatePayMoneyDetail];
        [self performSelector:@selector(goBack:) withObject:nil afterDelay:2];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_CheckCoupon]) {
        
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_CreateOrder]) {
        
    }
}

-(BOOL) ValidateOperate{
    if (!selPaymentType || selPaymentType.chectTypeID==initCheckTypeID) {
        [self HUDShow:@"请选择支付方式" delay:1.5];
        return NO;
    }
    if (!selDeleveryType || selDeleveryType.chectTypeID==initCheckTypeID) {
        [self HUDShow:@"请选择配送方式" delay:1.5];
        return NO;
    }
    if (myAddressInfo==nil) {
        [self HUDShow:@"请选择收货地址" delay:1.5];
        return NO;
    }
    return YES;
}


#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 787879 && !isUseCoupon) {
        return NO;
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (textField.tag==787879) {
        if (txtCoupon.text.length==0) {
            checkCouponInfo = nil;
        }
        
        [self selectCheckCoupon];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if (textField.tag == 787879) {
        [self selectCheckCoupon];
        [self goApiRequest_CheckCoupon];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *tmpTxt = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger Length = tmpTxt.length - range.length + string.length;
    if(textField.tag == 787879){
        if ( Length == 11 ){
//            NSString * coup = [NSString stringWithFormat:@"%@%@",textField.text,string];
//            if (string.length==0) {
//                coup = [coup substringToIndex:coup.length-1];
//            }
            
            textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
            [textField resignFirstResponder];
        }
        [self selectCheckCoupon];
    }
    return YES;
}

- (void) selectCheckCoupon{
    for (resMod_MyCouponInfo * coupon in self.arrCoupons) {
        UIButton * btntmp = (UIButton*)[view_couponlist viewWithTag:coupon.CouponId];
        UIImageView * imgcheck = (UIImageView*)[btntmp viewWithTag:222333];
        if ([coupon.CouponNo isEqualToString:txtCoupon.text])
            [imgcheck setImage:[UIImage imageNamed:@"checkbox_greensel.png"]];
        else
            [imgcheck setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




