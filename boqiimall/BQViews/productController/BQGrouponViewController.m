//
//  BQGrouponViewController.m
//  boqiimall
//
//  Created by iXiaobo on 14-9-23.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQGrouponViewController.h"
#import "BQGrouponCollectionViewCell.h"
#import "resMod_Mall_GetShoppingMallGroupGoodsList.h"


#define kHeightOfTopBar 44

#define kDogName @"狗狗"
#define kCatName @"猫猫"
#define kLittlePetName @"小宠"
#define kWaterPetName @"水族"

#define kCollectionViewCellHeight 180
#define kCollectionViewCellWidth 142


#define kCount 10

@implementation BQGrouponViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        groupGoodsArray = [[NSMutableArray alloc] init];
        arrCategoryType = [[NSMutableArray alloc] init];
        willRefreshRemainTimerLabelsDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.lblTitle setTextColor:[UIColor whiteColor]];
    
   

}


-(void)loadNavBarView {
    [super loadNavBarView];
    
    [self._titleLabel setBackgroundColor:[UIColor clearColor]];
    self.backImgName = @"icon_back_white2.png";
    [self.backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
    self._titleLabel.textColor = [UIColor whiteColor];
    [self setTitle:@"商品团购"];
    [self.navBarView setBackgroundColor:color_fc4a00];
}


//- (void)loadNavBarView {
//    
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textColor = [UIColor whiteColor];
//    [titleLabel setBackgroundColor:[UIColor clearColor]];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = @"商品团购";
//    [bgView addSubview:titleLabel];
//    [self.navBarView setBackgroundColor:color_fc4a00];
//    [self.navBarView addSubview:bgView];
//}


- (void)viewDidLoad {
   
    [super viewDidLoad];
     //self.backImgName = @"icon_back_white2.png";
    //[self loadNavBarView];
    // Do any additional setup after loading the view.
    resMod_Mall_IndexResponseData * cateinfo = [[PMGlobal shared] GetDataFromPlist_MallIndex];
    if (cateinfo) {
        [arrCategoryType addObjectsFromArray: [cateinfo MainData]];
    }
    NSMutableArray *itemsArray = [[NSMutableArray alloc]init];
    for ( resMod_Mall_IndexMain *item in arrCategoryType) {
        [itemsArray addObject:item.TabName];
    }
    
    grouponSegmentedView = [[BQGrouponSegmentedView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kHeightOfTopBar) withItems:itemsArray];
    [self.view addSubview:grouponSegmentedView];
    [grouponSegmentedView setDelegate:self];
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kHeightOfTopBar+kNavBarViewHeight, __MainScreen_Width, (kMainScreenHeight-kHeightOfTopBar - kNavBarViewHeight)) collectionViewLayout:flowLayout] ;
    [_collectionView registerClass:[BQGrouponCollectionViewCell class] forCellWithReuseIdentifier:@"BQGrouponCollectionViewCell"];
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    [_collectionView setBackgroundColor:color_ededed];
    _collectionView.alwaysBounceVertical = YES;
    
    
    headerView = [[PullToRefreshHeaderView alloc] initWithFrame:CGRectMake(0, (0-self.view.frame.size.height), self.view.frame.size.width, self.view.frame.size.height)];
    [headerView setDelegate:self];
    [_collectionView addSubview:headerView];
    [self.view addSubview:_collectionView];
    isRefreshFlag = YES;
    
    [grouponSegmentedView setSelectedIndex:[[PMGlobal shared] overAllIdxForClassify]];
    [self onBQGrouponSegmentedViewSelected:((resMod_Mall_IndexMain*)[arrCategoryType objectAtIndex:[[PMGlobal shared] overAllIdxForClassify]]).TabName ];
    typeId  = ((resMod_Mall_IndexMain*)[arrCategoryType objectAtIndex:[[PMGlobal shared] overAllIdxForClassify]]).TabId;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */


