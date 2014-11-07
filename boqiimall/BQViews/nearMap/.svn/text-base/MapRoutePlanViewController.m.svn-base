//
//  MapRoutePlanViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-16.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MapRoutePlanViewController.h"

#define heightCellRow  90
#define heightCellHead 90

@implementation MapRoutePlanViewController
@synthesize mapRoute;
@synthesize sTarget;
@synthesize para_AMapSearchType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self loadNavBarView];
    [self setTitle:@""];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    

    self.mapRoute = [self.receivedParams objectForKey:@"param_route"];
    self.sTarget = [self.receivedParams objectForKey:@"param_targetRoad"];
    self.para_AMapSearchType = [self.receivedParams objectForKey:@"param_searchType"];
    if (self.para_AMapSearchType.length>0) {
        [segtitleView setButtonIndex:[self.para_AMapSearchType intValue]];
    }
    
    self.searchApi = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
    self.searchApi.delegate = self;
    
    rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, __ContentHeight_noTab) style:UITableViewStylePlain];
    rootTableView.backgroundColor = color_body;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    [self.view addSubview:rootTableView];
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    [self._titleLabel setHidden:YES];
    segtitleView = [[EC_SegmentedView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2-80, 4, 180, 36)
                                                 btntitle1:@"驾车" btn1Img:@"icon_jx_press"
                                                 btntitle2:@"步行" btn2Img:@"icon_bx_press"
                                                 img1Press:@"icon_jx_nomal" img2press:@"icon_bx_nomal"];
    [segtitleView setSegmentDelegate:self];
    [self.subNavBarView addSubview:segtitleView];

}

//- (void)loadNavBarView {
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    segtitleView = [[EC_SegmentedView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2-80, 4, 180, 36)
//                                                 btntitle1:@"驾车" btn1Img:@"icon_jx_press"
//                                                 btntitle2:@"步行" btn2Img:@"icon_bx_press"
//                                                 img1Press:@"icon_jx_nomal" img2press:@"icon_bx_nomal"];
//    [segtitleView setSegmentDelegate:self];
//    [bgView addSubview:segtitleView];
//    [self.navBarView addSubview:bgView];
//}



#pragma mark    --  load ui
//- (void)addTitleView {
//    
//    segtitleView = [[EC_SegmentedView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2-80, 4+kStatusBarHeight, 180, 36)
//                                                 btntitle1:@"驾车" btn1Img:@"icon_jx_press"
//                                                 btntitle2:@"步行" btn2Img:@"icon_bx_press"
//                                                 img1Press:@"icon_jx_nomal" img2press:@"icon_bx_nomal"];
//    [segtitleView setSegmentDelegate:self];
//    self.navigationItem.titleView = segtitleView;
//}


- (void) loadNoData{
    view_NoData = [[UIView alloc]initWithFrame:CGRectMake(0, heightCellHead, __MainScreen_Width, __ContentHeight_noTab-heightCellHead)];
    [view_NoData setBackgroundColor:[UIColor whiteColor]];
    [view_NoData setHidden:YES];
    
    lbl_NoData = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, __MainScreen_Width, 20)];
    [lbl_NoData setTextAlignment:NSTextAlignmentCenter];
    [lbl_NoData setText: @"没有找到路线，请尝试其它搜索"];
    [lbl_NoData setFont:[UIFont systemFontOfSize:12]];
    [lbl_NoData setTextColor:[UIColor convertHexToRGB:@"999999"]];
    [view_NoData addSubview:lbl_NoData];
    [self.view addSubview:view_NoData];
}

- (void) onSegmentedClick:(int) selectIndex{
    
    self.para_AMapSearchType = [NSString stringWithFormat:@"%d",selectIndex];
    if (selectIndex == 0) {      //-- 驾车.
        [self searchPathForDriveOrWalk:AMapSearchType_NaviDrive nav_origin:self.mapRoute.origin
                       nav_destination:self.mapRoute.destination];
    } else{                      //-- 步行.
        [self searchPathForDriveOrWalk:AMapSearchType_NaviWalking nav_origin:self.mapRoute.origin
                       nav_destination:self.mapRoute.destination];
    }
}


