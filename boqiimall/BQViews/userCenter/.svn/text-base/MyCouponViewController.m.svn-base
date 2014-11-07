//
//  MyCouponViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-16.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MyCouponViewController.h"
#import "TableCell_UserCenter.h"

#define requestPageNum 10
#define heightForHead 40
#define heightForCell 90

#define buttonFilterTag 7923
#define buttonTitles  @"未使用:1|已使用:2|已过期:3"

@implementation MyCouponViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CouponStatus = @"1";
        arrCouponList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MobClick event:@"myBoqii_myCoupon"];
    //[self loadNavBarView];
    [self setTitle:@"我的优惠券"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //[self loadNavBarView:@"我的优惠券"];
    [self.view addSubview:[self loadView_TopCouponStatus]];
    
    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0,heightForHead+kNavBarViewHeight,__MainScreen_Width,__ContentHeight_noTab-heightForHead) style:UITableViewStylePlain];
    [rootTableView setTag:2000];
    rootTableView.backgroundColor = [UIColor clearColor];
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:rootTableView];
    [self.view sendSubviewToBack:rootTableView];
    //  --api....
    [self goApiRequest:@""];
}

//- (void)loadNavBarView:(NSString *)title
//{
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
//


//  -- 上面的服务券状态
- (UIView *) loadView_TopCouponStatus{
    UIView * HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, heightForHead)];
    [HeadView setBackgroundColor:[UIColor whiteColor]];
    
    UIView * ShadowBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, __MainScreen_Width, heightForHead-1)];
    [ShadowBg setBackgroundColor:[UIColor whiteColor]];
    ShadowBg.layer.shadowColor = [UIColor blackColor].CGColor;
    ShadowBg.layer.shadowOffset = CGSizeMake(0, 0.5);
    ShadowBg.layer.shadowOpacity = 0.3;
    ShadowBg.layer.shadowRadius = 0.8;
    [HeadView addSubview:ShadowBg];
    
    NSArray * arrTxtStatus = [buttonTitles componentsSeparatedByString:@"|"];
    float fWidth = (__MainScreen_Width-10)/arrTxtStatus.count;
    int i=0;
    for (NSString * titleProper in arrTxtStatus) {
        NSArray * stxt = [titleProper componentsSeparatedByString:@":"];
        int xpoint = 7+i*fWidth;
        
        UIButton * serviceStatusType = [UIButton buttonWithType:UIButtonTypeCustom];
        int tabBtn = [stxt[1] intValue];
        [serviceStatusType setTag: buttonFilterTag + tabBtn];
        [serviceStatusType setFrame: CGRectMake(xpoint, 0, fWidth-4, heightForHead)];
        [serviceStatusType setTitle: stxt[0] forState:UIControlStateNormal];
        [serviceStatusType.titleLabel setFont:defFont14];
        [serviceStatusType setTitleColor: [UIColor convertHexToRGB:i==0 ? @"FC4A00" : @"3c3c3c"]
                                forState: UIControlStateNormal];
        [serviceStatusType addTarget:self action:@selector(onCouponStatusClick:)
                    forControlEvents:UIControlEventTouchUpInside];
        [HeadView addSubview:serviceStatusType];
        
        if (i==0) {
            currentStatus = serviceStatusType;
        }
        if (i>0 && i!=arrTxtStatus.count) {
            [UICommon Common_line:CGRectMake(0, heightForHead/2-7, 0.5, 15) targetView:serviceStatusType backColor:color_d1d1d1];
        }
        ++i;
    }
    
    return HeadView;
}

//  --
- (void) onCouponStatusClick:(id) sender{
    UIButton * btnstatus = (UIButton*) sender;
    
    [btnstatus setTitleColor: [UIColor convertHexToRGB:@"FC4A00"] forState:UIControlStateNormal];
    [currentStatus setTitleColor: [UIColor convertHexToRGB:@"3c3c3c"] forState:UIControlStateNormal];
    
    if (btnstatus!=currentStatus) {
        CouponStatus = [NSString stringWithFormat:@"%d",btnstatus.tag-buttonFilterTag];
        [arrCouponList removeAllObjects];
        [self goApiRequest:@"正在加载"];
    }
    
    if ([CouponStatus isEqualToString:@"1"]) { [MobClick event:@"userCenter_myTicket_notUsed"]; }
    if ([CouponStatus isEqualToString:@"2"]) { [MobClick event:@"userCenter_myTicket_used"]; }
    if ([CouponStatus isEqualToString:@"3"]) { [MobClick event:@"userCenter_myTicket_overdue"]; }
    
    currentStatus = btnstatus;
}