#pragma mark -api Request
- (void)goApiRequest_GetShoppingMallGroupGoodsList:(NSString *)Id startIndex:(NSInteger)startIndex number:(NSInteger)number withLoadingAnimal:(BOOL)isAinmal
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject: Id forKey:@"FirstTypeId"];
    [params setObject:[NSString stringWithFormat:@"%d",startIndex] forKey:@"StartIndex"];
    [params setObject:[NSString stringWithFormat:@"%d",number] forKey:@"Number"];
    NSString *hudContent ;
    if (isAinmal)
    {
        hudContent = @"";
    }
    else
    {
        hudContent = @"正在加载";
    }
    [[APIMethodHandle shareAPIMethodHandle] goApiRequestGetShoppingMallGroupGoodsList:params ModelClass:@"resMod_CallbackMall_GetShoppingMallGroupGoodsList" showLoadingAnimal:isAinmal hudContent:hudContent delegate:self];
    grouponSegmentedView.isEnable = NO;
    
    [[self lodingAnimationView]stopLoadingAnimal];
}

#pragma mark -api Delegate
-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName
{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    grouponSegmentedView.isEnable = YES;
    [self hudWasHidden:HUD];
    if ([ApiName isEqualToString:kApiMethod_Mall_GetShoppingMallGroupGoodsList])
    {
        resMod_CallbackMall_GetShoppingMallGroupGoodsList * backObj = [[resMod_CallbackMall_GetShoppingMallGroupGoodsList alloc] initWithDic:retObj];
        int requestCount = backObj.ResponseData.count;
        if (isRefreshFlag)
        {
            if ([refreshRemainTimer isValid])
            {
                [refreshRemainTimer invalidate];
            }
            refreshRemainTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshGroupGoodsRemainTime:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:refreshRemainTimer forMode:NSRunLoopCommonModes];
            [groupGoodsArray removeAllObjects];
            groupGoodsArray = backObj.ResponseData;
            [willRefreshRemainTimerLabelsDict removeAllObjects];
        }
        else
        {
            [groupGoodsArray addObjectsFromArray:backObj.ResponseData];
        }
        
        [_collectionView reloadData];
        
        if (requestCount == kCount) {
            isFooterViewShouldShow = YES;
            [self removePullToRefreshFooterView];
            [self setPullToRefreshFooterView];
        }
        else {
            isFooterViewShouldShow = NO;
            [self removePullToRefreshFooterView];
        }
        
        [self loadingDataFinished];
        [self.noDataView noDataViewIsHidden:groupGoodsArray.count==0 ? NO:YES warnImg:@"" warnMsg:@"抱歉，暂无相关团购商品 !"];
    }
}

