//
//  MallProductListVController.m
//  BoqiiLife
//
//  Created by YSW on 14-6-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MallProductListVController.h"
#import "TableCell_Common.h"
#import "resMod_Mall_Goods.h"
#import "resMod_GetFilterCategory.h"
#import "resMod_Mall_ShoppingCart.h"
#import "resMod_Mall_Classification.h"
#import <POP/POP.h>
#import "OfflineShoppingCart.h"

#define heightTopFilter 44
#define height_3thClassRow  45
#define heightForCell   100
#define tagFilter       6458
#define tagFilter_category  723923

#define pageNum         @"8"
#define FilterButtons_2 @"分类:1:icon_sj|销量:2|价格:3:icon_arrowtip|评论:4"
#define FilterButtons   @"销量:2|价格:3:icon_arrowtip|评论:4"

//  -------------------------   EC_ProductFilterButton

@implementation EC_ProductFilterButton
@synthesize isSelected,isFocus,img_icon,iconName;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isSelected = NO;
        img_icon = [[UIImageView alloc]initWithFrame:CGRectZero];
        [img_icon setBackgroundColor:[UIColor clearColor]];
        [self addSubview:img_icon];
    }
    return self;
}

- (void) setIconName:(NSString *) _icon{
    iconName = _icon.length>0 ? _icon:self.iconName;
    CGSize titleSize = [self.titleLabel.text sizeWithFont:defFont15 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    
    NSString * imgname = @"";
    if (self.isSelected) {
        imgname = [NSString stringWithFormat:@"%@%@", _icon,self.isFocus?@"_upsel":@"_upnor"];
    }
    else{
        imgname = [NSString stringWithFormat:@"%@%@", _icon,self.isFocus?@"_downsel":@"_downnor"];
    }
    
    [img_icon setImage:[UIImage imageNamed:imgname]];
    [img_icon setFrame:CGRectMake((self.frame.size.width+titleSize.width)/2+2, self.frame.size.height/2-5, 10, 10)];
}

//- (void) setBtnStatus:(BOOL)_isSelected{
//    self.isSelected = _isSelected;
//    
//    [self setIconName:self.iconName];
//}
@end




@implementation MallProductListVController
@synthesize param_1thClass;
@synthesize param_2thClass;
@synthesize param_3thClass;
@synthesize param_Keyword;
@synthesize param_OrderType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        filterTypeID = -100;
        filterBrandID = -100;
        arrProductList = [[NSMutableArray alloc] initWithCapacity:0];
        dicActivityColor = [[NSMutableDictionary alloc] initWithCapacity:12];
        [dicActivityColor setObject: @"满减|FD5E4B"  forKey:@"activity1"];
        [dicActivityColor setObject: @"折扣|1E9E4F"  forKey:@"activity2"];
        [dicActivityColor setObject: @"满减+折扣|FF7D25"  forKey:@"activity3"];
        [dicActivityColor setObject: @"包邮|8FC31F"  forKey:@"activity4"];
        [dicActivityColor setObject: @"赠品|E3000C"  forKey:@"activity5"];
        [dicActivityColor setObject: @"限购|FF7D25"  forKey:@"activity6"];
        [dicActivityColor setObject: @"代发货|29A9E1" forKey:@"activity7"];
        [dicActivityColor setObject: @"满赠|FF5353"   forKey:@"activity8"];
        [dicActivityColor setObject: @"多买多惠|586FB5" forKey:@"activity9"];
        [dicActivityColor setObject: @"折扣价|FF417F"   forKey:@"activity10"];
        [dicActivityColor setObject: @"换购|FEB037"  forKey:@"activity11"];
        [dicActivityColor setObject: @"团购|E3000C"   forKey:@"activity12"];
        
        
        dicFilterWhere = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Hidden:self.tabBarController];
    
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
    [self setTitle:@"商品列表"];
    self.param_1thClass = [self.receivedParams objectForKey:@"param1thClass"];
    self.param_2thClass = [self.receivedParams objectForKey:@"param2thClass"];
    self.param_3thClass = [self.receivedParams objectForKey:@"param3thClass"];
    self.param_Keyword  = [self.receivedParams objectForKey:@"paramKeyword"];
    self.param_ApiURL   = [self.receivedParams objectForKey:@"param_URLProductList"];
    self.param_SelClassName = [self.receivedParams objectForKey:@"paramSelClassName"];
    isActivityRecommed  = self.param_ApiURL.length>0;

    [self loadView_UI];
    
    if (self.param_ApiURL.length>0) {
        
        [self setTitle:@"活动推荐"];
        [viewFilter setHidden:YES];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestWithURL:self.param_ApiURL ModelClass:@"resMod_CallBackMall_GoodsList"
                                                        hudContent:@"正在加载" delegate:self];
        [rootTableView setFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    }
    else{
        [self loadView_nav];
        [self goApiRequestProductList:YES hudshow:@""];
    }
}

