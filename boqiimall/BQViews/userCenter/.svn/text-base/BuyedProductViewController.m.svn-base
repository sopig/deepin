//
//  BuyedProductViewController.m
//  boqiimall
//
//  Created by YSW on 14-7-11.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BuyedProductViewController.h"
#import "TableCell_Common.h"
#import "resMod_Mall_Goods.h"

#define heightForCell 100
#define pageNum @"8"

@implementation BuyedProductViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        arrProductList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MobClick event:@"myBoqii_myGoodsOrder_myBoughtGoods"];
    
    //[self loadNavBarView:@"我购买的商城商品"];
   // [self loadNavBarView];
    [self setTitle:@"我购买的商城商品"];
    //  --  ........
    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    [rootTableView setTag:11111];
    rootTableView.backgroundColor = color_bodyededed;
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:rootTableView];

    [self goApiRequest_BuyedMallProduct:YES];
}

- (void)loadNavBarView
{
    [super loadNavBarView];
}

//- (void)loadNavBarView:(NSString *)title {
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


#pragma mark    --  api 请求 加调

-(void) goApiRequest_BuyedMallProduct:(BOOL) isrefresh{
    
    b_isPullRefresh = isrefresh;
    int startIndex = b_isPullRefresh ? 0:arrProductList.count;
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue: [UserUnit userId] forKey:@"UserId"];
    [dicParams setValue: [NSString stringWithFormat:@"%d",startIndex] forKey:@"StartIndex"];
    [dicParams setValue: pageNum forKey:@"Number"];
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_GetMyBuyedGoodsList class:@"resMod_CallBackMall_GoodsList"
//              params:dicParams isShowLoadingAnimal:YES  hudShow:@""];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMyBuyedGoodsList:dicParams ModelClass:@"resMod_CallBackMall_GoodsList" showLoadingAnimal:YES hudContent:@"" delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    
    if ([ApiName isEqualToString:kApiMethod_Mall_GetMyBuyedGoodsList]) {
        resMod_CallBackMall_GoodsList * backObj = [[resMod_CallBackMall_GoodsList alloc] initWithDic:retObj];
        if (b_isPullRefresh) {
            [arrProductList removeAllObjects];
        }
        [arrProductList addObjectsFromArray: backObj.ResponseData];
        
        int icount = arrProductList.count;
//        [rootTableView setHidden:icount>0?NO:YES];
        [rootTableView reloadData: (icount==0 || icount<[pageNum intValue]) ? YES:NO allDataCount:arrProductList.count];
        
        [self.noDataView noDataViewIsHidden:icount==0 ? NO:YES warnImg:@"" warnMsg:@"您还未成功购买任何商品。"];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
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
                
                UILabel * lbl_goodspec = [[UILabel alloc] initWithFrame:CGRectMake(cell.lbl_mallTitle.frame.origin.x, 48,200,20)];
                [lbl_goodspec setTag:101010];
                [lbl_goodspec setBackgroundColor:[UIColor clearColor]];
                [lbl_goodspec setText:@"规格: 绿色，xxl"];
                [lbl_goodspec setTextColor:color_989898];
                [lbl_goodspec setFont:defFont14];
                [cell.contentView addSubview:lbl_goodspec];
                
                [cell.lbl_cellSpaceLine setFrame:CGRectMake(0, heightForCell-0.5, __MainScreen_Width, 0.5)];
            }
        }
    }
    
    if (arrProductList.count>0) {
        resMod_Mall_GoodsInfo * goodinfo = arrProductList[indexPath.row];
        [cell.mallProductImg sd_setImageWithURL:[NSURL URLWithString:goodinfo.GoodsImg]
                            placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
        [cell.lbl_mallTitle setText:goodinfo.GoodsTitle];
        [cell.lbl_mallPrice setText:[self convertPrice:goodinfo.GoodsPrice]];
        [cell.lbl_mallSoldNum setText:goodinfo.GoodsStatus];
        
        [cell setTitleFrame:cell.lbl_mallTitle.text];
        [cell.lbl_mallMarketPrice setHidden:YES];
        [cell.lbl_priceDelLine setHidden:YES];
        
        //  --规格
        NSString * spec = @"";
        int i=0;
        for (resMod_Mall_OrderGoodsSpec * sproperty in goodinfo.GoodsSpec) {
            spec = [NSString stringWithFormat:@"%@%@%@",spec,(i>0?@"，":@""),sproperty.Value];
            i++;
        }
        UILabel * lbl_101010 = (UILabel*)[cell viewWithTag:101010];
        [lbl_101010 setText:[NSString stringWithFormat:@"%@%@", (spec.length>0?@"规格: ":@"") ,spec]];
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
}

#pragma mark    --  scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [rootTableView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [rootTableView tableViewDidDragging];
    if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
        [rootTableView tableViewIsRefreshing];
        [arrProductList removeAllObjects];
        [self goApiRequest_BuyedMallProduct:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger returnKey = [rootTableView tableViewDidEndDragging];
    if (returnKey == k_RETURN_LOADMORE){    // 上拉加载更多
//        [arrProductList removeAllObjects];
        [self goApiRequest_BuyedMallProduct:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
