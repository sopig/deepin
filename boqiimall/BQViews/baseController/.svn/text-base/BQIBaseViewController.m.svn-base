//
//  BQIBaseViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-4-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "LoginViewController.h"
#import "resMod_Mall_GoodsForApiParams.h"
#import "BQIAppDelegate.h"

@implementation BQIBaseViewController
@synthesize noDataView,lodingAnimationView,lblTitle;
@synthesize dicAllPages;
@synthesize isRootPage,backImgName,receivedParams;
@synthesize Delegate;
@synthesize navBarView=_navBarView;
@synthesize subNavBarView = _subNavBarView;
@synthesize _titleLabel;
@synthesize backBtn;

- (NSDictionary *) dicAllPages {
    
    if (dicAllPages == nil) {
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"boqiiPageKeyValue" withExtension:@"plist"];
        dicAllPages = [NSMutableDictionary dictionaryWithContentsOfURL:url];
    }
    return dicAllPages;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isShowNavBar = YES;
        self.isRootPage = NO;
        self.backImgName = @"icon_back.png";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavBarView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    #ifdef __IPHONE_7_0
    if ( IOS7_OR_LATER ) {      // 针对ios7以上的处理
        self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    #endif
    
    if(!IOS7_OR_LATER) {
        UISwipeGestureRecognizer *recognizer  = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [[self view] addGestureRecognizer:recognizer];
    }
    
    //  -- ..反回
    [self addBackNavigationButton];
    //  -- ..无数据

    self.noDataView = [[NoDataView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight) msgForNoData:@"" isHidden:YES];
    [self.view addSubview:noDataView];
    //  -- ..加载动画
    self.lodingAnimationView = [[LoadingAnimationView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, kMainScreenHeight)];
    [self.view addSubview:lodingAnimationView];
    
//    self.navBarView = [[BQNavBarView alloc] initWithFrame:CGRectMake(0, 0,__MainScreen_Width, kNavBarViewHeight)];
//    [self.navBarView setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:self.navBarView];

   // [self loadNavBarView];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //  -- 友盟统计页面访问深度 ： begin
    [MobClick beginLogPageView:  [self.dicAllPages objectForKey:[self.class description]]];
    
    self.lblTitle.TextColor = color_333333;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem.title = @"";
    self.navigationController.navigationBar.backItem.hidesBackButton = YES;
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:def_ImgStretchable(@"NavBg_ffffff.png", 5, 20)
                                                  forBarMetrics:UIBarMetricsDefault];
    if (isShowNavBar) {
        [self NavController_Show:YES animated:YES];
    }
    
    [self.view bringSubviewToFront:self.navBarView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //  -- 友盟统计页面访问深度 ： end
    [MobClick endLogPageView: [self.dicAllPages objectForKey:[self.class description]]];
}

#pragma  -mark -- 添加自定义的navigationBarView

- (void)loadNavBarView {
    self.navBarView = [[BQNavBarView alloc] initWithFrame:CGRectMake(0, 0,__MainScreen_Width, kNavBarViewHeight)];
    [self.navBarView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.navBarView];
    self.subNavBarView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
    [self.navBarView addSubview:self.subNavBarView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self._titleLabel setTextColor:color_333333];
    [self._titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:18]];
    [self.subNavBarView addSubview:_titleLabel];
}


#pragma mark    --  title 设置
- (void) setTitle:(NSString *) _stitle{
    [super setTitle:@""];
    _titleLabel.text = _stitle;
    
//    self.navigationController.title = @"";
//    if (IOS7_OR_LATER) {
//        [self.navigationController.navigationBar setBarTintColor:[UIColor convertHexToRGB:@"f4f4f4"]];
//    }
//    else{
//        [self.navigationController.navigationBar setTintColor:[UIColor convertHexToRGB:@"000000"]];
//    }
//    
//    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
//    [self.lblTitle setBackgroundColor:[UIColor clearColor]];
//    [self.lblTitle setText:_stitle];
//    [self.lblTitle setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:18]];
//    [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
//    [self.lblTitle setTextColor:color_333333];
//    self.navigationItem.titleView = lblTitle;
//    NSDictionary * dicText = [[NSDictionary alloc] initWithObjectsAndKeys:color_333333,UITextAttributeTextColor,defFont(YES, 18),UITextAttributeFont,[UIColor clearColor],UITextAttributeTextShadowColor, nil];
//    self.navigationController.navigationBar.titleTextAttributes = dicText;
}

//- (void) setTitle:(NSString *) _stitle textAttributes:(NSDictionary*) _attr{
//    [self setTitle:@""];
//    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:color_333333 forKey:UITextAttributeTextColor];
//}

#pragma mark    --  back Navigation
- (void)addBackNavigationButton{
    
    //若为根页面，则不增加返回按钮
    if (self.isRootPage) {
        return;
    }
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(4, 7, 30, 30)];
    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
    [self.subNavBarView addSubview:backBtn];
    