- (void) loadView_UI{
    
    //  --  筛选区........
    viewFilter = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, heightTopFilter)];
    [viewFilter setBackgroundColor:[UIColor clearColor]];
    UIView * filterShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightTopFilter-1)];
    [filterShadow setBackgroundColor:[UIColor whiteColor]];
    filterShadow.layer.shadowColor = [UIColor blackColor].CGColor;
    filterShadow.layer.shadowOffset = CGSizeMake(0, 0.5);
    filterShadow.layer.shadowOpacity = 0.3;
    filterShadow.layer.shadowRadius = 0.8;
    [viewFilter addSubview:filterShadow];
    [self.view addSubview:viewFilter];
    [self addProductFilter];
    
    //  --  ........
    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0,heightTopFilter+kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight-heightTopFilter - kNavBarViewHeight) style:UITableViewStylePlain];
    [rootTableView setTag:11111];
    rootTableView.backgroundColor = color_bodyededed;
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:rootTableView];
    [self.view bringSubviewToFront:viewFilter];
    
    //  -- 前往购物车按钮
    goCarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goCarButton setTag:1011];
    [goCarButton setFrame:CGRectMake(__MainScreen_Width-60, kMainScreenHeight-60, 50, 50)];
    [goCarButton setBackgroundColor:[UIColor clearColor]];
    [goCarButton setBackgroundImage:[UIImage imageNamed:@"car_btn.png"] forState:UIControlStateNormal];
    [goCarButton setTitle:@"" forState:UIControlStateNormal];
    [goCarButton addTarget:self action:@selector(onGoShoppingCarClick:) forControlEvents:UIControlEventTouchUpInside];
    lbl_carnum = [[UILabel alloc] initWithFrame:CGRectMake(24, 11, 20, 18)];
    [lbl_carnum setBackgroundColor:[UIColor clearColor]];
    [lbl_carnum setText: [NSString stringWithFormat:@"%d",[UserUnit userCarNum]]];
    [lbl_carnum setFont:defFont(NO, 11)];
    [lbl_carnum setTextAlignment:NSTextAlignmentCenter];
    [lbl_carnum setTextColor:[UIColor whiteColor]];
    [goCarButton addSubview:lbl_carnum];
    [self.view addSubview:goCarButton];
}

