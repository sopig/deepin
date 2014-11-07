//
//  WebDetailViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-13.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "WebDetailViewController.h"
#import "resMod_Mall_ShoppingCart.h"
#import "resMod_Mall_Goods.h"
#import "OfflineShoppingCart.h"

#define urlScheme @"iosalipay"

#define YSW_VERSION 0
#define POLLY_VERSION 1


@interface WebDetailViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>

@property(nonatomic,readwrite,assign)BOOL isOn;

@end

@implementation WebDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isFromMallProductDetail = NO;
        isFromLogin = NO;
        _isOn = NO;
        strUrl = [[NSString alloc]init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   // [goCarButton setHidden:![UserUnit isUserLogin]];
    if ([UserUnit isUserLogin])
    {
        [self goApiRequest_GetCartNum];
    }
    else
    {
      
        NSArray *offlineItemsArray = [OfflineShoppingCart queryAll];
        if (offlineItemsArray.count == 0)
        {
            [goCarButton setHidden:YES];
            
        }
        else
        {
            [goCarButton setHidden:NO];
            [lbl_carnum setText: [NSString stringWithFormat:@"%d",offlineItemsArray.count]];
        }
       
        
        
    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadNavBarView];
    [self setTitle:@""];
    
    strUrl = [self.receivedParams objectForKey:@"param_url"];
    NSString * sTitle = [self.receivedParams objectForKey:@"param_title"];
    //  -- 是否来自第三方登录 (用于支付宝)
    isFromLogin = [[self.receivedParams objectForKey:@"param_isFromLogin"] isEqualToString:@"100"] ? YES : NO;
    //  -- 商城商品详情
    isFromMallProductDetail=[[self.receivedParams objectForKey:@"param_isFromMallProduct"] isEqualToString:@"100"] ? YES:NO;
    ProductInfo = [self.receivedParams objectForKey:@"param_mallProductInfo"];
    if (strUrl.length==0) {
        [self HUDShow:@"URL为空" delay:1.5 dothing:YES];
        return ;
    }
    if (sTitle.length>0) {
        [self setTitle: sTitle];
    }
    
  //  [self loadNavBarView:sTitle];
    
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, __ContentHeight_noTab)];
    _webView.suppressesIncrementalRendering = YES;
    _webView.delegate = self;
    _webView.userInteractionEnabled = YES;
    _webView.scalesPageToFit = YES;
    _webView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_webView];
    
    
#if YSW_VERSION
    
	NSURL *url = [NSURL URLWithString:strUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url
											 cachePolicy:NSURLRequestUseProtocolCachePolicy
										 timeoutInterval:40.0];
    [_webView loadRequest:request];
 
#endif
    
#if POLLY_VERSION
 
    if (isFromMallProductDetail) {
        
        NSMutableString *string = [NSMutableString stringWithContentsOfURL:[NSURL URLWithString:strUrl] encoding:NSUTF8StringEncoding error:nil];

        NSString *touchString = @"<script language=\"javascript\">document.ontouchstart=function(){document.location=\"myweb:touch:start\";};document.ontouchend=function(){document.location=\"myweb:touch:end\";}; document.ontouchmove=function(){document.location=\"myweb:touch:move\";} </script>";
        
        [string appendString:touchString];
        
        [_webView loadHTMLString:string baseURL:nil];
    }
    else{
        NSURL *url = [NSURL URLWithString:strUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval:40.0];
        
        [_webView loadRequest:request];
    }
    
#endif
    
    if (isFromMallProductDetail) {
        [self addButton_BackAndCarAndBuy];
    }
}


//-(void)loadNavBarView:(NSString *)title
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

-(void)HUDdelayDo {
    [self goBack:nil];
}

#pragma mark - #########################


#if POLLY_VERSION
NSTimeInterval delayTime = 0.3f;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

        NSLog(@"%@",request.URL);
        NSString *urlstr = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
        if([urlstr hasPrefix:loginOkAlipay]) {
            isLoginSuccess = YES;
        }

    if (isFromMallProductDetail) {
        //处理触摸事件
        NSString *requestString = [[request URL] absoluteString];
        
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        
        if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"myweb"]) {
            
            if([(NSString *)[components objectAtIndex:1] isEqualToString:@"touch"]) {
                
                if ([(NSString *)[components objectAtIndex:2] isEqualToString:@"start"]) {
                    [self performSelector:@selector(singleTap) withObject:nil afterDelay:delayTime];
                }
                
                else if ([(NSString *)[components objectAtIndex:2] isEqualToString:@"move"]) {
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
                }
                
                else if ([(NSString *)[components objectAtIndex:2] isEqualToString:@"end"]) {
                    NSLog(@"touch end");
                }
            }
            return NO;
        }
    }
    return YES;
}
#endif