/* 驾车 or 步行 导航搜索. */
- (void)searchPathForDriveOrWalk:(AMapSearchType) searchtype
                      nav_origin:(AMapGeoPoint*) _navorigin
                 nav_destination:(AMapGeoPoint*) _navdestination{
    
    AMapNavigationSearchRequest *navi = [[AMapNavigationSearchRequest alloc] init];
    navi.searchType = searchtype;//AMapSearchType_NaviDrive;
    navi.requireExtension = YES;
    
    //  --  出发点.
    navi.origin = _navorigin;//[AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude longitude:self.startCoordinate.longitude];
    //  --  目的地.
    navi.destination = _navdestination;//[AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude longitude:self.destinationCoordinate.longitude];
    
    [self HUDShow:@"搜索路径..."];
    [self.searchApi AMapNavigationSearch:navi];
}

#pragma mark  --  路 径 回 调
- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response
{
    [self hudWasHidden:HUD];
    if (response.route == nil) {
        if (request.searchType == AMapSearchType_NaviDrive) {
            [self HUDShow:@"没有找到驾车方案" delay: 2];
        }else{
            [self HUDShow:@"没有找到步行方案" delay: 2];
        }
        return;
    }
    
    self.mapRoute = response.route;
    [rootTableView reloadData];
}

/*! @brief 通知查询成功或失败的回调函数   */
- (void)search:(id)searchRequest error:(NSString*)errInfo{
    [self HUDShow:errInfo delay:2];
}


#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    [view_NoData setHidden: self.mapRoute.paths.count];

    return self.mapRoute.paths.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return heightCellRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return heightCellHead;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel * HeadView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 1)];
    [HeadView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView * img1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, heightCellHead/4-7, 12, 12)];
    [img1 setBackgroundColor:[UIColor clearColor]];
    [img1 setImage:[UIImage imageNamed:@"icon_blue_quan"]];
    [HeadView addSubview:img1];
    
    // 三个点
    int ypoint = img1.frame.origin.y+16;
    for (int i=0; i<3; i++) {
        UIImageView * img2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, ypoint+(i*10), 6, 6)];
        [img2 setBackgroundColor:[UIColor clearColor]];
        [img2 setImage:[UIImage imageNamed:@"foucs_normal"]];
        [HeadView addSubview:img2];
    }

    UIImageView * img3 = [[UIImageView alloc] initWithFrame:CGRectMake(12, heightCellHead-28, 12, 12)];
    [img3 setBackgroundColor:[UIColor clearColor]];
    [img3 setImage:[UIImage imageNamed:@"icon_orage_quan"]];
    [HeadView addSubview:img3];
    
    
//    UIImageView * img4 = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width-35, heightCellHead/2-13, 22, 25)];
//    [img4 setBackgroundColor:[UIColor clearColor]];
//    [img4 setImage:[UIImage imageNamed:@"icon_luxian_wf1"]];
//    [HeadView addSubview:img4];
    
    [UICommon Common_line:CGRectMake(40, heightCellHead/2, def_WidthArea(40), 1) targetView:HeadView backColor:color_body];
    
    //我的位置
    UILabel *mylocal = [[UILabel alloc] initWithFrame:CGRectMake(40, 2, 200, heightCellHead/2-4)];
    mylocal.text = @"我的当前位置";
    mylocal.backgroundColor = [UIColor clearColor];
    [mylocal setTextColor: color_333333];
    [mylocal setFont: defFont14];
    [HeadView addSubview:mylocal];
    
    //路线信息
    targetRoad = [[UILabel alloc] initWithFrame:CGRectMake(40, heightCellHead/2+2, 200, heightCellHead/2-4)];
    targetRoad.text = self.sTarget;
    targetRoad.backgroundColor = [UIColor clearColor];
    [targetRoad setTextColor: color_333333];
    [targetRoad setFont: defFont14];
    [HeadView addSubview:targetRoad];
    
    [UICommon Common_line:CGRectMake(0, heightCellHead-1, __MainScreen_Width, 1) targetView:HeadView backColor:color_ededed];
    return HeadView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifierSection = @"packageContructSectionOther";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierSection];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierSection];

        [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width, 10) targetView:cell.contentView backColor:color_body];
        //路线信息
        UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, __MainScreen_Width-50, 50)];
        messageLab.tag = 1000;
        messageLab.text = @"共和新路》呼曲路》无可奈何花落去";
        messageLab.backgroundColor = [UIColor clearColor];