#pragma mark    -- 本地筛选  1.0版本 废掉了
- (void) setFilterWhere{
    //  -- 组合 筛选条件
    if (arrProductList.count>0) {
        resMod_CategoryList * filterInfoSuper1 = [[resMod_CategoryList alloc] init];
        filterInfoSuper1.TypeName = @"分类";
        filterInfoSuper1.TypeList = [[NSMutableArray alloc] init];
        
        resMod_CategoryList * filterInfoSuper2 = [[resMod_CategoryList alloc] init];
        filterInfoSuper2.TypeName = @"品牌";
        filterInfoSuper2.TypeList = [[NSMutableArray alloc] init];
        
        for (resMod_Mall_GoodsInfo * goodsinfo in arrProductList) {
            
            resMod_CategoryInfo * filterInfoSub1 = [[resMod_CategoryInfo alloc] init];
            filterInfoSub1.SubTypeId = goodsinfo.TypeId;
            filterInfoSub1.SubTypeName = goodsinfo.TypeName;
            [filterInfoSuper1.TypeList addObject:filterInfoSub1];
            
            //  -- 记住选中分类
            for (resMod_CategoryInfo * dicClassTmp in [[dicFilterWhere objectForKey:@"section0"] TypeList]) {
                if (dicClassTmp.SubTypeId == goodsinfo.TypeId) {
                    filterInfoSub1.isChecked = dicClassTmp.isChecked;
                    continue;
                }
            }
            
            resMod_CategoryInfo * filterInfoSub2 = [[resMod_CategoryInfo alloc] init];
            filterInfoSub2.SubTypeId = goodsinfo.BrandId;
            filterInfoSub2.SubTypeName = goodsinfo.BrandName;
            [filterInfoSuper2.TypeList addObject:filterInfoSub2];
            
            //  -- 记住选中品牌
            for (resMod_CategoryInfo * dicBrandTmp in [[dicFilterWhere objectForKey:@"section1"] TypeList]) {
                if (dicBrandTmp.SubTypeId == goodsinfo.BrandId) {
                    filterInfoSub2.isChecked = dicBrandTmp.isChecked;
                    continue;
                }
            }
        }
        [dicFilterWhere setValue:filterInfoSuper1 forKey:@"section0"];
        [dicFilterWhere setValue:filterInfoSuper2 forKey:@"section1"];
    }
}
//  -- 确定本地筛选
- (void)onDelegateProductFilter{
    [self HUDShow:@"本地筛选 1.0版本 废掉了" delay:2];
}


#pragma mark    --  event
- (void) onSearchClick:(id) sender{
    
    
    if (searchText.text.length>0) {
        self.param_Keyword = searchText.text;
        [self goApiRequestProductList:YES hudshow:@"正在搜索"];
    }
    else{
        [self HUDShow:@"请输入搜索内容" delay:2];
    }
    

    
    
    
}
//  -- 筛选
- (void) onMallProductFilter:(id) sender{
    
    EC_ProductFilterButton * btnTmp = (EC_ProductFilterButton*)sender;
    for (int i=tagFilter;i<tagFilter+10;i++) {
        EC_ProductFilterButton * btn = (EC_ProductFilterButton *)[viewFilter viewWithTag:i];
        if (btn) {
            if (btnTmp.tag!=btn.tag) {
                [btn setTitleColor:color_333333 forState:UIControlStateNormal];
                [btn.img_icon setImage:[UIImage imageNamed:[NSString stringWithFormat: @"%@_downnor",btn.iconName]]];
            }
            else{
                [btn setTitleColor:color_fc4a00 forState:UIControlStateNormal];
            }
        }
    }
    

    if ([btnTmp.titleLabel.text isEqualToString:@"筛选"]) {
        ViewMPFilter.dicFilterData = dicFilterWhere;
        [ViewMPFilter isExpansionMpFilterView:YES];
    }
    else{
        if (btnTmp.tag-tagFilter > 1) {
            [self ShowOrHiddenCategoryForFilter:NO];
        }
        
        switch (btnTmp.tag-tagFilter) {     //  --  1:销量  2:价格高到低  3:价格低到高 4:评论
            case 1: {
                [MobClick event:@"goodslist_classification"];
                FilterButtonIsDoubleClick_cates = !FilterButtonIsDoubleClick_cates;
                NSString * sImgName = FilterButtonIsDoubleClick_cates? @"upsel" :@"downsel";
                [btnTmp.img_icon setImage:[UIImage imageNamed:[NSString stringWithFormat: @"%@_%@",btnTmp.iconName,sImgName]]];
                [self ShowOrHiddenCategoryForFilter: FilterButtonIsDoubleClick_cates];
                
                if (FilterButtonIsDoubleClick_cates) {
                    
                    [self.noDataView setHidden:YES];
                }

                self.param_3thClass = @"";
                self.param_OrderType = @"";
            }
                break;
            case 2:
                if (self.param_2thClass.length>0) {
                    [MobClick event:@"goodslist_salesVolume"];
                }
                else {
                    [MobClick event:@"SearchResultPage_salesVolume"];
                }
                
                self.param_OrderType = @"1";
                break;
            case 3: {
                if (self.param_2thClass.length>0) {
                    [MobClick event:@"goodslist_price"];
                }
                else {
                    [MobClick event:@"SearchResultPage_price"];
                }

                
                FilterButtonIsDoubleClick_price = !FilterButtonIsDoubleClick_price;
                NSString * sImgName = FilterButtonIsDoubleClick_price? @"downsel" :@"upsel";
                [btnTmp.img_icon setImage:[UIImage imageNamed:[NSString stringWithFormat: @"%@_%@",btnTmp.iconName,sImgName]]];
                self.param_OrderType = FilterButtonIsDoubleClick_price ? @"2":@"3";
            }
                break;
            case 4:
                if (self.param_2thClass.length>0)
                {
                    [MobClick event:@"goodslist_comment"];
                }
                else
                {
                    [MobClick event:@"SearchResultPage_comment"];
                }
                self.param_OrderType = @"4";
                break;
                
            default: break;
        }
        if (self.param_OrderType.length>0) {
            [self goApiRequestProductList:YES hudshow:@"正在加载"];
        }
    }
}

