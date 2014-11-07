//
//  NearbyViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-4-30.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "NearbyViewController.h"
#import "TableCell_Common.h"
#import "resMod_TicketInfo.h"

#define apiRowNum   @"8"
#define heightTopFilter 38
#define heightForCell   102
#define heightCellSpace 6
#define topSwitchKey_1     @"附近的服务"
#define topSwitchKey_2     @"附近的商户"

@implementation NearbyViewController
@synthesize searchKeyWords;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        b_isFirstSwitch = YES;
        m_ServiceList = [[NSMutableArray alloc] init];
        m_MerchantList= [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Hidden:self.tabBarController];
}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [filterView OpenOrCloseFilter:NO];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@""];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.searchKeyWords = [self.receivedParams objectForKey:@"params_keyword"];

   // [self loadNavBarView];
    
    [self initData_TitleFilter];
    
   // [self initTitleSegmentedView];
  
    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0,heightTopFilter+kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight- kNavBarViewHeight -heightTopFilter) style:UITableViewStylePlain];
    [rootTableView setTag:2000];
    rootTableView.backgroundColor = color_bodyededed;
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:rootTableView];
    [self.view sendSubviewToBack:rootTableView];
    
    [self LoadData_SegmentedAndFilterView:topSwitchKey_2];
    [self LoadAndRefreshData];
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    

    segtitleView = [[EC_SegmentedView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2-80, 4, 160, 36)
                                                 btntitle1:topSwitchKey_1 btn1Img:@""
                                                 btntitle2:topSwitchKey_2 btn2Img:@""
                                                 img1Press:@"" img2press:@""];
    [segtitleView setSegmentDelegate:self];
    [self.subNavBarView addSubview:segtitleView];
    btn_navMap = [[UIButton alloc] initWithFrame:CGRectMake(275, 2, 40, 40)];
    [btn_navMap setBackgroundColor:[UIColor clearColor]];
    [btn_navMap setImage:[UIImage imageNamed:@"nearby_btn.png"] forState:UIControlStateNormal];
    [btn_navMap addTarget:self action:@selector(onNearMapClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:btn_navMap];
 //   [self.navBarView addSubview:bgView];
}


- (void) LoadAndRefreshData{
    if (smCurrentType==SMOperation_Service) {
        [m_ServiceList removeAllObjects];
    }
    else{
        [m_MerchantList removeAllObjects];
    }
    
    //  --列表
    [self goApiRequest:@""];
}

//  -- 初始化 : 头部&筛选区
- (void) LoadData_SegmentedAndFilterView:(NSString *) swithType{
    
    smCurrentType = [swithType isEqualToString:topSwitchKey_1] ? SMOperation_Service : SMOperation_Merchant;
    [segtitleView setButtonIndex: smCurrentType == SMOperation_Merchant ? 1 : 0];
    [self addTopFilterView:swithType];
    [self apiRequestFilterData];
}

//  -- 初始化 : 顶部和筛选 用到的数据
- (void) initData_TitleFilter{
    NSArray * services = [[NSArray alloc] initWithObjects:filterKey_all,filterKey_near, nil];
    NSArray * merchants = [[NSArray alloc] initWithObjects:filterKey_MerchantCategory,filterKey_merchantOrderType, nil];
    
    topSwithFilters = [[NSMutableDictionary alloc] initWithCapacity:2];
    [topSwithFilters setObject:services forKey: topSwitchKey_1];
    [topSwithFilters setObject:merchants forKey: topSwitchKey_2];
    
    dicFilterData = [[NSMutableDictionary alloc] initWithCapacity:5];
    dicFilterResult = [[NSMutableDictionary alloc] initWithCapacity:2];
}

