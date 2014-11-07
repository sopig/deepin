//
//  NearMapViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-8.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "NearMapViewController.h"
#import "CommonUtility.h"
#import "LineDashPolyline.h"
#import "resMod_MerchantInfo.h"
#import "resMod_NearList.h"
#import "BQNavBarView.h"


#define span 4000
#define heightToolBar 130
#define heightHead   76/2
#define heightRow    50
#define widthToolButton __MainScreen_Width/3 - 10
#define buttonTag 34987

#define btnTitles_near     @"到这去:btn_gothere:1|电话:btn_call:5|详情:btn_detail1:6"
#define btnTitles_Merchant @"驾车:icon_jx_nomal:1|步行:icon_bx_nomal:2"

@implementation NearMapViewController
@synthesize maproute;
@synthesize startCoordinate;
@synthesize destinationCoordinate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        hasSetMapRect = NO;
    }
    return self;
}

- (void)goBack:(id)sender{
    [MobClick event:@"lifeNear_map_srvList"];
    [super goBack:sender];
}


//- (void)setRouteFrom:(CLLocationCoordinate2D)start To:(CLLocationCoordinate2D)dest
//{
//    [self.mapViewBase removeAnnotations:self.annotationsBase];
//    
//    self.startCoordinate = start;
//    self.destinationCoordinate = dest;
//    
//    self.annotationsBase = [NSMutableArray array];
//    
//    MAPointAnnotation *sPoint = [[MAPointAnnotation alloc] init];
//    sPoint.coordinate = startCoordinate;
//    sPoint.title = @"Start";
//    sPoint.subtitle = @"fadsasdfasf";
//    [self.annotationsBase addObject:sPoint];
//    
//    MAPointAnnotation *tPoint = [[MAPointAnnotation alloc] init];
//    tPoint.coordinate = destinationCoordinate;
//    tPoint.title = @"Destination";
//    [self.annotationsBase addObject:tPoint];
//    
//    
//    
//    MKMapRect flyTo = MKMapRectNull;
//    
//    for (MAPointAnnotation *annotation in self.annotationsBase) {
//        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
//        MKMapRect pointRect = MKMapRectMake(annotationPoint.x-1500, annotationPoint.y-1500, 3000, 3000);
//        if (MKMapRectIsNull(flyTo)) {
//            flyTo = pointRect;
//        } else {
//            flyTo = MKMapRectUnion(flyTo, pointRect);
//        }
//    }
//    
//    CGFloat deltaX = flyTo.size.width / 8;
//    CGFloat deltaY = flyTo.size.height / 8;
//    flyTo.origin.x -= deltaX;
//    flyTo.origin.y -= deltaY;
//    flyTo.size.width += 2*deltaX;
//    flyTo.size.height += 2*deltaY;
//    [self.mapViewBase addAnnotations:self.annotationsBase];
//    
//    MAMapRect maFlyTo = [CommonUtility maMapRectByMKMapRect:flyTo];
//    [self.mapViewBase setVisibleMapRect:maFlyTo animated:YES];
//}

