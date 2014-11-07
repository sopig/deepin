//
//  IndexViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-4-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "IndexViewController.h"
#import "GeoData.h"
#import "resMod_GetOpenCitys.h"
#import <POP/POP.h>

#define height_subCatesHead     35
#define height_PerRowSubCates   70

#define heightbanner         252/2
#define heightForRowHot      90
#define heightHead_hot       50
#define citysTag             6763
#define bannerTag            93759
#define widthBanner          __MainScreen_Width


//  --  .....................
@implementation EC_LifeSubCatesButton
@synthesize cateID;
@synthesize cateName;
@synthesize cateType;
@end


//  --  .....................
@implementation IndexViewController
@synthesize checkedCityID,checkedCityName;
@synthesize dic_ServiceCategory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isFirstComeInPage = YES;
        self.isRootPage   = YES;
        isAllowLoading = YES;
        m_openCitys     = [[NSMutableArray alloc] initWithCapacity:0];
        m_BannerList    = [[NSMutableArray alloc] initWithCapacity:0];
        m_HotList       = [[NSMutableArray alloc] initWithCapacity:0];
        m_LowPriceList  = [[NSMutableArray alloc] initWithCapacity:0];
        m_ServiceCatesList = [[NSMutableArray alloc] initWithCapacity:0];
        
        [self getUserCheckedCity];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Show:self.tabBarController];

    
    isAllowLoading = YES;
    [self goApiRequest_GetCitys];
}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self ShowOrCloseCity:NO];
//}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self ShowOrCloseCity:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
   // [self loadNavBarView];
    //[self setTitle:@"首页"];
   // [self addTitleSearchView];
    tableView_Root = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, __ContentHeight_noNavTab) style:UITableViewStylePlain];
    tableView_Root.isCloseFooter = YES;
    [tableView_Root setTag:2000];
    [tableView_Root setBackgroundColor:[UIColor convertHexToRGB:@"f0f0f0"]];
    tableView_Root.delegate = self;
    tableView_Root.dataSource = self;
    tableView_Root.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView_Root.showsHorizontalScrollIndicator= NO;
    tableView_Root.showsVerticalScrollIndicator  = NO;
    [self.view addSubview:tableView_Root];
    
    //----------------------        banner : 推荐位UI
    scrollview_banner = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, widthBanner, heightbanner)];
    [scrollview_banner setTag:2111];
    scrollview_banner.backgroundColor = [UIColor clearColor];
    scrollview_banner.delegate= self;
    [scrollview_banner setPagingEnabled:YES];
    scrollview_banner.showsHorizontalScrollIndicator = NO;
    //----------------------        page control
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    [pageControl setFrame:CGRectZero];
    [pageControl setBackgroundColor:[UIColor convertHexToRGB:@"777777"]];
    pageControl.layer.opacity = 0.5;
    pageControl.layer.cornerRadius = 5.0f;
    pageControl.numberOfPages = 3;
    pageControl.userInteractionEnabled = NO;
    
    
    //----------------------        城市
    viewCityBG = [[UIButton alloc] initWithFrame:CGRectMake(0, -__ContentHeight_noNavTab, __MainScreen_Width, __ContentHeight_noNavTab)];
    [viewCityBG setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCloseCity)];
    [viewCityBG addGestureRecognizer:singleTap];
    viewCityBG.userInteractionEnabled =YES;
    
    viewCityContent = [[UIView alloc] initWithFrame:CGRectZero];
    [viewCityContent setBackgroundColor: color_bodyededed];
    [self.view addSubview:viewCityBG];

    
    //----------------------        定时器
    [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector: @selector(handleTimer:) userInfo:nil repeats:YES];
    
    //----------------------        当定位成功时
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(onLocationSuccess) name:@"goLocation" object:nil];
    
    //  --
    [self goApiRequest_homeData];
}

-(void) getUserCheckedCity{
    
    //  --  取上次选中的城市
    NSDictionary * checkedcity = [[PMGlobal shared] location_GetUserCheckedCity];
    self.checkedCityID = [checkedcity objectForKey:@"CityId"];
    self.checkedCityName = [checkedcity objectForKey:@"CityName"];
    
    if (self.checkedCityID.length==0) {
        self.checkedCityID = @"31";
    }
    if (self.checkedCityName.length==0) {
        self.checkedCityName = @"上海";
    }
}

#pragma mark    --  UI加载

