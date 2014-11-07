//
//  SMHomeListViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-6.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "SMHomeListViewController.h"
#import "TableCell_Common.h"
#import "resMod_TicketInfo.h"

#define apiRowNum   @"8"
#define heightTopFilter 38
#define heightForCell   102
#define heightCellSpace 6
#define topSwitchKey_1     @"服务"
#define topSwitchKey_2     @"商户"


@implementation SMHomeListViewController
@synthesize searchKeyWords;
@synthesize param_serviceSortTypeId,param_typename;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Hidden:self.tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@""];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self loadView_UI];
    
    //  初始化基本数据
    b_isFirstSwitch = YES;
    smCurrentType = SMOperation_Service;
    m_ServiceList = [[NSMutableArray alloc] init];
    m_MerchantList= [[NSMutableArray alloc] init];

    //  --筛选条件
    [self apiRequestFilterData];
    
    //  --列表
    [self goApiRequest:@""];
}

- (void)loadNavBarView
{

    [super loadNavBarView];
    segtitleView = [[EC_SegmentedView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2-80, 4, 160, 36)
                                                 btntitle1:topSwitchKey_1 btn1Img:@"icon_service_press"
                                                 btntitle2:topSwitchKey_2 btn2Img:@"icon_merchant_press"
                                                 img1Press:@"icon_service_nomal" img2press:@"icon_merchant_nomal"];
    [segtitleView setSegmentDelegate:self];
    [self.subNavBarView addSubview:segtitleView];
    UIButton *btn_navMap = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_navMap setFrame:CGRectMake(275, 2, 40, 40)];
    [btn_navMap setImage:[UIImage imageNamed:@"nearby_btn.png"] forState:UIControlStateNormal];
    [btn_navMap addTarget:self action:@selector(onNearMapClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:btn_navMap];
}


//  -- ....
- (void) loadView_UI{
    self.searchKeyWords = [self.receivedParams objectForKey:@"params_keyword"];
    self.param_serviceSortTypeId = [self.receivedParams objectForKey:@"params_sorttypeid"];
    self.param_typename = [self.receivedParams objectForKey:@"params_typename"];
   // [self loadNavBarView];
  //  [self addTitleView];
    [self initFilterTitle];
    [self addTopFilterView];
    
    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0,heightTopFilter+kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight - heightTopFilter - kNavBarViewHeight) style:UITableViewStylePlain];
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
}

//  -- 顶部开关
- (void) initFilterTitle{
    
    NSArray * services = [[NSArray alloc] initWithObjects:filterKey_all,filterKey_areaservice,filterKey_near, nil];
    NSArray * merchants =[[NSArray alloc] initWithObjects:filterKey_MerchantCategory,filterKey_area,filterKey_merchantOrderType, nil];

    topSwithFilters = [[NSMutableDictionary alloc] initWithCapacity:2];
    [topSwithFilters setObject:services forKey: topSwitchKey_1];
    [topSwithFilters setObject:merchants forKey: topSwitchKey_2];
    
    dicFilterData = [[NSMutableDictionary alloc] initWithCapacity:5];
    dicFilterResult = [[NSMutableDictionary alloc] initWithCapacity:2];
}

#pragma mark    --  load ui
- (void)addTitleView {
    segtitleView = [[EC_SegmentedView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2-80, 4, 180, 36)
                                                 btntitle1:topSwitchKey_1 btn1Img:@"icon_service_press"
                                                 btntitle2:topSwitchKey_2 btn2Img:@"icon_merchant_press"
                                                 img1Press:@"icon_service_nomal" img2press:@"icon_merchant_nomal"];
    [segtitleView setSegmentDelegate:self];
    self.navigationItem.titleView = segtitleView;
    
    /**********          地图        ***********/
    UIButton * btn_navMap = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn_navMap setBackgroundColor:[UIColor clearColor]];
    [btn_navMap setImage:[UIImage imageNamed:@"nearby_btn.png"] forState:UIControlStateNormal];
    [btn_navMap addTarget:self action:@selector(onNearMapClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:btn_navMap];
    self.navigationItem.rightBarButtonItem = r_bar;
    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
}