- (void)singleTap{
    
    self.isOn = !self.isOn;
    
    UIImageView *imgView =(UIImageView *)[self.view viewWithTag:1014];
    UIButton *buyButton = (UIButton*)[self.view viewWithTag:1012];
    UIButton *btn_addCar = (UIButton*)[self.view viewWithTag:1013];
    
    if (self.isOn) {
        
        CATransform3D transformImgView = imgView.layer.transform;
        CATransform3D transformgoCarButton = goCarButton.layer.transform;
        CATransform3D transformbuyButton = buyButton.layer.transform;
        CATransform3D transformbtn_addCar = btn_addCar.layer.transform;
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            imgView.layer.transform = CATransform3DTranslate(transformImgView, 0, 120, 0);
            goCarButton.layer.transform = CATransform3DTranslate(transformgoCarButton, 0, 120, 0);
            buyButton.layer.transform = CATransform3DTranslate(transformbuyButton, 0, 120, 0);
            btn_addCar.layer.transform = CATransform3DTranslate(transformbtn_addCar, 0, 120, 0);

            
        } completion:^(BOOL finished) {
            
        }];
        
        
    }else{
        
        CATransform3D transformImgView = imgView.layer.transform;
        CATransform3D transformgoCarButton = goCarButton.layer.transform;
        CATransform3D transformbuyButton = buyButton.layer.transform;
        CATransform3D transformbtn_addCar = btn_addCar.layer.transform;
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            imgView.layer.transform = CATransform3DTranslate(transformImgView, 0, -120, 0);
            goCarButton.layer.transform = CATransform3DTranslate(transformgoCarButton, 0, -120, 0);
            buyButton.layer.transform = CATransform3DTranslate(transformbuyButton, 0, -120, 0);
            btn_addCar.layer.transform = CATransform3DTranslate(transformbtn_addCar, 0, -120, 0);
//            imgView.alpha = 1;
//            goCarButton.alpha = 1;
//            buyButton.alpha = 1;
//            btn_addCar.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}


#pragma mark    --  web View call back

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self HUDShow:@"正在加载..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self hudWasHidden:HUD];
    
    if (isFromLogin && isLoginSuccess) {
        NSString *alipay_uid=[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('alipay_userid').value"];
//      NSString *alipay_uName=[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('alipay_realname')"];
//      NSString *alipay_token=[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('alipay_token')"];
    
        if (alipay_uid.length==0) {
            [self HUDShow:@"支付宝登录失败，请重试" delay:2];
            return;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"onFastLoginSuccessFromWeb" object:[[NSDictionary alloc] initWithObjectsAndKeys:@"alipay",@"channeltype",alipay_uid,@"userid", nil]];
        [self goBack:nil];
    }
}
//当结束请求的时候被通知
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    if (isFromLogin) {
        return;
    }
    [self HUDShow:@"加载错误" delay:1.5];
};

#if YSW_VERSION

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType{
    
//    [self HUDShow:@"正在加载"];
    
    NSLog(@"%@",request.URL);
    NSString *urlstr = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    
    if([urlstr hasPrefix:loginOkAlipay])
    {
        isLoginSuccess = YES;
//        NSArray * arr = [urlstr componentsSeparatedByString:@"&"];
//        for (NSString * str in arr) {
//            NSArray *
//        }
//        NSString *outMobile = [urlstr substringFromIndex:ule_Mobile.length];
//        if([outMobile hasPrefix:uleLogin])
//        {
//            NSArray  *loginArray = [outMobile componentsSeparatedByString:@"_"];
//            NSString *aUrl = [loginArray objectAtIndex:1];
//        }
//        else if([outMobile hasPrefix:uleVi])
//        {
//            NSArray *vIList = [outMobile componentsSeparatedByString:@"_"];
//            NSString *listId = [vIList objectAtIndex:1];
//            m_Params = [[NSMutableDictionary alloc]init];
//            [m_Params setObject:listId forKey:@"listId"];
//            [m_Params setObject:@"YES" forKey:@"isIndexPageView"];
//            [self pushNewViewController:@"ProductDetailsViewController" isNibPage:YES setHideTabBar:YES];
//            [m_Params release];
//            return NO;
//        }
    }

    return  YES;
}
#endif


