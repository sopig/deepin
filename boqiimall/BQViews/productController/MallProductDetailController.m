//
//  MallProductDetailController.m
//  BoqiiLife
//
//  Created by YSW on 14-6-17.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MallProductDetailController.h"
#import <AGCommon/AGCommon.h>
#import "resMod_Mall_ShoppingCart.h"
#import "OfflineShoppingCart.h"


#define heightBanner    320
#define tagBanner       3858
#define tabRowCount     6
#define pageNum         @"6"

#define productActivities   @"购买本商品最多可获得 30 积分 （2.00)倍\n促销活动:购买满100元优惠 5元"
#define productServiceType  @"允许开箱验货:icon_pinfo_examine|支持信用卡:icon_pinfo_card|上海南宁货到付款:icon_pinfo_cod"


@implementation EC_ButtonForProDetailHead
@synthesize isOpenDetail;
@synthesize rightIcon;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isOpenDetail = NO;
    }
    return self;
}

- (void) loadRightIcon:(CGRect) cgframe iconname:(NSString*) sicon{
    self.rightIcon = [[UIImageView alloc] initWithFrame:cgframe];
    [self.rightIcon setTag:3335];
    [self.rightIcon setImage:[UIImage imageNamed:sicon]];
    [self addSubview:rightIcon];
}
@end




//。。。。。。。。。。。。。。。。。。。。。。。。。。

@implementation MallProductDetailController
@synthesize GoodsID,param_ApiURL;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isGift = NO;
        isShowNavBar = NO;
        m_GoodsComments = [[NSMutableArray alloc] initWithCapacity:0];
        dic_TabRowIsOpen = [[NSMutableDictionary alloc] initWithCapacity:tabRowCount];
        for (int i=0; i<tabRowCount; i++) {
            [dic_TabRowIsOpen setValue:i==4?@"1":@"0" forKey:[NSString stringWithFormat:@"section%d",i]];
        }
        
        ContentHeightByVersion = kMainScreenHeight - kStatusBarHeight;
        activityColorArray = [[NSMutableArray alloc] initWithObjects:@"满减|FD5E4B",@"折扣|1E9E4F",@"满减+折扣|FF7D25", @"包邮|8FC31F",@"赠品|E3000C",@"限购|FF7D25",@"代发货|29A9E1",@"满赠|FF5353" ,@"多买多惠|586FB5",@"折扣价|FF417F",@"换购|FEB037",@"团购|E3000C",nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navBarView setHidden:YES];
    [self tabBar_Hidden:self.tabBarController];
    [self NavController_Show:NO animated:YES];
    
    
    if ([UserUnit isUserLogin]) {
        [self goApiRequest_GetCartNum];
    }
    else {
        NSArray *offlineItemsArray = [OfflineShoppingCart queryAll];
        if (offlineItemsArray.count == 0) {
            [goCarButton setHidden:YES];
        }
        else {
            [goCarButton setHidden:NO];
            [lbl_carnum setText: [NSString stringWithFormat:@"%d",offlineItemsArray.count]];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.title = @"";
    self.GoodsID = [self.receivedParams objectForKey:@"paramGoodsID"];
    self.param_ApiURL   = [self.receivedParams objectForKey:@"param_URLProductDetail"];
    
    [self loadView_UI];
    
    [self addButton_BackAndCarAndBuy];
    
    if (self.param_ApiURL.length>0) {
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestWithURL:self.param_ApiURL ModelClass:@"resMod_CallBackMall_GoodsDetail" hudContent:@"正在加载" delegate:self];
    }
    else{
        [self goApiRequest_ProductDetail];
    }
    
    //----------------------        定时器
    [NSTimer scheduledTimerWithTimeInterval:1.3 target:self selector: @selector(handleTimer:) userInfo:nil repeats: YES];
}