- (void)viewDidLoad{
    [super viewDidLoad];

//    [self setRouteFrom:CLLocationCoordinate2DMake(31.2258903,121.4669681) To:CLLocationCoordinate2DMake(31.3306422, 121.5176082)];
//    return;
    
    
//    UIButton * btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnMore setFrame:CGRectMake(10, 2, 30, 40)];
//    [btnMore setImage:[UIImage imageNamed:@"list_btn.png"] forState:UIControlStateNormal];
//    [btnMore setBackgroundColor:[UIColor clearColor]];
//    [btnMore addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:btnMore];
//    self.navigationItem.rightBarButtonItem = r_bar;
//    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;

    //[self loadNavBarView];
    isFromMerchantPage = [[self.receivedParams objectForKey:@"param_fromMerchant"] isEqualToString:@"1"] ? YES : NO;
    if (!isFromMerchantPage)
    {
        [self setTitle:@"地图模式"];
       // [self loadNavBarView:@"地图模式"];
    }
    else
    {
        [self setTitle:@""];
      //  [self loadNavBarView:nil];
    }
    btn_searchNear = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_searchNear setFrame:CGRectMake(__MainScreen_Width/2-250/4, 6+kNavBarViewHeight, 250/2, 86/2)];
    [btn_searchNear setBackgroundColor:[UIColor clearColor]];
    [btn_searchNear setTitle:@"查看此处商户" forState:UIControlStateNormal];
    [btn_searchNear.titleLabel setFont:defFont14];
    [btn_searchNear setBackgroundImage:def_ImgStretchable(@"btnOra_shadow", 8, 8) forState:UIControlStateNormal];
    [btn_searchNear addTarget:self action:@selector(onSearchNearMerchantClick:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_searchNear];
    
    btn_userLocal = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_userLocal setFrame:CGRectMake(__MainScreen_Width-55, kMainScreenHeight-55, 40, 40)];
    [btn_userLocal setImage:[UIImage imageNamed:@"location_btn.png"] forState:UIControlStateNormal];
    [btn_userLocal addTarget:self action:@selector(onLocalClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_userLocal];

    
    [self initAnnotations];
    
    [self initBottomView: isFromMerchantPage ? YES : NO];

    //  --  ........  call out ticket list
    ViewCallOut = [[UIView alloc] initWithFrame:CGRectMake(0,0,def_WidthArea(20),170)];
    [ViewCallOut setBackgroundColor:[UIColor clearColor]];
    [ViewCallOut setHidden:YES];
    [self.mapViewBase addSubview:ViewCallOut];
    
    tabBG = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,def_WidthArea(20),170)];
    [tabBG setBackgroundColor:[UIColor clearColor]];
    [tabBG setImage:def_ImgStretchable(@"mapPop_BG.png", 70, 8)];
    [ViewCallOut addSubview:tabBG];
    
    lbl_noTickets = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, tabBG.frame.size.width, 20)];
    [lbl_noTickets setBackgroundColor:[UIColor clearColor]];
    [lbl_noTickets  setHidden:YES];
    [lbl_noTickets setText:@"未查询到该商户服务券！"];
    [lbl_noTickets setTextColor:color_333333];
    [lbl_noTickets setFont:defFont15];
    [lbl_noTickets setTextAlignment:NSTextAlignmentCenter];
    [tabBG addSubview:lbl_noTickets];

    tableViewTickets = [[UITableView alloc] initWithFrame:CGRectMake(4,3,tabBG.frame.size.width-8,tabBG.frame.size.height-18) style:UITableViewStylePlain];
    [tableViewTickets setTag:11111];
    tableViewTickets.backgroundColor = [UIColor whiteColor];
    tableViewTickets.bounces = YES;
    tableViewTickets.delegate = self;
    tableViewTickets.dataSource = self;
    tableViewTickets.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableViewTickets.showsHorizontalScrollIndicator= NO;
    tableViewTickets.showsVerticalScrollIndicator  = NO;
    tableViewTickets.layer.cornerRadius = 5.0f;
    [ViewCallOut addSubview:tableViewTickets];

    //----------------------        定时器
    [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector: @selector(handleTimer:) userInfo:nil repeats: NO];

//    [self addObserver:self forKeyPath:@"m_tickets" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    UIButton * btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnMore setFrame:CGRectMake(280, 2, 30, 40)];
    [btnMore setImage:[UIImage imageNamed:@"list_btn.png"] forState:UIControlStateNormal];
    [btnMore setBackgroundColor:[UIColor clearColor]];
    [btnMore addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:btnMore];
}

//- (void)loadNavBarView:(NSString *)title
//{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = title;
//    [bgView addSubview:titleLabel];
//    UIButton * btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnMore setFrame:CGRectMake(280, 2, 30, 40)];
//    [btnMore setImage:[UIImage imageNamed:@"list_btn.png"] forState:UIControlStateNormal];
//    [btnMore setBackgroundColor:[UIColor clearColor]];
//    [btnMore addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:btnMore];
//    [self.navBarView addSubview:bgView];
//}