#pragma mark    --  商城商品web详情
- (void) onGoCartOrBuyClick:(id) sender{
    UIButton * btnTmp = (UIButton*) sender;
    
    //  --  查看购物车
    if (btnTmp.tag==1011) {
        [self pushNewViewController:@"ShoppingCartViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"param_isFromPush", nil]];
    }
    //  --  立即购买
    else if (btnTmp.tag==1012) {
        if (ProductInfo!=nil) {
            [self pushNewViewController:@"MallProductSpecController" isNibPage:NO hideTabBar:YES setDelegate:NO
                          setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:ProductInfo,@"param_productinfo",
                                         @"0",@"param_opertype", nil]];
        }
    }
    //  --  加入购物车
    else if (btnTmp.tag==1013) {
        if (ProductInfo!=nil) {
            [self pushNewViewController:@"MallProductSpecController" isNibPage:NO hideTabBar:YES setDelegate:NO
                          setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:ProductInfo,@"param_productinfo",
                                         @"1",@"param_opertype", nil]];
        }
    }
}

//  --  返回按钮 加入购物车按钮 购买按钮
- (void)addButton_BackAndCarAndBuy {
    
    //  -- 前往购物车按钮
    goCarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goCarButton setTag:1011];
    [goCarButton setFrame:CGRectMake(__MainScreen_Width-60, kMainScreenHeight-65, 50, 50)];
    [goCarButton setBackgroundColor:[UIColor clearColor]];
    [goCarButton setBackgroundImage:[UIImage imageNamed:@"car_btn.png"] forState:UIControlStateNormal];
    [goCarButton setTitle:@"" forState:UIControlStateNormal];
    [goCarButton addTarget:self action:@selector(onGoCartOrBuyClick:) forControlEvents:UIControlEventTouchUpInside];
    lbl_carnum = [[UILabel alloc] initWithFrame:CGRectMake(24, 11, 20, 18)];
    [lbl_carnum setBackgroundColor:[UIColor clearColor]];
    [lbl_carnum setText: @"0"];
    [lbl_carnum setFont:defFont(NO, 11)];
    [lbl_carnum setTextAlignment:NSTextAlignmentCenter];
    [lbl_carnum setTextColor:[UIColor whiteColor]];
    [goCarButton addSubview:lbl_carnum];
    [self.view addSubview:goCarButton];
    
    if (ProductInfo) {
        
        resMod_Mall_GoodsInfo * pinfo = (resMod_Mall_GoodsInfo*)ProductInfo;
        
        if (pinfo && pinfo.GoodsCanBuy) {
            
            [goCarButton setFrame:CGRectMake(__MainScreen_Width-60, kMainScreenHeight-115, 50, 50)];
            
            //  --  阴影
            UIImageView * imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight-59,__MainScreen_Width, 60)];
            [imgBG setTag:1014];
            [imgBG setBackgroundColor:[UIColor colorWithRed:239 green:239 blue:239 alpha:0.7]];
            imgBG.layer.shadowColor = [UIColor blackColor].CGColor;
            imgBG.layer.shadowOffset = CGSizeMake(0, 0);
            imgBG.layer.shadowOpacity = 0.5;
            imgBG.layer.shadowRadius = 1;
            [self.view addSubview:imgBG];
            
            //  --  立即购买
            UIButton * btn_buy = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn_buy setTag:1012];
            [btn_buy setFrame:CGRectMake(20, kMainScreenHeight-50, __MainScreen_Width/2-30, 40)];
            [btn_buy setBackgroundColor: color_fc4a00];
            btn_buy.layer.cornerRadius = 3.0;
            [btn_buy setTitle:@"立即购买" forState:UIControlStateNormal];
            [btn_buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn_buy.titleLabel setFont: defFont15];
            [btn_buy addTarget:self action:@selector(onGoCartOrBuyClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn_buy];
            
            //  --  加入购物车
            UIButton * btn_addCar = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn_addCar setTag:1013];
            [btn_addCar setFrame:CGRectMake( __MainScreen_Width/2+10, kMainScreenHeight-50, __MainScreen_Width/2-30, 40)];
            [btn_addCar setBackgroundColor: [UIColor convertHexToRGB:@"8fc31f"]];
            btn_addCar.layer.cornerRadius = 3.0;
            [btn_addCar setTitle:@"加入购物车" forState:UIControlStateNormal];
            [btn_addCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn_addCar.titleLabel setFont: defFont15];
            [btn_addCar addTarget:self action:@selector(onGoCartOrBuyClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn_addCar];
        }
    }
}

- (void)interfaceExcuteSuccess:(id)retObj apiName:(NSString *)ApiName{
    if ([ApiName isEqualToString:kApiMethod_Mall_CartNum]) {
        resMod_CallBackMall_CartNum * backObj = [[resMod_CallBackMall_CartNum alloc] initWithDic:retObj];
        resMod_GetShoppingCartNum * cartnum = backObj.ResponseData;
        [UserUnit saveCartNum:cartnum.Number];
        
        [goCarButton setHidden:[UserUnit userCarNum]>0?NO:YES];
        [lbl_carnum setText: [NSString stringWithFormat:@"%d",[UserUnit userCarNum]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