- (void)loadView_UI{
    //----------------------        ....
    tableview_root = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0, IOS7_OR_LATER?20:0,__MainScreen_Width,ContentHeightByVersion) style:UITableViewStylePlain];
    [tableview_root setTag:1111];
    tableview_root.backgroundColor = [UIColor clearColor];
    tableview_root.bounces = YES;
    [tableview_root setHidden:YES];
    tableview_root.delegate = self;
    tableview_root.dataSource = self;
    tableview_root.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview_root.showsHorizontalScrollIndicator= NO;
    tableview_root.showsVerticalScrollIndicator  = YES;
    tableview_root.isCloseHeader = YES;
    tableview_root.isCloseFooter = YES;
    [self.view addSubview:tableview_root];
    
    //----------------------        scroll : 顶部的bannner
    scrollview_banner = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightBanner)];
    [scrollview_banner setTag:22220];
    scrollview_banner.backgroundColor = [UIColor clearColor];
    scrollview_banner.delegate= self;
    [scrollview_banner setPagingEnabled:YES];
    [scrollview_banner setUserInteractionEnabled:YES];
    scrollview_banner.showsHorizontalScrollIndicator = NO;
    UISwipeGestureRecognizer *sgLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(bannerHandleSwipe:)];
    [scrollview_banner addGestureRecognizer:sgLeft];
    [sgLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    UISwipeGestureRecognizer *sgRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(bannerHandleSwipe:)];
    [scrollview_banner addGestureRecognizer:sgRight];
    
    //----------------------        收藏.
    btn_collect = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_collect setTag:5739];
    [btn_collect setFrame:CGRectZero];
    [btn_collect setBackgroundColor:[UIColor clearColor]];
    [btn_collect setTitle:@"收藏" forState:UIControlStateNormal];
    [btn_collect.titleLabel setFont:defFont(YES, 12)];
    [btn_collect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_collect setTitleEdgeInsets:UIEdgeInsetsMake(22, 0, 0, 0)];
    imgcollect = [[UIImageView alloc] initWithFrame:CGRectMake((35-25)/2, 0, 25, 25)];
    [imgcollect setImage:[UIImage imageNamed: isCollected?@"mark_btn_sel.png":@"mark_btn_nor.png"]];
    [imgcollect setBackgroundColor:[UIColor clearColor]];
    [btn_collect addSubview:imgcollect];
    [btn_collect addTarget:self action:@selector(onCollectOrShareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //----------------------        评论加载更多按钮
    btn_addmore = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_addmore setFrame:CGRectMake(0, 10, __MainScreen_Width, 40)];
    [btn_addmore setBackgroundColor:[UIColor clearColor]];
    [btn_addmore setTitle:@"点击查看更多" forState:UIControlStateNormal];
    [btn_addmore setTitleColor:color_575757 forState:UIControlStateNormal];
    [btn_addmore setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [btn_addmore.titleLabel setFont:defFont16];
    [btn_addmore setImage:[UIImage imageNamed:@"info_icon_open.png"] forState:UIControlStateNormal];
    [btn_addmore addTarget:self action:@selector(onAddMoreClick:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 设置换轮播焦点图速度

- (void)bannerHandleSwipe:(UISwipeGestureRecognizer *)sender {
    [MobClick event:@"goodsDetails_goodspicture"];
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            pageControlCurrent++;
            if (pageControlCurrent >= m_BannerArr.count-1) {
                pageControlCurrent = m_BannerArr.count-1;
            }
            break;
        case UISwipeGestureRecognizerDirectionRight:
            pageControlCurrent--;
            if (pageControlCurrent <= 0) {
                pageControlCurrent=0;
            }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{
        scrollview_banner.contentOffset = CGPointMake(pageControlCurrent*__MainScreen_Width,0);
    }];
}

- (void) handleTimer: (NSTimer *) timer{
    if (m_BannerArr.count>0) {
        if (TimeNum % 3 == 0 ) {
            if (!Tend) {
                pageControlCurrent++;
                if (pageControlCurrent >= m_BannerArr.count-1) {
                    Tend = YES;
                    pageControlCurrent = m_BannerArr.count-1;
                }
            }
            else{
                pageControlCurrent--;
                if (pageControlCurrent <= 0) {
                    Tend = NO;
                    pageControlCurrent=0;
                }
            }
            [UIView animateWithDuration:0.6 //速度0.7秒
                             animations:^{  //修改坐标
                                 scrollview_banner.contentOffset = CGPointMake(pageControlCurrent*__MainScreen_Width,0);
                             }];
        }
        TimeNum ++;
    }
}

#pragma mark    --  event  ButtonClick

- (void) onCollectOrShareClick:(id)sender{

    UIButton * btnTmp = (UIButton*)sender;
    if (btnTmp.tag==5738) {     //--分享
        
        [MobClick event:@"mallIndex_share"];
        [self ShareService];
    }
    if (btnTmp.tag==5739) {     //--收藏
        
        [MobClick event:@"mallIndex_collect"];
        if (![UserUnit isUserLogin]) {
            [self goLogin:@"gocollection" param:nil delegate:self];
            return;
        }
        [self goApiRequest_Collection];
    }
}

- (void)LoginSuccessPushViewController:(NSString *)m_str param:(id)m_param{
    if ([m_str isEqualToString:@"gocollection"]) {
        [self goApiRequest_Collection];
    }
}

- (void) onButtonClick:(id)sender{
    
    UIButton * btnTmp = (UIButton*)sender;

    //  --  返回
    if (btnTmp.tag==1010) {
        [self goBack:sender];
    }
    //  --  查看购物车
    else if (btnTmp.tag==1011) {
        [self pushNewViewController:@"ShoppingCartViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"param_isFromPush", nil]];
    }
    //  --  立即购买
    else if (btnTmp.tag==1012) {
        [MobClick event:@"goodsDetails_buyNow"];
        if (ProductInfo!=nil) {
            [self pushNewViewController:@"MallProductSpecController" isNibPage:NO hideTabBar:YES setDelegate:NO
                          setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:ProductInfo,@"param_productinfo",
                                         @"0",@"param_opertype", nil]];
        }
    }
    //  --  加入购物车
    else if (btnTmp.tag==1013) {
        
        [MobClick event:@"goodsDetails_addToCart"];
        if (ProductInfo!=nil) {
            [self pushNewViewController:@"MallProductSpecController" isNibPage:NO hideTabBar:YES setDelegate:NO
                          setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:ProductInfo,@"param_productinfo",
                                         @"1",@"param_opertype", nil]];
        }
    }
}
//  --  点击商品大图
- (void)onBannerProduct_Action:(id)sener{
    
}
//  --  加论加载
- (void)onAddMoreClick:(id)sender{
    [self goApiRequest_ProductComments];
}

- (void)onSectionHeaderClick:(id) sender{
    EC_ButtonForProDetailHead * btnTmp = (EC_ButtonForProDetailHead*)sender;
    NSString * sDicKey;
    
    if (btnTmp.tag==7788) { //  --赠品.
        sDicKey = @"section1";
        rowNum_gift = rowNum_gift>0 ? 0 : ProductInfo.GoodsPresents.count;
    }
    if (btnTmp.tag==7789) { //  --商品详情.
        [MobClick event:@"goodsDetails_goodsDetails"];
        NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
        [param setValue:ProductInfo.GoodsTitle forKey:@"param_title"];
        [param setValue:ProductInfo.GoodsDetailUrl forKey:@"param_url"];
        [param setValue:@"100" forKeyPath:@"param_isFromMallProduct"];
        [param setValue:ProductInfo forKeyPath:@"param_mallProductInfo"];
        [self pushNewViewController:@"WebDetailViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:param];
        return;
    }
    if (btnTmp.tag==7790) { //  --商品参数.
        [MobClick event:@"goodsDetails_goodsParameter"];
        sDicKey = @"section3";
        rowNum_proinfo = rowNum_proinfo>0 ? 0 :ProductInfo.GoodsParams.count;
    }
    if (btnTmp.tag==7791) { //  --评论.
         [MobClick event:@"goodsDetails_UserComments"];
        sDicKey = @"section4";
        rowNum_discuss = rowNum_discuss>0 ? 0 :m_GoodsComments.count;
    }
    
    if (btnTmp.isOpenDetail) {
        NSLog(@"--%@",sDicKey);
    }
    BOOL isopen =[[dic_TabRowIsOpen objectForKey:sDicKey] isEqualToString:@"1"]?YES:NO;
    [dic_TabRowIsOpen setValue:!isopen?@"1":@"0" forKey:sDicKey];
    [tableview_root reloadData];
}

//  --  返回按钮 加入购物车按钮 购买按钮
- (void)addButton_BackAndCarAndBuy {
    
    //  -- 返回按钮
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTag:1010];
    [backButton setFrame:CGRectMake(10, IOS7_OR_LATER?25:8, 44, 44)];
    [backButton setBackgroundColor:[UIColor clearColor]];
    [backButton setImage:[UIImage imageNamed:@"balck_back_btn.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //  -- 前往购物车按钮
    goCarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goCarButton setTag:1011];
    [goCarButton setFrame:CGRectMake(__MainScreen_Width-60, ContentHeightByVersion-(IOS7_OR_LATER?95:115), 50, 50)];
    [goCarButton setBackgroundColor:[UIColor clearColor]];
    [goCarButton setBackgroundImage:[UIImage imageNamed:@"car_btn.png"] forState:UIControlStateNormal];
    [goCarButton setTitle:@"" forState:UIControlStateNormal];
    [goCarButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    lbl_carnum = [[UILabel alloc] initWithFrame:CGRectMake(24, 11, 20, 18)];
    [lbl_carnum setBackgroundColor:[UIColor clearColor]];
    [lbl_carnum setText: @"0"];
    [lbl_carnum setFont:defFont(NO, 11)];
    [lbl_carnum setTextAlignment:NSTextAlignmentCenter];
    [lbl_carnum setTextColor:[UIColor whiteColor]];
    [goCarButton addSubview:lbl_carnum];
    [self.view addSubview:goCarButton];
    
    //  --  阴影
    UIImageView * imgBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, ContentHeightByVersion-(IOS7_OR_LATER?39:59),__MainScreen_Width, 60)];
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
    [btn_buy setFrame:CGRectMake(20, ContentHeightByVersion-(IOS7_OR_LATER?30:50), __MainScreen_Width/2-30, 40)];
    [btn_buy setBackgroundColor: color_fc4a00];
    btn_buy.layer.cornerRadius = 3.0;
    [btn_buy setTitle:@"立即购买" forState:UIControlStateNormal];
    [btn_buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_buy.titleLabel setFont: defFont15];
    [btn_buy addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_buy];
    
    //  --  加入购物车
    UIButton * btn_addCar = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_addCar setTag:1013];
    [btn_addCar setFrame:CGRectMake( __MainScreen_Width/2+10, ContentHeightByVersion-(IOS7_OR_LATER?30:50), __MainScreen_Width/2-30, 40)];
    [btn_addCar setBackgroundColor: [UIColor convertHexToRGB:@"8fc31f"]];
    btn_addCar.layer.cornerRadius = 3.0;
    [btn_addCar setTitle:@"加入购物车" forState:UIControlStateNormal];
    [btn_addCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_addCar.titleLabel setFont: defFont15];
    [btn_addCar addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_addCar];
}

- (void) setButton_BuyCar_Status:(BOOL) canbuy{
    UIButton * btn_1011 = (UIButton*)[self.view viewWithTag:1011];
    UIButton * btn_1012 = (UIButton*)[self.view viewWithTag:1012];
    UIButton * btn_1013 = (UIButton*)[self.view viewWithTag:1013];
    UIImageView * img_1014  = (UIImageView*)[self.view viewWithTag:1014];
    
    [btn_1011 setFrame:CGRectMake(btn_1011.frame.origin.x, btn_1011.frame.origin.y+(canbuy?0:40), btn_1011.frame.size.width, btn_1011.frame.size.height)];
    [btn_1012 setHidden:!canbuy];
    [btn_1013 setHidden:!canbuy];
    [img_1014 setHidden:!canbuy];

    if (ProductInfo && ProductInfo.CannotBuyReason.length>0) {
        
        [img_1014 setHidden:NO];
        [img_1014 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
        [UICommon Common_UILabel_Add:CGRectMake(0, 0, __MainScreen_Width, img_1014.frame.size.height)
                          targetView:img_1014 bgColor:[UIColor clearColor] tag:101401
                                text:ProductInfo.CannotBuyReason
                               align:0 isBold:YES fontSize:17 tColor:[UIColor whiteColor]];
        [btn_1011 setFrame:CGRectMake(btn_1011.frame.origin.x, img_1014.frame.origin.y-btn_1011.frame.size.height-5, btn_1011.frame.size.width, btn_1011.frame.size.height)];
    }

}

#pragma mark    --  load ui : 头部banner
- (void) addMallBannerImage{
    for (UIImageView * tmpimg in scrollview_banner.subviews) {
        [tmpimg removeFromSuperview];
    }
    
    for ( int i=0; i< m_BannerArr.count; i++) {
        
        NSString * imgUrl = m_BannerArr[i]; //取原图
        imgUrl = [imgUrl stringByReplacingOccurrencesOfString:@"_thumb." withString:@"."];
        imgUrl = [imgUrl stringByReplacingOccurrencesOfString:@"_y." withString:@"."];
        imgUrl = [imgUrl stringByReplacingOccurrencesOfString:@"_m." withString:@"."];
        imgUrl = [imgUrl stringByReplacingOccurrencesOfString:@"_s." withString:@"."];
        
        UIButton * btnBanner    =   [UIButton buttonWithType:UIButtonTypeCustom];
        [btnBanner setBackgroundColor:[UIColor clearColor]];
        btnBanner.tag = tagBanner+i;
        [btnBanner setFrame:CGRectMake(__MainScreen_Width*i, 0, __MainScreen_Width, heightBanner)];
        [btnBanner addTarget:self action:@selector(onBannerProduct_Action:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_banner addSubview:btnBanner];

        UIImageView * imgBan = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightBanner)];
        [imgBan setBackgroundColor:[UIColor clearColor]];
        [btnBanner addSubview:imgBan];
        
        __weak UIImageView *blockimg = imgBan;
        [imgBan sd_setImageWithURL:[NSURL URLWithString:imgUrl]
                  placeholderImage:[UIImage imageNamed:@"placeHold_320x320.png"]
                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                             
                          CGSize  imgsize = [BQ_global downloadImageSizeWithURL:imgUrl];
                          if (imgsize.width == 0 || imgsize.height==0) {imgsize = CGSizeMake(__MainScreen_Width, heightBanner);}
                          float imgWidth = MIN(__MainScreen_Width, imgsize.width);
                          float imgHeight= MIN(heightBanner,imgsize.height);
                          [blockimg setFrame:CGRectMake((__MainScreen_Width-imgWidth)/2, (heightBanner-imgHeight)/2, imgWidth, imgHeight)];
                      }];
    }
}