- (void)initBottomView:(BOOL) isShow{
    
    if (alphaBg)       [alphaBg removeFromSuperview];
    if (toolBarView)   [toolBarView removeFromSuperview];
    
    alphaBg = [[UIView alloc]initWithFrame:CGRectMake(0,kMainScreenHeight,__MainScreen_Width, heightToolBar)];
    [alphaBg setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.8]];//convertHexToRGB:@"F0F0F0"
    [self.view addSubview:alphaBg];

    toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0,kMainScreenHeight,__MainScreen_Width, heightToolBar)];
    [toolBarView setBackgroundColor:[UIColor clearColor]];//convertHexToRGB:@"F0F0F0"
    [self.view addSubview:toolBarView];
    
    lbl_pName = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 80, 30)];
    [lbl_pName setBackgroundColor:[UIColor clearColor]];
    [lbl_pName setText:@"淘气宝贝宠物店"];
    [lbl_pName setFont:defFont16];
    [lbl_pName setTextColor:color_4e4e4e];
    [toolBarView addSubview:lbl_pName];
    
    lbl_roadName = [[UILabel alloc] initWithFrame:CGRectMake(100, 8, 150, 30)];
    [lbl_roadName setBackgroundColor:[UIColor clearColor]];
    [lbl_roadName setText:@"杨浦区政和路1117号"];
    [lbl_roadName setFont: defFont14];
    [lbl_roadName setTextColor:color_717171];
    [toolBarView addSubview:lbl_roadName];
    
    int xPoint;
    NSArray * arrTitles = [(isFromMerchantPage ? btnTitles_Merchant : btnTitles_near) componentsSeparatedByString:@"|"];
    for (int i=0; i<arrTitles.count; i++) {
        
        NSArray * arrtxt = [arrTitles[i] componentsSeparatedByString:@":"];
        NSString * stitle = arrtxt[0];
        NSString * stxt_img = arrtxt[1];
        int   iTag = [arrtxt[2] intValue];
        
        xPoint = (__MainScreen_Width-10)/arrTitles.count*i + 8;
        UIButton * btnTool = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnTool setTag:buttonTag+iTag];
        [btnTool setUserInteractionEnabled:YES];
        [btnTool setFrame:CGRectMake(xPoint, 46, widthToolButton, 36)];
        [btnTool setBackgroundColor: color_8fc31f];
        btnTool.layer.cornerRadius= 3.0f;
        [btnTool setTitle:stitle forState:UIControlStateNormal];
        [btnTool.titleLabel setFont:defFont14];
        [btnTool setImage:[UIImage imageNamed:stxt_img] forState:UIControlStateNormal];
        [btnTool addTarget:self action:@selector(onFunctionClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolBarView bringSubviewToFront:btnTool];
        [toolBarView addSubview:btnTool];
        
        if (isFromMerchantPage) {
            [lbl_pName setHidden:YES];
            [lbl_roadName setHidden:YES];
            [btnTool setFrame:CGRectMake(__MainScreen_Width/2*i+10, 7, __MainScreen_Width/2-20, 36)];
            [alphaBg setBackgroundColor:[UIColor blackColor]];
            [alphaBg setAlpha:0.5];
            [alphaBg setFrame:CGRectMake(0,kMainScreenHeight-alphaBg.frame.size.height,__MainScreen_Width, 50)];
            [toolBarView setFrame:CGRectMake(0,kMainScreenHeight-toolBarView.frame.size.height,__MainScreen_Width, 50)];
        }
        else{

            lbl_spaceline = [[UILabel alloc] initWithFrame:CGRectZero];
            [lbl_spaceline setBackgroundColor:color_717171];
            [toolBarView addSubview:lbl_spaceline];
            
            [UICommon Common_line:CGRectMake(0, 40, toolBarView.frame.size.width, 0.5) targetView:toolBarView backColor:color_d1d1d1];
        }
    }
    
    if (!isFromMerchantPage) {
        [UIView animateWithDuration:0.3
                         animations:^{
                            [alphaBg setFrame:CGRectMake(0,kMainScreenHeight,__MainScreen_Width, heightToolBar)];
                            [toolBarView setFrame:CGRectMake(0,kMainScreenHeight,__MainScreen_Width, heightToolBar)];
                             if (isShow) {
                                 [alphaBg setFrame:CGRectMake(0,kMainScreenHeight-90,__MainScreen_Width, heightToolBar)];
                                 [toolBarView setFrame:CGRectMake(0,kMainScreenHeight-90,__MainScreen_Width, heightToolBar)];
                             }
                         }];
    }
}

