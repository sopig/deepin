//
//  ServiceDetailViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-6.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "ServiceDetailViewController.h"
#import <AGCommon/AGCommon.h>
#define kTicketID_ParaKey @"param_TicketId"


@interface ServiceDetailViewController () {
    CGFloat _webViewHeightForSuitMerchant;
    CGFloat _webViewHeightForThisDetail;
    
    BOOL  _webViewForSuitMerchantLoad;
    BOOL  _webViewForThisDetailLoad;
    
    UIWebView *_webViewForSuitMerchant;
    UIWebView *_webViewForThisDetail;
    
    int _webViewForSuitMerchantLoadNum;
    int _webViewForThisDetailLoadNum;
}
@end



@implementation ServiceDetailViewController
@synthesize iTicketID;
@synthesize URLService;

#define heightCellSpace 10
#define heightTopImg    210

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dicCellHeight = [[NSMutableDictionary alloc] initWithCapacity:0];
        mod_TicketInfo = [[resMod_TicketInfo alloc] init];
        arrBannerList = [[NSArray alloc] init];
        isCollected = NO;
        
        _webViewForSuitMerchantLoad = NO;
        _webViewForThisDetailLoad = NO;
    }
    return self;
}

- (void) loadView_UI{
  //  [self addBarRightView];
    
    //  --  tableView..
    detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [detailTableView setBackgroundColor: [UIColor whiteColor]];
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    [detailTableView setShowsVerticalScrollIndicator:NO];
    
    //----------------------        banner : 商品大图
    scrollBanner = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightTopImg)];
    [scrollBanner setTag:2111];
    scrollBanner.backgroundColor = [UIColor clearColor];
    scrollBanner.delegate= self;
    [scrollBanner setPagingEnabled:YES];
    scrollBanner.showsHorizontalScrollIndicator = NO;
    //----------------------        page control
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    [pageControl setFrame:CGRectZero];
    [pageControl setBackgroundColor:[UIColor convertHexToRGB:@"777777"]];
    pageControl.layer.opacity = 0.5;
    pageControl.layer.cornerRadius = 5.0f;
    pageControl.numberOfPages = 3;
    pageControl.userInteractionEnabled = NO;
    
    //----------------------        定时器
    [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector: @selector(handleTimer:) userInfo:nil repeats: YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Hidden:self.tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self loadNavBarView];
    self.title = @"服务券详情";
    self.view.backgroundColor = color_bodyededed;
    self.iTicketID = [self.receivedParams objectForKey:@"param_TicketId"];
    self.URLService = [self.receivedParams objectForKey:@"param_URLService"];
    
    _webViewHeightForSuitMerchant = 10;
    _webViewHeightForThisDetail = 10;
//    _isReload = NO;
    
    _webViewForSuitMerchant = [[UIWebView alloc]initWithFrame:CGRectZero];
    _webViewForSuitMerchant.dataDetectorTypes = UIDataDetectorTypeNone;
    
    _webViewForThisDetail = [[UIWebView alloc]initWithFrame:CGRectZero];
    _webViewForThisDetail.dataDetectorTypes = UIDataDetectorTypeNone;
    
    _webViewForSuitMerchantLoadNum = 0;
    _webViewForThisDetailLoadNum = 0;
    
   // [self loadNavBarView];
    
    [self loadView_UI];
    
    if (self.URLService.length>0) {
//        [self ApiRequestWithURL:self.URLService class:@"resMod_CallBack_TicketDetail" hudShow:@"正在加载"];
         [[APIMethodHandle shareAPIMethodHandle]goApiRequestWithURL:self.URLService ModelClass:@"resMod_CallBack_TicketDetail" hudContent:@"正在加载" delegate:self];
    }
    else{
        NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dicParams setValue:self.iTicketID forKey:@"TicketId"];
        if (_lon!=-10000000.00 && _lat !=-10000000.00) {
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lat] forKey:@"Lat"];
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lon] forKey:@"Lng"];
        }
        if([UserUnit isUserLogin]){
            [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
        }
        
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_TicketDetail class:@"resMod_CallBack_TicketDetail"
//                  params:dicParams  isShowLoadingAnimal:YES hudShow:@"正在加载"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetTicketDetail:dicParams ModelClass:@"resMod_CallBack_TicketDetail" showLoadingAnimal:YES hudContent:@"正在加载" delegate:self];
    }
}