#pragma mark    --  load ui
- (void)initTitleSegmentedView {
    segtitleView = [[EC_SegmentedView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2-80, 4, 180, 36)
                                                 btntitle1:topSwitchKey_1 btn1Img:@""
                                                 btntitle2:topSwitchKey_2 btn2Img:@""
                                                 img1Press:@"" img2press:@""];
    [segtitleView setSegmentDelegate:self];
    self.navigationItem.titleView = segtitleView;
    
    /**********          地图        ***********/
    btn_navMap = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn_navMap setBackgroundColor:[UIColor clearColor]];
    [btn_navMap setImage:[UIImage imageNamed:@"nearby_btn.png"] forState:UIControlStateNormal];
    [btn_navMap addTarget:self action:@selector(onNearMapClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:btn_navMap];
    self.navigationItem.rightBarButtonItem = r_bar;
    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
}


#pragma mark    --  加载 筛选 条件 数据
- (void) apiRequestFilterData{
    
    //-- 初始化固定数据.
    [self setFilterData];
    
    //-- 初始化非固定数据.
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_GetSortType class:@"resMod_CallBack_FilterCategory"
//              params:nil  isShowLoadingAnimal:NO hudShow:@"正在加载"];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_GetAreaType class:@"resMod_CallBack_FilterCategory"
//              params:nil  isShowLoadingAnimal:NO hudShow:@"正在加载"];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_GetMerchantSortType class:@"resMod_CallBack_FilterCategory"
//              params:nil  isShowLoadingAnimal:NO hudShow:@"正在加载"];
    
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetSortType:nil ModelClass:@"resMod_CallBack_FilterCategory" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetAreaType:nil ModelClass:@"resMod_CallBack_FilterCategory" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMerchantSortType:nil ModelClass:@"resMod_CallBack_FilterCategory" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
    
}

#pragma mark    --  switch 切 换  : 服务或商户
- (void)onSegmentedClick:(int) selectIndex {
    
    [rootTableView setContentOffset:CGPointMake(0, 0)];
    
    //  -- 每次切换时都先置空，因为用的是一个，不置空就有问题.
    [filterView.dic_SelectValue removeAllObjects];
    
    if (selectIndex == 0) {
        [MobClick event:@"near_nearSrv"];
        smCurrentType = SMOperation_Service;
        [self.noDataView setHidden: b_isFirstSwitch ? YES : (m_ServiceList.count==0 ? NO:YES)];
        [rootTableView reloadData:NO allDataCount:m_ServiceList.count];
        
        // --  第一次切换 需请求.
        if (b_isFirstSwitch) {
            self.lodingAnimationView.hasDisplayed = NO;
            [self goApiRequest:@""];
            b_isFirstSwitch = NO;
        }
        
        //  -- 切换的时候带上以前筛选条件.
        if ([dicFilterResult objectForKey:topSwitchKey_1]) {
            filterView.dic_SelectValue = [[dicFilterResult objectForKey:topSwitchKey_1] mutableCopy];
        }
        [filterView setArrFilterTitle: [topSwithFilters objectForKey: topSwitchKey_1]];
    }
    else if (selectIndex == 1) {
        [MobClick event:@"near_nearMerchant"];
        
        smCurrentType = SMOperation_Merchant;
        [self.noDataView setHidden: b_isFirstSwitch ? YES : (m_MerchantList.count==0 ? NO:YES)];
        [rootTableView reloadData:NO allDataCount:m_MerchantList.count];
        
        // --  第一次切换 需请求.
        if (b_isFirstSwitch) {
            self.lodingAnimationView.hasDisplayed = NO;
            [self goApiRequest:@""];
            b_isFirstSwitch = NO;
        }
        
        //  -- 切换的时候带上以前筛选条件.
        if ([dicFilterResult objectForKey:topSwitchKey_2]) {
            filterView.dic_SelectValue = [[dicFilterResult objectForKey:topSwitchKey_2] mutableCopy];
        }
        [filterView setArrFilterTitle: [topSwithFilters objectForKey: topSwitchKey_2]];
    }
}


#pragma mark    --  DropDownFilterView & delegate
//  --  上面筛选区
- (void) addTopFilterView:(NSString*) skey{
    
    if (filterView) {
        [filterView removeFromSuperview];
    }
    filterView= [[DropDownFilterView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, heightTopFilter)
                                              addViewRef:self.view
                                            filterHeight:heightTopFilter
                                             filterTitle:[topSwithFilters objectForKey:skey]
                                               dicSelect:nil];
    [filterView setFilterDelegate:self];
}