//  --  所有开通城市
-(void)LoadView_AllOpenCitys{
    
    for (UIView * subview in viewCityContent.subviews) {
        [subview removeFromSuperview];
    }
    [viewCityContent removeFromSuperview];
    
    float cityRowsHeight = 50*(ceil((float)m_openCitys.count/3));
    float contentHeight = cityRowsHeight+120;
    [viewCityContent setFrame:CGRectMake(0, -contentHeight, __MainScreen_Width, contentHeight)];
    [viewCityBG addSubview:viewCityContent];

    UIView * vOpenCity = [[UIView alloc] initWithFrame:CGRectMake(0, 17, __MainScreen_Width, cityRowsHeight)];
    [vOpenCity setBackgroundColor:[UIColor clearColor]];
    [viewCityContent addSubview:vOpenCity];
    
    int irows = 0;
    int idxForRow = 0;
    int i=0;
    for (resMod_GetOpenCitys * cityinfo in m_openCitys) {
        if (i>0 && i%3==0) {
            irows++;
            idxForRow=0;
        }
        int xpoint = 15+(103*idxForRow);
        int ypoint = 8+(irows*50);
        UIButton * btncity = [UIButton buttonWithType:UIButtonTypeCustom];
        [btncity setTag: citysTag+i];
        [btncity setBackgroundColor:[self.checkedCityName isEqualToString:cityinfo.CityName] ? color_dedede:[UIColor whiteColor]];
        [btncity setFrame:CGRectMake(xpoint, ypoint, 168/2, 35)];
        [btncity setTitle:cityinfo.CityName forState:UIControlStateNormal];
        [btncity.titleLabel setFont:defFont16];
        [btncity setTitleColor:color_333333 forState:UIControlStateNormal];
        [btncity addTarget:self action:@selector(onDidSeletedCity:) forControlEvents:UIControlEventTouchUpInside];
        btncity.layer.borderColor = color_d1d1d1.CGColor;
        btncity.layer.borderWidth= 0.5f;
        [vOpenCity addSubview:btncity];
        
        idxForRow++;
        i++;
    }
    
    UILabel * lblMore = [[UILabel alloc] initWithFrame:CGRectMake(15, vOpenCity.frame.size.height+15, def_WidthArea(15), 36)];
    [lblMore setBackgroundColor:[UIColor clearColor]];
    [lblMore setText:@"更多城市即将上线"];
    [lblMore setTextAlignment:NSTextAlignmentCenter];
    [lblMore setTextColor:color_4e4e4e];
    [lblMore setFont:defFont14];
    [viewCityContent addSubview:lblMore];
    
    [UICommon Common_line:CGRectMake(15, lblMore.frame.origin.y+lblMore.frame.size.height+10, def_WidthArea(15), 0.5) targetView:viewCityContent backColor:color_d1d1d1];
    
    UIButton * BtnLocalCity = [[UIButton alloc] initWithFrame:CGRectMake(15, lblMore.frame.origin.y+lblMore.frame.size.height+20, def_WidthArea(15), 36)];
    [BtnLocalCity setBackgroundColor:[UIColor whiteColor]];
    BtnLocalCity.layer.borderColor = color_d1d1d1.CGColor;
    BtnLocalCity.layer.borderWidth= 0.5f;
    [BtnLocalCity setTitle:@"当前定位城市:" forState:UIControlStateNormal];//:@"   当前定位城市:"];
    [BtnLocalCity setTitleEdgeInsets:UIEdgeInsetsMake(0, -175, 0, 0)];
    [BtnLocalCity.titleLabel setFont:defFont14];
    [BtnLocalCity setTitleColor:color_4e4e4e forState:UIControlStateNormal];
    [BtnLocalCity addTarget:self action:@selector(GoLocalCity) forControlEvents:UIControlEventTouchUpInside];
    [viewCityContent addSubview:BtnLocalCity];
    
    UILabel * lblcity = [[UILabel alloc] initWithFrame:CGRectMake(__MainScreen_Width-150, BtnLocalCity.frame.origin.y,120,36)];
    [lblcity setBackgroundColor:[UIColor clearColor]];
    [lblcity setText: [[PMGlobal shared] location_GetLocalCity]];
    [lblcity setTextAlignment:NSTextAlignmentRight];
    [lblcity setTextColor:color_fc4a00];
    [lblcity setFont:defFont14];
    [viewCityContent addSubview:lblcity];
}

