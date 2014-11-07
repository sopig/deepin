//
//  MyCollectViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-16.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MyCollectViewController.h"

#define heightForDelView    130
#define requestPageNum 6
#define heightForCell_mallcollect 100
#define heightForCell_lifecollect 122

@implementation MyCollectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        delTickedId = -1000;
        arrProductCollections = [[NSMutableArray alloc] initWithCapacity:0];
        arrTicketCollections = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MobClick event:@"myBoqii_myCollection"];
    //[self loadNavBarView];
    //[self setTitle:@"我的收藏"];
    [self.view setBackgroundColor:color_bodyededed];
   // [self loadNavBarView:@"我的收藏"];
  //  [self addTitleView];
    
#if APPVERSIONTYPE
    //  -- Mall 商品
    TableView_BQMall = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0,kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    [TableView_BQMall setTag:2000];
    TableView_BQMall.backgroundColor = [UIColor clearColor];
    TableView_BQMall.bounces = YES;
    TableView_BQMall.delegate = self;
    TableView_BQMall.dataSource = self;
    TableView_BQMall.separatorStyle = UITableViewCellSeparatorStyleNone;
    TableView_BQMall.showsHorizontalScrollIndicator= NO;
    TableView_BQMall.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:TableView_BQMall];
#endif
    
    //  -- 生活馆 ticket
    TableView_BQLife = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0,kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    [TableView_BQLife setTag:3000];
    [TableView_BQLife setHidden: APPVERSIONTYPE ? YES:NO];
    TableView_BQLife.backgroundColor = [UIColor clearColor];
    TableView_BQLife.bounces = YES;
    TableView_BQLife.delegate = self;
    TableView_BQLife.dataSource = self;
    TableView_BQLife.separatorStyle = UITableViewCellSeparatorStyleNone;
    TableView_BQLife.showsHorizontalScrollIndicator= NO;
    TableView_BQLife.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:TableView_BQLife];
    
    collecttype = collect_BQLIFE;
    if (APPVERSIONTYPE) {
        collecttype = collect_BQMALL;
        [self goApiRequest_mallproduct];
    }
    [self goApiRequest_lifeTicket];
    [self addDelWarnView];
}
- (void)loadNavBarView
{
    [super loadNavBarView];
    segtitleView = [[EC_SegmentedView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2-106, 4, 215, 36)
                                                 btntitle1:@"我收藏的商品" btn1Img:@""
                                                 btntitle2:@"我收藏的服务券" btn2Img:@""
                                                 img1Press:@"" img2press:@""];
    [segtitleView setSegmentDelegate:self];
    [self.subNavBarView addSubview:segtitleView];
}
//- (void)loadNavBarView:(NSString *)title
//{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    [self.navBarView addSubview:bgView];
//    
//    
//}

#pragma mark    --  switch 切 换  : 服务或商户
- (void)onSegmentedClick:(int) selectIndex {

    [delWarnView setFrame:CGRectMake(0, kMainScreenHeight, __MainScreen_Width, heightForDelView)];
    
    if (selectIndex==0) {
        [MobClick event:@"myCollection_myCollectGoods"];
        collecttype = collect_BQMALL;
        [TableView_BQMall setHidden:NO];
        [TableView_BQLife setHidden:YES];
    }
    if (selectIndex==1) {
        [MobClick event:@"myCollection_myCollectService"];
        collecttype = collect_BQLIFE;
        [TableView_BQMall setHidden:YES];
        [TableView_BQLife setHidden:NO];
    }
    [self SetNoDataView];
}

#pragma mark    --  load ui
- (void)addTitleView {
    if (APPVERSIONTYPE) {
        segtitleView = [[EC_SegmentedView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2-106, 4+kStatusBarHeight, 215, 36)
                                                 btntitle1:@"我收藏的商品" btn1Img:@""
                                                 btntitle2:@"我收藏的服务券" btn2Img:@""
                                                 img1Press:@"" img2press:@""];
        [segtitleView setSegmentDelegate:self];
        [self.navBarView addSubview:segtitleView];
       // self.navigationItem.titleView = segtitleView;
    }
}