- (void)initAnnotations{
    //  --  remove annotation
    [self.mapViewBase removeOverlays:self.mapViewBase.overlays];
    [self.mapViewBase removeAnnotations:self.annotationsBase];
    [self.annotationsBase removeAllObjects];
    
    for (resMod_MerchantInfo * merchantInfo in self.nearMerchantList) {
        CLLocationCoordinate2D location2D=CLLocationCoordinate2DMake([merchantInfo.MerchantLat doubleValue],
                                                                     [merchantInfo.MerchantLng doubleValue]);
        if(fabs(location2D.latitude)>0.5 && fabs(location2D.longitude)>0.5 ) {
            EC_MAPointAnnotation *sPoint = [[EC_MAPointAnnotation alloc] init];
            sPoint.coordinate = location2D;
            sPoint.merchantName = merchantInfo.MerchantTitle.length>0 ? merchantInfo.MerchantTitle :merchantInfo.MerchantName;
            sPoint.merchantPhone = merchantInfo.MerchantTele;
            sPoint.merchantid = [NSString stringWithFormat:@"%d",merchantInfo.MerchantId];
            sPoint.merchantAddress = merchantInfo.BusinessArea;
            
            [self.annotationsBase addObject:sPoint];
            
            if (isFromMerchantPage) {
                
                [self setTitle:merchantInfo.MerchantName];
              // titleLabel.text = merchantInfo.MerchantName;
                self.destinationCoordinate = location2D;
            }
        }
    }
    
    //  --  计算map可视区域
    [self MapRect];
    
    //  --  add annotation
    [self.mapViewBase addAnnotations:self.annotationsBase];
}

- (void)presentCurrentRoute {
    NSArray *polylines = nil;
    
    polylines = [CommonUtility polylinesForPath:self.maproute.paths[0]];
    [self.mapViewBase addOverlays:polylines];
}

#pragma mark    --  下面功能区 事件
- (void) handleTimer:(id) sender{
    hasSetMapRect = YES;    //  --关闭地图可视
}

- (void) onLocalClick:(id) sender{
//    self.mapViewBase.showsUserLocation = YES;
    self.mapViewBase.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)onSearchNearMerchantClick:(id) sender{
    isFromMerchantPage = NO;
    [self initBottomView:NO];
    [self goApiRequest_nearMerchant];
}

- (void)onFunctionClick:(id)sender{
    UIButton *btnTmp= (UIButton*)sender;
    int btnTag = btnTmp.tag-buttonTag;
    if (btnTag == 1 || btnTag==2 ) {      //-- 到这儿去.....
        
        [MobClick event:@"near_Map_gotoMerchant"];
        //  --  出发点.
        AMapGeoPoint *navOrigin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                                            longitude:self.startCoordinate.longitude];
        //  --  目的地.
        AMapGeoPoint *navDestination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                                 longitude:self.destinationCoordinate.longitude];
        
        if (btnTag==1)
        {
            
            [self searchPathForDriveOrWalk: AMapSearchType_NaviDrive nav_origin:navOrigin nav_destination:navDestination];
            
        }
        if (btnTag==2) {
            navDestination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                                    longitude:self.destinationCoordinate.longitude];
            [self searchPathForDriveOrWalk: AMapSearchType_NaviWalking nav_origin:navOrigin nav_destination:navDestination];
        }
        [MobClick event:@"lifeNear_map_gotoMerchant"];
    }
    else if(btnTag == 5){               //-- 电话.....
        
        [MobClick event:@"near_Map_call"];

        if ([[BQ_global questModelInfo] isEqualToString:@"iPhone"]) {
            
            NSString * stel = [selMAnnotation.merchantPhone stringByReplacingOccurrencesOfString:@"," withString:@""];
            stel = [stel stringByReplacingOccurrencesOfString:@" " withString:@""];
            EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"拨 打"
                                                                                  message:stel
                                                                        cancelButtonTitle:@"取消"
                                                                            okButtonTitle:@"呼叫"];
            alertView.delegate1 = self;
            [alertView setTag:9839];
            [alertView show];
        }
        else{
            [self HUDShow:@"您的设备不支持通话" delay:1.5];
        }
    }
    else if(btnTag == 6){               //-- 详情......
        
        [MobClick event:@"near_Map_merchantDetail"];

        [self pushNewViewController:@"MerchantDetailViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:selMAnnotation.merchantid,@"param_MerchantId", nil]];
    }
}
#pragma mark    --  aMap operation
/* 根据所有坐标点 算可视区域. */
- (void)MapRect {
    if (!hasSetMapRect) {
        NSMutableArray * annotationAndUserLocal= [[NSMutableArray alloc] initWithCapacity:0];
        [annotationAndUserLocal addObjectsFromArray:self.annotationsBase];
        
        //  -- 把用户坐标加一起  算地图可视区
        MAPointAnnotation *sPoint = [[MAPointAnnotation alloc] init];
        sPoint.coordinate = self.startCoordinate;
        if (sPoint.coordinate.latitude!=0 && sPoint.coordinate.longitude!=0) {
            [annotationAndUserLocal addObject:sPoint];
        }
        
        [self setMapRectByAnnotations:annotationAndUserLocal];
    }
}