- (void) onMallProductFilterByCategory:(id) sender{
    
    UIButton * btntmp = (UIButton*)sender;
    [btntmp setTitleColor:color_fc4a00 forState:UIControlStateNormal];
    
    if ([btntmp.titleLabel.text isEqualToString:@"全部"])
    {
        [MobClick event:@"goodslist_classification_all"];
    }
    else {
        [MobClick event:@"goodslist_classification_otherClassification"];
    }
    
    for (UIButton * subBtn in scrollCategoryForFilter.subviews) {
        if ([subBtn isKindOfClass:[UIButton class]] && subBtn.tag!=btntmp.tag) {
            [subBtn setTitleColor:color_4e4e4e forState:UIControlStateNormal];
        }
    }
    
    if (btnChecked3thClass) {
        if (btnChecked3thClass.tag == btntmp.tag) {
            return;
        }
        [btnChecked3thClass setTitleColor:color_4e4e4e forState:UIControlStateNormal];
    }
    btnChecked3thClass = btntmp;
    self.param_3thClass = [NSString stringWithFormat:@"%d",btntmp.tag];
    
    [self ShowOrHiddenCategoryForFilter:NO];
    [self goApiRequestProductList:YES hudshow:@"正在加载"];
}

- (void) onGoShoppingCarClick:(id) sender{
    [MobClick event:@"goodslist_shoppingCart"];
    [self pushNewViewController:@"ShoppingCartViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"param_isFromPush", nil]];
}

#pragma mark    --  load ui : 导航 & 购物车
- (void) loadView_nav {

    NSString * selCateName = self.param_SelClassName.length>0 ? self.param_SelClassName:@"全部";
    
    UIView * viewTitle = [[UIView alloc] initWithFrame:CGRectMake(45, kStatusBarHeight+7, __MainScreen_Width - 45 - 10, 30)];
    [viewTitle setBackgroundColor:color_dedede];
    viewTitle.layer.cornerRadius = 3.0f;

    UILabel * lblCate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 30)];
    [lblCate setText:selCateName];
    [lblCate setBackgroundColor:[UIColor clearColor]];
    [lblCate setFont:defFont13];
    [lblCate setTextColor:color_989898];
    [lblCate setTextAlignment:NSTextAlignmentCenter];
    [viewTitle addSubview:lblCate];
    
    UIImageView * imgarrow = [[UIImageView alloc] initWithFrame:CGRectMake(lblCate.frame.size.width-6, 13, 6, 3)];
    [imgarrow setImage:[UIImage imageNamed:@"down_arrow.png"]];
    [imgarrow setAlpha:0.6];
    [viewTitle addSubview:imgarrow];
    
    [UICommon Common_line:CGRectMake(48.5, 9, 0.5, 12) targetView:viewTitle backColor:color_989898];
    
    searchText = [[UITextField alloc] initWithFrame:CGRectMake(54, 5, viewTitle.frame.size.width-90, 20)];
    searchText.delegate = self;
    [searchText setBackgroundColor:[UIColor clearColor]];
    [searchText setPlaceholder:@"请输入搜索关键字"];
    [searchText setText:self.param_Keyword];
    [searchText setFont: defFont14];
    [searchText setReturnKeyType:UIReturnKeySearch];
    [searchText setTextAlignment:NSTextAlignmentLeft];
    [searchText setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [viewTitle addSubview:searchText];
    
    UIButton * btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(230, 0, 35, 30)];
    [btnSearch setBackgroundColor:[UIColor clearColor]];
    btnSearch.layer.cornerRadius = 3.0f;
    [viewTitle addSubview:btnSearch];
    UIImageView * searchicon =[[UIImageView alloc] initWithFrame:CGRectMake(5, (30-16)/2, 16, 16)];
    [searchicon setBackgroundColor:[UIColor clearColor]];
    [searchicon setImage:[UIImage imageNamed:@"navbar_search_icon_normal"]];
    [btnSearch addSubview:searchicon];
    [viewTitle addSubview:btnSearch];
    [btnSearch addTarget:self action:@selector(onSearchClick:) forControlEvents:UIControlEventTouchUpInside];
    [[self navBarView] addSubview:viewTitle];
}