//  --  加载大焦点图 : banner
-(void)adBannerImg{
    for (UIImageView * tmpimg in scrollview_banner.subviews) {
        if (tmpimg.tag>bannerTag && tmpimg.tag<bannerTag+10) {
            [tmpimg removeFromSuperview];
        }
    }
    
    for ( int i=0; i< m_BannerList.count; i++) {
        UIImageView *imgBan = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width*i, 0, __MainScreen_Width, heightbanner)];
        [imgBan setBackgroundColor:[UIColor whiteColor]];
        imgBan.tag = bannerTag+i;
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(banner_Action:)];
        [imgBan addGestureRecognizer:singleTap];
        imgBan.userInteractionEnabled =YES;
        [scrollview_banner addSubview:imgBan];
        
        NSString * s_url=[BQ_global convertImageUrlString:kImageUrlType_320x126 withurl:[m_BannerList[i] ImageUrl]];
        [imgBan sd_setImageWithURL:[NSURL URLWithString:s_url] placeholderImage:[UIImage imageNamed:@"placeHold_320x126"]];
    }
}

//  --  服务分类
- (void) addSubCates:(resMod_IndexServiceList *) subServiceList tagetview:(UIView*) _target{
    
    for (UIButton * tmpmid in _target.subviews) {
        if (tmpmid.tag>1998 && tmpmid.tag<2100) {
            [tmpmid removeFromSuperview];
        }
    }
    
    int icount = subServiceList.ServiceTypeList.count>7?7:subServiceList.ServiceTypeList.count;
    int currentRow = 0;
    int x_num = 0;
    float y_point = 0;
    for(int i=0;i < icount+1;i++) {
        
        if(i!=0 && i%4 == 0){
            currentRow++;
            x_num = 0;
        }
        //动态根据当前行算每行个数
        int tmp_R_num = 4;
        float area_width = __MainScreen_Width/tmp_R_num;
        float x_point = area_width*x_num;
        y_point = height_PerRowSubCates*currentRow + height_subCatesHead + 6;
        
        NSString * sTitle = @"更多";
        NSString * imgUrl = @"";
        int icateID = subServiceList.ServiceId;
        resMod_IndexServiceInfo * subCateInfo=nil;
        if (i<icount) {
            subCateInfo = subServiceList.ServiceTypeList[i];
            icateID = subCateInfo.TypeId;
            sTitle = subCateInfo.TypeName;
            imgUrl = subCateInfo.TypeImg;
        }
        
        EC_LifeSubCatesButton * btnsubcate = [EC_LifeSubCatesButton buttonWithType:UIButtonTypeCustom];
        [btnsubcate setFrame:CGRectMake(x_point,y_point,area_width, height_PerRowSubCates)];
        [btnsubcate setTag:1999 + i];
        [btnsubcate setBackgroundColor:[UIColor clearColor]];
        [btnsubcate setTitle:sTitle forState:UIControlStateNormal];
        [btnsubcate setTitleColor:color_4e4e4e forState:UIControlStateNormal];
        [btnsubcate setTitleEdgeInsets:UIEdgeInsetsMake(42, 0, 0, 0)];
        [btnsubcate.titleLabel setFont:defFont13];
        btnsubcate.cateID = icateID;
        btnsubcate.cateName = subCateInfo.TypeName;
        btnsubcate.cateType = subServiceList.ServiceName;
        [btnsubcate addTarget:self action:@selector(onLifeSubCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
        [_target addSubview:btnsubcate];
        
        UIImageView * imgicon = [[UIImageView alloc] initWithFrame:CGRectMake(area_width/2-25, 0, 48, 48)];
        [imgicon setBackgroundColor:[UIColor clearColor]];
        [imgicon sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"btn_morequan.png"]];
        [btnsubcate addSubview:imgicon];
        
        x_num ++;
    }
}

#pragma mark    --  定 位 & 开 通 城 市.

-(void) onLocationSuccess{
    
    [self getUserCheckedCity];
    NSString * localCity = [[PMGlobal shared] location_GetLocalCity];
    
    if (![localCity isEqualToString:self.checkedCityName]) {
        
        BOOL isExistInOpenCitys = NO;
        for (resMod_GetOpenCitys * cityinfo in m_openCitys) {
            if ([cityinfo.CityName isEqualToString:localCity]) {
                isExistInOpenCitys = YES;
                continue;
            }
        }
        
        if (isExistInOpenCitys && isFirstComeInPage) {

            isFirstComeInPage = NO;
            
            NSString * warnmsg = [NSString stringWithFormat:@"系统定位您在%@,是否切换?",localCity];
            EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"提 示"
                                                                                  message:warnmsg
                                                                        cancelButtonTitle:@"取消"
                                                                            okButtonTitle:@"切换"];
            alertView.delegate1 = self;
            alertView.tag = 3956;
            [alertView show];
        }
    }
}