- (void)loadNavBarView {
    
    [super loadNavBarView];
    UIView * navFuntion = [[UIView alloc] initWithFrame:CGRectMake(240, 0, 80, 44)];
    [navFuntion setBackgroundColor:[UIColor clearColor]];
    UIButton * btn_share = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 35, 44)];
    [btn_share setTag:1787];
    [btn_share setBackgroundColor:[UIColor clearColor]];
    [btn_share setImage:[UIImage imageNamed:@"icon_share.png"] forState:UIControlStateNormal];
    [btn_share addTarget:self action:@selector(onTopBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navFuntion addSubview:btn_share];
    
    btn_Collection = [[UIButton alloc] initWithFrame:CGRectMake(45, 0, 35, 44)];
    [btn_Collection setTag:2934];
    [btn_Collection setBackgroundColor:[UIColor clearColor]];
    [btn_Collection setImage:[UIImage imageNamed:@"mark_btn.png"] forState:UIControlStateNormal];
    [btn_Collection addTarget:self action:@selector(onTopBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navFuntion addSubview:btn_Collection];
    [self.subNavBarView addSubview:navFuntion];
}


#pragma mark    --  UI加载
//  --  加载大焦点图 : banner
-(void)adBannerImg{
    
    for (UIImageView * tmpimg in scrollBanner.subviews) {
        if (tmpimg.tag>999 && tmpimg.tag<1100) {
            [tmpimg removeFromSuperview];
        }
    }
    for ( int i=0; i< arrBannerList.count; i++) {
        UIImageView *imgBan = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width*i, 0, __MainScreen_Width, heightTopImg)];
        [imgBan setBackgroundColor:[UIColor clearColor]];
        NSString * proimgUrl = arrBannerList[i];//[BQ_global convertImageUrlString:kImageUrlType_320x210 withurl:arrBannerList[i]];
        [imgBan sd_setImageWithURL:[NSURL URLWithString:proimgUrl]
               placeholderImage:[UIImage imageNamed:@"placeHold_320x210"]];
        [scrollBanner addSubview:imgBan];
        
//        NSString * s_url = arrBannerList[i];
//        if (s_url.length > 0  && ![s_url isEqualToString:@"null"])
//            imgBan.imageURL = [NSURL URLWithString:s_url];
    }
}


#pragma mark - 设置换轮播焦点图速度
- (void) handleTimer: (NSTimer *) timer{
    if (arrBannerList.count>0) {
        if (TimeNum % 3 == 0 ) {
            if (!Tend) {
                pageControlCurrent++;
                if (pageControlCurrent >= arrBannerList.count-1) {
                    Tend = YES;
                    pageControlCurrent = arrBannerList.count-1;
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
                                 pageControl.currentPage = pageControlCurrent;
                                 scrollBanner.contentOffset = CGPointMake(pageControlCurrent*__MainScreen_Width,0);
                             }];
        }
        TimeNum ++;
    }
}


#pragma mark -
- (void) addBarRightView{
 
    UIView * navFuntion = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
    [navFuntion setBackgroundColor:[UIColor clearColor]];
    UIButton * btn_share = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 35, 44)];
    [btn_share setTag:1787];
    [btn_share setBackgroundColor:[UIColor clearColor]];
    [btn_share setImage:[UIImage imageNamed:@"icon_share.png"] forState:UIControlStateNormal];
    [btn_share addTarget:self action:@selector(onTopBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navFuntion addSubview:btn_share];
    
    btn_Collection = [[UIButton alloc] initWithFrame:CGRectMake(45, 0, 35, 44)];
    [btn_Collection setTag:2934];
    [btn_Collection setBackgroundColor:[UIColor clearColor]];
    [btn_Collection setImage:[UIImage imageNamed:@"mark_btn.png"] forState:UIControlStateNormal];
    [btn_Collection addTarget:self action:@selector(onTopBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navFuntion addSubview:btn_Collection];
    
    UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:navFuntion];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;

    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,r_bar, nil];
}