- (void) addDelWarnView{
    
    delWarnView = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight, __MainScreen_Width, heightForDelView)];
    [delWarnView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [self.view addSubview:delWarnView];
    
    [UICommon Common_UILabel_Add:CGRectMake(0, 0, __MainScreen_Width, 35)
                      targetView:delWarnView bgColor:[UIColor clearColor] tag:123
                            text:@"确定删除吗?" align:0 isBold:NO fontSize:16 tColor:[UIColor whiteColor]];
    
    
    for (int i=0; i<2; i++) {
        UIButton * btn_DelOkOrCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_DelOkOrCancel setTag:999+i];
        [btn_DelOkOrCancel setFrame:CGRectMake(15, 35+i*50, def_WidthArea(15), 38)];
        [btn_DelOkOrCancel setBackgroundColor: i==0 ? color_fc4a00 : color_989898];
        [btn_DelOkOrCancel setTitle:i==0 ? @"是":@"否" forState:UIControlStateNormal];
        [btn_DelOkOrCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_DelOkOrCancel.titleLabel setFont:defFont16];
        btn_DelOkOrCancel.layer.cornerRadius = 3.0;
        [btn_DelOkOrCancel addTarget:self action:@selector(onButtonDelClick:) forControlEvents:UIControlEventTouchUpInside];
        [delWarnView addSubview:btn_DelOkOrCancel];
    }
}

//  -- cell delegate to del
- (void) OnDelegateDelCollect:(UITableViewCell *)cell{
    
    delTickedId = -1000;
    [MobClick event:@"userCenter_myCollection_delete"];
    
    currentCell = cell;
    
    if (collecttype == collect_BQMALL) {
        [MobClick event:@"myCollection_myCollectGoods_delete"];
        NSIndexPath * indexpath = [TableView_BQMall indexPathForCell:cell];
        resMod_ProductCollectionInfo * goodsinfo = arrProductCollections[indexpath.row];
        delProductId = goodsinfo.GoodsId;
        
        if (delProductId>0) {
            [self showDelWarnView:YES];
        }
    }
    else if(collecttype == collect_BQLIFE){
        [MobClick event:@"myCollection_myCollectService_delete"];
        NSIndexPath * indexpath = [TableView_BQLife indexPathForCell:cell];
        resMod_MyCollectionInfo * collectioninfo = arrTicketCollections[indexpath.row];
        delTickedId = collectioninfo.TicketId;
        
        if (delTickedId>0) {
            [self showDelWarnView:YES];
        }
    }
}

//  -- 是 否 删 除 。
- (void) onButtonDelClick:(id) sender{
    UIButton * btntmp = (UIButton*)sender;
    
    [self showDelWarnView:NO];
    
    if (btntmp.tag==999) {
        if (collecttype == collect_BQMALL) {
            
            [self goApiRequest_delCollectionMallProduct:[NSString stringWithFormat:@"%d",delProductId]];
        }
        if (collecttype == collect_BQLIFE) {
            [self goApiRequest_delCollectionLifeTicket:[NSString stringWithFormat:@"%d",delTickedId]];
        }
    }
}

//  --删 tablecell
- (void) delRow{
    
    if (currentCell!=nil) {
        
        if (collecttype == collect_BQMALL) {
            NSIndexPath * indexpath = [TableView_BQMall indexPathForCell:currentCell];
            [arrProductCollections removeObjectAtIndex:indexpath.row];
            
            [TableView_BQMall beginUpdates];
            [TableView_BQMall deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexpath, nil] withRowAnimation:UITableViewRowAnimationTop];
            [TableView_BQMall endUpdates];
        }
    
        if (collecttype == collect_BQLIFE) {
            NSIndexPath * indexpath = [TableView_BQLife indexPathForCell:currentCell];
            [arrTicketCollections removeObjectAtIndex:indexpath.row];
            
            [TableView_BQLife beginUpdates];
            [TableView_BQLife deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexpath, nil] withRowAnimation:UITableViewRowAnimationTop];
            [TableView_BQLife endUpdates];

        }
    }
}