#pragma mark    --  aMap   MAMapViewDelegate
//  --  annotation   生成
-(MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    if ([annotation isKindOfClass:[EC_MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        [annotationView setTag:89893];
        annotationView.enabled = YES;           // 是否响应 Touch 事件.
        annotationView.canShowCallout= NO;     // 控制轻击按钮是否生成一个注解视图，默认为Yes－开启.
        annotationView.rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeCustom];
        
        annotationView.image = [UIImage imageNamed:@"Annotation_ora"];
        annotationView.calloutOffset = CGPointMake(2.0, 0);    // 矫正callout的位置
        annotationView.centerOffset = CGPointMake(0, -14.5);
        
        return annotationView;
    }
    return nil;
}
//  --  点出大头针时.
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    
    
    if (view.tag!=89893) {  return; }
    [MobClick event:@"near_Map_merchant"];
    
    [self initBottomView:YES];
    
    selAnnotationView = view;
    selMAnnotation = view.annotation;
    self.destinationCoordinate = selMAnnotation.coordinate;

    CGSize tsize1 = [selMAnnotation.merchantName sizeWithFont:defFont17 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    CGSize tsize2 = [selMAnnotation.merchantAddress sizeWithFont:defFont14 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    lbl_pName.text = selMAnnotation.merchantName;
    lbl_roadName.text = selMAnnotation.merchantAddress;
    [lbl_pName setFrame:CGRectMake(10, 6, tsize1.width, 30)];
    [lbl_spaceline setFrame:CGRectMake(tsize1.width+16, 15, 1, lbl_roadName.text.length==0?0:13)];
    [lbl_roadName setFrame:CGRectMake(tsize1.width+23, 7, tsize2.width, 30)];
    
    //  -- 点击变大一号
    CGRect r = view.frame;
    r.origin.x -= r.size.width * 0.07;
    r.origin.y -= r.size.height * 0.14;
    r.size.width *= 1.14;
    r.size.height *= 1.14;
    
    view.image = [UIImage imageNamed:@"Annotation_Blue"];
    
    rootViewPoint = [[view superview] convertPoint:CGPointMake(r.origin.x, r.origin.y) toView:self.view];
    
    [self goApiRequest_TicketsByMerchant:selMAnnotation.merchantid];
    [ViewCallOut setHidden:NO];
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                     animations: ^{
                         view.frame = r;
                     }
                     completion: ^(BOOL finished) {
                     }
     ];
    
    [MobClick event:@"lifeNear_map_merchant"];
}

//  --  取消选择大图钉时
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    
    [self initBottomView:NO];
    if (view.tag!=89893) {
        return;
    }
    
    //  -- 取消选择后变回原大小
    CGRect r = view.frame;
    r.origin.x += r.size.width*0.07;
    r.origin.y += r.size.height*0.07;
    r.size.width = 35;
    r.size.height = 35;
    view.image = [UIImage imageNamed:@"Annotation_ora"];
    view.frame = r;
    
    [ViewCallOut setHidden:YES];
}