//  -- 附近
- (void)onNearMapClick:(id) sender{
    
    [MobClick event:@"near_nearMap"];
    NSMutableArray * arrmerchants = [[NSMutableArray alloc] initWithCapacity:0];
    if (smCurrentType == SMOperation_Service) {
        [MobClick event:@"serviceList_map"];
        
        for (resMod_TicketInfo * tickinfo in m_ServiceList) {
            [arrmerchants addObject: tickinfo.MerchantInfo];
        }
    }
    else{
        [MobClick event:@"merchantList_map"];
        arrmerchants = m_MerchantList;
    }
    
    [self pushNewViewController:@"NearMapViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                 arrmerchants,@"param_merchants",
                                 @"0",@"param_fromMerchant",nil]];
}


#pragma mark    --  加载 筛选 条件 数据
- (void) apiRequestFilterData{

    //--初始化固定数据.
    [self setFilterData];

    //-- 初始化非固定.
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_GetSortType class:@"resMod_CallBack_FilterCategory"
//              params:nil isShowLoadingAnimal:NO  hudShow:@""];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_GetAreaType class:@"resMod_CallBack_FilterCategory"
//              params:nil isShowLoadingAnimal:NO  hudShow:@""];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_GetMerchantSortType class:@"resMod_CallBack_FilterCategory"
//              params:nil isShowLoadingAnimal:NO  hudShow:@""];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetSortType:nil ModelClass:@"resMod_CallBack_FilterCategory" showLoadingAnimal:NO hudContent:@"" delegate:self];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetAreaType:nil ModelClass:@"resMod_CallBack_FilterCategory" showLoadingAnimal:NO hudContent:@"" delegate:self];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMerchantSortType:nil ModelClass:@"resMod_CallBack_FilterCategory" showLoadingAnimal:NO hudContent:@"" delegate:self];
}

#pragma mark    --  switch 切 换  : 服务或商户
- (void)onSegmentedClick:(int) selectIndex {
    
    [rootTableView setContentOffset:CGPointMake(0, 0)];

    //  -- 每次切换时都先置空，因为用的是一个，不置空就有问题.
    [filterView.dic_SelectValue removeAllObjects];
    
    if (selectIndex == 0) {                       [MobClick event:@"lifeList_srv"];
        //  -- .......
        smCurrentType = SMOperation_Service;
        [self.noDataView setHidden:m_ServiceList.count==0?NO:YES];
        [rootTableView reloadData:NO allDataCount:m_ServiceList.count];
        
        //  -- 切换的时候带上以前筛选条件
        if ([dicFilterResult objectForKey:topSwitchKey_1]) {
            filterView.dic_SelectValue = [[dicFilterResult objectForKey:topSwitchKey_1] mutableCopy];
        }
        [filterView setArrFilterTitle: [topSwithFilters objectForKey: topSwitchKey_1]];
    }
    else if (selectIndex == 1) {                  [MobClick event:@"lifeList_merchant"];
        //  -- .......
        smCurrentType = SMOperation_Merchant;
        [self.noDataView setHidden: b_isFirstSwitch ? YES:(m_MerchantList.count==0?NO:YES)];
        [rootTableView reloadData:NO allDataCount:m_MerchantList.count];
        
        if (b_isFirstSwitch) {      // --  第一次切换请求
            self.lodingAnimationView.hasDisplayed = NO;
            [self goApiRequest:@""];
            b_isFirstSwitch = NO;
        }
        
        //  -- 切换的时候带上以前筛选条件
        if ([dicFilterResult objectForKey:topSwitchKey_2]) {
            filterView.dic_SelectValue = [[dicFilterResult objectForKey:topSwitchKey_2] mutableCopy];
        }
        
        [filterView setArrFilterTitle: [topSwithFilters objectForKey: topSwitchKey_2]];
    }
}

#pragma mark    --  DropDownFilterView & delegate
//  --  上面筛选区
- (void) addTopFilterView{
    
    resMod_filterWhere * initFilterWhere = [[resMod_filterWhere alloc] init];
    initFilterWhere.parentTableId = self.param_serviceSortTypeId;
    initFilterWhere.parentTableValue = self.param_typename;
    initFilterWhere.subTableId  = self.param_serviceSortTypeId;;
    
    [dicFilterResult setObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:initFilterWhere,filterKey_all, nil]
                        forKey:topSwitchKey_1];
    
    filterView= [[DropDownFilterView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, heightTopFilter)
                                              addViewRef:self.view
                                            filterHeight:heightTopFilter
                                             filterTitle:[topSwithFilters objectForKey:topSwitchKey_1]
                                               dicSelect:[dicFilterResult objectForKey:topSwitchKey_1]];
    [filterView setFilterDelegate:self];
}