-(void) onCheckedCityChanged{
    
    [btn_city setTitle:self.checkedCityName forState:UIControlStateNormal];
    [[PMGlobal shared] location_SetUserCheckedCity:[[NSDictionary alloc] initWithObjectsAndKeys:
                                                    self.checkedCityID  ,@"CityId",
                                                    self.checkedCityName,@"CityName", nil]];
}

- (void) onButtonLocalCityClick:(id) sender{
    
    [MobClick event:@"serviceIndex_city"];
    isShowOpenCity = !isShowOpenCity;
    if (isShowOpenCity) {
        
        [self LoadView_AllOpenCitys];
        
        [self ShowOrCloseCity:YES];
    }
    else{
        [self ShowOrCloseCity:NO];
    }
}

- (void) GoLocalCity{
    [self onCloseCity];
    for (resMod_GetOpenCitys * city in m_openCitys) {
        if ([city.CityName isEqualToString:[[PMGlobal shared] location_GetLocalCity] ]) {
            self.checkedCityID = city.CityId;
            self.checkedCityName = city.CityName;
        }
    }
    [self onCheckedCityChanged];
    [self goApiRequest_homeData];
}

- (void) onCloseCity{
    [self ShowOrCloseCity:NO];
}

- (void) onDidSeletedCity:(id) sender{
    
    UIButton * btntmp = (UIButton*) sender;
    int idx = btntmp.tag-citysTag;
    self.checkedCityID = [m_openCitys[idx] CityId];
    self.checkedCityName = [m_openCitys[idx] CityName];
    
    [self onCheckedCityChanged];
    
    [self ShowOrCloseCity:NO];
    [self goApiRequest_homeData];
}

- (void) ShowOrCloseCity:(BOOL) _bool{
    
    CGRect BGframe;
    CGRect ContentFrame;
    if (_bool) {
        BGframe = CGRectMake(0, 0, __MainScreen_Width, kMainScreenHeight);
        ContentFrame = CGRectMake(0, kNavBarViewHeight-8, __MainScreen_Width, viewCityContent.frame.size.height);
    }
    else{
        BGframe = CGRectMake(0, -kMainScreenHeight, __MainScreen_Width, kMainScreenHeight);
        ContentFrame = CGRectMake(0, -viewCityContent.frame.size.height-8, __MainScreen_Width, viewCityContent.frame.size.height);
    }
    
//    POPSpringAnimation *bgAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
//    bgAnimation.toValue = [NSValue valueWithCGRect:BGframe];
//    bgAnimation.springBounciness = 1.0f;
//    bgAnimation.springSpeed = 10.0f;
//    [viewCityBG pop_addAnimation:bgAnimation forKey:@"changeframe"];
    
//    POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
//    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    alphaAnimation.toValue  = _bool ?@(0.8) : @(0.0);
//    [viewCityBG pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
    
    if (_bool) {
        [UIView animateWithDuration:0.5 animations:^{
            [viewCityBG setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
        }];
        
        [viewCityBG setFrame:BGframe];
    }
    
    POPSpringAnimation *contentAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    contentAnimation.toValue = [NSValue valueWithCGRect:ContentFrame];
    contentAnimation.springBounciness = 3.0f;
    contentAnimation.springSpeed = 3.5f;
    [viewCityContent pop_addAnimation:contentAnimation forKey:@"changeframe"];
    
    if (!_bool) {
        isShowOpenCity = NO;
        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(packUpViewCity) userInfo:nil repeats:NO];
    }
}
//---
- (void) packUpViewCity{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [viewCityBG setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
                     }
                     completion:^(BOOL finished){
                         [viewCityBG setFrame:CGRectMake(0, -kMainScreenHeight, __MainScreen_Width, kMainScreenHeight)];
                     }];
}

#pragma mark    --  点击  事件  Action

//  -- 生活馆服务分类点击
- (void) onLifeSubCategoryClick:(id) sender{
    
    EC_LifeSubCatesButton * btntmp = (EC_LifeSubCatesButton*)sender;
    
    //  --   友盟统计   ing
    NSString * scatetype = @"unknow";
    if ([btntmp.cateType isEqualToString:@"狗狗生活服务"])    {
        scatetype = @"dog";
    }
    else if ([btntmp.cateType isEqualToString:@"猫猫生活服务"])   {
        scatetype = @"cat";
    }
    [MobClick event:[NSString stringWithFormat:@"serviceIndex_%@_%d",scatetype,btntmp.tag-1999+1]];
    //  --   友盟统计   eng
    
    
    NSString * typename = [btntmp.cateType substringToIndex:2];
    [self pushNewViewController:@"SMHomeListViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:[[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%d",btntmp.cateID],@"params_sorttypeid",
                                 [NSString stringWithFormat:@"%@%@",typename,btntmp.cateName.length==0?@"全部":btntmp.cateName],@"params_typename",nil]];
}