#pragma mark    --  load ui :  头部筛选区
- (void) addProductFilter{
    
    //  -- 筛选层
    ViewMPFilter = [[MallProductFilterView alloc] init];
    [ViewMPFilter setMPFDelegate:self];
    [ViewMPFilter setFrame:CGRectMake(0, -__ContentHeight_noTab, __MainScreen_Width, __ContentHeight_noTab)];
    [viewFilter setBackgroundColor:color_bodyededed];
    [self.view addSubview:ViewMPFilter];
    
    NSArray * arrFilters = [(self.param_2thClass.length>0 ? FilterButtons_2:FilterButtons) componentsSeparatedByString:@"|"];
    float widthBtn = __MainScreen_Width/arrFilters.count;
    int i=0;
    for (NSString * svalue in arrFilters) {

        NSArray * fInfo = [svalue componentsSeparatedByString:@":"];
        
        EC_ProductFilterButton * btnprofilter = [EC_ProductFilterButton buttonWithType:UIButtonTypeCustom];
        [btnprofilter setFrame:CGRectMake(widthBtn*i, 0, widthBtn, heightTopFilter)];
        [btnprofilter setTag:tagFilter+[fInfo[1] intValue]];
        [btnprofilter setBackgroundColor:[UIColor clearColor]];
        [btnprofilter setTitle:fInfo[0] forState:UIControlStateNormal];
        [btnprofilter setTitleColor:color_333333 forState:UIControlStateNormal];
        [btnprofilter.titleLabel setFont:defFont15];
        [btnprofilter addTarget:self action:@selector(onMallProductFilter:) forControlEvents:UIControlEventTouchUpInside];
        [viewFilter addSubview:btnprofilter];
        
        if (fInfo.count==3) {
            [btnprofilter setIconName:fInfo[2]];
        }
        
        if (i>0) {
            [UICommon Common_line:CGRectMake(0, viewFilter.frame.size.height/2-5, 0.5, 10)
                       targetView:btnprofilter backColor:color_d1d1d1];
        }
        i++;
    }
    
    //  -- 按第三级分类筛选
    scrollCategoryForFilter = [[UIScrollView alloc] initWithFrame:CGRectMake(0, heightTopFilter+kNavBarViewHeight, __MainScreen_Width, height_3thClassRow*3+10)];
    [scrollCategoryForFilter setHidden:YES];
    [scrollCategoryForFilter setBackgroundColor:color_d1d1d1];
    [self.view addSubview:scrollCategoryForFilter];
    [self.view sendSubviewToBack:scrollCategoryForFilter];
    
    if (self.param_2thClass.length>0) {
        [scrollCategoryForFilter setHidden:NO];
        [self goApiRequest_MallClassification];
    }
}

