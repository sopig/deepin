//
//  ProjectShowViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-10.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "ProjectShowViewController.h"

#define heightTopView 60

@implementation ProjectShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self tabBar_Hidden:self.tabBarController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self loadNavBarView];
    [self setTitle:@"服务项目展示"];
    [self.view setBackgroundColor:color_body];
    
  //  [self loadNavBarView];
    
    ticketInfo = [self.receivedParams objectForKey:@"param_ticketInfo"];
    
    if (!ticketInfo) {
        [self.noDataView noDataViewIsHidden:NO warnImg:@"" warnMsg:@"抱歉，没有找到相关信息"];
        return;
    }
    
    UIView * topView=[[UIView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, heightTopView)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    
    [UICommon Common_line:CGRectMake(0, heightTopView, __MainScreen_Width, 1) targetView:topView backColor:color_d1d1d1];
    [self.view addSubview:topView];
    
    CGSize size_xj = [[self convertPrice:ticketInfo.TicketPrice] sizeWithFont:defFont(YES, 20)
                                                            constrainedToSize:CGSizeMake(MAXFLOAT, 25)];
    CGSize size_yj = [[self convertPrice:ticketInfo.TicketOriPrice] sizeWithFont:defFont14
                                                               constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    //--现价.
    [UICommon Common_UILabel_Add:CGRectMake(5, 10, 105, 25) targetView:topView
                         bgColor:[UIColor clearColor] tag:1001
                            text:[self convertPrice:ticketInfo.TicketPrice]
                           align:-1 isBold:YES fontSize:22 tColor:color_fc4a00];
    //--原价.
    [UICommon Common_UILabel_Add:CGRectMake(size_xj.width+20, 14, size_yj.width, 20)
                      targetView:topView bgColor:[UIColor clearColor] tag:1002
                            text:[self convertPrice:ticketInfo.TicketOriPrice]
                           align:-1 isBold:NO fontSize:14 tColor:color_b3b3b3];
    [UICommon Common_line:CGRectMake(size_xj.width+19, 24, size_yj.width+2, 1) targetView:topView backColor:color_b3b3b3];
    
    //--折扣.
    [UICommon Common_UILabel_Add:CGRectMake(size_xj.width+20+size_yj.width+10, 14, 60, 20)
                      targetView:topView bgColor:[UIColor clearColor] tag:1003
                            text:[NSString stringWithFormat:@"%.1f折",[ticketInfo.TicketSale floatValue]]
                           align:-1 isBold:NO fontSize:15 tColor:color_333333];
    
    //--限购信息.
    [UICommon Common_UILabel_Add:CGRectMake(8, 36, 200, 20) targetView:topView
                         bgColor:[UIColor clearColor] tag:1004
                            text:ticketInfo.TicketLimit   /*@"一个用户最多只可购买2张"*/
                           align:-1 isBold:NO fontSize:13 tColor:color_717171];
    
    UIButton * btn_Buy = [[UIButton alloc] initWithFrame:CGRectMake(__MainScreen_Width-90, 10, 80, 40)];
    [btn_Buy setTag:19040];
    [btn_Buy setTitle: ticketInfo.TicketRemain<0 ? @"已过期":@"立即购买" forState:UIControlStateNormal];
    [btn_Buy setBackgroundColor: ticketInfo.TicketRemain<0 ? color_b3b3b3:color_fc4a00];
    [btn_Buy.titleLabel setFont: defFont(YES, 15)];
    btn_Buy.layer.cornerRadius = 3.0f;
    [btn_Buy addTarget:self action:@selector(onBuyClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn_Buy];
    
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, heightTopView+1+kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight-heightTopView-kNavBarViewHeight)];
    _webView.delegate=self;
    _webView.userInteractionEnabled = YES;
    _webView.scalesPageToFit=YES;
    _webView.backgroundColor=[UIColor convertHexToRGB:@"e6e6e6"];
    [self.view addSubview:_webView];

	NSURL *url = [NSURL URLWithString:ticketInfo.TicketShowUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url
											 cachePolicy:NSURLRequestUseProtocolCachePolicy
										 timeoutInterval:40.0];
    [self HUDShow:@"正在加载"];
    [_webView loadRequest:request];
}

//- (void)loadNavBarView
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
//    titleLabel.text = @"服务项目展示";
//    [bgView addSubview:titleLabel];
//    [self.navBarView addSubview:bgView];
//}


#pragma mark    --  事件区
- (void)onBuyClick:(id) sender{
    
    if (ticketInfo.TicketRemain<0) {
        return;
    }
    
    if (![UserUnit isUserLogin]) {
        [self goLogin:@"go_ordersubmitcontroller" param:nil delegate:self];
        return;
    }
    else{
        [self goOrderSubmitController];
    }
//    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithObjectsAndKeys: ticketInfo,@"orderNeed", nil];
//    [self pushNewViewController:@"OrderSubmitController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
}

- (void) goOrderSubmitController{
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithObjectsAndKeys: ticketInfo,@"orderNeed", nil];
    [self pushNewViewController:@"OrderSubmitController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
}

- (void)LoginSuccessPushViewController:(NSString *)m_str param:(id)m_param{
    if ([m_str isEqualToString:@"go_ordersubmitcontroller"]) {
        [self goOrderSubmitController];
    }
}
#pragma mark    --  web View call back
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self hudWasHidden:HUD];
    
}
//当结束请求的时候被通知
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self HUDShow:@"内部错误" delay:1.5];
};


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