//        messageLab.numberOfLines = 0;
//        messageLab.lineBreakMode = NSLineBreakByCharWrapping;
        [messageLab setTextColor: color_333333];
        [messageLab setFont:[UIFont fontWithName:@"TrebuchetMS" size:14]];
        [cell.contentView addSubview:messageLab];
        
        
        //时间
        UIImageView * imgtime = [[UIImageView alloc] initWithFrame:CGRectMake(12, heightCellRow-28, 18, 18)];
        [imgtime setBackgroundColor:[UIColor clearColor]];
        [imgtime setImage:[UIImage imageNamed:@"icon_timekeeping.png"]];
        [cell.contentView addSubview:imgtime];
        UILabel *lblTime = [[UILabel alloc] initWithFrame:CGRectMake(imgtime.frame.origin.x+25, heightCellRow-28, 100, 20)];
        lblTime.tag = 1001;
        lblTime.text = @"22分钟";
        lblTime.backgroundColor = [UIColor clearColor];
        [lblTime setTextColor: color_717171];
        [lblTime setFont: defFont13];
        [cell.contentView addSubview:lblTime];
        
        
        //里程
        UIImageView * imgfaraway = [[UIImageView alloc] initWithFrame:CGRectMake(150, heightCellRow-30, 22, 22)];
        [imgfaraway setBackgroundColor:[UIColor clearColor]];
        [imgfaraway setImage:[UIImage imageNamed:@"myaddress_icon.png"]];
        [cell.contentView addSubview:imgfaraway];
        UILabel *lblFa = [[UILabel alloc] initWithFrame:CGRectMake(imgfaraway.frame.origin.x+25, heightCellRow-28, 100, 20)];
        lblFa.tag = 1002;
        lblFa.text = @"5公里";
        lblFa.backgroundColor = [UIColor clearColor];
        [lblFa setTextColor: color_717171];
        [lblFa setFont: defFont13];
        [cell.contentView addSubview:lblFa];
        
        
        UIImageView * imgdetail = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width-22, 4+(heightCellRow-15)/2, 15, 15)];
        [imgdetail setBackgroundColor:[UIColor clearColor]];
        [imgdetail setImage:[UIImage imageNamed:@"right_icon.png"]];
        [cell.contentView addSubview:imgdetail];
    }
    
    if (self.mapRoute.paths.count>0) {
        UILabel * lbl_1000 = (UILabel*)[cell.contentView viewWithTag:1000];
        UILabel * lbl_1001 = (UILabel*)[cell.contentView viewWithTag:1001];
        UILabel * lbl_1002 = (UILabel*)[cell.contentView viewWithTag:1002];
        
        AMapPath * pathTmp = self.mapRoute.paths[indexPath.row];
        NSArray * arrSteps = pathTmp.steps;
        NSString * pathPlan = @"";
        for (AMapStep * step in arrSteps) {
            if (step.road.length>0) {
                if (pathPlan.length==0) {
                    NSString * ss = pathTmp.strategy.length>0 ? @"：" : @"";
                    pathPlan = [NSString stringWithFormat:@"%@%@%@",pathTmp.strategy,ss,step.road];
                }else {
                    pathPlan = [NSString stringWithFormat:@"%@ > %@",pathPlan,step.road];
                }
            }
        }
        [lbl_1000 setText: pathPlan];
        [lbl_1001 setText: [NSString stringWithFormat:@"%d分钟",pathTmp.duration/60]];
        [lbl_1002 setText: [NSString stringWithFormat:@"%.2f公里",(float)pathTmp.distance/1000]];
    }
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //  --点击具体路线方案后跳到 画路线 页
    NSMutableDictionary * dicparam = [[NSMutableDictionary alloc]initWithCapacity:3];
    [dicparam setObject:self.mapRoute.paths[indexPath.row] forKey:@"params_mapPath"];
    [dicparam setObject:self.mapRoute.origin      forKey:@"param_origin"];
    [dicparam setObject:self.mapRoute.destination forKey:@"param_destination"];
    [dicparam setObject:para_AMapSearchType forKey:@"param_searchType"];
    [self pushNewViewController:@"MapRoutePlanDetailViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:dicparam];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