-(void)ShowOrHiddenCategoryForFilter:(BOOL) _bool{
    //return;
    
    CGRect cgFrame;
    float ftopheight = viewFilter.hidden ? 0:heightTopFilter;
    ftopheight += kNavBarViewHeight;
    if (_bool) {
        cgFrame = CGRectMake(rootTableView.frame.origin.x, ftopheight + scrollCategoryForFilter.frame.size.height, rootTableView.frame.size.width, rootTableView.frame.size.height);
    }
    else{
        if (FilterButtonIsDoubleClick_cates) {
            FilterButtonIsDoubleClick_cates = NO;
        }
        cgFrame = CGRectMake(rootTableView.frame.origin.x, ftopheight, rootTableView.frame.size.width, rootTableView.frame.size.height);
    }
    
    POPSpringAnimation *contentAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    contentAnimation.toValue = [NSValue valueWithCGRect:cgFrame];
    contentAnimation.springBounciness = 1.0f;
    contentAnimation.springSpeed = 20.0f;
    [rootTableView pop_addAnimation:contentAnimation forKey:@"changeframe"];
}

-(void)loadData_3thClass{
    int currentLine = -1;
    int numInRow = 0;
    float fbtnHeight = 45;
    float fbtnpadding = 12;
    float fbtnWidth = (__MainScreen_Width-14)/3-fbtnpadding;
    
    for (UIButton * btn in scrollCategoryForFilter.subviews) {
        [btn removeFromSuperview];
    }
    
    int i=0;
    for (resMod_Mall_Class3th * cls3th in arr3thClassList) {
        
        if ( i%3==0) {
            currentLine++;
            numInRow=0;
        }
        
        UIButton * btnprofilter = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnprofilter setFrame:CGRectMake((fbtnWidth+fbtnpadding)*numInRow+13, fbtnHeight*currentLine+11, fbtnWidth, fbtnHeight-12)];
        [btnprofilter setTag:cls3th.ThirdTypeId];
        [btnprofilter setBackgroundColor:[UIColor whiteColor]];
        [btnprofilter setTitle:[NSString stringWithFormat:@"%@",cls3th.ThirdTypeName] forState:UIControlStateNormal];
        [btnprofilter setTitleColor:[self.param_3thClass intValue]==cls3th.ThirdTypeId ? color_fc4a00:color_4e4e4e forState:UIControlStateNormal];
        [btnprofilter.titleLabel setFont:defFont13];
        [btnprofilter addTarget:self action:@selector(onMallProductFilterByCategory:) forControlEvents:UIControlEventTouchUpInside];
        [scrollCategoryForFilter addSubview:btnprofilter];
        
        i++;
        numInRow++;
    }

    CGRect cgframe = scrollCategoryForFilter.frame;
    currentLine++;
    [scrollCategoryForFilter setFrame:CGRectMake(CGRectGetMinX(cgframe), CGRectGetMinY(cgframe), CGRectGetWidth(cgframe), 10+height_3thClassRow*(currentLine>3?3:currentLine))];
    [scrollCategoryForFilter setContentSize:CGSizeMake(__MainScreen_Width, fbtnHeight*currentLine+8)];
}

#pragma mark    --  api 请 求 & 回 调.

-(void)goApiRequest_MallClassification{
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_Classification class:@"resMod_CallBackMall_Classification"
//              params:nil  isShowLoadingAnimal:NO hudShow:@"正在加载"];
//    GetShoppingMallCategoryType
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingMallCategoryType:nil ModelClass:@"resMod_CallBackMall_Classification" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
}