- (void) onFilterButtonForDelegateClick:(NSString *) filterKey{

    DDFilterType tmpType = SimpleFilter;
    if ([filterKey isEqualToString:filterKey_all]
        || [filterKey isEqualToString:filterKey_areaservice]
        || [filterKey isEqualToString:filterKey_area]) {
        tmpType = ComplexFilter;
    }
    
    int datasourceCount = smCurrentType==SMOperation_Service ? m_ServiceList.count :m_MerchantList.count;
    [rootTableView reloadData:NO allDataCount:datasourceCount];
    [filterView loadFilterDataSoure:filterKey tableSouce:[dicFilterData objectForKey:filterKey] FilterType:tmpType];
    
    //  -- umeng统计
    NSString * umengEventID;
    if ([filterKey isEqualToString:filterKey_all])          umengEventID = @"serviceList_Classification";
    if ([filterKey isEqualToString:filterKey_near])         umengEventID = @"serviceList_sort";
    if ([filterKey isEqualToString:filterKey_areaservice])       umengEventID = @"serviceList_area";
    if ([filterKey isEqualToString:filterKey_MerchantCategory])  umengEventID = @"merchantList_classification";
    if ([filterKey isEqualToString:filterKey_area])              umengEventID = @"merchantList_area";
    if ([filterKey isEqualToString:filterKey_merchantOrderType]) umengEventID = @"merchantList_sort";
    [MobClick event:umengEventID];
}

- (void) onDelegateForSearch{
    
    //-- 每次记住上次筛选条件
    if (smCurrentType == SMOperation_Service) {
        
        //-- 每次筛选清 0
        [m_ServiceList removeAllObjects];
        
        //-- 更新筛选条件
        [dicFilterResult setObject:[filterView.dic_SelectValue mutableCopy] forKey:topSwitchKey_1];
        
        
        resMod_filterWhere *filter = [filterView.dic_SelectValue objectForKey:@"离我最近"];
        if ([filter.parentTableValue isEqualToString:@"离我最近"])
        {
            [MobClick event:@"serviceList_sort_nearest"];
        }
        if ([filter.parentTableValue isEqualToString:@"价格最高"])
        {
             [MobClick event:@"serviceList_sort_lowPrice"];
        }
        if ([filter.parentTableValue isEqualToString:@"价格最低"])
        {
            [MobClick event:@"serviceList_sort_highPrice"];
        }
        if ([filter.parentTableValue isEqualToString:@"销量最好"])
        {
            [MobClick event:@"serviceList_sort_salesVolume"];
        }
    }
    else{
        //-- 每次筛选清 0
        [m_MerchantList removeAllObjects];
        
        resMod_filterWhere *filter = [filterView.dic_SelectValue objectForKey:@"默认排序"];
        
        if ([filter.parentTableValue isEqualToString:@"离我最近"])
        {
            [MobClick event:@"merchantList_sort_nearest"];
        }
        if ([filter.parentTableValue isEqualToString:@"认证商户"])
        {
            [MobClick event:@"merchantList_sort_authenticationMerchan"];
        }
        if ([filter.parentTableValue isEqualToString:@"平均消费由高到低"])
        {
            [MobClick event:@"merchantList_sort_averageConsumeHightolow"];
        }
        if ([filter.parentTableValue isEqualToString:@"平均消费由低到高"])
        {
            [MobClick event:@"merchantList_sort_averageConsumeLowtohigh"];
        }
        if ([filter.parentTableValue isEqualToString:@"人气由高到低"])
        {
            [MobClick event:@"merchantList_sort_popularityHightolow"];
        }
        
        //-- 更新筛选条件
        [dicFilterResult setObject:[filterView.dic_SelectValue mutableCopy] forKey:topSwitchKey_2];
    }
    
    [self goApiRequest:@"正在加载"];
}