- (void) onButtonClick:(id) sender{
    UIButton * btnTmp = (UIButton*)sender;
    switch (btnTmp.tag) {
        case 3999: { //--附近服务
            [MobClick event:@"serviceIndex_near"];
            [self pushNewViewController:@"NearbyViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
        }
            break;
            
        default:
            break;
    }
}

//  -- banner 事件
- (void) banner_Action:(id) sender{
    
    [MobClick event:@"serviceIndex_banner"];
    UITapGestureRecognizer* img_btn = (UITapGestureRecognizer*)sender;
    NSInteger tag = img_btn.view.tag;
    int idx = tag-bannerTag;
    [self actionCommon:m_BannerList[idx]];
}
#pragma mark    --     Action 跳转约定
/*  跳转约定 【所有共用跳转】
 *  BannerType : 【 1、券列表 2、商户列表 3、券详情 4、商户详情 】
 *  Url : 完整的请求 包含排序，分类等信息的完整url
 */
- (void)actionCommon:(resMod_IndexBannerInfo *) _bannerinfo{
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString * targetViewController = [[NSString alloc] init];
    BOOL b_HideTabbar=NO;
    switch (_bannerinfo.BannerType) {
        case 1:{    //  -- type 为 1 ：券列表
            [pms setValue:_bannerinfo.Url forKey:@"param_URLTicket"];
            targetViewController = @"SMRecommendViewController";
            b_HideTabbar = YES;
        }
            break;
        case 2:{    //  -- type 为 2 ：商户列表
            [pms setValue:_bannerinfo.Url forKey:@"param_URLMerchant"];
            targetViewController = @"SMRecommendViewController";
            b_HideTabbar = YES;
        }
            break;
        case 3:{    //  -- type 为 3 ：券详情
            [pms setValue:_bannerinfo.Url forKey:@"param_URLService"];
            targetViewController = @"ServiceDetailViewController";
            b_HideTabbar = YES;
        }
            break;
        case 4:{    //  -- type 为 4 ：商户详情
            [pms setValue:_bannerinfo.Url forKey:@"param_URLMerchant"];
            targetViewController = @"MerchantDetailViewController";
            b_HideTabbar = YES;
        }
            break;
        case 5:    //  -- type 为 5 ：活动推荐 跳"html5"页
            [pms setValue:_bannerinfo.Url forKey:@"param_Html5URL"];
            [pms setValue:_bannerinfo.Title forKey:@"param_TITLE"];
            targetViewController = @"html5ActivityRecommendedVC";
            b_HideTabbar = YES;
            break;
            
        default:
            break;
    }
    if (targetViewController.length==0) {
        [self HUDShow:@"跳转页不可为空" delay:1.5];
    } else {
        [self pushNewViewController:targetViewController isNibPage:NO hideTabBar:b_HideTabbar setDelegate:NO setPushParams:pms];
    }
}

#pragma mark - 设置换轮播焦点图速度
- (void) handleTimer: (NSTimer *) timer{
    if (m_BannerList.count>0) {
        if (TimeNum % 3 == 0 ) {
            if (!Tend) {
                pageControlCurrent++;
                if (pageControlCurrent >= m_BannerList.count-1) {
                    Tend = YES;
                    pageControlCurrent = m_BannerList.count-1;
                }
            }
            else{
                pageControlCurrent--;
                if (pageControlCurrent <= 0) {
                    Tend = NO;
                    pageControlCurrent=0;
                }
            }
            [UIView animateWithDuration:0.6 //速度0.6秒
                             animations:^{  //修改坐标
                                 pageControl.currentPage = pageControlCurrent;
                                 scrollview_banner.contentOffset = CGPointMake(pageControlCurrent*__MainScreen_Width,0);
                             }];
        }
        TimeNum ++;
    }
}

- (void)loadNavBarView {
    [super loadNavBarView];
    
    [self._titleLabel setHidden:YES];
    btn_city= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_city setFrame:CGRectMake(0, 0, 60, 44)];
    [btn_city setBackgroundColor:[UIColor clearColor]];
    [btn_city setTitleColor:color_fc4a00 forState:UIControlStateNormal];
    [btn_city setTitle:self.checkedCityName forState:UIControlStateNormal];
    [btn_city setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn_city addTarget:self action:@selector(onButtonLocalCityClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn_city.titleLabel setFont:defFont(YES, 16)];
    [self.subNavBarView addSubview:btn_city];
    
    UIImageView * imgarrow = [[UIImageView alloc] initWithFrame:CGRectMake(40, 17, 10, 10)];
    [imgarrow setImage:[UIImage imageNamed:@"icon_sj_downsel.png"]];
    [self.subNavBarView addSubview:imgarrow];
    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(62, 6, __MainScreen_Width-110, 32)];
    [searchView setBackgroundColor:color_dedede];
    searchView.layer.cornerRadius = 3;
    [self.subNavBarView addSubview:searchView];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(9, 1, searchView.frame.size.width, 30)];
    [searchBtn setBackgroundColor:[UIColor clearColor]];
    [searchBtn setTitle:@"请输入搜索关键字" forState:UIControlStateNormal];
    [searchBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [searchBtn.titleLabel setFont: defFont13];
    [searchBtn setTitleColor:color_b3b3b3 forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(onButton_SearchClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    
    UIImageView * imgicon = [[UIImageView alloc] initWithFrame:CGRectMake(searchBtn.frame.size.width-34, 8, 16, 16)];
    [imgicon setBackgroundColor:[UIColor clearColor]];
    [imgicon setImage:[UIImage imageNamed:@"navbar_search_icon_normal.png"]];
    [searchBtn addSubview:imgicon];
    
    UIButton * nearService = [UIButton buttonWithType:UIButtonTypeCustom];
    [nearService setTag:3999];
    [nearService setFrame:CGRectMake(275, 2, 40, 40)];
    [nearService setTitle:@"附近" forState:UIControlStateNormal];
    [nearService setTitleColor:color_fc4a00 forState:UIControlStateNormal];
    [nearService.titleLabel setFont:defFont16];
    [nearService addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:nearService];
}

#pragma mark    --  Load Search
- (void) addTitleSearchView{
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
    [titleView setBackgroundColor:[UIColor clearColor]];
    
    btn_city= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_city setFrame:CGRectMake(0, 0, 60, 44)];
    [btn_city setBackgroundColor:[UIColor clearColor]];
    [btn_city setTitleColor:color_fc4a00 forState:UIControlStateNormal];
    [btn_city setTitle:self.checkedCityName forState:UIControlStateNormal];
    [btn_city setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn_city addTarget:self action:@selector(onButtonLocalCityClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn_city.titleLabel setFont:defFont(YES, 16)];
    [titleView addSubview:btn_city];
    
    UIImageView * imgarrow = [[UIImageView alloc] initWithFrame:CGRectMake(40, 17, 10, 10)];
    [imgarrow setImage:[UIImage imageNamed:@"icon_sj_downsel.png"]];
    [titleView addSubview:imgarrow];
    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(62, 6, __MainScreen_Width-110, 32)];
    [searchView setBackgroundColor:color_dedede];
    searchView.layer.cornerRadius = 3;
    [titleView addSubview:searchView];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(9, 1, searchView.frame.size.width, 30)];
    [searchBtn setBackgroundColor:[UIColor clearColor]];
    [searchBtn setTitle:@"请输入搜索关键字" forState:UIControlStateNormal];
    [searchBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [searchBtn.titleLabel setFont: defFont13];
    [searchBtn setTitleColor:color_b3b3b3 forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(onButton_SearchClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchBtn];
    
    UIImageView * imgicon = [[UIImageView alloc] initWithFrame:CGRectMake(searchBtn.frame.size.width-34, 8, 16, 16)];
    [imgicon setBackgroundColor:[UIColor clearColor]];
    [imgicon setImage:[UIImage imageNamed:@"navbar_search_icon_normal.png"]];
    [searchBtn addSubview:imgicon];
    
    UIButton * nearService = [UIButton buttonWithType:UIButtonTypeCustom];
    [nearService setTag:3999];
    [nearService setFrame:CGRectMake(275, 2, 40, 40)];
    [nearService setTitle:@"附近" forState:UIControlStateNormal];
    [nearService setTitleColor:color_fc4a00 forState:UIControlStateNormal];
    [nearService.titleLabel setFont:defFont16];
    [nearService addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:nearService];
    [self.navBarView addSubview:titleView];
   // self.navigationItem.titleView = titleView;
}

- (void) onButton_SearchClick:(id) sender{
    [MobClick event:@"serviceIndex_serch"];
    [self pushNewViewController:@"SearchPageViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
}


#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger iSectionRows = 0;
    switch (section) {
        case 0: iSectionRows = m_BannerList.count>0 ? 1:0;
            break;
        case 1: iSectionRows = m_ServiceCatesList.count;
            break;
        case 2: iSectionRows = m_HotList.count;
            break;
        case 3: iSectionRows = m_LowPriceList.count;
            break;
        default:
            break;
    }
    
    return iSectionRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int iSection = indexPath.section;
    float rowHeight = 0;
    switch (iSection) {
        case 0:     rowHeight = heightbanner;
            break;
        case 1: {
            resMod_IndexServiceList * servicelist = m_ServiceCatesList[indexPath.row];
            int icount = servicelist.ServiceTypeList.count>7 ? 7:servicelist.ServiceTypeList.count;
            int irow = ceil((float) icount/4);
            rowHeight = servicelist.ServiceTypeList.count>0 ? (height_subCatesHead + 8 + irow*height_PerRowSubCates):0;
        }
            break;
        case 2:     rowHeight = indexPath.row == 0 ? heightHead_hot+heightForRowHot : heightForRowHot;
            break;
        case 3:     rowHeight = indexPath.row == 0 ? heightHead_hot+heightForRowHot : heightForRowHot;
            break;
        default:
            break;
    }
    
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString * Identifier_service = @"service";
    static  NSString * Identifier_hot =     @"hotRecommend";
    static  NSString * Identifier_groupBuy = @"groupBuy";
    NSInteger iSection =  indexPath.section;
    NSInteger iRow = indexPath.row;
    
    if(iSection == 0){
        NSString * cellIdentifier = @"SecondCellSection";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentifier];
            
            [cell.contentView addSubview:scrollview_banner];
            [cell.contentView addSubview:pageControl];
        }
        
        if (m_BannerList.count>0 && isAllowLoading) {
//            isAllowLoading = NO;
            [self adBannerImg];
            [scrollview_banner setContentSize:CGSizeMake(widthBanner*m_BannerList.count, heightbanner)];
            float pageWidth = 16*m_BannerList.count;
            [pageControl setFrame:CGRectMake(__MainScreen_Width/2-(pageWidth/2), heightbanner-15, pageWidth, 10)];
            pageControl.numberOfPages = m_BannerList.count;
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
    else if (iSection == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: Identifier_service];
        
        if (m_ServiceCatesList.count>0) {
            resMod_IndexServiceList * servicelist = m_ServiceCatesList[indexPath.row];
            if (servicelist.ServiceTypeList.count>0) {
                
                [UICommon Common_UILabel_Add:CGRectMake(12, 0, def_WidthArea(10), height_subCatesHead)
                                  targetView:cell.contentView bgColor:[UIColor clearColor] tag:100
                                        text:servicelist.ServiceName align:-1 isBold:NO fontSize:16 tColor:color_333333];
                
                [UICommon Common_line:CGRectMake(12, height_subCatesHead, def_WidthArea(12), 0.5) targetView:cell.contentView backColor:color_d1d1d1];
                
                [self addSubCates:servicelist tagetview:cell.contentView];
            }
        }

        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        TableCell_Hot *cell = (TableCell_Hot*)[tableView dequeueReusableCellWithIdentifier:iSection ==2 ? Identifier_hot: Identifier_groupBuy];
        if ( !cell ) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_Index" owner:self options:nil];
            for(id oneObject in nib) {
                if([oneObject isKindOfClass:[TableCell_Hot class]]) {
                    cell = (TableCell_Hot *)oneObject;
                    
                    if (iRow == 0) {
                        UILabel * lbl_back = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 12)];
                        [lbl_back setBackgroundColor:[UIColor convertHexToRGB:@"f0f0f0"]];
                        [cell addSubview:lbl_back];
                        
                        UILabel * lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(8, heightHead_hot-32, 150, 30)];
                        [lblTitle setBackgroundColor:[UIColor clearColor]];
                        [lblTitle setText: iSection==2 ? @"热门推荐" : @"低价团"];
                        [lblTitle setFont: defFont18];
                        [lblTitle setTextColor: color_fc4a00];
                        [cell addSubview:lblTitle];
                        
                        [UICommon Common_line:CGRectMake(0,heightHead_hot-0.5,__MainScreen_Width,0.5) targetView:cell backColor:color_d1d1d1];
                        
                        [cell resetSubViewFrame:heightHead_hot];
                        
//                        if (iSection==2) {
//                            UIButton * btnMore = [[UIButton alloc] initWithFrame:CGRectMake(__MainScreen_Width-85, heightHead_hot-30, 80, 30)];
//                            [btnMore setTag:3999];
//                            [btnMore setBackgroundColor:[UIColor clearColor]];
//                            [btnMore setTitle:@"附近服务" forState:UIControlStateNormal];
//                            [btnMore.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
//                            [btnMore setTitleColor:[UIColor convertHexToRGB:@"25aaeb"] forState:UIControlStateNormal];
//                            [btnMore addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//                            [cell addSubview:btnMore];
//                        }
                    }
                }
            }
        }
        
        if (m_HotList.count>0 || m_LowPriceList.count>0) {
            resMod_IndexHotInfo * tmpData = iSection==2 ? m_HotList[iRow] : m_LowPriceList[iRow];
            [cell bindData:tmpData];
        }
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger iSection =  indexPath.section;
    NSInteger iRow = indexPath.row;
    
    
    if (iSection==2) {

        [MobClick event:[NSString stringWithFormat:@"serviceIndex_hotRecommend_%d",iRow]];
        
        NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithObjectsAndKeys :
                                     [NSString stringWithFormat:@"%d",[m_HotList[iRow] TicketId]],@"param_TicketId", nil];
        [self pushNewViewController:@"ServiceDetailViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
    }
    else if(iSection==3){
        
        [MobClick event:[NSString stringWithFormat:@"serviceIndex_lowPrice_%d",iRow]];

        NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:1];
        [pms setObject:[NSString stringWithFormat:@"%d",[m_LowPriceList[iRow] TicketId]] forKey:@"param_TicketId"];