-(void)goApiRequestProductList:(BOOL) _isRefresh hudshow:(NSString*) _hudshow{

    b_isRefreshPage = _isRefresh;
    int startIndex = b_isRefreshPage?0:arrProductList.count;
    NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
    [apiParams setObject:[NSString stringWithFormat:@"%d",startIndex] forKey:@"StartIndex"];
    [apiParams setObject:pageNum forKey:@"Number"];
    if (self.param_1thClass.length>0)
        [apiParams setObject:self.param_1thClass forKey:@"FirstTypeId"];
    if (self.param_3thClass.length>0)
        [apiParams setObject:self.param_3thClass forKey:@"ThirdTypeId"];
    if (self.param_Keyword.length>0)
        [apiParams setObject:self.param_Keyword forKey:@"KeyWord"];
    if (self.param_OrderType.length>0)
        [apiParams setObject:self.param_OrderType forKey:@"OrderTypeId"];
    if (filterTypeID>-1)
        [apiParams setObject:[NSString stringWithFormat:@"%d",filterTypeID] forKey:@"TypeId"];
    if (filterBrandID>-1)
        [apiParams setObject:[NSString stringWithFormat:@"%d",filterBrandID] forKey:@"BrandId"];
    

    [[APIMethodHandle shareAPIMethodHandle] goApiRequestGetShoppingMallGoodsList:apiParams ModelClass:@"resMod_CallBackMall_GoodsList" showLoadingAnimal:YES hudContent:_hudshow delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    
    if ([ApiName isEqualToString:kApiMethod_Mall_Classification]) {
        resMod_CallBackMall_Classification * backObj = [[resMod_CallBackMall_Classification alloc] initWithDic:retObj];
        
        if(backObj.ResponseData.count>0){
            for (resMod_Mall_Class1th * clstmp in backObj.ResponseData) {
                if (clstmp.TypeId == [self.param_1thClass intValue]) {
                    for (resMod_Mall_Class2th * cls2tmp in clstmp.TypeList) {
                        if (cls2tmp.SubTypeId == [self.param_2thClass intValue]) {
                            arr3thClassList = cls2tmp.SubTypeList;
                            [self loadData_3thClass];
                            continue;
                        }
                    }
                }
            }
        }
    }

    if ([ApiName isEqualToString:kApiMethod_Mall_GoodsList] || [ApiName isEqualToString:self.param_ApiURL]) {
        resMod_CallBackMall_GoodsList * backObj = [[resMod_CallBackMall_GoodsList alloc] initWithDic:retObj];
        if (b_isRefreshPage)
        {
            b_isRefreshPage = NO;
            [arrProductList removeAllObjects];
        }
        [arrProductList addObjectsFromArray: backObj.ResponseData];
        
        [self setFilterWhere];
        
        int icount = backObj.ResponseData.count;
        if ([ApiName isEqualToString:self.param_ApiURL]) {
            [rootTableView reloadData:YES allDataCount:arrProductList.count];
        }
        else{
            [rootTableView reloadData: (icount==0 || icount<[pageNum intValue]) ? YES:NO allDataCount:arrProductList.count];
        }
        
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
        [self.noDataView noDataViewIsHidden:arrProductList.count==0 ? NO :YES
                                    warnImg:@"" warnMsg:@"抱歉，暂无相关商品 !"];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_CartNum]) {
        resMod_CallBackMall_CartNum * backObj = [[resMod_CallBackMall_CartNum alloc] initWithDic:retObj];
        resMod_GetShoppingCartNum * cartnum = backObj.ResponseData;
        [UserUnit saveCartNum:cartnum.Number];
        
        [goCarButton setHidden:[UserUnit userCarNum]>0?NO:YES];
        [lbl_carnum setText: [NSString stringWithFormat:@"%d",[UserUnit userCarNum]]];
    }
}

-(void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];
    
    [self.noDataView noDataViewIsHidden:arrProductList.count==0 ? NO :YES warnImg:@"" warnMsg:@"抱歉，暂无相关商品 !"];
    [rootTableView reloadData:YES allDataCount:arrProductList.count];
    
    if ([ApiName isEqualToString:kApiMethod_Mall_GoodsList] || [ApiName isEqualToString:self.param_ApiURL]) {
        b_isRefreshPage = NO;
    }
}