//  --  路 径 回 调
- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response
{
    [self hudWasHidden:HUD];
    if (response.route == nil) {
        self.maproute = nil;
        return;
    }
    
    self.maproute = response.route;
    [self.mapViewBase removeOverlays:self.mapViewBase.overlays];
    [self presentCurrentRoute];
    
    //  --路线查询成功后跳到方案页
    NSMutableDictionary * dicparam = [[NSMutableDictionary alloc]initWithCapacity:3];
    [dicparam setObject:self.maproute forKey:@"param_route"];
    [dicparam setObject:lbl_roadName.text.length>0?lbl_roadName.text:(lbl_pName.text.length>0 ? lbl_pName.text:@"")
                 forKey:@"param_targetRoad"];
    [dicparam setObject:request.searchType==AMapSearchType_NaviDrive ? @"0" : @"1" forKey:@"param_searchType"];
    [self pushNewViewController:@"MapRoutePlanViewController"
                      isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:dicparam];
}

/*! @brief 通知查询成功或失败的回调函数   */
- (void)search:(id)searchRequest error:(NSString*)errInfo{
    [self HUDShow:errInfo delay:2];
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineView *overlayView = [[MAPolylineView alloc] initWithPolyline:overlay];
        overlayView.lineWidth   = 5;
        overlayView.strokeColor = [UIColor colorWithRed:0.3 green:0.6 blue:1.0 alpha:0.9];
        overlayView.lineJoin = kCGLineJoinRound;
        
        return overlayView;
    }
    return nil;
}