//    UIButton *l_backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
//    [l_backBtn setBackgroundColor:[UIColor clearColor]];
//    [l_backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [l_backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView * imgicon = [[UIImageView alloc] initWithFrame:CGRectMake(-8, 7, 30, 30)];
//    [imgicon setImage:[UIImage imageNamed:self.backImgName]];
//    [l_backBtn addSubview:imgicon];
//    
//    UIBarButtonItem *bar_Btn = [[UIBarButtonItem alloc]initWithCustomView:l_backBtn];
//    if (IOS7_OR_LATER) {
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSpacer.width = -5;
//        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,bar_Btn, nil];
//    }else{
//        self.navigationItem.leftBarButtonItem = bar_Btn;
//    }
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    [self goBack:nil];
}

- (void)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

/*  参数说明
 *  controllerName : push的目标页 例：@“testcontroll”    ---注意不带.h
 *  isNibPage      : 目标页是否带 xib 文件
 *  setHideTabBar  : 当前页是否隐藏 tabBar      -----注意 是当前页 非目标页
 *  setDelegate    : 是否设置委托
 */
- (void)pushNewViewController:(NSString *)controllerName isNibPage:(BOOL) _isNib hideTabBar:(BOOL) _bool
                  setDelegate:(BOOL)b_delegate  setPushParams:(NSMutableDictionary *) _pushParams
{
    if (controllerName.length <= 0)
        return;
    
    Class   class_Page = NSClassFromString((NSString *)controllerName);
    if (class_Page != nil) {
        
        BQIBaseViewController * viewCtrl_Page = _isNib ? [[class_Page alloc] initWithNibName:controllerName bundle:nil]
                                                       : [[class_Page alloc] init];
       
        if (b_delegate) {
            [viewCtrl_Page setDelegate:self];
        }
        if (_pushParams != nil && _pushParams.count>0) {
            [viewCtrl_Page setReceivedParams:_pushParams];
        }
        
        if (_bool)
            [viewCtrl_Page setHidesBottomBarWhenPushed:YES];
        else
            [viewCtrl_Page setHidesBottomBarWhenPushed:YES];
        
        [self.navigationController pushViewController:viewCtrl_Page animated:YES];
        
    }
}