#pragma mark    --  api 请求 加调

-(void) goApiRequest:(NSString*) _hudmsg{
    int starIndex = b_isPullRefresh?0:arrCouponList.count;
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:CouponStatus forKey:@"OrderType"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", starIndex] forKey:@"StartIndex"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", requestPageNum] forKey:@"Number"];
    
    
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_MyCouponList class:@"resMod_CallBack_MyCouponList"
//              params:dicParams isShowLoadingAnimal:YES hudShow:_hudmsg];
//    GetMyCouponList
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMyCouponList:dicParams ModelClass:@"resMod_CallBack_MyCouponList" showLoadingAnimal:YES hudContent:_hudmsg delegate:self];
    
    
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_MyCouponList]) {
        resMod_CallBack_MyCouponList * backObj = [[resMod_CallBack_MyCouponList alloc] initWithDic:retObj];
        int callNum = backObj.ResponseData.count;
        if (b_isPullRefresh) {
            b_isPullRefresh = NO;
            [arrCouponList removeAllObjects];
        }
        [arrCouponList addObjectsFromArray: backObj.ResponseData];
        
        [self.noDataView setHidden:arrCouponList.count==0 ? NO :YES];
        [rootTableView reloadData: callNum==10 ? NO : YES allDataCount:arrCouponList.count];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
}

-(void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];
    b_isPullRefresh = NO;
}


#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int iRowCount = arrCouponList.count;
    return iRowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightForCell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString * Identifier = @"CouponOrderCell";
    
    TableCell_Coupon * cell = (TableCell_Coupon*)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if ( !cell ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_UserCenter" owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[TableCell_Coupon class]]) {
                cell = (TableCell_Coupon *)oneObject;
                
                [UICommon Common_line:CGRectMake(0, heightForCell-0.5, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
            }
        }
    }
    
    int irow = indexPath.row;
    if (arrCouponList.count>0) {
        resMod_MyCouponInfo * couponInfo = arrCouponList[irow];
        [cell.lbl_CouponTitle setText:couponInfo.CouponTitle];
        [cell.lbl_Price setText:[self convertPrice:couponInfo.CouponPrice]];
        [cell.lbl_CouponStatus setText: [CouponStatus isEqualToString:@"1"] ? @"未使用"
                                      :([CouponStatus isEqualToString:@"2"] ? @"已使用" : @"已过期")];
        [cell.lbl_CouponStatus setBackgroundColor:[CouponStatus isEqualToString:@"1"] ? color_8fc31f
                                                 :([CouponStatus isEqualToString:@"2"]? color_ff2a00 : color_989898)];
        [cell.lbl_CouponRange setText:[NSString stringWithFormat:@"使用范围: %@",couponInfo.CouponRange]];
        
        [cell.CouponImg setImage:[UIImage imageNamed:[CouponStatus isEqualToString:@"1"] ? @"mycoupon_canUse"
                                                                                        : @"mycoupon_noUse"]];
    }
    
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * coupontype = [NSString stringWithFormat:@"%d",[arrCouponList[indexPath.row] CouponType]];
    NSString * cid = [NSString stringWithFormat:@"%d",[arrCouponList[indexPath.row] CouponId]];
    NSString * couponrange = [NSString stringWithFormat:@"%@",[arrCouponList[indexPath.row] CouponRange]];
    [self pushNewViewController:@"CouponDetailViewController"
                      isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                 CouponStatus,@"param_CouponStatus", coupontype,@"param_CouponType",cid,@"param_CouponId",couponrange,@"param_CouponRange", nil]];
}

//  --....
#pragma mark    --  scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [rootTableView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [rootTableView tableViewDidDragging];

    if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
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