#pragma mark    --  api 请 求 & 回 调.
-(void)goApiRequest_ProductDetail{
    
    if (self.GoodsID.length>0) {
        NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
        [apiParams setObject:self.GoodsID forKey:@"GoodsId"];
        if ([UserUnit isUserLogin]) {
            [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
        }
        
//        GetShoppingMallGoodsDetail
//
//        [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_GoodsDetail class:@"resMod_CallBackMall_GoodsDetail"
//                  params:apiParams isShowLoadingAnimal:YES hudShow:@"正在加载"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingMallGoodsDetail:apiParams ModelClass:@"resMod_CallBackMall_GoodsDetail" showLoadingAnimal:YES hudContent:@"正在加载" delegate:self];
        
//        [self.view sendSubviewToBack: self.lodingAnimationView];
    }
}

-(void)goApiRequest_ProductComments{
    
    if (self.GoodsID.length>0 && !hasLoadedAllComments) {
        NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
        [apiParams setObject:self.GoodsID forKey:@"GoodsId"];
        [apiParams setObject:[NSString stringWithFormat:@"%d",m_GoodsComments.count] forKey:@"StartIndex"];
        [apiParams setObject:pageNum forKey:@"Number"];
        
//        [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_GoodsCommentList class:@"resMod_CallBackMall_CommentList"
//                  params:apiParams isShowLoadingAnimal:NO hudShow:@"加载评论中..."];
        
//        GetShoppingMallGoodsCommentList
        
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingMallGoodsCommentList:apiParams ModelClass:@"resMod_CallBackMall_CommentList" showLoadingAnimal:NO hudContent:@"正在加载评论..." delegate:self];
    }
}

