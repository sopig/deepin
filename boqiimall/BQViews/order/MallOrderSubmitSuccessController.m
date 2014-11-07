//
//  MallOrderSubmitSuccessController.m
//  boqiimall
//
//  Created by YSW on 14-6-25.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "MallOrderSubmitSuccessController.h"

#define heightRowPayDetail 45

#define payMoneyDetail @"订 单 号|应付金额|支付方式|配送方式"

#define payWarn_COD    @"提示：您已使用货到付款成功下单，系统审核完成后，将在7个工作日内完成派送，请注意查收。"
#define payWarn_onLine @"提示：为了保证及时处理您的订单，请于下单后24小时内付款，若逾期未付款，订单将被取消，需重新下单。"

@implementation MallOrderSubmitSuccessController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isRootPage = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"订单提交成功"];
    //[self loadNavBarView:@"订单提交成功"];
    [self.view setBackgroundColor:color_bodyededed];
    orderInfo = [self.receivedParams objectForKey:@"pOrderInfo"];
    
    NSArray * arrpaydetail = [payMoneyDetail componentsSeparatedByString:@"|"];

    //  --  支付明细
    view_PayDetail = [[UIView alloc] initWithFrame:CGRectMake(15, -1+kNavBarViewHeight, def_WidthArea(15), heightRowPayDetail*arrpaydetail.count)];
    [view_PayDetail setBackgroundColor:[UIColor whiteColor]];
    view_PayDetail.layer.borderColor = [UIColor convertHexToRGB:@"dbdbdb"].CGColor;
    view_PayDetail.layer.borderWidth = 0.5f;
    [self.view addSubview:view_PayDetail];
    
    UIImageView * bgview = [[UIImageView alloc] initWithFrame:CGRectMake(15, view_PayDetail.frame.size.height-1.5+kNavBarViewHeight, view_PayDetail.frame.size.width, 7/2)];
    [bgview setBackgroundColor:[UIColor clearColor]];
    [bgview setImage:[UIImage imageNamed:@"misumi_ine.png"]];
    [self.view addSubview:bgview];
    
    float ypoint = 0;
    for (int i=0; i<arrpaydetail.count; i++) {
        ypoint =  heightRowPayDetail*i;
        [UICommon Common_UILabel_Add:CGRectMake(10, ypoint, 80, heightRowPayDetail)
                          targetView:view_PayDetail bgColor:[UIColor clearColor] tag:1002
                                text:[NSString stringWithFormat:@"%@:",arrpaydetail[i]]
                               align:-1 isBold:NO fontSize:14
                              tColor:color_4e4e4e];
        
        NSString * stxt = @"";
        switch (i) {
            case 0: stxt = [NSString stringWithFormat:@"%d",orderInfo.OrderId];
                break;
            case 1: stxt = [self convertPrice:orderInfo.OrderPrice];
                break;
            case 2: stxt = orderInfo.payType;
                break;
            case 3: stxt = orderInfo.deleveryType;
                break;
            default:
                break;
        }
        [UICommon Common_UILabel_Add:CGRectMake(__MainScreen_Width-120, ypoint, 80, heightRowPayDetail)
                          targetView:view_PayDetail bgColor:[UIColor clearColor] tag:1003
                                text:stxt
                               align:1 isBold: i==1?YES:NO
                            fontSize: (i==0||i==1) ? 16 : 14
                              tColor: i==1?color_fc4a00:color_4e4e4e];
        if (i>0) {
            UILabel * dotLine = [[UILabel alloc] initWithFrame:CGRectMake(0, ypoint, view_PayDetail.frame.size.width, 0.5)];
            [dotLine setBackgroundColor:[UIColor clearColor]];
            dotLine.layer.borderColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]].CGColor;
            dotLine.layer.borderWidth=0.5f;
            [view_PayDetail addSubview:dotLine];
        }
    }
    
//    [UICommon Common_UILabel_Add:CGRectMake(14, view_PayDetail.frame.size.height+6, def_WidthArea(14), 60)
//                      targetView:self.view bgColor:[UIColor clearColor] tag:2000
//                            text:payWarn align:-1 isBold:NO fontSize:13 tColor:color_717171];
    
    
    float fbtnWidth = __MainScreen_Width/2-30;
    UIButton * btn_unPay = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_unPay setTag:99998];
    [btn_unPay setHidden:YES];
    [btn_unPay setFrame:CGRectMake(20, view_PayDetail.frame.size.height+70+kNavBarViewHeight, fbtnWidth, 40)];
    [btn_unPay setBackgroundColor:color_b3b3b3];
    btn_unPay.layer.cornerRadius = 2.0;
    [btn_unPay setTitle:@"暂不支付" forState:UIControlStateNormal];
    [btn_unPay.titleLabel setFont:defFont16];
    [btn_unPay addTarget:self action:@selector(onPayClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_unPay];
    
    UIButton * btn_PayOnline = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_PayOnline setTag:99999];
    [btn_PayOnline setHidden:YES];
    [btn_PayOnline setFrame:CGRectMake(__MainScreen_Width/2+10,view_PayDetail.frame.size.height+70+kNavBarViewHeight, fbtnWidth, 40)];
    [btn_PayOnline setBackgroundColor:color_fc4a00];
    btn_PayOnline.layer.cornerRadius = 2.0;
    [btn_PayOnline setTitle:@"在线支付" forState:UIControlStateNormal];
    [btn_PayOnline.titleLabel setFont:defFont16];
    [btn_PayOnline addTarget:self action:@selector(onPayClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_PayOnline];
    
    if ([orderInfo.payType isEqualToString:@"在线支付"]) {
        [btn_unPay setHidden:NO];
        [btn_PayOnline setHidden:NO];
    }
    if (orderInfo.OrderPaymentId == 2                           //货到付款永远是 2
        || [orderInfo.payType isEqualToString:@"银行转账"]) {    //银行转账 也不用在线支付
        [btn_unPay setHidden:NO];
        [btn_unPay setTitle:@"完 成" forState:UIControlStateNormal];
        [btn_unPay setBackgroundColor:color_fc4a00];
        [btn_unPay setFrame:CGRectMake((__MainScreen_Width-fbtnWidth)/2, view_PayDetail.frame.size.height+70, fbtnWidth, 40)];
    }
}

//- (void)loadNavBarView:(NSString *)title
//{
//
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = title;
//    [bgView addSubview:titleLabel];
//    [self.navBarView addSubview:bgView];
//}

- (void)onPayClick:(id) sender{
    UIButton * btntmp = (UIButton*)sender;
    if (btntmp.tag==99998) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoRootNotification" object:@"goMallOrder"];
    }
    if (btntmp.tag==99999) {
        NSMutableDictionary * dicparam = [[NSMutableDictionary alloc]init];
        [dicparam setObject:[NSString stringWithFormat:@"%d",orderInfo.OrderId] forKey:@"param_orderid"];
        [dicparam setObject:[NSString stringWithFormat:@"%.2f",orderInfo.OrderPrice] forKey:@"param_orderprice"];
        [self pushNewViewController:@"MallOrderPaymentVC" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:dicparam];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
