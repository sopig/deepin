//
//  IndexBqiMallController.m
//  BoqiiLife
//
//  Created by YSW on 14-6-17.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "IndexBqiMallController.h"
#import <POP/POP.h>
#import "resMod_Mall_ShoppingCart.h"

#define buttonTitleForMore  @"更多"
//#define buttonForCategorys  @"狗狗:0|猫猫:1|小宠:2|水族:3"

#define heightBanner        252/2
#define heightForCategory   80/2
#define heightMiddleSpace   12          // 小分类与下面推荐位间隔
#define height_PerRowSubCates   75
#define height_MosicRow  296/2


#define tagMallBanner       999
#define tagForBtnCates      9830


@implementation IndexBqiMallController
@synthesize m_BannerArr;
@synthesize m_MainArr;
@synthesize m_RecommendList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isRootPage = YES;
        self.m_BannerArr = [[NSMutableArray alloc] initWithCapacity:0];
        self.m_MainArr   = [[NSMutableArray alloc] initWithCapacity:0];
        self.m_RecommendList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Show:self.tabBarController];
    
    //  --只有首页上面是灰色背景
    [self.navigationController.navigationBar setBackgroundImage:def_ImgStretchable(@"NavBg_f4f4f4.png", 5, 20)
                                                  forBarMetrics:UIBarMetricsDefault];
    //  --.
    if ([[PMGlobal shared] isSetOverAllIdxForClassify]) {
        [self setCheckedAnimalClass:[[PMGlobal shared] overAllIdxForClassify]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setTitle:@""];
    [self.view setBackgroundColor:color_bodyededed];
  //  [self loadNavBarView];
    [self loadView_UI];
    [self goApiRequest_mallIndexData];
    
    //----------------------        定时器
    [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector: @selector(handleTimer:) userInfo:nil repeats: YES];
   
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(firstOpenApp_selectClass)
                                                 name: @"firstOpenApp_selectClass"
                                               object: nil];
}

- (void)loadView_UI{

    //----------------------        table view
    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, __ContentHeight_noTab) style:UITableViewStylePlain];
    rootTableView.isCloseFooter = YES;
    [rootTableView setTag:101010];
    [rootTableView setBackgroundColor:[UIColor clearColor]];
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = NO;
    [self.view addSubview:rootTableView];
    
    //----------------------        scroll : 顶部的bannner
    scrollview_banner = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightBanner)];
    [scrollview_banner setTag:22220];
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
    
    //----------------------        大分类切换
    viewMallCates = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightForCategory)];
    [viewMallCates setBackgroundColor: color_d1d1d1];
    
    UIView * contentbg = [[UIView alloc] initWithFrame:CGRectMake(0, heightForCategory, __MainScreen_Width, height_PerRowSubCates*2)];
    [contentbg setBackgroundColor:[UIColor whiteColor]];
    [viewMallCates addSubview:contentbg];
    
    catesSelectBg = [[UIView alloc] initWithFrame:CGRectZero];
    [catesSelectBg setBackgroundColor:[UIColor whiteColor]];
    
    lblSelCatesName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width/4, heightForCategory)];
    [lblSelCatesName setTextAlignment:NSTextAlignmentCenter];
    [lblSelCatesName setTextColor:color_fc4a00];
    [lblSelCatesName setFont:defFont15];
    [catesSelectBg addSubview:lblSelCatesName];
    
    [UICommon Common_line:CGRectMake(0, 0, 0.5, heightForCategory) targetView:catesSelectBg backColor:color_d1d1d1];
    [UICommon Common_line:CGRectMake(__MainScreen_Width/4-0.5, 0, 0.5, heightForCategory) targetView:catesSelectBg backColor:color_d1d1d1];
    
    UIImageView * imgtopbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width/4, 5)];
    [imgtopbg setBackgroundColor:[UIColor clearColor]];
    [imgtopbg setImage:[UIImage imageNamed:@"bg_selected.png"]];
    [catesSelectBg addSubview:imgtopbg];
    [viewMallCates addSubview:catesSelectBg];

}