#pragma mark    --  事件
//查看其他商户
- (void)didTapOnOtherMerchantButton:(id)sender
{
    if (mod_TicketInfo.HasOtherMerchant > 0)
    {
        NSMutableDictionary *params=[[NSMutableDictionary alloc] initWithObjectsAndKeys
                                                 :[NSString stringWithFormat:@"%d",mod_TicketInfo.TicketId],kTicketID_ParaKey, nil];
        [self pushNewViewController:@"BQTicketOtherMerchantListViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:params];
    }
}


- (void) onTopBarButtonClick:(id) sender{
    UIButton * btn = sender;
    if (btn.tag==1787) {
        [MobClick event:@"serviceDetails_share"];
        [self ShareService];
        //  --分享
    }
    else if(btn.tag==2934){
        [MobClick event:@"serviceDetails_collect"];
        if (![UserUnit isUserLogin]) {
            [self goLogin:@"servicedetailviewcontroller" param:nil delegate:self];
            return;
        }
        
        [self goApiRequest_handlecollection];
    }
}

- (void) onBuyClick:(id) sender{
    UIButton * btnTmp = (UIButton*)sender;
    if (btnTmp.tag==19040) {
        
        [MobClick event:@"serviceDetails_buyNow"];
        
        if (mod_TicketInfo.TicketRemain<0) {
            return;
        }
        
        if (![UserUnit isUserLogin]) {
            [self goLogin:@"go_ordersubmitcontroller" param:nil delegate:self];
            return;
        }
        else{
            [self goOrderSubmitController];
        }
    }
    else if(btnTmp.tag==38954){
        
        [MobClick event:@"serviceDetails_merchant_call"];
        if (mod_TicketInfo.TicketMerchant.MerchantTele.length==0) {
            [self HUDShow:@"暂无此商家联系方式" delay:1.5];
            return;
        }
        
        EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"拨 打"
                                                                              message:[mod_TicketInfo.TicketMerchant.MerchantTele stringByReplacingOccurrencesOfString:@"," withString:@""]
                                                                    cancelButtonTitle:@"取消"
                                                                        okButtonTitle:@"呼叫"];
        alertView.delegate1 = self;
        [alertView setTag:2049];
        [alertView show];
    }
}

- (void) goOrderSubmitController{
    [MobClick event:@"lifeSrvDetail_buyNow"];
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithObjectsAndKeys: mod_TicketInfo,@"orderNeed", nil];
    [self pushNewViewController:@"OrderSubmitController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
}

- (void)LoginSuccessPushViewController:(NSString *)m_str param:(id)m_param{
    if ([m_str isEqualToString:@"go_ordersubmitcontroller"]) {
        [self goOrderSubmitController];
    }
    if ([m_str isEqualToString:@"servicedetailviewcontroller"]) {
        [self goApiRequest_handlecollection];
    }
}

//  -- 打电话
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==2049) {
        if(buttonIndex == 1) {
            NSString *url = [[NSString alloc]initWithFormat:@"tel://%@",[mod_TicketInfo.TicketMerchant.MerchantTele stringByReplacingOccurrencesOfString:@"-" withString:@""]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByReplacingOccurrencesOfString:@" " withString:@""]]];
            
        }
    }
}

/**
 * 剩余时间
 */
- (NSString *) compareCurrentTime:(int) secondTime {
    
    if (secondTime<0) {
        return @"已过期";
    }
    
    NSString * sLeftTime = @"";
    if (secondTime<60) { return [NSString stringWithFormat:@"剩余%d秒",secondTime]; }
    int days    =secondTime/(3600*24);
    int hours   =secondTime%(3600*24)/3600;
    int minute  =secondTime%(3600*24)%3600/60;
    
    if (days>0) {
        if (days>3) {
            return @"剩余3天以上";
        }
        sLeftTime = [NSString stringWithFormat:@"剩余%d天",days];
    }
    if (hours>0) {
        sLeftTime = [NSString stringWithFormat:@"%@%d小时",sLeftTime,hours];
    }
    if (minute>0) {
        sLeftTime = [NSString stringWithFormat:@"%@%d分钟",sLeftTime,minute];
    }
    return  sLeftTime;
}