- (void) showDelWarnView:(BOOL) _show{
    
    if (_show) {
        [self.view bringSubviewToFront:delWarnView];
        [delWarnView setFrame:CGRectMake(0, kMainScreenHeight, __MainScreen_Width, heightForDelView)];
        [UIView animateWithDuration:0.3 animations:^{
            [delWarnView setFrame:CGRectMake(0, kMainScreenHeight-heightForDelView, __MainScreen_Width, heightForDelView)];
        }];
    }
    else{
        [UIView animateWithDuration:0.3 animations:^{
            [delWarnView setFrame:CGRectMake(0, kMainScreenHeight, __MainScreen_Width, heightForDelView)];
        }];
    }
}

- (void) SetNoDataView{
    if (collecttype == collect_BQMALL) {
        [self.noDataView setHidden:arrProductCollections.count==0 ? NO:YES];
    }
    if (collecttype == collect_BQLIFE) {
        [self.noDataView setHidden:arrTicketCollections.count==0 ? NO:YES];
    }
}

#pragma mark    --  api 请求 加调
-(void) goApiRequest_mallproduct{
    int starIndex = b_isPullRefresh?0:arrProductCollections.count;
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", starIndex] forKey:@"StartIndex"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", requestPageNum] forKey:@"Number"];
    
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_MyCollectedGoodsList class:@"resMod_CallBack_ProductCollectionList"
//              params:dicParams  isShowLoadingAnimal:YES hudShow:@""];
//    GetMyCollectedGoodsList

    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMyCollectedGoodsList:dicParams ModelClass:@"resMod_CallBack_ProductCollectionList" showLoadingAnimal:YES hudContent:@"" delegate:self];
}