#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrProductList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightForCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * IdentifierCell = @"ProductListCell";
    
    TableCell_MallProductList1 *cell = (TableCell_MallProductList1*)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    if ( !cell ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_Common" owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[TableCell_MallProductList1 class]]) {
                cell = (TableCell_MallProductList1 *)oneObject;
                [cell.lbl_cellSpaceLine setFrame:CGRectMake(0, heightForCell-0.5, __MainScreen_Width, 0.5)];
            }
        }
    }
    
    if (arrProductList.count>0) {
        resMod_Mall_GoodsInfo * goodinfo = arrProductList[indexPath.row];
        [cell.mallProductImg sd_setImageWithURL:[NSURL URLWithString:goodinfo.GoodsImg]
                               placeholderImage:[UIImage imageNamed:@"placeHold_75x75.png"]];
        [cell.lbl_mallTitle setText:goodinfo.GoodsTitle];
        [cell.lbl_mallPrice setText:[self convertPrice:goodinfo.GoodsPrice]];
        [cell.lbl_mallMarketPrice setText:[self convertPrice:goodinfo.GoodsOriPrice]];
        if ([self.param_OrderType isEqualToString:@"4"]) {
            [cell.lbl_mallSoldNum setText:[NSString stringWithFormat:@"评价 %d", goodinfo.GoodsCommentNum]];
        }
        else{
            [cell.lbl_mallSoldNum setText:[NSString stringWithFormat:@"已售 %d", goodinfo.GoodsSaledNum]];
        }
        
        [cell setTitleFrame:cell.lbl_mallTitle.text];
        
        //  -- 活动标签 ：1满减 2折扣 3满减+折扣 4包邮 5赠品 6团购 7代发货 8满赠 9多买优惠 10折扣价
        [cell setActivityTag:goodinfo.GoodsActionList colorAndNames:dicActivityColor];
    }

    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString * PID = [NSString stringWithFormat:@"%d",[arrProductList[indexPath.row] GoodsId]];
    [self pushNewViewController:@"MallProductDetailController" isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:PID,@"paramGoodsID", nil]];

    [self ShowOrHiddenCategoryForFilter:NO];
}


#pragma mark - textfiled delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self ShowOrHiddenCategoryForFilter:NO];
    UIButton * btnresponse = [[UIButton alloc] initWithFrame:CGRectMake(0,0,__MainScreen_Width,__ContentHeight_noNavTab)];
    [btnresponse setBackgroundColor:[UIColor clearColor]];
    [btnresponse addTarget:self action:@selector(onEndEditing:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnresponse];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self onSearchClick:nil];
    
    return YES;
}
- (void)onEndEditing:(id)sender{
    UIButton * btntmp = (UIButton*)sender;
    [btntmp removeFromSuperview];
    [searchText resignFirstResponder];
}
#pragma mark    --  scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [rootTableView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
  //  [self ShowOrHiddenCategoryForFilter:NO];

    NSInteger returnKey = [rootTableView tableViewDidDragging];
    if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新

        b_isRefreshPage = YES;
        [rootTableView tableViewIsRefreshing];
        
        if (self.param_ApiURL.length>0) {
//            [self ApiRequestWithURL:self.param_ApiURL class:@"resMod_CallBackMall_GoodsList" hudShow:@"正在加载"];
            [[APIMethodHandle shareAPIMethodHandle]goApiRequestWithURL:self.param_ApiURL ModelClass:@"resMod_CallBackMall_GoodsList" hudContent:@"正在加载" delegate:self];
        }
        else{
            [self goApiRequestProductList:YES hudshow:@""];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger returnKey = [rootTableView tableViewDidEndDragging];
    if (returnKey == k_RETURN_LOADMORE){    // 上拉加载更多
        [self goApiRequestProductList:NO hudshow:@""];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