-(void)goApiRequest_Collection{
    if (self.GoodsID.length>0) {
        NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
        [apiParams setObject:self.GoodsID forKey:@"GoodsId"];
        [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
        [apiParams setObject:isCollected ? @"2":@"1" forKey:@"Method"];
        
//        [self ApiRequest:api_BOQIIMALL method:kApiMethod_HandleGoodsCollection class:@"ResponseBase"
//                  params:apiParams  isShowLoadingAnimal:NO hudShow:@"操作中..."];
//        HandleGoodsCollection
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestHandleGoodsCollection:apiParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"操作中..." delegate:self];
    }
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_Mall_CartNum]) {
        resMod_CallBackMall_CartNum * backObj = [[resMod_CallBackMall_CartNum alloc] initWithDic:retObj];
        resMod_GetShoppingCartNum * cartnum = backObj.ResponseData;
        [UserUnit saveCartNum:cartnum.Number];
        
        [goCarButton setHidden:[UserUnit userCarNum]>0?NO:YES];
        [lbl_carnum setText: [NSString stringWithFormat:@"%d",[UserUnit userCarNum]]];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_GoodsDetail] || [ApiName isEqualToString:self.param_ApiURL]) {
        resMod_CallBackMall_GoodsDetail * backObj = [[resMod_CallBackMall_GoodsDetail alloc] initWithDic:retObj];
        ProductInfo = backObj.ResponseData;

        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
        if (ProductInfo) {
            self.GoodsID = [NSString stringWithFormat:@"%d",ProductInfo.GoodsId];
            isCollected = ProductInfo.GoodsIsCollected==0 ? NO :YES;
            m_BannerArr = [ProductInfo.GoodsImgList componentsSeparatedByString:@","];
            
            [imgcollect setImage:[UIImage imageNamed:isCollected?@"mark_btn_sel.png":@"mark_btn_nor.png"]];
            [self setButton_BuyCar_Status: ProductInfo.GoodsCanBuy==0?NO:YES];
            [self goApiRequest_ProductComments];
        }
        [tableview_root setHidden:NO];
        [tableview_root reloadData:YES allDataCount:0];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_GoodsCommentList]) {
        resMod_CallBackMall_CommentList * backObj = [[resMod_CallBackMall_CommentList alloc] initWithDic:retObj];
        [m_GoodsComments addObjectsFromArray:backObj.ResponseData];
        
        hasLoadedAllComments = backObj.ResponseData.count < [pageNum intValue];
        rowNum_discuss = m_GoodsComments.count;
        [tableview_root reloadData];
        [self hudWasHidden:HUD];
    }
    if ([ApiName isEqualToString:kApiMethod_HandleGoodsCollection]) {
        isCollected = !isCollected;
        [imgcollect setImage:[UIImage imageNamed:isCollected?@"mark_btn_sel.png":@"mark_btn_nor.png"]];
        [self HUDShow: isCollected?@"收藏成功":@"已取消收藏" delay:2];
    }
}