//  --  地图定位更新回调
-(void)mapView:(MAMapView*)mapView didUpdateUserLocation:(MAUserLocation*)userLocation updatingLocation:(BOOL)updatingLocation
{
    NSLog(@"-----定位成功");
    
    //--    用户地理坐标
    self.startCoordinate    = userLocation.coordinate;
    [self MapRect];
}
//- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView{
//    NSLog(@"-----定位停止时");
//}
//  --  地图定位失败
//-(void)mapView:(MAMapView*)mapView didFailToLocateUserWithError:(NSError*)error
//{
//    NSLog(@"-----定位失败啦");
//}
/*!
 @brief 地图区域即将改变时会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    [btn_searchNear setHidden:YES];
    if (!ViewCallOut.hidden) {
        [tabBG setHidden:YES];
        [tableViewTickets setHidden:YES];
    }
}

/*!
 @brief 地图区域改变完成后会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [btn_searchNear setHidden:NO];
    
    rootViewPoint = [[selAnnotationView superview] convertPoint:CGPointMake(selAnnotationView.frame.origin.x, selAnnotationView.frame.origin.y) toView:self.view];
    [self resetCallOutFrame];
}


//打电话
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //  --打电话
    if (alertView.tag == 9839) {
        if(buttonIndex == 1) {
            NSString * stel = [selMAnnotation.subtitle stringByReplacingOccurrencesOfString:@"-" withString:@""];
            stel = [stel stringByReplacingOccurrencesOfString:@"," withString:@""];
            stel = [stel stringByReplacingOccurrencesOfString:@" " withString:@""];
            stel = [NSString stringWithFormat:@"tel://%@",stel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stel]];
        }
    }
}


#pragma mark    --  Table view : call Out Tickets
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.m_tickets?self.m_tickets.count:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return heightHead;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableViewTickets.frame.size.width, heightHead)];
    [headview setBackgroundColor:[UIColor whiteColor]];
    UILabel * lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 239, heightHead)];
    [lblTitle setBackgroundColor:[UIColor whiteColor]];
    [lblTitle setText: selMAnnotation.merchantName];//@"淘气宝贝宠物店"
    [lblTitle setTextColor:color_333333];
    [lblTitle setFont:defFont16];
    [headview addSubview:lblTitle];
    
    UILabel * lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, heightHead-2, headview.frame.size.width, 2)];
    [lblLine setBackgroundColor:color_8fc31f];
    [headview addSubview:lblLine];
    return headview;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString * Identifier = @"ticketsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
        [UICommon Common_UILabel_Add:CGRectMake(10, 5, def_WidthArea(38), 40)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1111
                                text:@"波奇狗狗感动就像蓝天对草原的问候/洗澡/寄养/用券寄养通用"
                               align:-1 isBold:NO fontSize:14 tColor:color_4e4e4e];
        
        [UICommon Common_UILabel_Add:CGRectMake(tableView.frame.size.width-100, 25, 77, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1112
                                text:@"128.00元"
                               align:1 isBold:NO fontSize:14 tColor:color_fc4a00];
        
        [UICommon Common_line:CGRectMake(0, heightRow-0.5, tableViewTickets.frame.size.width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
        
        UIImageView * righticon = [[UIImageView alloc] initWithFrame:CGRectMake(tableViewTickets.frame.size.width-18, heightRow/2-6, 15, 15)];
        [righticon setImage:[UIImage imageNamed:@"right_icon.png"]];
        [righticon setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:righticon];
    }
    
    if (self.m_tickets.count>0) {
        resMod_NearTicketInfo * ticketInfo = self.m_tickets[indexPath.row];
        UILabel * lbl_1111 = (UILabel*)[cell.contentView viewWithTag:1111];
        UILabel * lbl_1112 = (UILabel*)[cell.contentView viewWithTag:1112];

        CGSize tsize = [ticketInfo.TicketTitle sizeWithFont:defFont14 constrainedToSize:CGSizeMake(def_WidthArea(35), MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        [lbl_1111 setFrame:CGRectMake(lbl_1111.frame.origin.x,lbl_1111.frame.origin.y,lbl_1111.frame.size.width,tsize.height)];
        [lbl_1111 setText: ticketInfo.TicketTitle];
        [lbl_1112 setText: [self convertPrice:ticketInfo.TicketPrice]];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    resMod_NearTicketInfo * tmpTicketinfo= self.m_tickets[indexPath.row];
    if (tmpTicketinfo!=nil) {
        NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:1];
        [params setObject:[NSString stringWithFormat:@"%d",tmpTicketinfo.TicketId] forKey:@"param_TicketId"];
        [self pushNewViewController:@"ServiceDetailViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:params];
    }
}


#pragma mark    -- NSKeyValueObservering
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    if([keyPath isEqualToString:@"m_tickets"]) {
//
//        [self.mapViewBase bringSubviewToFront:ViewCallOut];
//        
//        [lbl_noTickets setHidden:YES];
//        [tableViewTickets setHidden:YES];
//
//        [self resetCallOutFrame];
//        [tableViewTickets reloadData];
//    }
//}
#pragma mark    -- 当数据源改变
- (void) onDataSourceChanged_mtickets{
    [self.mapViewBase bringSubviewToFront:ViewCallOut];
    
    [lbl_noTickets setHidden:YES];
    [tableViewTickets setHidden:YES];
    
    [self resetCallOutFrame];
    [tableViewTickets reloadData];
}

- (void) resetCallOutFrame{
    [tabBG setHidden:NO];
    rootViewPoint.y -= kNavBarViewHeight;
    
    if (self.m_tickets && self.m_tickets.count>1) {
        [tableViewTickets setHidden:NO];
        
        [ViewCallOut setFrame:CGRectMake(rootViewPoint.x-35, rootViewPoint.y-165, ViewCallOut.frame.size.width, 170)];
        [tabBG setFrame:CGRectMake(0,0,def_WidthArea(20),170)];
        [tableViewTickets setFrame:CGRectMake(4,3,tabBG.frame.size.width-8,tabBG.frame.size.height-18)];
    }
    if (self.m_tickets && self.m_tickets.count==1) {
        [tableViewTickets setHidden:NO];
        
        [ViewCallOut setFrame:CGRectMake(rootViewPoint.x-35, rootViewPoint.y-165+heightRow, ViewCallOut.frame.size.width, 170-heightRow)];
        [tabBG setFrame:CGRectMake(0,0,def_WidthArea(20),170-heightRow)];
        [tableViewTickets setFrame:CGRectMake(4,3,tabBG.frame.size.width-8,tabBG.frame.size.height-18)];
    }
    if (self.m_tickets.count==0) {
        [lbl_noTickets setHidden:NO];
        [tableViewTickets setHidden:YES];
        
        [ViewCallOut setFrame:CGRectMake(rootViewPoint.x-35, rootViewPoint.y-165+heightRow*2, ViewCallOut.frame.size.width, 170-heightRow*2)];
        [tabBG setFrame:CGRectMake(0,0,def_WidthArea(20),170-heightRow*2)];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