- (void) refreshTemplate:(BOOL) refreshTable{
    
    self.m_BannerArr= indexData.BannerList;
    self.m_MainArr  = indexData.MainData;
//    [rootTableView setHidden: indexData==nil];

    if (self.m_MainArr.count>0) {
        
        resMod_Mall_IndexMain * mainDataTmp= self.m_MainArr[[PMGlobal shared].overAllIdxForClassify];
        //  --  下面的推荐位
        self.m_RecommendList = mainDataTmp.TemplateList;
        if (refreshTable) {
            [rootTableView reloadData:YES allDataCount:1];
        }
    }
    else{
        [self.m_RecommendList removeAllObjects];
        [rootTableView reloadData:YES allDataCount:1];
    }
}

- (void) setCheckedAnimalClass:(int) selIndex{
    
    UIButton * btnCate = (UIButton*)[viewMallCates viewWithTag:tagForBtnCates+selIndex];

    //  --  设置选中的全局分类index
    [[PMGlobal shared] SaveOverAllIdxForClassify:selIndex];
    
    if (btnCate.tag!=currentSelCate.tag) {
        
        [self refreshTemplate:NO];
        
        [currentSelCate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        currentSelCate = btnCate;
        
        [lblSelCatesName setAlpha:0.4];
        
        //  --  pop
        //        viewMallSubCates.frame = CGRectMake(-__MainScreen_Width, viewMallSubCates.frame.origin.y, viewMallSubCates.frame.size.width, viewMallSubCates.frame.size.height);
        //        CGRect cgframe = CGRectMake(0, viewMallSubCates.frame.origin.y, viewMallSubCates.frame.size.width, viewMallSubCates.frame.size.height);
        //        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        //        springAnimation.toValue = [NSValue valueWithCGRect:cgframe];
        //        springAnimation.springBounciness = 5.0f;
        //        springAnimation.springSpeed = 0.5f;
        //        [viewMallSubCates pop_addAnimation:springAnimation forKey:@"changeframe"];

        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect SelFrame = btnCate.frame;
                             SelFrame.origin.y -= 1;
                             SelFrame.size.height += 2;
                             POPSpringAnimation *frameAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
                             frameAnimation.toValue = [NSValue valueWithCGRect:SelFrame];
                             frameAnimation.springBounciness = 17.0f;    //20
                             frameAnimation.springSpeed = 72.0f;        //50
                             [catesSelectBg pop_addAnimation:frameAnimation forKey:@"changeframe"];
                             
                             [lblSelCatesName setText:btnCate.titleLabel.text];
                             POPBasicAnimation *alphaAnimation=[POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
                             alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                             alphaAnimation.toValue  = @(1.0);
                             [lblSelCatesName pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
                         }
                         completion:^(BOOL finished){
                             [rootTableView reloadData:YES allDataCount:1];
                         }];
    }
}
#pragma mark    --  event

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {
    int idx = 0;
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            idx =[[PMGlobal shared] overAllIdxForClassify];
            idx++;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            idx =[[PMGlobal shared] overAllIdxForClassify];
            idx--;
            break;
        default:
            break;
    }
    
    if (idx>=0 && idx<self.m_MainArr.count) {
        [self setCheckedAnimalClass: idx];
    }
}