- (void) setFilterData{
    resMod_CategoryList * catmp;
    
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
        [tmpArrFilter2 addObject:catmp];
    }
    [dicFilterData setObject:tmpArrFilter2 forKey:filterKey_merchantOrderType];
}

#pragma mark    --  api 请 求 : 回 调
//  -- 直接 api 请求
- (void) goApiRequest:(NSString *) _hudShow{
    
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    if(self.searchKeyWords.length>0){
        [dicParams setValue:self.searchKeyWords forKey:@"KeyWord"];
    }
    
    //  -- 是服务
    if (smCurrentType == SMOperation_Service) {
        if (_lon!=-10000000.00 && _lat !=-10000000.00) {
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lat] forKey:@"Lat"];
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lon] forKey:@"Lng"];
        }
        int startIndex = b_isPullRefresh?0:m_ServiceList.count;
        [dicParams setValue:[NSString stringWithFormat:@"%d",startIndex] forKey:@"StartIndex"];
        [dicParams setValue:apiRowNum forKey:@"Number"];
        [dicParams setValue:self.param_serviceSortTypeId forKey:@"SortTypeId"];
        
        //  -- 取筛选出来的条件.
        NSMutableDictionary * tmpWhere = [dicFilterResult objectForKey:topSwitchKey_1];
        if ([tmpWhere objectForKey:filterKey_all]) {
            [dicParams setValue:[[tmpWhere objectForKey:filterKey_all] subTableId] forKey:@"SortTypeId"];
        }
        if ([tmpWhere objectForKey:filterKey_near]) {
            [dicParams setValue:[[tmpWhere objectForKey:filterKey_near] parentTableId] forKey:@"OrderTypeId"];
        }
        if ([[tmpWhere objectForKey:filterKey_areaservice] subTableId].length>0) {
            
            [dicParams setValue:[[tmpWhere objectForKey:filterKey_areaservice] subTableId] forKey:@"AreaId"];
            
            //  -- 传AreaId必须传Type，否则忽略该字段
            NSString * stype = [[tmpWhere objectForKey:filterKey_areaservice] subTableProperty1];
            [dicParams setValue:stype.length==0 ? @"2" : stype forKey:@"Type"];
        }
//        //.........
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_TicketList class:@"resMod_CallBack_TicketList"
//                  params:dicParams  isShowLoadingAnimal:YES hudShow:_hudShow];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestSearchTicketList:dicParams ModelClass:@"resMod_CallBack_TicketList" showLoadingAnimal:YES hudContent:_hudShow delegate:self];
    }
    //  -- 是商户
    else if(smCurrentType == SMOperation_Merchant){
        if (_lon!=-10000000.00 && _lat !=-10000000.00) {
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lat] forKey:@"Lat"];
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lon] forKey:@"Lng"];
        }
        int startIndex = b_isPullRefresh?0:m_MerchantList.count;
        [dicParams setValue:[NSString stringWithFormat:@"%d",startIndex] forKey:@"StartIndex"];
        [dicParams setValue:apiRowNum forKey:@"Number"];

        //  -- 取筛选出来的条件.
        NSMutableDictionary * tmpWhere = [dicFilterResult objectForKey:topSwitchKey_2];
        if ([tmpWhere objectForKey:filterKey_MerchantCategory]) {
            [dicParams setValue:[[tmpWhere objectForKey:filterKey_MerchantCategory] parentTableId] forKey:@"SortTypeId"];
        }
        if ([tmpWhere objectForKey:filterKey_merchantOrderType]) {
            [dicParams setValue:[[tmpWhere objectForKey:filterKey_merchantOrderType] parentTableId] forKey:@"OrderTypeId"];
        }
        if ([[tmpWhere objectForKey:filterKey_area] subTableId].length>0) {

            [dicParams setValue:[[tmpWhere objectForKey:filterKey_area] subTableId] forKey:@"AreaId"];
            
            //  -- 传AreaId必须传Type，否则忽略该字段
            NSString * stype = [[tmpWhere objectForKey:filterKey_area] subTableProperty1];
            [dicParams setValue:stype.length==0 ? @"2" : stype forKey:@"Type"];
        }
        