- (void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName {
    [super interfaceExcuteError:error apiName:ApiName];
    
    grouponSegmentedView.isEnable = YES;
    [self hudWasHidden:HUD];
    [self loadingDataFinished];
    [self.noDataView noDataViewIsHidden:groupGoodsArray.count==0 ? NO:YES warnImg:@"" warnMsg:@"抱歉，暂无相关团购商品 !"];    
}
#pragma mark --refresher remain timer

- (void)refreshGroupGoodsRemainTime:(NSTimer*)timer
{
    if (groupGoodsArray.count != 0)
    {
        for (resMod_Mall_GetShoppingMallGroupGoods *goods in groupGoodsArray)
        {
            goods.remainTime -= 1;
            if (goods.remainTime <= 0)
            {
                goods.remainTime = 0;
            }
            UILabel *remainTimeLabel = [willRefreshRemainTimerLabelsDict objectForKey:[NSString stringWithFormat:@"%d",goods.goodsId]];
            if (remainTimeLabel)
            {
                if (goods.remainTime == 0)
                {
                    remainTimeLabel.text = @"活动已结束";
                }
                else
                {
                    remainTimeLabel.text = [self remainTimeToString:goods.remainTime];
                }
                
                
            }
        }
    }
}

#pragma -mark  BQGrouponSegmentedViewDelegate
- (void)onBQGrouponSegmentedViewSelected:(id)selectedObj
{
    NSString *selectedItem = (NSString *)selectedObj;
   // selectedItemName = selectedItem;
    if ([selectedItem isEqualToString:@"狗狗"])
    {
        [MobClick event:@"group_buying_dog"];
    }
    if ([selectedItem isEqualToString:@"猫猫"])
    {
        [MobClick event:@"group_buying_cat"];
    }
    if ([selectedItem isEqualToString:@"小宠"])
    {
        [MobClick event:@"group_buying_smallPet"];
    }
    if ([selectedItem isEqualToString:@"水族"])
    {
        [MobClick event:@"group_buying_aquaticAnimals"];
    }
    
    for (resMod_Mall_IndexMain *item in arrCategoryType)
    {
        if ([item.TabName isEqualToString:selectedItem]) {
            typeId = item.TabId;
        }
    }
    isRefreshFlag = YES;
    [self goApiRequest_GetShoppingMallGroupGoodsList:typeId startIndex:0 number:kCount withLoadingAnimal:NO];
    [_collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma -mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [groupGoodsArray count] ;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}



- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([willRefreshRemainTimerLabelsDict allValues].count != 0)
    {
        resMod_Mall_GetShoppingMallGroupGoods *item = [groupGoodsArray objectAtIndex:indexPath.row];
        [willRefreshRemainTimerLabelsDict removeObjectForKey:[NSString stringWithFormat:@"%d",item.goodsId]];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"BQGrouponCollectionViewCell";
    BQGrouponCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell)
    {
        resMod_Mall_GetShoppingMallGroupGoods *goods = [groupGoodsArray objectAtIndex:indexPath.row];
        cell.goodsTitle.text = goods.goodsTitle;
        [cell.goodsImage sd_setImageWithURL:[NSURL URLWithString:goods.goodsImgUrl]
                           placeholderImage:[UIImage imageNamed:@"placeHold_320x210.png"]];
        cell.goodsOriPrice.text = [NSString stringWithFormat:@"%0.2f",goods.goodsOriPrice];
        UIFont* theFont = [UIFont systemFontOfSize:12];
        CGSize sizeName = [[NSString stringWithFormat:@"%0.2f",goods.goodsOriPrice] sizeWithFont:theFont
                              constrainedToSize:CGSizeMake(MAXFLOAT, 0.0)
                                  lineBreakMode:NSLineBreakByWordWrapping];
        CGRect horizontalLineRect = cell.horizontalLineView.frame;
        horizontalLineRect.size.width = sizeName.width+5;
        cell.horizontalLineView.frame = horizontalLineRect;
        
        cell.goodsCurrentPrice.text = [NSString stringWithFormat:@"%0.2f",goods.goodsPrice];
        cell.discountLabel.text = goods.goodsScale;
        if (goods.goodsSaledNum > 10000) {
            cell.TotalNumber.text = [NSString stringWithFormat:@"%.2f万人已购买",goods.goodsSaledNum/10000.0];
        }
        else {
            cell.TotalNumber.text = [NSString stringWithFormat:@"%d 人已购买",goods.goodsSaledNum];
        }
        
        if (goods.remainTime == 0)
        {
            cell.remainTime.text = @"活动已结束";
        }
        else
        {
            cell.remainTime.text = [self remainTimeToString:goods.remainTime];
        }
        
        [willRefreshRemainTimerLabelsDict setObject:cell.remainTime  forKey:[NSString stringWithFormat:@"%d",goods.goodsId]];
    }
   
   
    return cell;
}

-(NSString *)remainTimeToString:(NSInteger)time
{
    NSInteger day = time/(60*60*24);
    NSInteger hour = time%(60*60*24)/(60*60) ;
    NSInteger minute = time%(60*60)/60;
    NSInteger second = time%60;
    return [NSString stringWithFormat:@"%d天%2d小时%2d分%2d秒",day,hour,minute,second];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCollectionViewCellWidth, kCollectionViewCellHeight);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    
    CGFloat margin = (__MainScreen_Width - kCollectionViewCellWidth*2)/3.0;
    return UIEdgeInsetsMake(12, margin, 12, margin);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 12.0f;
}