-(void) goApiRequest_lifeTicket{
    int starIndex = b_isPullRefresh?0:arrTicketCollections.count;
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", starIndex] forKey:@"StartIndex"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", requestPageNum] forKey:@"Number"];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_MyCollectionList class:@"resMod_CallBack_GetMyCollectionList"
//              params:dicParams isShowLoadingAnimal:YES hudShow:@""];
//    GetMyCollectedGoodsList

    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMyCollectionList:dicParams ModelClass:@"resMod_CallBack_GetMyCollectionList" showLoadingAnimal:YES hudContent:@"" delegate:self];
}
//  -- 删除收藏 商品
-(void) goApiRequest_delCollectionMallProduct:(NSString*) pid{
    if (pid.length==0) {
        [self HUDShow:@"商品id不可为空" delay:1];
        return;
    }
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:pid forKey:@"GoodsId"];
    [dicParams setValue:@"2" forKey:@"Method"];
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_HandleGoodsCollection class:@"ResponseBase"
//              params:dicParams  isShowLoadingAnimal:NO hudShow:@"正在删除"];
//    HandleGoodsCollection
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestHandleGoodsCollection:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在删除" delegate:self];
    
}
//  -- 删除收藏 服务券
-(void) goApiRequest_delCollectionLifeTicket:(NSString*) ticketid{
    if (ticketid.length==0) {
        [self HUDShow:@"服务券id不可为空" delay:1];
        return;
    }
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:ticketid forKey:@"TicketId"];
    [dicParams setValue:@"2" forKey:@"Method"];
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_HandleCollection class:@"ResponseBase"
//              params:dicParams  isShowLoadingAnimal:NO hudShow:@"正在删除"];

    [[APIMethodHandle shareAPIMethodHandle]goApiRequestHandleCollection:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在删除" delegate:self];
}
-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];

    if ([ApiName isEqualToString:kApiMethod_MyCollectedGoodsList]) {
        resMod_CallBack_ProductCollectionList * backObj = [[resMod_CallBack_ProductCollectionList alloc] initWithDic:retObj];
        int callNum = backObj.ResponseData.count;
        if (b_isPullRefresh ) {
            b_isPullRefresh = NO;
            [arrProductCollections removeAllObjects];
        }
        [arrProductCollections addObjectsFromArray: backObj.ResponseData];
        
        [TableView_BQMall reloadData: callNum<requestPageNum ? YES:NO allDataCount:arrProductCollections.count];
        
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
    if ([ApiName isEqualToString:kApiMethod_MyCollectionList]) {
        resMod_CallBack_GetMyCollectionList * backObj = [[resMod_CallBack_GetMyCollectionList alloc] initWithDic:retObj];
        int callNum = backObj.ResponseData.count;
        if (b_isPullRefresh ) {
            b_isPullRefresh = NO;
            [arrTicketCollections removeAllObjects];
        }
        [arrTicketCollections addObjectsFromArray: backObj.ResponseData];
        
        [TableView_BQLife reloadData: callNum<requestPageNum ? YES:NO allDataCount:arrTicketCollections.count];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
    if ([ApiName isEqualToString:kApiMethod_HandleGoodsCollection]) {
        [self delRow];
        [self HUDShow:@"已删除" delay:1.5];
    }
    if ([ApiName isEqualToString:kApiMethod_HandleCollection]) {
        [self delRow];
        [self HUDShow:@"已删除" delay:1.5];
    }
    
    [self SetNoDataView];
}

-(void) interfaceExcuteError:(NSError*)error apiName:(NSString*)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];
    b_isPullRefresh = NO;
    
    if (collecttype == collect_BQMALL) {
        [TableView_BQMall reloadData: arrProductCollections.count==0 ? YES:NO allDataCount:arrProductCollections.count];
    }
    if (collecttype == collect_BQLIFE) {
        [TableView_BQLife reloadData: arrTicketCollections.count==0 ? YES:NO allDataCount:arrTicketCollections.count];
    }
}