- (void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    
    [super interfaceExcuteError:error apiName:ApiName];
    
    if ([ApiName isEqualToString:kApiMethod_Mall_GoodsCommentList]) {
        [tableview_root reloadData];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_CartNum]) {
        [goCarButton setHidden:[UserUnit userCarNum]>0?NO:YES];
        [lbl_carnum setText: [NSString stringWithFormat:@"%d",[UserUnit userCarNum]]];
    }
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tabRowCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger irownum=0;
    switch (section) {
        case 0:     irownum = 1;
            break;
        case 1:     irownum = rowNum_gift;
            break;
        case 2:     irownum = 0;
            break;
        case 3:     irownum = rowNum_proinfo;
            break;
        case 4:     irownum = rowNum_discuss;
            break;
        case 5:     irownum = 1;
            break;
            
        default:
            break;
    }
    return irownum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    float headerHeight=0;
    switch (section) {
        case 0:     headerHeight = 0;
            break;
        case 1:     headerHeight = ProductInfo.GoodsPresents.count==0 ? 0 : 86/2;
            break;
        case 2:     headerHeight = 86/2;
            break;
        case 3:     headerHeight = ProductInfo.GoodsParams.count==0 ? 0 : 86/2;
            break;
        case 4:     headerHeight = 86/2;
            break;
        case 5:     headerHeight = 0;
            break;
            
        default:  break;
    }
    return headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float heightRow=0;
    switch (indexPath.section) {
        case 0:{
            CGSize proActSize = [ProductInfo.GoodsTip sizeWithFont:defFont14 constrainedToSize:CGSizeMake(def_WidthArea(15), MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
            heightRow = heightBanner+ 30+30+35 +(ProductInfo.GoodsTip.length>0 ? proActSize.height+35:0);
        }
            break;
        case 1:     heightRow = 99;
            break;
        case 2:     heightRow = 0;
            break;
        case 3:{
            resMod_Mall_ProductProperty * propertyinfo = ProductInfo.GoodsParams[indexPath.row];
            RTLabel *lbl_proinfo = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, def_WidthArea(13), 100)];
            lbl_proinfo.text = [NSString stringWithFormat:@"%@: %@",propertyinfo.Key,propertyinfo.Value];
            [lbl_proinfo setFont:defFont14];
            CGSize optimumSize = [lbl_proinfo optimumSize];
            heightRow = optimumSize.height + 10;
        }
            break;
        case 4:{
            resMod_Mall_GoodsCommentInfo * commentinfo = m_GoodsComments[indexPath.row];
            CGSize tsize_comment = [commentinfo.CommentContent sizeWithFont:defFont14 constrainedToSize:CGSizeMake(def_WidthArea(12), MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
            
            CGSize tsize_boqiiReply = [commentinfo.ReplyCommentContent sizeWithFont:defFont13 constrainedToSize:CGSizeMake(def_WidthArea(20), MAXFLOAT)];
            CGFloat fheightReply = commentinfo.ReplyCommentContent.length>0 ? tsize_boqiiReply.height+15:0;
            
            heightRow = 12 + tsize_comment.height + 10 + 20 + 5 + fheightReply;
        }
            break;
        case 5:     heightRow = 40 + 90;
            break;
            
        default:
            break;
    }
    return heightRow;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width,43)];
    [viewHead setBackgroundColor: [UIColor whiteColor]];
    
    EC_ButtonForProDetailHead * btn_title = [EC_ButtonForProDetailHead buttonWithType:UIButtonTypeCustom];
    [btn_title setFrame:CGRectMake(36, 0, __MainScreen_Width-40,viewHead.frame.size.height)];
    [btn_title setBackgroundColor:[UIColor clearColor]];
    [btn_title setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn_title setTitleColor:color_333333 forState:UIControlStateNormal];
    [btn_title.titleLabel setFont:defFont15];
    [btn_title addTarget:self action:@selector(onSectionHeaderClick:) forControlEvents:UIControlEventTouchUpInside];
    BOOL isopen =[[dic_TabRowIsOpen objectForKey:[NSString stringWithFormat:@"section%d",section]] isEqualToString:@"1"]?YES:NO;
    [btn_title loadRightIcon:CGRectMake(btn_title.frame.size.width-20, 14, 15, 15)
                    iconname:isopen?@"info_icon_open.png":@"right_icon.png"];
    [viewHead addSubview:btn_title];
    
    UIImageView * imgicon = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 25, 25)];
    [imgicon setBackgroundColor:[UIColor clearColor]];
    [viewHead addSubview:imgicon];
    
    [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width, 0.5) targetView:viewHead backColor:color_d1d1d1];
    [UICommon Common_line:CGRectMake(0, 43-0.5, __MainScreen_Width, 0.5) targetView:viewHead backColor:color_d1d1d1];
    
    if (section==1) {
        [imgicon setImage:[UIImage imageNamed:@"icon_gift.png"]];
        [btn_title setTag:7788];
        [btn_title setIsOpenDetail:YES];
        [btn_title setTitle:@"查看赠品" forState:UIControlStateNormal];
    }
    else if (section==2) {
        [imgicon setImage:[UIImage imageNamed:@"pic_icon.png"]];
        [btn_title.rightIcon setImage:[UIImage imageNamed:@"right_icon.png"]];
        
        [btn_title setTag:7789];
        [btn_title setTitle:@"商品详情" forState:UIControlStateNormal];
    }
    else if (section==3) {
        [imgicon setImage:[UIImage imageNamed:@"list_icon.png"]];
        [btn_title setTag:7790];
        [btn_title setTitle:@"商品参数" forState:UIControlStateNormal];

    }
    else if (section==4) {
        [imgicon setImage:[UIImage imageNamed:@"comment_icon.png"]];
        [btn_title setTag:7791];
        [btn_title setTitle:[NSString stringWithFormat:@"用户评论(%d)",ProductInfo.GoodsCommentNum] forState:UIControlStateNormal];
    }
    else{
        return nil;
    }
    return viewHead;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * Identifier = @"productDetailCell";
    int isection = indexPath.section;

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    
    //  -- 商品图，配送信息.
    if (isection==0) {
        
        [cell.contentView addSubview:scrollview_banner];
        [self addMallBannerImage];
        
        //  -- 图片上面的浮层.
        UIView * vProInfo = [[UIView alloc] initWithFrame:CGRectMake(0, heightBanner-55, __MainScreen_Width, 55)];
        [vProInfo setBackgroundColor:[UIColor blackColor]];
        [vProInfo setAlpha:0.5];
        [cell.contentView addSubview:vProInfo];
        
        //  -- title.
        [UICommon Common_UILabel_Add:CGRectMake(8, heightBanner-55+7, __MainScreen_Width-100, 40)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:100
                                text:ProductInfo.GoodsTitle
                               align:-1 isBold:NO fontSize:16 tColor:[UIColor whiteColor]];
        //  -- 分享.
        UIButton * btn_share = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_share setTag:5738];
        [btn_share setFrame:CGRectMake(__MainScreen_Width-80, heightBanner-55+10, 35, 40)];
        [btn_share setBackgroundColor:[UIColor clearColor]];
        [btn_share setTitle:@"分享" forState:UIControlStateNormal];
        [btn_share.titleLabel setFont:defFont(YES, 12)];
        [btn_share setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_share setTitleEdgeInsets:UIEdgeInsetsMake(22, 0, 0, 0)];
        UIImageView * imgshare = [[UIImageView alloc] initWithFrame:CGRectMake((35-25)/2, 0, 25, 25)];
        [imgshare setImage:[UIImage imageNamed:@"icon_share_white.png"]];
        [imgshare setBackgroundColor:[UIColor clearColor]];
        [btn_share addSubview:imgshare];
        [btn_share addTarget:self action:@selector(onCollectOrShareClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn_share];
        
        //  --  收藏
        [btn_collect setFrame:CGRectMake(__MainScreen_Width-40, heightBanner-55+10, 35, 40)];
        [cell.contentView addSubview:btn_collect];

        
        //  -- 市场价.
        NSString * marketPrice = [self convertPrice: ProductInfo.GoodsOriPrice];
        [UICommon Common_UILabel_Add:CGRectMake(14, heightBanner+12, 100, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:100
                                text:marketPrice  align:-1 isBold:NO fontSize:15 tColor:color_b3b3b3];
        
        CGSize tsize = [marketPrice sizeWithFont:defFont15 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
        [UICommon Common_line:CGRectMake(12, heightBanner+22, tsize.width+4,1) targetView:cell.contentView backColor:color_b3b3b3];
         //  --  团购与代发货 标签
        if (ProductInfo.GoodsActionType.length > 0)
        {
            CGFloat xPoint = 14+tsize.width+10;
            CGSize tmpSize ;
            
            ProductInfo.GoodsActionType = [ProductInfo.GoodsActionType stringByReplacingOccurrencesOfString:@"3" withString:@"1,2"];
            NSArray *goodsActionTypeArray = [ProductInfo.GoodsActionType componentsSeparatedByString:@","];
            
            for (NSInteger index = 0; index < [goodsActionTypeArray count]; index++)
            {
                NSInteger type = [[goodsActionTypeArray objectAtIndex:index] integerValue];
                NSString *actionTypeName =  [[[activityColorArray objectAtIndex:(type-1)] componentsSeparatedByString:@"|"] objectAtIndex:0];
                NSString *actionTypeColor = [[[activityColorArray objectAtIndex:(type-1)] componentsSeparatedByString:@"|"] objectAtIndex:1];
                tmpSize = [actionTypeName sizeWithFont:defFont(NO, 11) constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                UILabel *actionTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, heightBanner+13, tmpSize.width+4, 17)];
                [actionTypeLabel setText:actionTypeName];
                [actionTypeLabel setBackgroundColor:[UIColor convertHexToRGB:actionTypeColor]];
                [actionTypeLabel setFont:defFont(NO, 11)];
                [actionTypeLabel setTextColor:[UIColor whiteColor]];
                [actionTypeLabel setTextAlignment:NSTextAlignmentCenter];
                [cell.contentView addSubview:actionTypeLabel];
                xPoint += (tmpSize.width+10);
            }
        }
       
        
        //  --  团购与代发货 标签
//        [UICommon Common_UILabel_Add:CGRectMake(12 + tsize.width+15, heightBanner+13, ProductInfo.IsGroup==1?35:0, 18)
//                          targetView:cell.contentView bgColor:[UIColor redColor] tag:98
//                                text:ProductInfo.IsGroup==1 ? @"团购" :@""
//                               align:0 isBold:NO fontSize:13 tColor:[UIColor whiteColor]];
//        [UICommon Common_UILabel_Add:CGRectMake(12 + tsize.width+15 + (ProductInfo.IsGroup==1?45:0), heightBanner+13, ProductInfo.IsDropShopping==1?50:0, 18) targetView:cell.contentView bgColor:color_26A9E1 tag:99
//                                text:ProductInfo.IsDropShopping==1 ? @"代发货":@""
//                               align:0 isBold:NO fontSize:13 tColor:[UIColor whiteColor]];
        
       
        
        
        
        //  -- 现价.
        NSString * boqiiPrice = [self convertPrice: ProductInfo.GoodsPrice];
        [UICommon Common_UILabel_Add:CGRectMake(12, heightBanner+32, 100, 30)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:101
                                text:boqiiPrice align:-1 isBold:YES fontSize:18 tColor:color_fc4a00];

        CGSize csize = [marketPrice sizeWithFont:defFont(NO, 18) constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        [UICommon Common_line:CGRectMake(csize.width+24, heightBanner+39, 1, 16) targetView:cell.contentView backColor:color_717171];

        //  -- 已售.
        [UICommon Common_UILabel_Add:CGRectMake(csize.width+36, heightBanner+32, 120, 30)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:102
                                text:[NSString stringWithFormat:@"已售 %d 件",ProductInfo.GoodsSaledNum]
                               align:-1 isBold:NO fontSize:15 tColor:color_4e4e4e];
        
        
        //  -- 活动说明.
        CGSize proActSize = [ProductInfo.GoodsTip sizeWithFont:defFont14 constrainedToSize:CGSizeMake(def_WidthArea(15), MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        float goodsTipHeight = ProductInfo.GoodsTip.length>0 ? proActSize.height+20 : 0;
        UIView * viewbg = [UICommon Common_DottedCornerRadiusView:CGRectMake(12, heightBanner+70, 592/2, goodsTipHeight) targetView:cell.contentView tag:1000 dottedImgName:@"dottedLine"];
        
        //  -- 活动说明.
        [UICommon Common_UILabel_Add:CGRectMake(10, 0, viewbg.frame.size.width-20, goodsTipHeight)
                          targetView:viewbg bgColor:[UIColor clearColor] tag:103
                                text:ProductInfo.GoodsTip align:-1 isBold:NO fontSize:14 tColor:color_717171];
        
        float xpoint = 0;
        float ypoint = viewbg.frame.origin.y + viewbg.frame.size.height + (goodsTipHeight>0?10:-6);
        NSArray * arrPST = [productServiceType componentsSeparatedByString:@"|"];
        for (int i=0; i<arrPST.count; i++) {
            NSArray * PSTinfo = [arrPST[i] componentsSeparatedByString:@":"];
            CGSize tsize = [PSTinfo[0] sizeWithFont:defFont12 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn1 setFrame:CGRectMake(xpoint, ypoint, tsize.width+30, 30)];
            [btn1 setBackgroundColor:[UIColor clearColor]];
            [btn1 setImage:[UIImage imageNamed:PSTinfo[1]] forState:UIControlStateNormal];
            [btn1 setTitle:PSTinfo[0] forState:UIControlStateNormal];
            [btn1 setTitleColor:color_333333 forState:UIControlStateNormal];
            [btn1.titleLabel setFont:defFont12];
            [cell.contentView addSubview:btn1];
            
            xpoint += btn1.frame.size.width;
        }
    }
    //  -- 赠品.
    else if(isection==1){
        
        resMod_Mall_PresentInfo * PreInfo = ProductInfo.GoodsPresents[indexPath.row];
        
        UIImageView * giftImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 75, 75)];
        [giftImg setBackgroundColor:[UIColor whiteColor]];
        giftImg.layer.borderWidth = 0.5;
        giftImg.layer.borderColor = color_d1d1d1.CGColor;
        giftImg.layer.cornerRadius = 1.0;
        [giftImg sd_setImageWithURL:[NSURL URLWithString:PreInfo.PresentImg]
                   placeholderImage:[UIImage imageNamed:@"placeHold_75x75.png"]];
        [cell.contentView addSubview:giftImg];
        
        //  -- 赠品title.
        [UICommon Common_UILabel_Add:CGRectMake(100, 10, __MainScreen_Width-110, 40)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:202
                                text:PreInfo.PresentTitle//@"法国皇家（ROYAL CANIN）宠物狗粮 小型犬幼犬离乳期奶糕 1kg"
                               align:-1 isBold:NO fontSize:14 tColor:color_333333];
        //  -- 赠品数量.
        [UICommon Common_UILabel_Add:CGRectMake(100, 65, 100, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:202
                                text:[NSString stringWithFormat:@"数量：%d",PreInfo.PresentNum]
                               align:-1 isBold:NO fontSize:14 tColor:color_717171];
        
        if (indexPath.row>0) {
            //  --  开始画虚线.....................
            UIImageView * dashline = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, def_WidthArea(12), 10)];
            [dashline setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:dashline];
            
            UIGraphicsBeginImageContext(dashline.frame.size);
            [dashline.image drawInRect:CGRectMake(0, 0, dashline.frame.size.width, dashline.frame.size.height)];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
            
            float lengths[] = {2,1.5};
            CGContextRef line = UIGraphicsGetCurrentContext();
            CGContextSetStrokeColorWithColor(line, color_b3b3b3.CGColor);
            
            CGContextSetLineDash(line, 0, lengths, 2);  //画虚线  : 开始画线
            CGContextMoveToPoint(line, 0.0, 0.0);
            CGContextAddLineToPoint(line, def_WidthArea(10), 0);

            CGContextStrokePath(line);
            dashline.image = UIGraphicsGetImageFromCurrentImageContext();
            //  --  结束画虚线.....................
        }

    }
    //  -- 商品详情.
    else if(isection==2){
        
    }
    //  -- 商品参数.
    else if(isection==3){
        
        //@"产品名称：法国皇家（ROYAL CANIN）宠物狗粮 小型犬幼犬离乳期奶糕 1kg\n适用范围：特幼犬（刚断奶犬）\n产品规格：1KG\n生产厂家：法国皇家";
        resMod_Mall_ProductProperty * propertyinfo = ProductInfo.GoodsParams[indexPath.row];
        
        RTLabel *lbl_proinfo = [[RTLabel alloc] initWithFrame:CGRectMake(13, 6, def_WidthArea(13), 100)];
        lbl_proinfo.text = [NSString stringWithFormat:@"%@: %@",propertyinfo.Key,propertyinfo.Value];
        [lbl_proinfo setFont:defFont14];
        [lbl_proinfo setTextColor:color_717171];

        CGSize optimumSize = [lbl_proinfo optimumSize];
        [lbl_proinfo setFrame:CGRectMake(13, 6, def_WidthArea(13), optimumSize.height)];
        [cell.contentView addSubview:lbl_proinfo];
    }
    //  -- 评论.
    else if(isection==4){
        
        resMod_Mall_GoodsCommentInfo * commentinfo = m_GoodsComments[indexPath.row];
        
        CGSize defaultSize = CGSizeMake(120, 20);
        CGSize nameSize = [commentinfo.CommentName sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:defaultSize lineBreakMode:NSLineBreakByWordWrapping];
        
        //  -- 评论者.
        [UICommon Common_UILabel_Add:CGRectMake(12, 8, nameSize.width, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:202
                                text: commentinfo.CommentName
                               align:-1 isBold:NO fontSize:13 tColor:color_717171];
        //  -- 评论时间.
        [UICommon Common_UILabel_Add:CGRectMake(12 + nameSize.width +5, 8, 75, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:203
                                text: commentinfo.CommentTime
                               align:1 isBold:NO fontSize:13 tColor:color_717171];
        
        //  --  星级
        for (int i=0; i<5; i++) {
            int iscore = floor((float)commentinfo.CommentScore);
            UIImageView * imgScore = [[UIImageView alloc] initWithFrame:CGRectMake((__MainScreen_Width-100)+(i*17), 5, 25, 25)];
            [imgScore setBackgroundColor:[UIColor clearColor]];
            [imgScore setImage:[UIImage imageNamed: i<iscore ? @"like_btn_sel.png":@"like_btn_nor.png"]];
            [cell.contentView addSubview:imgScore];
        }
        
        //  --  评论内容
        CGSize csize=[commentinfo.CommentContent sizeWithFont:defFont14 constrainedToSize:CGSizeMake(def_WidthArea(12), MAXFLOAT)];
        UILabel * lblContent = [[UILabel alloc] initWithFrame:CGRectMake(12, 35, def_WidthArea(12), csize.height)];
        [lblContent setBackgroundColor:[UIColor clearColor]];
        [lblContent setTextAlignment:NSTextAlignmentLeft];
        [lblContent setNumberOfLines:0];
        [lblContent setLineBreakMode:NSLineBreakByCharWrapping];
        [lblContent setFont:defFont14];
        [lblContent setTextColor:color_333333];
        [lblContent setText:commentinfo.CommentContent];
        [cell.contentView addSubview:lblContent];
        
        //  -- 追加回复
        if (commentinfo.ReplyCommentContent.length>0) {
            CGSize tsize=[commentinfo.ReplyCommentContent sizeWithFont:defFont13 constrainedToSize:CGSizeMake(def_WidthArea(20), MAXFLOAT)];
            UIImageView *commentBG = [[UIImageView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(lblContent.frame), def_WidthArea(12), tsize.height+20)];
            [commentBG setBackgroundColor:[UIColor clearColor]];
            [commentBG setImage:def_ImgStretchable(@"comment_bg.png", 40, 10)];
            [cell.contentView addSubview:commentBG];

            [UICommon Common_UILabel_Add:CGRectMake(11, 13, commentBG.frame.size.width-12, tsize.height)
                              targetView:commentBG bgColor:[UIColor clearColor] tag:5899
                                    text:commentinfo.ReplyCommentContent
                                   align:-1 isBold:NO fontSize:13 tColor:color_717171];
        }
    }
    //  -- 加载更多按钮
    else if (isection==5){
        if (rowNum_discuss>0) {
            [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
            if (!hasLoadedAllComments) {
                [cell.contentView addSubview:btn_addmore];
            }
        }
        if (m_GoodsComments.count==0) {
            [UICommon Common_UILabel_Add:CGRectMake(0, 15, __MainScreen_Width, 20)
                              targetView:cell.contentView bgColor:[UIColor clearColor] tag:5001
                                    text:@"暂无该商品评论信息" align:0 isBold:NO fontSize:16 tColor:color_333333];
        }
    }
    
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    if ( isection>0 ) {
        [cell.contentView setBackgroundColor:[UIColor convertHexToRGB:@"F4F4F4"]];
    }
    if (indexPath.row>0 && isection!=1 && isection!=3) {
        [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        resMod_Mall_PresentInfo * PreInfo = ProductInfo.GoodsPresents[indexPath.row];
        [self pushNewViewController:@"MallProductDetailController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",PreInfo.PresentId],@"paramGoodsID",nil]];
    }
}



#pragma mark    --  share sdk
- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType {
    
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [viewController.navigationItem.leftBarButtonItem setTitle:@""];
    [viewController.navigationItem.leftBarButtonItem setBackgroundImage:def_ImgStretchable(@"icon_back_white", 58/2, 0) forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [viewController.navigationItem.rightBarButtonItem setBackgroundImage:def_ImgStretchable(@"btn_bg_white", 8, 10) forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    NSDictionary * fontAtt =[[NSDictionary alloc] initWithObjectsAndKeys:color_fc4a00,UITextAttributeTextColor,defFont(YES, 14),UITextAttributeFont,[UIColor clearColor],UITextAttributeTextShadowColor, nil];
    [viewController.navigationItem.rightBarButtonItem setTitleTextAttributes:fontAtt forState:UIControlStateNormal];
    
    viewController.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:color_333333 forKey:UITextAttributeTextColor];
}

- (void) ShareService{
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@%@",BQShareContent,APP_DOWNLOADURL]
                                       defaultContent:@"波奇宠物服务分享"
                                                image:[ShareSDK pngImageWithImage:[UIImage imageNamed:@"shareimg.png"]]
                                                title:@"波奇宠物"
                                                  url:APP_DOWNLOADURL
                                          description:BQShareContent
                                            mediaType:SSPublishContentMediaTypeNews];
    
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"内容分享"
                                                              oneKeyShareList:[ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeTencentWeibo,nil]
                                                               qqButtonHidden:NO
                                                        wxSessionButtonHidden:NO
                                                       wxTimelineButtonHidden:NO
                                                         showKeyboardOnAppear:YES
                                                            shareViewDelegate:self
                                                          friendsViewDelegate:self
                                                        picViewerViewDelegate:self];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:[ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeWeixiSession,ShareTypeWeixiTimeline,ShareTypeQQ,ShareTypeQQSpace,ShareTypeTencentWeibo,ShareTypeSMS, nil]
                           content:publishContent
                     statusBarTips:NO
                       authOptions:nil
                      shareOptions:shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess) {
                                    [self HUDShow:@"分享成功" delay:2];
                                }
                                else if (state == SSResponseStateFail) {
                                    [self HUDShow:[NSString stringWithFormat:@"分享失败 %@",[error errorDescription]] delay:2];
//                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

#pragma mark    ---    Scroll View Delegate
//- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView.tag==22220) {
//        pageControlCurrent  = scrollView.contentOffset.x/__MainScreen_Width;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