#pragma mark    --  share sdk
- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType {
    
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [viewController.navigationItem.leftBarButtonItem setTitle:@""];
    [viewController.navigationItem.leftBarButtonItem setBackgroundImage:def_ImgStretchable(@"icon_back_white", 58/2, 0) forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [viewController.navigationItem.rightBarButtonItem setBackgroundImage:def_ImgStretchable(@"btn_bg_white", 8, 10) forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    NSDictionary * fontAtt =[[NSDictionary alloc] initWithObjectsAndKeys:color_fc4a00,UITextAttributeTextColor,defFont(YES, 14),UITextAttributeFont,[UIColor clearColor],UITextAttributeTextShadowColor, nil];
    [viewController.navigationItem.rightBarButtonItem setTitleTextAttributes:fontAtt forState:UIControlStateNormal];
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

#pragma mark    --  api 请求 回调

-(void) goApiRequest_handlecollection{
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:[NSString stringWithFormat:@"%d",mod_TicketInfo.TicketId] forKey:@"TicketId"];
    [dicParams setValue:isCollected ? @"2":@"1" forKey:@"Method"];
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_HandleCollection class:@"ResponseBase"
//              params:dicParams isShowLoadingAnimal:NO hudShow:@"操作中"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestHandleCollection:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"操作中" delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_TicketDetail] || [ApiName isEqualToString:self.URLService]) {
        resMod_CallBack_TicketDetail * backObj = [[resMod_CallBack_TicketDetail alloc] initWithDic:retObj];
        mod_TicketInfo = backObj.ResponseData;
        arrBannerList = [mod_TicketInfo.ImageList componentsSeparatedByString:@","];
        
        isCollected = mod_TicketInfo.IsCollected==0 ? NO : YES;
        [btn_Collection setImage:[UIImage imageNamed:isCollected ? @"mark_btn_sel.png" : @"mark_btn.png"]
                                  forState:UIControlStateNormal];
        
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
        [self.view addSubview:detailTableView];
        [self.view sendSubviewToBack:detailTableView];
    }
    else if([ApiName isEqualToString:kApiMethod_HandleCollection]){
        isCollected = !isCollected;
        [self HUDShow: isCollected ? @"收藏成功":@"已取消" delay:1.5];
        [btn_Collection setImage:[UIImage imageNamed:isCollected ? @"mark_btn_sel.png" : @"mark_btn.png"]
                        forState:UIControlStateNormal];
    }
}


#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section==0 ? 1 : 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
    return section==0 ? 0 : 60;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==1) {
        UIView * HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 60)];
        [HeadView setBackgroundColor:[UIColor whiteColor]];

        CGSize size_xj = [[self convertPrice:mod_TicketInfo.TicketPrice] sizeWithFont:defFont(YES, 20)
                                                                    constrainedToSize:CGSizeMake(MAXFLOAT, 25)];
        CGSize size_yj = [[self convertPrice:mod_TicketInfo.TicketOriPrice] sizeWithFont:defFont14
                                                                       constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
        //--现价.
        [UICommon Common_UILabel_Add:CGRectMake(5, 10, 100, 25) targetView:HeadView
                             bgColor:[UIColor clearColor] tag:1001
                                text:[self convertPrice:mod_TicketInfo.TicketPrice]
                               align:-1 isBold:YES fontSize:20 tColor:color_fc4a00];
        //--原价.
        [UICommon Common_UILabel_Add:CGRectMake(size_xj.width+10, 14, size_yj.width, 20) targetView:HeadView
                             bgColor:[UIColor clearColor] tag:1002
                                text:[self convertPrice:mod_TicketInfo.TicketOriPrice]
                               align:-1 isBold:NO fontSize:14 tColor:color_b3b3b3];
        [UICommon Common_line:CGRectMake(size_xj.width+9, 24, size_yj.width+2, 1) targetView:HeadView backColor:color_b3b3b3];
        
        //--折扣.
        [UICommon Common_UILabel_Add:CGRectMake(size_xj.width+10+size_yj.width+10, 14, 60, 20) targetView:HeadView
                             bgColor:[UIColor clearColor] tag:1003
                                text:[NSString stringWithFormat:@"%@折", mod_TicketInfo.TicketSale]
                               align:-1 isBold:NO fontSize:15 tColor:color_fc4a00];
        //--限购信息.
        [UICommon Common_UILabel_Add:CGRectMake(8, 36, 200, 20) targetView:HeadView
                             bgColor:[UIColor clearColor] tag:1004
                                text:mod_TicketInfo.TicketLimit   /*@"一个用户最多只可购买2张"*/
                               align:-1 isBold:NO fontSize:13 tColor:color_717171];
        
        UIButton * btn_Buy = [[UIButton alloc] initWithFrame:CGRectMake(__MainScreen_Width-90, 10, 80, 40)];
        [btn_Buy setTag:19040];
        [btn_Buy setTitle: mod_TicketInfo.TicketRemain<0 ? @"已过期":@"立即购买" forState:UIControlStateNormal];
        [btn_Buy setBackgroundColor: mod_TicketInfo.TicketRemain<0 ? color_b3b3b3 : color_fc4a00];
        [btn_Buy.titleLabel setFont: defFont(YES, 15)];
        btn_Buy.layer.cornerRadius = 3.0f;
        [btn_Buy addTarget:self action:@selector(onBuyClick:) forControlEvents:UIControlEventTouchUpInside];
        [HeadView addSubview:btn_Buy];
        
        [UICommon Common_line:CGRectMake(0, 59.5, __MainScreen_Width, 0.5) targetView:HeadView backColor:color_b3b3b3];
        return HeadView;
    }
    else
        return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger iRow = indexPath.row;

    float fHeight = 0;
    if (indexPath.section==0) {
        fHeight = heightTopImg;
    }
    if(indexPath.section==1){
        switch (iRow) {
            case 0:{
                CGSize tSize = [mod_TicketInfo.TicketTitle sizeWithFont:defFont16 constrainedToSize:CGSizeMake(def_WidthArea(6), MAXFLOAT)];
                fHeight = 8+tSize.height+50+20+10+heightCellSpace;
            }
                break;
            case 1:     fHeight = 115+44;
                break;
            case 2:{
                fHeight = _webViewHeightForSuitMerchant + 45 + 30;
           
            }
                break;
            case 3:     {
                fHeight = _webViewHeightForThisDetail + 45 + 50;
            }
                break;
            case 4:     fHeight = 40;
                break;
            case 5:     fHeight = 40;
                break;
            case 6:     fHeight = 40;
                break;

            default:
                break;
        }
        NSString * dicKey = [NSString stringWithFormat:@"cell%d",iRow];
        //if (iRow != 2) {
            fHeight = fHeight + (iRow>0?16:0);
       // }
        [dicCellHeight setValue:[NSString stringWithFormat:@"%.2f",fHeight] forKey:dicKey];
    }
    return fHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger iRow = indexPath.row;
    UITableViewCell * cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section==0) {
        [cell.contentView addSubview:scrollBanner];
        [self adBannerImg];
        [scrollBanner setContentSize:CGSizeMake(__MainScreen_Width*arrBannerList.count, heightTopImg)];
        float pageWidth = 16*arrBannerList.count;
        [pageControl setFrame:CGRectMake(__MainScreen_Width/2-(pageWidth/2), heightTopImg-15, pageWidth, 10)];
        pageControl.numberOfPages = arrBannerList.count;
    }
    else if(indexPath.section==1) {
        if(iRow==0){
            
            CGSize tSize = [mod_TicketInfo.TicketTitle sizeWithFont:defFont16
                                                  constrainedToSize:CGSizeMake(def_WidthArea(6), MAXFLOAT)];
            //--标题.
            [UICommon Common_UILabel_Add:CGRectMake(8, 6, def_WidthArea(8), tSize.height) targetView:cell.contentView
                                 bgColor:[UIColor clearColor] tag:2001
                                    text: mod_TicketInfo.TicketTitle
                                   align:-1 isBold:NO fontSize:16 tColor:color_333333];
            //--服务券说明.
            [UICommon Common_UILabel_Add:CGRectMake(8, tSize.height+10, def_WidthArea(6), 50) targetView:cell.contentView
                                 bgColor:[UIColor clearColor] tag:2002
                                    text: mod_TicketInfo.TicketDesc
                                   align:-1 isBold:NO fontSize:13 tColor: color_717171];
            //--已购人数.
            [UICommon Common_UILabel_Add:CGRectMake(8, tSize.height+10+50, 150, 20) targetView:cell.contentView
                                 bgColor:[UIColor clearColor] tag:2003
                                    text:[NSString stringWithFormat: @"%d人已购买",mod_TicketInfo.TicketBuyed]
                                   align:-1 isBold:YES fontSize:13 tColor:color_fc4a00];
            //--剩余时间.
            [UICommon Common_UILabel_Add:CGRectMake(__MainScreen_Width-160, tSize.height+10+50, 150, 20)
                              targetView:cell.contentView bgColor:[UIColor clearColor] tag:2004
                                    text:[self compareCurrentTime:mod_TicketInfo.TicketRemain]
                                   align:1 isBold:NO fontSize:13 tColor:[UIColor grayColor]];
        }
        else if(iRow==1){
            
            [UICommon Common_UILabel_Add:CGRectMake(10+17+8, 0, 100, 40) targetView:cell.contentView
                                 bgColor:[UIColor clearColor] tag:3001
                                    text:@"适用商户"
                                   align:-1 isBold:NO fontSize:17 tColor:color_333333];
            [UICommon Common_line:CGRectMake(0,40,__MainScreen_Width,0.5) targetView:cell.contentView backColor:color_d1d1d1];
            
            //--商户名字
            [UICommon Common_UILabel_Add:CGRectMake(10, 48, 260, 20) targetView:cell.contentView
                                 bgColor:[UIColor clearColor] tag:3002
                                    text:[mod_TicketInfo.TicketMerchant MerchantName]
                                   align:-1 isBold:NO fontSize:16 tColor:color_333333];
            //--商户地址
//            [UICommon Common_UILabel_Add:CGRectMake(10, 70, 250, 20) targetView:cell.contentView
//                                 bgColor:[UIColor clearColor] tag:3003
//                                    text:
//                                   align:-1 isBold:NO fontSize:14 tColor:color_717171];
            UILabel * lbl_merchantAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 250, 20)];
            [lbl_merchantAddress setBackgroundColor:[UIColor clearColor]];
            [lbl_merchantAddress setText:[mod_TicketInfo.TicketMerchant MerchantAddress]];
            [lbl_merchantAddress setTextAlignment:NSTextAlignmentLeft];
            [lbl_merchantAddress setFont:defFont14];
            [lbl_merchantAddress setTextColor:color_717171];
            [lbl_merchantAddress setTag:3003];
            [cell.contentView addSubview:lbl_merchantAddress];
            
            //--商户距离
            [UICommon Common_UILabel_Add:CGRectMake(10, 90, 100, 20) targetView:cell.contentView
                                 bgColor:[UIColor clearColor] tag:3004
                                    text:[self convertDistance:[mod_TicketInfo.TicketMerchant MerchantDistance]]
                                   align:-1 isBold:NO fontSize:14 tColor:color_717171];
            
            [UICommon Common_line:CGRectMake(260, 52, 0.5, 50) targetView:cell.contentView backColor:color_d1d1d1];
            
            UIButton * btn_call = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn_call setTag:38954];
            [btn_call setFrame:CGRectMake(__MainScreen_Width-72, 40, 70, 80)];
            [btn_call setTitle:@"" forState:UIControlStateNormal];
            [btn_call setBackgroundColor:[UIColor clearColor]];
            [btn_call.titleLabel setFont: defFont14];
            [btn_call addTarget:self action:@selector(onBuyClick:) forControlEvents:UIControlEventTouchUpInside];
            UIImageView * callBg = [[UIImageView alloc] initWithFrame:CGRectMake(25, 22, 35, 35)];
            [callBg setImage:[UIImage imageNamed:@"icon_call_ora.png"]];
            [btn_call addSubview:callBg];
            [cell.contentView addSubview:btn_call];
            
            UILabel *upLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, __MainScreen_Width,1)];
            upLine.backgroundColor = color_ededed;
            [cell.contentView addSubview:upLine];
            UIButton *otherMerchantbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 121, __MainScreen_Width, 44)];
            [otherMerchantbtn setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:otherMerchantbtn];
            [otherMerchantbtn addTarget:self action:@selector(didTapOnOtherMerchantButton:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, __MainScreen_Width*3/4.0,40)];
            [detailLabel setBackgroundColor:[UIColor clearColor]];
            detailLabel.font = [UIFont systemFontOfSize:14];
            detailLabel.textColor = color_fc4a00;
            detailLabel.text = [NSString stringWithFormat:@"查看全部%d家商铺",mod_TicketInfo.HasOtherMerchant];
            [otherMerchantbtn addSubview:detailLabel];
            
            UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width-25, 15+120, 15, 15)];
            [iconImg setImage:[UIImage imageNamed:@"right_icon.png"]];
            [cell.contentView addSubview:iconImg];
            UILabel *downLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 120+45, __MainScreen_Width,1)];
            downLine.backgroundColor = color_ededed;
        }
        else if(iRow==2 || iRow==3){
            
            NSString * testTitle = iRow==2 ? @"本单详情":@"特别提醒";
            NSString * testDes   = iRow==3 ? mod_TicketInfo.TicketDetail : mod_TicketInfo.TicketRemind;
            
            [UICommon Common_UILabel_Add:CGRectMake(10+17+8, 0, 100, 40) targetView:cell.contentView
                                 bgColor:[UIColor clearColor] tag:45001
                                    text:testTitle
                                   align:-1 isBold:NO fontSize:17 tColor:color_333333];
            [UICommon Common_line:CGRectMake(0, 40,__MainScreen_Width,0.5) targetView:cell.contentView backColor:color_d1d1d1];

            NSURL *url = [NSURL URLWithString:testDes];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            if (iRow == 2) {
                if (_webViewForSuitMerchantLoadNum <= 4) {
                     [_webViewForSuitMerchant loadRequest:request];
                    _webViewForSuitMerchantLoadNum++;
                }
                
                _webViewForSuitMerchant.delegate = self ;
                _webViewForSuitMerchant.tag = iRow;
                
                _webViewForSuitMerchant.backgroundColor = [UIColor whiteColor];
                _webViewForSuitMerchant.scrollView.scrollEnabled = NO;
                [cell.contentView addSubview:_webViewForSuitMerchant];
                [_webViewForSuitMerchant sizeThatFits:CGSizeZero];
            }
            else
            {
                if (_webViewForThisDetailLoadNum <= 4)
                {
                   [_webViewForThisDetail loadRequest:request];
                    _webViewForThisDetailLoadNum++;
                }
                _webViewForThisDetail.delegate = self ;
                _webViewForThisDetail.tag = iRow;
                
                _webViewForThisDetail.backgroundColor = [UIColor whiteColor];
                _webViewForThisDetail.scrollView.scrollEnabled = NO;
                
                [cell.contentView addSubview:_webViewForThisDetail];
                [_webViewForThisDetail sizeThatFits:CGSizeZero];

            }
        }
        else{
            NSString * sTitle = @"";
            if (iRow==4) {
                sTitle = @"项目展示";
            }
            else if(iRow==5){
                sTitle = [NSString stringWithFormat:@"本单点评(%d)",mod_TicketInfo.CommentNum];
            }
            else if(iRow==6){
                sTitle = @"商户介绍";
            }

            [UICommon Common_UILabel_Add:CGRectMake(10+17+8, 2.5, __MainScreen_Width, 40) targetView:cell.contentView
                                 bgColor:[UIColor clearColor] tag:67001
                                    text:sTitle align:-1 isBold:NO fontSize:17 tColor:color_333333];
            UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width-25, 40/2-5, 15, 15)];
            [iconImg setImage:[UIImage imageNamed:@"right_icon.png"]];
            iconImg.userInteractionEnabled = YES;
            [cell.contentView addSubview:iconImg];
        }
        
        
        float cellHeight = [[dicCellHeight objectForKey:[NSString stringWithFormat:@"cell%d",iRow]] floatValue];
        [UICommon Common_line:CGRectMake(0, cellHeight-heightCellSpace, __MainScreen_Width, heightCellSpace)
                   targetView:cell backColor:color_ededed];
        
        
        //  --  前面小图标
        NSString * iconName = [self cellIcon:iRow];
        if (iconName.length>0) {
            UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(4, 8, 50/2, 50/2)];
            [iconImg setImage:[UIImage imageNamed: iconName]];
            [cell.contentView addSubview:iconImg];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==4) {
        
        [MobClick event:@"serviceDetails_showPro"];
        
        NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                     mod_TicketInfo,@"param_ticketInfo", nil];
        [self pushNewViewController:@"ProjectShowViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
    }
    else if(indexPath.row ==1 || indexPath.row ==6){
        
        [MobClick event: indexPath.row ==1 ? @"serviceDetails_merchant" : @"serviceDetails_toMerchant"];
        
        NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithObjectsAndKeys :[NSString stringWithFormat:@"%d",mod_TicketInfo.TicketMerchant.MerchantId],@"param_MerchantId", nil];
        [self pushNewViewController:@"MerchantDetailViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
    }
    else if(indexPath.row == 5){
        
        [MobClick event:@"serviceDetails_serviceComment"];
        NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
        [paramsDic setObject:[NSString stringWithFormat:@"%.2f",mod_TicketInfo.TicketPrice] forKey:@"TicketPrice"];
        [paramsDic setObject:[self convertPrice:mod_TicketInfo.TicketOriPrice] forKey:@"TicketOriPrice"];
        [paramsDic setObject:[NSString stringWithFormat:@"%@折", mod_TicketInfo.TicketSale] forKey:@"TicketSale"];
        [paramsDic setObject:mod_TicketInfo forKey:@"mod_TicketInfo"];
        [self pushNewViewController:@"TicketCommentListVC" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:paramsDic];
    }
}