- (void) onFilterButtonForDelegateClick:(NSString *) filterKey{
    
    DDFilterType tmpType = SimpleFilter;
    if ([filterKey isEqualToString:filterKey_all]
        || [filterKey isEqualToString:filterKey_area]) {
        tmpType = ComplexFilter;
    }
    int datasourceCount = smCurrentType==SMOperation_Service ? m_ServiceList.count :m_MerchantList.count;
    [rootTableView reloadData:NO allDataCount:datasourceCount];
    [filterView loadFilterDataSoure:filterKey tableSouce:[dicFilterData objectForKey:filterKey] FilterType:tmpType];
    
    
    //  -- umeng统计
    NSString * umengEventID;
    if ([filterKey isEqualToString:filterKey_all])          umengEventID = @"near_nearSrv_Classification";
    if ([filterKey isEqualToString:filterKey_near])         umengEventID = @"near_nearSrv_sort";
    if ([filterKey isEqualToString:filterKey_MerchantCategory])  umengEventID = @"near_nearMerchant_Classification";
    if ([filterKey isEqualToString:filterKey_merchantOrderType]) umengEventID = @"near_nearMerchant_sort";
    [MobClick event:umengEventID];
}

- (void) onDelegateForSearch{
    
    //-- 每次记住上次筛选条件
    if (smCurrentType == SMOperation_Service) {
        
        //-- 每次筛选清 0
        [m_ServiceList removeAllObjects];
        
        //-- 更新筛选条件
        [dicFilterResult setObject:[filterView.dic_SelectValue mutableCopy] forKey:topSwitchKey_1];
    }
    else{
        //-- 每次筛选清 0
        [m_MerchantList removeAllObjects];
        
        //-- 更新筛选条件
        [dicFilterResult setObject:[filterView.dic_SelectValue mutableCopy] forKey:topSwitchKey_2];
    }
    
    [self goApiRequest:@"正在加载"];
}

- (void) setFilterData{
    resMod_CategoryList * catmp;
    [dicFilterData removeAllObjects];
    
    //  --  离我最近.
    NSMutableArray * tmpArrFilter1 = [[NSMutableArray alloc] init];
    NSArray * arrNear = [filterValue_near componentsSeparatedByString:@"|"];
    for (NSString * ss in arrNear) {
        NSArray * aInfo = [ss componentsSeparatedByString:@":"];
        catmp= [[resMod_CategoryList alloc]init];
        catmp.TypeName = aInfo[0];
        catmp.CategoryId = aInfo[1];
        [tmpArrFilter1 addObject:catmp];
    }
    [dicFilterData setObject:tmpArrFilter1 forKey:filterKey_near];
    
    //  --  排序.
    NSMutableArray * tmpArrFilter2 = [[NSMutableArray alloc] init];
    NSArray * arrSort = [filterValue_merchantOrderType componentsSeparatedByString:@"|"];
    for (NSString * ss in arrSort) {
        NSArray * aInfo = [ss componentsSeparatedByString:@":"];
        catmp= [[resMod_CategoryList alloc]init];
        catmp.TypeName = aInfo[0];
        catmp.CategoryId = aInfo[1];
        catmp.isSelect_parent = [catmp.TypeName isEqualToString:@"离我最近"] ? YES : NO;
        
        if (![catmp.TypeName isEqualToString:@"默认排序"]) {
            [tmpArrFilter2 addObject:catmp];
        }
    }
    [dicFilterData setObject:tmpArrFilter2 forKey:filterKey_merchantOrderType];
}

#pragma mark    --  click 事件区
- (void)onNearMapClick:(id)sener{
    
    [MobClick event:@"lifeNear_nearMap"];

    NSMutableArray * arrmerchants = [[NSMutableArray alloc] initWithCapacity:0];
    if (smCurrentType == SMOperation_Service) {
        for (resMod_TicketInfo * tickinfo in m_ServiceList) {
            [arrmerchants addObject: tickinfo.MerchantInfo];
        }
    }
    else{
        arrmerchants = m_MerchantList;
    }
    [self pushNewViewController:@"NearMapViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                 arrmerchants,@"param_merchants",
                                 @"0",@"param_fromMerchant",nil]];
}