#pragma mark    --  用户登录
- (void)goLogin:(NSString *) loginSuccessPushController param:(id) dicParam delegate:(id) _logindelegate{
    LoginViewController *loginView = [[LoginViewController alloc] init];
    loginView.loginDelegate = _logindelegate;
    loginView.pushContollerString = loginSuccessPushController;
    loginView.param = dicParam;
    
    UINavigationController*loginNav = [[UINavigationController alloc] initWithRootViewController:loginView];
    if (IOS_VERSION>=5.0) {
        [loginNav.navigationBar setBackgroundImage:[[UIImage imageNamed:@"NavBg_f4f4f4.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:10] forBarMetrics:UIBarMetricsDefault];
    }
    [self presentViewController:loginNav animated:YES completion:nil];
}

#pragma mark    --  NavBar 显示与隐藏
-(void)NavController_Show:(BOOL) showOrHidden animated:(BOOL) animated{
    [self.navigationController setNavigationBarHidden:YES];
    return;

//    //显示
//    if (showOrHidden) {
//        
//        [[self navigationController] setNavigationBarHidden:NO animated:NO];
//
//        CGRect navBarFrame=NavBarFrame;
//        navBarFrame.origin.y = 20;
//        
//        [UIView animateWithDuration:0.2 animations:^{
//            NavBarFrame = navBarFrame;
//        }];
//    }
//    //隐藏
//    if (!showOrHidden) {
//        
//        CGRect frame =NavBarFrame;
//        frame.origin.y = -24;
//        
//        if (animated) {
//            [UIView animateWithDuration:0.2 animations:^{
//                NavBarFrame = frame;
//                [[self navigationController] setNavigationBarHidden:YES animated:NO];
//            }];
//        }
//        else{
//            NavBarFrame = frame;
//            [[self navigationController] setNavigationBarHidden:YES animated:NO];
//        }
//    }
}

#pragma mark    --  tabBar 显示与隐藏
//  --  tab隐藏
- (void)tabBar_Hidden:(UITabBarController *) tabbarcontroller { return;
    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    
//    for(UIView *view in tabbarcontroller.view.subviews)
//    {
//        if([view isKindOfClass:[UITabBar class]]) {
//            if (IOS7_OR_LATER) {
//                [view setFrame:CGRectMake(view.frame.origin.x, __MainScreen_Height+22, view.frame.size.width, 0)];
//            }else{
//                [view setFrame:CGRectMake(view.frame.origin.x, __MainScreen_Height+22, view.frame.size.width, view.frame.size.height)];
//            }
//        }
//        else {
//            if (!IOS7_OR_LATER) {
//                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, __MainScreen_Height+22)];
//            }
//        }
//    }
//    [UIView commitAnimations];
}
//  --  tab显示
- (void)tabBar_Show:(UITabBarController *) tabbarcontroller { return;
    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.1];
//    for(UIView *view in tabbarcontroller.view.subviews)
//    {
//        if([view isKindOfClass:[UITabBar class]]) {
//            if (IOS7_OR_LATER) {
////                NSLog(@"--star tab ypoint :%.2f",view.frame.origin.y);
//                [view setFrame:CGRectMake(view.frame.origin.x, __MainScreen_Height-49 + 20, view.frame.size.width,50)];
////                NSLog(@"--end tab ypoint :%.2f",view.frame.origin.y);
//            }else{
//                [view setFrame:CGRectMake(view.frame.origin.x, __MainScreen_Height-49 + 20, view.frame.size.width, view.frame.size.height)];
//            }
//        }
//        else {
////            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, __MainScreen_Height + 25)];
//        }
//    }
//    
//    [UIView commitAnimations];
}

#pragma mark   -- 提示
- (void)failWithErrorText:(NSString *)text
{
    NSError *   error = [NSError errorWithDomain:@"errormessage" code:0 userInfo:[NSDictionary dictionaryWithObject:text forKey:NSLocalizedDescriptionKey]];
    
    [self HUDShow:[error.userInfo objectForKey:NSLocalizedDescriptionKey] delay:kShowMsgAfterDelay];
}

#pragma mark - animationDelegate
- (void)showLoadingAnimation:(BOOL)isShow Content:(NSString *)content
{
    isShow = self.lodingAnimationView.hasDisplayed ? NO:isShow;
    if (!isShow && content.length>0) {
        [self HUDShow: content];
    }
    if (isShow) {
        [lodingAnimationView startLoadingAnimal];
    }
}

//////
#pragma mark    -- MBProgressHUD Delegate
-(void) initHUD {
    if (HUD == nil ) {
        /*
         UIWindow *defaultWindow = [HKGlobal defaultWindow];
         HUD = [[MBProgressHUD alloc]initWithView:defaultWindow];
         [defaultWindow addSubview:HUD];
         HUD.delegate = self;
         */
        HUD = [[MBProgressHUD alloc]initWithView:self.view];
        HUD.delegate = self;
        [self.view addSubview:HUD];
    }
}

-(void)HUDShow:(NSString*)text {
    [self initHUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeCustomView;//MBProgressHUDModeIndeterminate;
    [HUD show:YES];
}

-(void)HUDShow:(NSString*)text delay:(float)second {
    [self initHUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    [HUD show:YES];
    [HUD hide:YES afterDelay:second];
}

-(void)HUDShow:(NSString*)text delay:(float)second dothing:(BOOL)bDo {
    [self initHUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    [HUD show:YES];
    [HUD hide:YES afterDelay:second dothing:bDo];
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    [HUD removeFromSuperview];
    HUD = nil;
}

-(void)HUDdelayDo {
    
}


//-- 请求成功
-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
}

//-- 请求出错时
-(void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName {

    [lodingAnimationView stopLoadingAnimal];
    
    NSString * warnMsg = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
    if (warnMsg.length>30) {
        [self HUDShow:@"访问出错 请稍后重试" delay:kShowMsgAfterDelay];
        return;
    }
    [self HUDShow:warnMsg.length==0 ? @"服务器出错" :warnMsg delay:kShowMsgAfterDelay];
}

#pragma mark    --  得到购物车数量
-(void)goApiRequest_GetCartNum{
    if ([UserUnit isUserLogin]) {
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingCartNumber:[[NSMutableDictionary alloc]initWithObjectsAndKeys:[UserUnit userId],@"UserId", nil] ModelClass:@"resMod_CallBackMall_CartNum" showLoadingAnimal:NO hudContent:@"" delegate:self];
    }
}

#pragma mark    --  常 用 转 换 .
//  -- 钱
- (NSString*) convertPrice:(float) price{
    return [NSString stringWithFormat:@"%.2f元",price];
}
//  -- 距离
- (NSString*) convertDistance:(float) distance{
    
    if (distance==0) {
        return @"";
    }
    
    float fd = distance/1000;
    if (fd<1) {
        return [NSString stringWithFormat:@"%.2fm",distance];
    }
    if (fd>5000) {  //不可能有5000公里的情况，除非错误数据
        return @"";
    }
    return [NSString stringWithFormat:@"%.2fkm",fd];
}
//  -- post 到服务器用到的商品信息
- (NSString*) convertGoodsInfoForApiParams:(NSMutableArray*) paramGoodsList
{
    NSString * sjsonGoodsInfo = @"";
    for(int i=0;i<paramGoodsList.count;i++){
        resMod_Mall_GoodsForApiParams * pGoodsInfo = paramGoodsList[i];
        sjsonGoodsInfo = [NSString stringWithFormat:@"%@%@{\"GoodsId\": %d,\"GoodsNum\": %d,\"GoodsSpecId\": \"%@\", \"GoodsType\": %d}",sjsonGoodsInfo,sjsonGoodsInfo.length>0?@",":@"",pGoodsInfo.GoodsId,pGoodsInfo.GoodsNum,pGoodsInfo.GoodsSpecId,pGoodsInfo.GoodsType];
    }
    return [NSString stringWithFormat:@"[%@]",sjsonGoodsInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