/*
 //--现价.
 [UICommon Common_UILabel_Add:CGRectMake(5, 10, 100, 25) targetView:HeadView
 bgColor:[UIColor clearColor] tag:1001
 text:[self convertPrice:mod_TicketInfo.TicketPrice]
 align:-1 isBold:YES fontSize:20 tColor:color_fc4a00];
 //--原价.
 [UICommon Common_UILabel_Add:CGRectMake(size_xj.width+10, 14, size_yj.width, 20) targetView:HeadView
 bgColor:[UIColor clearColor] tag:1002
 text:[self convertPrice:mod_TicketInfo.TicketOriPrice]
 align:-1 isBold:NO fontSize:14 tColor:color_b3b3b3];
 [UICommon Common_line:CGRectMake(size_xj.width+9, 24, size_yj.width+2, 1) targetView:HeadView backColor:color_b3b3b3];
 
 //--折扣.
 [UICommon Common_UILabel_Add:CGRectMake(size_xj.width+10+size_yj.width+10, 13, 60, 20) targetView:HeadView
 bgColor:[UIColor clearColor] tag:1003
 text:[NSString stringWithFormat:@"%@折", mod_TicketInfo.TicketSale]
 align:-1 isBold:NO fontSize:15 tColor:color_333333];
 //--限购信息.
 [UICommon Common_UILabel_Add:CGRectMake(8, 36, 200, 20) targetView:HeadView
 bgColor:[UIColor clearColor] tag:1004
 text:mod_TicketInfo.TicketLimit
 */