#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == TableView_BQMall) {
        return arrProductCollections.count;
    }
    else{
        return arrTicketCollections.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView==TableView_BQMall? heightForCell_mallcollect:heightForCell_lifecollect;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString * Identifier = @"CouponOrderCell";
    
    if (tableView==TableView_BQMall) {

        TableCell_CollectMallProduct * cell = (TableCell_CollectMallProduct*)[tableView dequeueReusableCellWithIdentifier:Identifier];
        if ( !cell ) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_UserCenter" owner:self options:nil];
            for(id oneObject in nib) {
                if([oneObject isKindOfClass:[TableCell_CollectMallProduct class]]) {
                    cell = (TableCell_CollectMallProduct *)oneObject;
                    cell.DelCollectProductDelegate = self;
                    
                    [UICommon Common_line:CGRectMake(2, heightForCell_mallcollect-0.5, def_WidthArea(2), 0.5) targetView:cell.contentView backColor:color_d1d1d1];
                }
            }
        }
        
        int irow = indexPath.row;
        if (arrProductCollections.count>0) {
            resMod_ProductCollectionInfo * collectioninfo = arrProductCollections[irow];
            NSString * proimgUrl = collectioninfo.GoodsImg;//[BQ_global convertImageUrlString:kImageUrlType_75x75 withurl:collectioninfo.GoodsImg];
            [cell.ProductImg sd_setImageWithURL:[NSURL URLWithString:proimgUrl]
                               placeholderImage:[UIImage imageNamed:@"placeHold_75x75"]];
            [cell.ProductTitle  setText:collectioninfo.GoodsTitle];
            [cell.lbl_TimesView setText:[NSString stringWithFormat:@"%d 人收藏",collectioninfo.GoodsCollected]];
            [cell.lbl_Price     setText:[self convertPrice:collectioninfo.GoodsPrice]];
        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
    else{
        TableCell_Collect * cell = (TableCell_Collect*)[tableView dequeueReusableCellWithIdentifier:Identifier];
        if ( !cell ) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_UserCenter" owner:self options:nil];
            for(id oneObject in nib) {
                if([oneObject isKindOfClass:[TableCell_Collect class]]) {
                    cell = (TableCell_Collect *)oneObject;
                    cell.DelCollectDelegate = self;
                    
                    [UICommon Common_line:CGRectMake(2, heightForCell_lifecollect-0.5, def_WidthArea(2), 0.5) targetView:cell.contentView backColor:color_d1d1d1];
                }
            }
        }
        
        int irow = indexPath.row;
        if (arrTicketCollections.count>0) {
            resMod_MyCollectionInfo * collectioninfo = arrTicketCollections[irow];
            NSString * proimgUrl = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:collectioninfo.TicketImg];
            [cell.ProductImg sd_setImageWithURL:[NSURL URLWithString:proimgUrl]
                               placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
            [cell.ProductTitle  setText:collectioninfo.TicketTitle];
            [cell.lbl_Price     setText:[self convertPrice:collectioninfo.TicketPrice]];
            [cell.lbl_markPrice setText:[self convertPrice:collectioninfo.TicketOriPrice]];
            [cell.lbl_Timeleft  setText:collectioninfo.TicketStatus];
            
            //  -- 删除线
            CGSize tSize = [[self convertPrice:collectioninfo.TicketOriPrice] sizeWithFont:defFont13 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            [cell.lbl_delline setFrame:CGRectMake(cell.lbl_markPrice.frame.origin.x-2, cell.lbl_markPrice.frame.origin.y+10, tSize.width+4, 1)];
        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int irow = indexPath.row;
    
    if (tableView==TableView_BQMall) {
        [MobClick event:@"myCollection_myCollectGoods_goodsPicture"];
        
        NSString * PID = [NSString stringWithFormat:@"%d",[arrProductCollections[indexPath.row] GoodsId]];
        [self pushNewViewController:@"MallProductDetailController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:PID,@"paramGoodsID", nil]];
    }
    if (tableView == TableView_BQLife) {
        [MobClick event:@"myCollection_myCollectService_servicePicture"];
        NSString * TicketID = [NSString stringWithFormat:@"%d",[arrTicketCollections[irow] TicketId]];
        [self pushNewViewController:@"ServiceDetailViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys :TicketID,@"param_TicketId", nil]];
    }
    
    [self showDelWarnView:NO];
}


#pragma mark    --  scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self showDelWarnView:NO];
    
    if (collecttype == collect_BQMALL) {
        [TableView_BQMall tableViewDidDragging];
    }
    if (collecttype == collect_BQLIFE) {
        [TableView_BQLife tableViewDidDragging];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{

    if (collecttype == collect_BQMALL) {
        NSInteger returnKey = [TableView_BQMall tableViewDidDragging];
        if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
            b_isPullRefresh = YES;
            [TableView_BQMall tableViewIsRefreshing];
            [self goApiRequest_mallproduct];
        }
    }
    
    if (collecttype == collect_BQLIFE) {
        NSInteger returnKey = [TableView_BQLife tableViewDidDragging];
        if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
            b_isPullRefresh = YES;
            [TableView_BQLife tableViewIsRefreshing];
            [self goApiRequest_lifeTicket];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (collecttype == collect_BQMALL) {
        NSInteger returnKey = [TableView_BQMall tableViewDidEndDragging];
        if (returnKey == k_RETURN_LOADMORE){    // 上拉加载更多
            [self goApiRequest_mallproduct];
        }
    }
    if (collecttype == collect_BQLIFE) {
        NSInteger returnKey = [TableView_BQLife tableViewDidEndDragging];
        if (returnKey == k_RETURN_LOADMORE){    // 上拉加载更多
            [self goApiRequest_lifeTicket];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