//        //.........
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_MerchantList class:@"resMod_CallBack_MerchantList"
//                  params:dicParams isShowLoadingAnimal:YES hudShow:_hudShow];
    
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestSearchMerchantList:dicParams ModelClass:@"resMod_CallBack_MerchantList" showLoadingAnimal:YES hudContent:_hudShow delegate:self];
    }
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_GetSortType]) {
        resMod_CallBack_FilterCategory * backObj = [[resMod_CallBack_FilterCategory alloc] initWithDic:retObj];
        
        //  --第一次选中默认
        if (backObj.ResponseData!=nil && backObj.ResponseData.count>0) {

            BOOL hasSetDefault = NO;
            for (resMod_CategoryList * list in backObj.ResponseData) {
                for (resMod_CategoryInfo * cinfo in list.TypeList) {
                    if (cinfo.SubTypeId==[self.param_serviceSortTypeId intValue]) {
                        list.isSelect_parent = YES;
                        cinfo.isChecked = YES;
                        hasSetDefault = YES;
                        continue;
                    }
                }
            }
            
            if (!hasSetDefault) {
                resMod_CategoryList * tmpList = (resMod_CategoryList*)backObj.ResponseData[0];
                tmpList.isSelect_parent = YES;
                if (tmpList.TypeList.count>0) {
                    resMod_CategoryInfo * tmpInfo = (resMod_CategoryInfo*)tmpList.TypeList[0];
                    tmpInfo.isChecked = YES;
                }
            }
        }
        [dicFilterData setObject:backObj.ResponseData forKey:filterKey_all];
    }
    else if([ApiName isEqualToString:kApiMethod_GetAreaType]){
        
        NSDictionary * dic = (NSDictionary*) retObj;
        
        for ( int i=0; i<2; i++) {
            resMod_CallBack_FilterCategory * backObj = [[resMod_CallBack_FilterCategory alloc] initWithDic: [dic mutableCopy]];
            
            //  --第一次选中默认
            if (backObj.ResponseData.count>0) {
                resMod_CategoryList * tmpList = (resMod_CategoryList*)backObj.ResponseData[0];
                tmpList.isSelect_parent = YES;
                if (tmpList.TypeList.count>0) {
                    resMod_CategoryInfo * tmpInfo = (resMod_CategoryInfo*)tmpList.TypeList[0];
                    tmpInfo.isChecked = YES;
                }
            }
            [dicFilterData setObject:backObj.ResponseData forKey: i==0 ? filterKey_area:filterKey_areaservice];
        }
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
        if (b_isPullRefresh) {
            b_isPullRefresh = NO;
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
        if (b_isPullRefresh) {
            b_isPullRefresh = NO;
            [m_ServiceList removeAllObjects];
        }
        [m_MerchantList addObjectsFromArray: backObj.ResponseData];
        
        int icount = backObj.ResponseData.count;
        [rootTableView reloadData: (icount==0 || icount <[apiRowNum intValue]) ? YES:NO allDataCount:m_MerchantList.count];
        [self.noDataView noDataViewIsHidden:m_MerchantList.count==0 ? NO :YES warnImg:@"" warnMsg:@"抱歉，没有找到相关商户"];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
}

- (void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_TicketList]
        ||[ApiName isEqualToString:kApiMethod_MerchantList]) {
        b_isPullRefresh = NO;
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
    UILabel * lbl_HeadView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 2)];
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
    if (smCurrentType == SMOperation_Service) {
        
        if (m_ServiceList&&iRow<=m_ServiceList.count) {
            resMod_TicketInfo * tmpTicketinfo= m_ServiceList[iRow];
            NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys
                                            :[NSString stringWithFormat:@"%d",tmpTicketinfo.TicketId],@"param_TicketId", nil];
            [self pushNewViewController:@"ServiceDetailViewController"
                              isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:params];
        }
    }
    else{
        
        if (m_MerchantList&&iRow<=m_MerchantList.count) {
            resMod_MerchantInfo * tmpMerchantinfo= m_MerchantList[iRow];
            NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys
                                            :[NSString stringWithFormat:@"%d",tmpMerchantinfo.MerchantId],@"param_MerchantId", nil];
            [self pushNewViewController:@"MerchantDetailViewController"
                              isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:params];
        }
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
        
        b_isPullRefresh = YES;
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