#pragma mark -UICollectionViewDelegate


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *itemName;
    for (resMod_Mall_IndexMain *item in arrCategoryType)
    {
        if (item.TabId == typeId)   {
            itemName = item.TabName;
            break;
        }
    }
    
    if ([itemName isEqualToString:@"狗狗"])
    {
        [MobClick event:@"group_buying_dog_goodspicture"];
    }
    if ([itemName isEqualToString:@"猫猫"])
    {
        [MobClick event:@"group_buying_cat_goodspicture"];
    }
    if ([itemName isEqualToString:@"小宠"])
    {
        [MobClick event:@"group_buying_smallPet_goodspicture"];
    }
    if ([itemName isEqualToString:@"水族"])
    {
        [MobClick event:@"group_buying_aquaticAnimals_goodspicture"];
    }
    
    resMod_Mall_GetShoppingMallGroupGoods *goods = [groupGoodsArray objectAtIndex:indexPath.row];
    if (goods.remainTime > 0)
    {
        NSString * PID = [NSString stringWithFormat:@"%d",goods.goodsId];
        [self pushNewViewController:@"MallProductDetailController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:PID,@"paramGoodsID", nil]];
    }
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}


#pragma mark --UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    if (headerView)
    {
        [headerView scrollViewWillBeginDragging:scrollView];
    }
    
    if (footerView)
    {
        [self setPullToRefreshFooterView];
        [footerView scrollViewWillBeginDragging:scrollView];
    }
    
    
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (headerView)
    {
        [headerView scrollViewDidEndDragging:scrollView];
    }
    
    if (!isRefreshFlag)
    {
        if (footerView)
        {
            [footerView scrollViewDidEndDragging:scrollView];
            
        }
    }
}


#pragma mark --PullToRefreshHeaderViewDelegate
- (void)onPullToRefreshHeaderViewDidTriggerRefresh:(PullToRefreshHeaderView *)view
{
    [self goApiRequest_GetShoppingMallGroupGoodsList:typeId startIndex:0 number:kCount withLoadingAnimal:YES];
    isRefreshFlag = YES;
}
#pragma mark --PullToRefreshFooterViewDelegate
- (void)onPullToRefreshFooterViewDidTriggerRefresh:(PullToRefreshFooterView *)view
{
    [self goApiRequest_GetShoppingMallGroupGoodsList:typeId startIndex:[groupGoodsArray count] number:kCount withLoadingAnimal:YES];
    isRefreshFlag = NO;
    
}

#pragma mark --数据加载完毕

- (void)loadingDataFinished
{
    if (isRefreshFlag)
    {
        isRefreshFlag = NO;
        if (headerView)
        {
            [headerView scrollViewDidLoadingFinished:_collectionView];
        }
    }
    else
    {
        if (footerView)
        {
            
            [footerView scrollViewDidLoadingFinished:_collectionView];
            
        }
        
        
    }
    
}


#pragma mark --PullToRefreshView
- (void)setPullToRefreshFooterView
{
    CGFloat height = MAX(_collectionView.contentSize.height,_collectionView.frame.size.height);
    if (footerView && [footerView superview]) {
        footerView.frame = CGRectMake(0.0f, height, _collectionView.frame.size.width, _collectionView.bounds.size.height);
    }
    else {
        footerView = [[PullToRefreshFooterView alloc] initWithFrame:
                      CGRectMake(0.0f, height, self.view.frame.size.width, self.view.bounds.size.height)];
        footerView.delegate = self;
        [_collectionView addSubview:footerView];
    }
}

- (void)removePullToRefreshFooterView
{
    if (footerView && [footerView superview]) {
        [footerView removeFromSuperview];
    }
    footerView = nil;
    if (!isFooterViewShouldShow)
    {
        [_collectionView setContentInset:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    }
}

- (void)dealloc
{
    if ([refreshRemainTimer isValid])
    {
        [refreshRemainTimer invalidate];
    }
}

@end