- (void)onGoCategoryClick:(id) sender{
    [MobClick endEvent:@"mallIndex_AllClassification"];
    [self pushNewViewController:@"MallFirstClassification" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
}

- (void)onSubCategoryClick:(id) sender{
    
    UIButton * btnSubCate = (UIButton*)sender;
    
    NSString * pushControllorName = @"";
    NSMutableDictionary * param = [[NSMutableDictionary alloc] initWithCapacity:0];
    resMod_Mall_IndexMain * sel1thClass = [self.m_MainArr objectAtIndex:[PMGlobal shared].overAllIdxForClassify];
 
    if (!sel1thClass) {
        return;
    }
    
    if ([btnSubCate.titleLabel.text isEqualToString:buttonTitleForMore]) {
        pushControllorName = @"MallSecondClassification";
        [param setObject:sel1thClass.TabId forKey:@"param_1thClassID"];
        [param setObject:@"100" forKey:@"param_FromIndex"];
    }
    else{
        resMod_Mall_IndexTypeData * cate2th = sel1thClass.TypeList[btnSubCate.tag-1999];
        pushControllorName = @"MallProductListVController";
        [param setValue:sel1thClass.TabId forKey:@"param1thClass"];
        [param setValue:sel1thClass.TabName forKey:@"paramSelClassName"];
        [param setValue:[NSString stringWithFormat:@"%d",cate2th.TypeId] forKey:@"param2thClass"];
        [param setValue:[NSString stringWithFormat:@"%d",cate2th.TypeId] forKey:@"param3thClass"];
    }
    
    if (pushControllorName.length>0) {
        [self pushNewViewController:pushControllorName isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:param];
    }
    
    //  --  友盟统计    ing
    NSString * classtype = @"";
    if ([sel1thClass.TabName isEqualToString:@"狗狗"]) {
        classtype = @"dog";
    }
    else if ([sel1thClass.TabName isEqualToString:@"猫猫"]) {
        classtype = @"cat";
    }
    else if ([sel1thClass.TabName isEqualToString:@"水族"]) {
        classtype = @"aquaticAnimals";
    }
    else if ([sel1thClass.TabName isEqualToString:@"小宠"]) {
        classtype = @"smallPet";
    }
    [MobClick event:[NSString stringWithFormat: @"mallIndex_%@_%d",classtype,btnSubCate.tag-1999+1]];
    //  -- 友盟统计     end
}

- (void)onProductSearchClick:(id)sender{
    [MobClick endEvent:@"mallIndex_serch"];
    [self pushNewViewController:@"MallProductSearchController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
}

- (void)onGroupBuyingClick:(id) sender{
    [MobClick event:@"mallIndex_group_buying"];
    
    
    [self pushNewViewController:@"BQGrouponViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
}

- (void)onCategorySelected:(id) sender{
    
    UIButton * btnCate = (UIButton*)sender;
    if ([btnCate.titleLabel.text isEqualToString:@"狗狗"])
    {
        [MobClick event:@"mallIndex_dog"];
    }
    if ([btnCate.titleLabel.text isEqualToString:@"猫猫"])
    {
        [MobClick event:@"mallIndex_cat"];
    }
    if ([btnCate.titleLabel.text isEqualToString:@"小宠"])
    {
        [MobClick event:@"mallIndex_smallPet"];
    }
    if ([btnCate.titleLabel.text isEqualToString:@"水族"])
    {
        [MobClick event:@"mallIndex_aquaticAnimals"];
    }
    
    [self setCheckedAnimalClass: btnCate.tag-tagForBtnCates];
}

- (void)onMallBanner_Action:(id) sender{
    
    [MobClick event:@"mallIndex_banner"];
    UITapGestureRecognizer* img_btn = (UITapGestureRecognizer*)sender;
    NSInteger tag = img_btn.view.tag;
    int idx = tag-tagMallBanner;
    resMod_Mall_IndexBanner * tmpbanner = self.m_BannerArr[idx];
    [self actionCommon:tmpbanner.Type requestUrl:tmpbanner.Url pageTitle:(NSString*) tmpbanner.Title];
}

- (void)onMosaicButtonClick:(int)type requestUrl:(NSString *)sUrl{
    if (type>0 ) {
        [self actionCommon:type requestUrl:sUrl pageTitle:@""];
    }
}

#pragma mark    --     Action 跳转约定
/*  跳转约定 【所有共用跳转】
 *  Type : 【 1、商品列表  2、商品详情  5、html5 】
 *  Url : 完整的请求 包含排序，分类等信息的完整url
 */
- (void)actionCommon:(int) itype requestUrl:(NSString *) apiUrl pageTitle:(NSString *) pagetitle{
    
    if (apiUrl.length==0) {
        [self HUDShow:@"URL配置错误" delay:2];
        return;
    }
    
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString * targetViewController = [[NSString alloc] init];
    BOOL b_HideTabbar=NO;
    switch (itype) {
        case 1:{    //  -- type 为 1 ：跳商城 商品表列
            [pms setValue:apiUrl forKey:@"param_URLProductList"];
            
            resMod_Mall_IndexMain * sel1thClass = [self.m_MainArr objectAtIndex:[PMGlobal shared].overAllIdxForClassify];
            if (sel1thClass) {
                [pms setValue:sel1thClass.TabName forKey:@"paramSelClassName"];
            }
            targetViewController = @"MallProductListVController";
            b_HideTabbar = YES;
        }
            break;
        case 2:{    //  -- type 为 1 ：跳商城 商品表列
            [pms setValue:apiUrl forKey:@"param_URLProductDetail"];
            targetViewController = @"MallProductDetailController";
            b_HideTabbar = YES;
        }
        case 3:    //  -- type 为 3 ：商城暂无类型3
            break;
        case 4:    //  -- type 为 4 ：商城暂无类型4
            break;
        case 5:    //  -- type 为 5 ：活动推荐 跳"html5"页
            [pms setValue:apiUrl forKey:@"param_Html5URL"];
            [pms setValue:pagetitle forKey:@"param_TITLE"];
            
            targetViewController = @"html5ActivityRecommendedVC";
            b_HideTabbar = YES;
            break;
            
        default:    break;
    }
    if (targetViewController.length==0) {
        [self HUDShow:@"跳转页不可为空" delay:1.5];
    } else {
        [self pushNewViewController:targetViewController isNibPage:NO hideTabBar:b_HideTabbar setDelegate:NO setPushParams:pms];
    }
}

#pragma mark - 设置换轮播焦点图速度
- (void) handleTimer: (NSTimer *) timer{
    if (self.m_BannerArr.count>0) {
        if (TimeNum % 3 == 0 ) {
            if (!Tend) {
                pageControlCurrent++;
                if (pageControlCurrent >= self.m_BannerArr.count-1) {
                    Tend = YES;
                    pageControlCurrent = self.m_BannerArr.count-1;
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
                                 scrollview_banner.contentOffset = CGPointMake(pageControlCurrent*__MainScreen_Width,0);
                             }];
        }
        TimeNum ++;
    }
}

#pragma mark    --  第一次打开app 选择分类
- (void) firstOpenApp_selectClass{
    
    if (self.m_MainArr.count>0 && ![[PMGlobal shared] isSetOverAllIdxForClassify] ) {
        UIWindow *currWindow = [[UIApplication sharedApplication] keyWindow];

        FirstOpenApp_CheckMallCategory * FirstSelAnimalCategory = [[FirstOpenApp_CheckMallCategory alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreenFrame.size.height)];
        FirstSelAnimalCategory.ypointSuperView = heightBanner + 45 + (IOS7_OR_LATER?20:0);
        FirstSelAnimalCategory.firstSelCategoryDelegate = self;
        
        NSMutableArray * parrs = [[NSMutableArray alloc] init];
        for (resMod_Mall_IndexMain * maininfo in self.m_MainArr) {
            [parrs addObject:maininfo.TabName];
        }
        [FirstSelAnimalCategory loadContent:parrs];
        [currWindow addSubview:FirstSelAnimalCategory];
        //
        FirstSelAnimalCategory.alpha = 0;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            FirstSelAnimalCategory.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];
        
   }
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    UIButton * btnGoCate = [[UIButton alloc] initWithFrame:CGRectMake(5, 2, 40, 40)];
    [btnGoCate setTag:1113];
    [btnGoCate setBackgroundColor:[UIColor clearColor]];
    [btnGoCate setImage:[UIImage imageNamed:@"classify_btn.png"] forState:UIControlStateNormal];
    [btnGoCate addTarget:self action:@selector(onGoCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:btnGoCate];
    
    UIButton * btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(50, 6, __MainScreen_Width-100, 32)];
    [btnSearch setTag:1119];
    [btnSearch setBackgroundColor:color_dedede];
    btnSearch.layer.cornerRadius = 3.0f;
    [btnSearch setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnSearch setTitle:@"   请输入搜索关键字" forState:UIControlStateNormal];
    [btnSearch.titleLabel setFont:defFont13];
    [btnSearch setTitleColor:color_b3b3b3 forState:UIControlStateNormal];
    [btnSearch addTarget:self action:@selector(onProductSearchClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:btnSearch];
    
    UIImageView * searchicon =[[UIImageView alloc] initWithFrame:CGRectMake(btnSearch.frame.size.width-25, 8, 16, 16)];
    [searchicon setBackgroundColor:[UIColor clearColor]];
    [searchicon setImage:[UIImage imageNamed:@"navbar_search_icon_normal"]];
    [btnSearch addSubview:searchicon];
    
    UIButton * btnGroupBuying = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnSearch.frame)+7, 4, 36, 36)];
    [btnGroupBuying setTag:1120];
    [btnGroupBuying setBackgroundColor:[UIColor clearColor]];
    [btnGroupBuying setImage:[UIImage imageNamed:@"discount_btn.png"] forState:UIControlStateNormal];
    [btnGroupBuying addTarget:self action:@selector(onGroupBuyingClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:btnGroupBuying];
    
}

#pragma mark    --  load ui : 导航
//- (void) loadView_nav{
//    UIView * viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    [viewTitle setBackgroundColor:[UIColor clearColor]];
//    
//    UIButton * btnGoCate = [[UIButton alloc] initWithFrame:CGRectMake(5, 2, 40, 40)];
//    [btnGoCate setTag:1113];
//    [btnGoCate setBackgroundColor:[UIColor clearColor]];
//    [btnGoCate setImage:[UIImage imageNamed:@"classify_btn.png"] forState:UIControlStateNormal];
//    [btnGoCate addTarget:self action:@selector(onGoCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
//    [viewTitle addSubview:btnGoCate];
//    
//    UIButton * btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(50, 6, __MainScreen_Width-100, 32)];
//    [btnSearch setTag:1119];
//    [btnSearch setBackgroundColor:color_dedede];
//    btnSearch.layer.cornerRadius = 3.0f;
//    [btnSearch setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [btnSearch setTitle:@"   请输入搜索关键字" forState:UIControlStateNormal];
//    [btnSearch.titleLabel setFont:defFont13];
//    [btnSearch setTitleColor:color_b3b3b3 forState:UIControlStateNormal];
//    [btnSearch addTarget:self action:@selector(onProductSearchClick:) forControlEvents:UIControlEventTouchUpInside];
//    [viewTitle addSubview:btnSearch];
//    
//    UIImageView * searchicon =[[UIImageView alloc] initWithFrame:CGRectMake(btnSearch.frame.size.width-25, 8, 16, 16)];
//    [searchicon setBackgroundColor:[UIColor clearColor]];
//    [searchicon setImage:[UIImage imageNamed:@"navbar_search_icon_normal"]];
//    [btnSearch addSubview:searchicon];
//    
//    UIButton * btnGroupBuying = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnSearch.frame)+7, 4, 36, 36)];
//    [btnGroupBuying setTag:1120];
//    [btnGroupBuying setBackgroundColor:[UIColor clearColor]];
//    [btnGroupBuying setImage:[UIImage imageNamed:@"discount_btn.png"] forState:UIControlStateNormal];
////    [btnGroupBuying setTitle:@"团购" forState:UIControlStateNormal];
////    [btnGroupBuying.titleLabel setFont:defFont16];
////    [btnGroupBuying setTitleColor:color_fc4a00 forState:UIControlStateNormal];
//    [btnGroupBuying addTarget:self action:@selector(onGroupBuyingClick:) forControlEvents:UIControlEventTouchUpInside];
//    [viewTitle addSubview:btnGroupBuying];
//    [self.navBarView addSubview:viewTitle];
//    //self.navigationItem.titleView = viewTitle;
//}

#pragma mark    --  load ui : 头部banner
- (void) addMallBannerImage{
    for (UIImageView * tmpimg in scrollview_banner.subviews) {
        [tmpimg removeFromSuperview];
    }
    
    for ( int i=0; i< self.m_BannerArr.count; i++) {
        
        UIImageView *imgBan = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width*i, 0, __MainScreen_Width, heightBanner)];
        [imgBan setBackgroundColor:[UIColor clearColor]];
        imgBan.tag = tagMallBanner+i;
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMallBanner_Action:)];
        [imgBan addGestureRecognizer:singleTap];
        imgBan.userInteractionEnabled =YES;
        [scrollview_banner addSubview:imgBan];
        
        resMod_Mall_IndexBanner * bannerInfo = self.m_BannerArr[i];
        NSString * s_url = bannerInfo.ImageUrl;
        [imgBan sd_setImageWithURL:[NSURL URLWithString:s_url] placeholderImage:[UIImage imageNamed:@"placeHold_320x126"]];
    }
}
#pragma mark    --  load ui : 商城大分类【切换】
- (void) loadView_MallCates{
    
    for (UIButton * tmp1thCate in viewMallSubCates.subviews) {
        if (tmp1thCate.tag>tagForBtnCates-1 && tmp1thCate.tag<tagForBtnCates+10) {
            [tmp1thCate removeFromSuperview];
        }
    }
    
    float fWidth = __MainScreen_Width/self.m_MainArr.count;
    int i=0;
    for (resMod_Mall_IndexMain * maininfo in self.m_MainArr) {
        
        int xpoint = i*fWidth;
        int butTag = tagForBtnCates + i;
        
        NSString * stxt = maininfo.TabName;
        UIButton * cateType = [UIButton buttonWithType:UIButtonTypeCustom];
        [cateType setFrame:CGRectMake(xpoint, 0.5, fWidth, heightForCategory-1)];
        [cateType setBackgroundColor: color_body];
        [cateType setTag:butTag];
        [cateType setTitle:stxt forState:UIControlStateNormal];
        [cateType.titleLabel setFont: defFont15];
        [cateType setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        [cateType addTarget:self action:@selector(onCategorySelected:) forControlEvents:UIControlEventTouchUpInside];
        [viewMallCates addSubview:cateType];
        
        if ([PMGlobal shared].overAllIdxForClassify == i) {
            currentSelCate = cateType;
            [lblSelCatesName setText:cateType.titleLabel.text];
            [catesSelectBg setFrame:CGRectMake(cateType.frame.origin.x, cateType.frame.origin.y-1, cateType.frame.size.width,cateType.frame.size.height+2)];
        }
        ++i;
    }
    [viewMallCates bringSubviewToFront:catesSelectBg];
}

- (void) addSubCates:(resMod_Mall_IndexMain *) _MainData{
    
    for (UIButton * tmpmid in viewMallSubCates.subviews) {
        if (tmpmid.tag>1998 && tmpmid.tag<2100) {
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [tmpmid setAlpha:0];
                             }
                             completion:^(BOOL finished){
                                 [tmpmid removeFromSuperview];
                             }];
        }
    }
    
    NSMutableArray * subCateList = _MainData.TypeList;
    int icount = subCateList.count>7?7:subCateList.count;
    
    int currentRow = 0;
    int x_num = 0;
    float y_point = heightBanner + heightForCategory;
    for(int i=0;i < icount+1;i++) {
        
        if(i!=0 && i%4 == 0){
            currentRow++;
            x_num = 0;
        }
        //动态根据当前行算每行个数
        int tmp_R_num = 4;
        float area_width = __MainScreen_Width/tmp_R_num;
        float x_point = area_width*x_num;
        y_point = height_PerRowSubCates*currentRow;
        
        NSString * sTitle = buttonTitleForMore;
        NSString * imgUrl = @"";
        resMod_Mall_IndexTypeData * subCateInfo=nil;
        if (i<icount) {
            subCateInfo = subCateList[i];
            sTitle = subCateInfo.TypeName;
            imgUrl = subCateInfo.TypeImg;
        }
        
        UIButton * btnsubcate = [[UIButton alloc] initWithFrame:CGRectMake(x_point,y_point,area_width, height_PerRowSubCates)];
        [btnsubcate setTag:1999 + i];
        [btnsubcate setAlpha:0];
        [btnsubcate setBackgroundColor:[UIColor clearColor]];
        [btnsubcate setTitle:sTitle forState:UIControlStateNormal];
        [btnsubcate setTitleColor:color_4e4e4e forState:UIControlStateNormal];
        [btnsubcate setTitleEdgeInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
        [btnsubcate.titleLabel setFont:defFont13];
        [btnsubcate addTarget:self action:@selector(onSubCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
        [viewMallSubCates addSubview:btnsubcate];
        
        UIImageView * imgicon = [[UIImageView alloc] initWithFrame:CGRectMake(area_width/2-24, 5, 48, 48)];
        [imgicon setBackgroundColor:[UIColor clearColor]];
        [imgicon sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"btn_morequan.png"]];
        [btnsubcate addSubview:imgicon];
        
        [UIView animateWithDuration:0.3 delay:0.25 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{ [btnsubcate setAlpha:1.0]; }
                         completion:^(BOOL finished){
                         }];
        x_num ++;
    }
}

#pragma mark    --  api 请 求 & 回 调.
-(void)goApiRequest_mallIndexData{
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingMallHomeData:nil ModelClass:@"resMod_CallBackMall_IndexData" showLoadingAnimal:YES hudContent:@"" delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_Mall_HomeData]) {
        resMod_CallBackMall_IndexData * backObj = [[resMod_CallBackMall_IndexData alloc] initWithDic:retObj];
        indexData = backObj.ResponseData;
        
        [self refreshTemplate:YES];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
}