#pragma mark    ---    Scroll View Delegate
- (void) scrollViewDidScroll:(UIScrollView *)_scrollView{
    [UIView animateWithDuration:0.6
                     animations:^{
                         pageControlCurrent  = _scrollView.contentOffset.x/__MainScreen_Width;
                         pageControl.currentPage = pageControlCurrent;
                     }];
}


//  --  cell 前面小图标
- (NSString*) cellIcon:(NSInteger) _cRow{
    NSString * strIcon = [NSString stringWithFormat:@""];
    switch (_cRow) {
        case 1:     strIcon = @"icon_house";
            break;
        case 2:     strIcon = @"icon_list";
            break;
        case 3:     strIcon = @"icon_warn";
            break;
        case 4:     strIcon = @"project_display_icon";
            break;
        case 5:     strIcon = @"comment_icon";
            break;
        case 6:     strIcon = @"icon_jishao";
            break;
        default:
            break;
    }
    return strIcon;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [self HUDShow:@"正在加载数据..." delay:0.5];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView.tag == 2) {
       
         NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
         _webViewHeightForSuitMerchant = [heightStr floatValue];
        if (_webViewHeightForSuitMerchant < 100) {
            _webViewHeightForSuitMerchant = 110;
        }
        
        webView.frame = CGRectMake(16, 45, def_WidthArea(20), _webViewHeightForSuitMerchant + 30);
    }
    else if (webView.tag == 3){
        NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
        _webViewHeightForThisDetail = [heightStr floatValue];
        
        if (_webViewHeightForThisDetail < 100) {
            _webViewHeightForThisDetail = 100;
        }
        
        webView.frame = CGRectMake(16, 45, def_WidthArea(20), _webViewHeightForThisDetail  + 50);
        [detailTableView reloadData];
    }
}

@end