#pragma mark    --  api 请 求 : 回 调
//-- 开始请求操作
- (void) goApiRequest:(NSString*) _hudshow{
    
    if (smCurrentType == SMOperation_Service) {
        NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
        if (_lon!=-10000000.00 && _lat !=-10000000.00) {
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lat] forKey:@"Lat"];
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lon] forKey:@"Lng"];
        }
        int startIndex = b_isPushRefresh?0:m_ServiceList.count;
        [dicParams setValue:[NSString stringWithFormat:@"%d",startIndex] forKey:@"StartIndex"];
        [dicParams setValue:apiRowNum forKey:@"Number"];
        
        //  -- 取筛选出来的条件.
        NSMutableDictionary * tmpWhere = [dicFilterResult objectForKey:topSwitchKey_1];
        if ([tmpWhere objectForKey:filterKey_all]) {
            [dicParams setValue:[[tmpWhere objectForKey:filterKey_all] subTableId] forKey:@"SortTypeId"];
        }
        if ([tmpWhere objectForKey:filterKey_near]) {
            [dicParams setValue:[[tmpWhere objectForKey:filterKey_near] parentTableId] forKey:@"OrderTypeId"];
        }
        
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestSearchTicketList:dicParams ModelClass:@"resMod_CallBack_TicketList" showLoadingAnimal:YES hudContent:_hudshow delegate:self];
        
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_TicketList class:@"resMod_CallBack_TicketList"
//                  params:dicParams isShowLoadingAnimal:YES hudShow:_hudshow];
    }
    else if(smCurrentType == SMOperation_Merchant){
        NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
        if (_lon!=-10000000.00 && _lat !=-10000000.00) {
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lat] forKey:@"Lat"];
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lon] forKey:@"Lng"];
        }
        int startIndex = b_isPushRefresh?0:m_MerchantList.count;
        [dicParams setValue:[NSString stringWithFormat:@"%d",startIndex] forKey:@"StartIndex"];
        [dicParams setValue:apiRowNum forKey:@"Number"];
        [dicParams setValue:@"2" forKey:@"OrderTypeId"];
        
        //  -- 取筛选出来的条件.
        NSMutableDictionary * tmpWhere = [dicFilterResult objectForKey:topSwitchKey_2];
        if ([tmpWhere objectForKey:filterKey_MerchantCategory]) {
            [dicParams setValue:[[tmpWhere objectForKey:filterKey_MerchantCategory] parentTableId] forKey:@"SortTypeId"];
        }
        if ([tmpWhere objectForKey:filterKey_merchantOrderType]) {
            [dicParams setValue:[[tmpWhere objectForKey:filterKey_merchantOrderType] parentTableId] forKey:@"OrderTypeId"];
        }
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestSearchMerchantList:dicParams ModelClass:@"resMod_CallBack_MerchantList" showLoadingAnimal:YES hudContent:_hudshow delegate:self];
        
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_MerchantList class:@"resMod_CallBack_MerchantList"
//                  params:dicParams isShowLoadingAnimal:YES hudShow:_hudshow];
    }
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_GetSortType]) {
        resMod_CallBack_FilterCategory * backObj = [[resMod_CallBack_FilterCategory alloc] initWithDic:retObj];
        
        //  --第一次选中默认
        if (backObj.ResponseData.count>0) {
            resMod_CategoryList * tmpList = (resMod_CategoryList*)backObj.ResponseData[0];
            tmpList.isSelect_parent = YES;
            if (tmpList.TypeList.count>0) {
                resMod_CategoryInfo * tmpInfo = (resMod_CategoryInfo*)tmpList.TypeList[0];
                tmpInfo.isChecked = YES;
            }
        }
        
        [dicFilterData setObject:backObj.ResponseData forKey:filterKey_all];
    }
    
    else if([ApiName isEqualToString:kApiMethod_GetAreaType]){
        resMod_CallBack_FilterCategory * backObj = [[resMod_CallBack_FilterCategory alloc] initWithDic:retObj];
        [dicFilterData setObject:backObj.ResponseData forKey:filterKey_area];
    }
    
    else if([ApiName isEqualToString:kApiMethod_GetMerchantSortType]){
        resMod_CallBack_FilterCategory * backObj = [[resMod_CallBack_FilterCategory alloc] initWithDic:retObj];
        
        //  --第一次选中默认
        if (backObj.ResponseData.count>0) {
            resMod_CategoryList * tmpList = (resMod_CategoryList*)backObj.ResponseData[0];
            tmpList.isSelect_parent = YES;
        }
        
        [dicFilterData setObject:backObj.ResponseData forKey:filterKey_MerchantCategory];
    }
    
    else if([ApiName isEqualToString:kApiMethod_TicketList]){
        resMod_CallBack_TicketList * backObj = [[resMod_CallBack_TicketList alloc] initWithDic:retObj];
        if (b_isPushRefresh) {
            b_isPushRefresh = NO;
            [m_ServiceList removeAllObjects];
        }
        [m_ServiceList addObjectsFromArray:backObj.ResponseData];
        
        int icount = backObj.ResponseData.count;
        [rootTableView reloadData: (icount==0 || icount <[apiRowNum intValue]) ? YES:NO allDataCount:m_ServiceList.count];
        [self.noDataView noDataViewIsHidden:m_ServiceList.count==0 ? NO :YES warnImg:@"" warnMsg:@"抱歉，没有找到相关服务券"];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
    else if([ApiName isEqualToString:kApiMethod_MerchantList]){
        resMod_CallBack_MerchantList * backObj = [[resMod_CallBack_MerchantList alloc] initWithDic:retObj];
        if (b_isPushRefresh) {
            b_isPushRefresh = NO;
            [m_MerchantList removeAllObjects];
        }
        [m_MerchantList addObjectsFromArray: backObj.ResponseData];
        
        int icount = backObj.ResponseData.count;
        [rootTableView reloadData: (icount==0 || icount <[apiRowNum intValue]) ? YES:NO allDataCount:m_MerchantList.count];
        [self.noDataView noDataViewIsHidden:m_MerchantList.count==0 ? NO :YES warnImg:@"" warnMsg:@"抱歉，没有找到相关商户"];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
}


#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger irownum=0;
    if (smCurrentType==SMOperation_Service) {
        irownum = m_ServiceList.count;
    }
    else{
        irownum = m_MerchantList.count;
    }
    
    return irownum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightForCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * lbl_HeadView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 10)];
    [lbl_HeadView setBackgroundColor:color_body];
    return lbl_HeadView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * Identifier1 = @"ServiceCell";
    NSString * Identifier2 = @"MerchantCell";
    
    int irow = indexPath.row;
    if (smCurrentType == SMOperation_Service) {
        TableCell_Common1 * cell = (TableCell_Common1*)[tableView dequeueReusableCellWithIdentifier:Identifier1];
        if ( !cell ) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_Common" owner:self options:nil];
            for(id oneObject in nib) {
                if([oneObject isKindOfClass:[TableCell_Common1 class]]) {
                    cell = (TableCell_Common1 *)oneObject;
                    
                    [UICommon Common_line:CGRectMake(0,heightForCell-2, __MainScreen_Width,0.5) targetView:cell.contentView backColor:color_d1d1d1];
                }
            }
        }
        if (m_ServiceList.count>0) {
            resMod_TicketInfo * tmpTicketinfo= m_ServiceList[irow];
            
            [cell.lbl_title setText:tmpTicketinfo.TicketTitle];
            [cell setTitleFrame:tmpTicketinfo.TicketTitle];
            
            NSString * proimgUrl = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:tmpTicketinfo.TicketImg];
            [cell.ProductImg sd_setImageWithURL:[NSURL URLWithString:proimgUrl]
                               placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
            [cell.lbl_salePrice setText:[self convertPrice:tmpTicketinfo.TicketPrice]];
            [cell.lbl_marketPrice setText:[self convertPrice:tmpTicketinfo.TicketOriPrice]];
            
//            resMod_MerchantInfo * merchantInfo = tmpTicketinfo.MerchantInfo;
//            CLLocation *merLoc = [[CLLocation alloc] initWithLatitude:merchantInfo.MerchantLat.doubleValue longitude:merchantInfo.MerchantLng.doubleValue];
//            CLLocation *nowLoc = [[CLLocation alloc] initWithLatitude:_lat longitude:_lon];
//            CLLocationDistance Distance = [merLoc distanceFromLocation:nowLoc];
            
            [cell.lbl_awayFrom setText:[self convertDistance:tmpTicketinfo.Distance]];
            [cell.lbl_roadName setText:tmpTicketinfo.BusinessArea];
            
            CGSize tSize = [[self convertPrice:tmpTicketinfo.TicketOriPrice] sizeWithFont:defFont12 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            [cell.lbl_delLine setFrame:CGRectMake(cell.lbl_marketPrice.frame.origin.x-1, cell.lbl_marketPrice.frame.origin.y+10, tSize.width+3, 1)];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        TableCell_Common2 * cell = (TableCell_Common2*)[tableView dequeueReusableCellWithIdentifier:Identifier2];
        if ( !cell ) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_Common" owner:self options:nil];
            for(id oneObject in nib) {
                if([oneObject isKindOfClass:[TableCell_Common2 class]]) {
                    cell = (TableCell_Common2 *)oneObject;
                    
                    [UICommon Common_line:CGRectMake(0,heightForCell-2, __MainScreen_Width,0.5) targetView:cell.contentView backColor:color_d1d1d1];
                }
            }
        }
        if (m_MerchantList.count>0) {
            resMod_MerchantInfo * tmpMerchantinfo = m_MerchantList[irow];
            NSString * proimgUrl = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:tmpMerchantinfo.MerchantImg];
            [cell.ProductImg sd_setImageWithURL:[NSURL URLWithString:proimgUrl]
                               placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
            [cell.lbl_title     setText:tmpMerchantinfo.MerchantTitle];
            [cell.lbl_viewTimes setText:[NSString stringWithFormat:@"浏览%d次",tmpMerchantinfo.ScanNumbers]];
            [cell.lbl_perPrice  setText:[self convertPrice:tmpMerchantinfo.AverageComsume]];
            [cell.lbl_roadName  setText:tmpMerchantinfo.BusinessArea];
            [cell.lbl_awayFrom  setText:[self convertDistance:[tmpMerchantinfo.Distance floatValue]]];
            [cell setIconFrame_QuanYi:tmpMerchantinfo.MerchantTitle Characteristic:tmpMerchantinfo.Characteristic];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int iRow = indexPath.row;
    if (smCurrentType ==SMOperation_Service) {
        
        resMod_TicketInfo * tmpTicketinfo= m_ServiceList[iRow];
        NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys
                                        :[NSString stringWithFormat:@"%d",tmpTicketinfo.TicketId],@"param_TicketId", nil];
        [self pushNewViewController:@"ServiceDetailViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:params];
    }
    else{
        
        resMod_MerchantInfo * tmpMerchantinfo= m_MerchantList[iRow];
        NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys
                                        :[NSString stringWithFormat:@"%d",tmpMerchantinfo.MerchantId],@"param_MerchantId", nil];
        [self pushNewViewController:@"MerchantDetailViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:params];
    }
}



#pragma mark    --  scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [rootTableView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [rootTableView tableViewDidDragging];
    if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
//        if (smCurrentType == SMOperation_Service) {
//            [m_ServiceList removeAllObjects];
//        }
//        if(smCurrentType == SMOperation_Merchant) {
//            [m_MerchantList removeAllObjects];
//        }
        b_isPushRefresh = YES;
        [rootTableView tableViewIsRefreshing];
        [self goApiRequest:@""];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger returnKey = [rootTableView tableViewDidEndDragging];
    if (returnKey == k_RETURN_LOADMORE){    // 上拉加载更多
        [self goApiRequest:@""];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