//       [NSString stringWithFormat:@"%d",[m_LowPriceList[iRow] TicketId]],@"param_TicketId",nil];
        [self pushNewViewController:@"ServiceDetailViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
    }
}

#pragma mark    --  api 请 求 & 回 调.
-(void)goApiRequest_homeData{
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_GetHomeData class:@"resMod_CallBack_IndexData"
//              params:nil isShowLoadingAnimal:YES hudShow:@""];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetHomeData:nil ModelClass:@"resMod_CallBack_IndexData" showLoadingAnimal:YES hudContent:@"" delegate:self];
}

-(void) goApiRequest_GetCitys{
        
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_GetOpenCityList class:@"resMod_CallBack_GetOpenCitys"
//              params:nil isShowLoadingAnimal:NO hudShow:@""];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetCityList:nil ModelClass:@"resMod_CallBack_GetOpenCitys" showLoadingAnimal:NO hudContent:@"" delegate:self];
    
    
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_GetHomeData]) {
        resMod_CallBack_IndexData * backObj = [[resMod_CallBack_IndexData alloc] initWithDic:retObj];
        resMod_IndexResponseData * indexData = backObj.ResponseData;
        
        [m_BannerList   removeAllObjects];
        [m_HotList      removeAllObjects];
        [m_LowPriceList removeAllObjects];
        [m_ServiceCatesList removeAllObjects];
        [m_BannerList    addObjectsFromArray: indexData.BannerList];
        [m_HotList       addObjectsFromArray: indexData.HotList];
        [m_LowPriceList  addObjectsFromArray: indexData.LowPriceList];
        [m_ServiceCatesList addObjectsFromArray: indexData.ServiceList];
        
        [tableView_Root reloadData:YES allDataCount:0];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
    
    if ([ApiName isEqualToString:kApiMethod_GetOpenCityList]) {
        resMod_CallBack_GetOpenCitys * backObj = [[resMod_CallBack_GetOpenCitys alloc] initWithDic:retObj];
        [m_openCitys removeAllObjects];
        [m_openCitys addObjectsFromArray:backObj.ResponseData];
        [self onCheckedCityChanged];
        //  -- 定位 取 当前城市
        [[GeoData singletonDB] locateUserCity];
    }
}

-(void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];
}

#pragma mark    ---    Scroll View Delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==2000) {
        [tableView_Root tableViewDidDragging];
    }
    if (scrollView.tag==2111) {
        [UIView animateWithDuration:0.6
                         animations:^{
                             pageControlCurrent  = scrollView.contentOffset.x/__MainScreen_Width;
                             pageControl.currentPage = pageControlCurrent;
                         }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    if (_scrollView.tag==2000) {
        NSInteger returnKey = [tableView_Root tableViewDidDragging];
        if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
            [tableView_Root tableViewIsRefreshing];
            [self goApiRequest_homeData];
        }
    }
}

//  ------      弹框确认
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 3956) {
        if(buttonIndex == 1) {
            [self GoLocalCity];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc
{
     [self ShowOrCloseCity:NO];
    
}
@end