-(void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];
}


#pragma mark    --  table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int numRows = 0;
    if (section==0) {       numRows = 1;    }
    else if(section==1){    numRows = 1;    }
    else if(section==2){    numRows = self.m_RecommendList.count;    }
    return numRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float rowheight = 0;
    if (indexPath.section==0)    {
        rowheight = heightBanner;
    }
    else if(indexPath.section==1){
        rowheight = heightForCategory+height_PerRowSubCates*2 + heightMiddleSpace;
    }
    else if(indexPath.section==2){
        resMod_Mall_IndexTemplate * temInfo = self.m_RecommendList[indexPath.row];
        rowheight = temInfo.TemplateType==2 ? height_MosicRow/2 : height_MosicRow;
    }
    return  rowheight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section==2?50:0;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 50)];
    [viewFoot setBackgroundColor:[UIColor clearColor]];
    return viewFoot;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static  NSString *cellIdentifier1 = @"BannerCell";
    static  NSString *cellIdentifier2 = @"CategoryCell";
    static  NSString *cellIdentifier3 = @"RecommendCell";
    
    int section = indexPath.section;
    if (section==0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
            
            [cell.contentView addSubview:scrollview_banner];
            [cell.contentView addSubview:pageControl];
        }
        
        if (self.m_BannerArr.count>0) {
            [self addMallBannerImage];
            [scrollview_banner setContentSize:CGSizeMake(__MainScreen_Width*m_BannerArr.count, heightBanner)];
            
            float pageWidth = 16*self.m_BannerArr.count;
            [pageControl setFrame:CGRectMake(__MainScreen_Width/2-(pageWidth/2), heightBanner-15, pageWidth, 10)];
            pageControl.numberOfPages = self.m_BannerArr.count;
            [scrollview_banner bringSubviewToFront:pageControl];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (section==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            
            //  --  大分类
            [cell.contentView addSubview:viewMallCates];
            
            float fheightSubCates = height_PerRowSubCates*2;
            
            //  --  小分类
            viewMallSubCates = [[UIView alloc] initWithFrame:CGRectMake(0, heightForCategory, __MainScreen_Width, height_PerRowSubCates*2)];
            [viewMallSubCates setBackgroundColor:[UIColor whiteColor]];
            UISwipeGestureRecognizer *sgLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
            [viewMallSubCates addGestureRecognizer:sgLeft];
            [sgLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
            
            UISwipeGestureRecognizer *sgRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
            [viewMallSubCates addGestureRecognizer:sgRight];
            [sgRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
            [cell.contentView addSubview:viewMallSubCates];
            

            
            //  -- 下面 10 像素分隔线
            UILabel * lbl_spaceLine = [[UILabel alloc] initWithFrame:CGRectMake(0, heightForCategory+fheightSubCates, __MainScreen_Width, heightMiddleSpace)];
            [lbl_spaceLine setBackgroundColor:color_bodyededed];
            lbl_spaceLine.layer.borderColor = color_d1d1d1.CGColor;
            lbl_spaceLine.layer.borderWidth = 0.5f;
            [cell.contentView addSubview:lbl_spaceLine];
        }
        
        if(self.m_MainArr.count>0) {
            
            //  --  数据: 大分类
            [self loadView_MallCates];
            
            //  --  数据: 小分类
            resMod_Mall_IndexMain * mainDataTmp= self.m_MainArr[[PMGlobal shared].overAllIdxForClassify];
            [self addSubCates: mainDataTmp];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (section==2) {
        TableCell_Mosaic * cell = (TableCell_Mosaic*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
        if (cell == nil) {
            cell = [[TableCell_Mosaic alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3];
            cell.cellMosaicDelegate = self;
            
            UILabel * lbl_Bottomline = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 0.5)];
            [lbl_Bottomline setTag:3878373];
            [lbl_Bottomline setBackgroundColor:color_d1d1d1];
            [cell addSubview:lbl_Bottomline];
        }

        if (self.m_RecommendList.count>indexPath.row) {
            resMod_Mall_IndexTemplate * temInfo = self.m_RecommendList[indexPath.row];
            [cell bindDataBytype:temInfo.TemplateType datainfo:temInfo.Template];
            
            UILabel * lbl_3878373 = (UILabel*)[cell viewWithTag:3878373];
            float frowheight = temInfo.TemplateType==2? height_MosicRow/2 :height_MosicRow;
            [lbl_3878373 setFrame:CGRectMake(0, frowheight-0.5, __MainScreen_Width, 0.5)];
        }
    
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:color_d1d1d1];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

#pragma mark    ---    Scroll View Delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==101010) {
        [rootTableView tableViewDidDragging];
    }
    if (scrollView.tag==22220) {
        [UIView animateWithDuration:0.6
                         animations:^{
                             pageControlCurrent  = scrollView.contentOffset.x/__MainScreen_Width;
                             pageControl.currentPage = pageControlCurrent;
                         }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    if (_scrollView.tag==101010) {
        NSInteger returnKey = [rootTableView tableViewDidDragging];
        if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
            [rootTableView tableViewIsRefreshing];
            [self goApiRequest_mallIndexData];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
