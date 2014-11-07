//
//  MapBaseViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-8.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MapBaseViewController.h"
#import <MapKit/MapKit.h>
#import "CommonUtility.h"
#import "LineDashPolyline.h"
#import "resMod_NearList.h"

@implementation EC_MAPointAnnotation
@synthesize merchantid;
@synthesize merchantName;
@synthesize merchantPhone;
@synthesize merchantAddress;
@synthesize b_isShow;
@end


@implementation MapBaseViewController
@synthesize mapViewBase;
@synthesize searchApi;
@synthesize annotationsBase;
@synthesize nearMerchantList;
@synthesize m_tickets;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self configureAPIKeyFor_aMap];
        self.annotationsBase = [[NSMutableArray alloc] initWithCapacity:0];
        self.nearMerchantList = [[NSMutableArray alloc] initWithCapacity:0];
        self.m_tickets = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}


- (void) loadView_UI{
    [self initMapView];
    [self initSearch];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle: @"地图模式"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self loadView_UI];
    
    NSMutableDictionary * dicTmp = [self.receivedParams objectForKey:@"param_merchants"];
    for (resMod_MerchantInfo * minfo in dicTmp) {
        [self.nearMerchantList addObject:minfo];
    }
}

- (void)configureAPIKeyFor_aMap {
    if ([APIKeyFor_aMap length] == 0) {
        NSString *name   = [NSString stringWithFormat:@"\nSDKVersion:%@\nFILE:%s\nLINE:%d\nMETHOD:%s", [MAMapServices sharedServices].SDKVersion, __FILE__, __LINE__, __func__];
        NSString *reason = [NSString stringWithFormat:@"请配置APIKey.h中的APIKey, 申请APIKey参考见 http://api.amap.com"];
        
        @throw [NSException exceptionWithName:name reason:reason userInfo:nil];
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKeyFor_aMap;
}
//
//#pragma mark - clear
//- (void)returnAction {
//    
//    [self.mapView removeAnnotations:self.mapView.annotations];
//    [self.mapView removeOverlays:self.mapView.overlays];
//    self.mapView.delegate = nil;
//    
//    self.searchApi.delegate = nil;
//}

#pragma mark - AMapSearchDelegate

- (void)search:(id)searchRequest error:(NSString *)errInfo {
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [searchRequest class], errInfo);
}

#pragma mark - Initialization

- (void)initMapView {
    self.mapViewBase = [[MAMapView alloc] initWithFrame:CGRectMake(0,kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
//    self.mapViewBase.Frame = CGRectMake(0,kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight);
    self.mapViewBase.delegate = self;
    self.mapViewBase.showsCompass = NO;
    self.mapViewBase.showsScale = NO;
    self.mapViewBase.showsUserLocation = YES;

    [self.view addSubview:self.mapViewBase];
}

- (void)initSearch {
    self.searchApi = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
    self.searchApi.delegate = self;
}

- (void)initAnnotations{
    
}


#pragma mark    --  aMap   根据所有坐标点 算可视区域.
- (void)setMapRectByAnnotations:(NSMutableArray *) arrAnnotations {
    
    MKMapRect flyTo = MKMapRectNull;
//    NSMutableArray * annotationAndUserLocal= [[NSMutableArray alloc] initWithCapacity:0];
//    [annotationAndUserLocal addObjectsFromArray:self.annotationsBase];
    
    for (MAPointAnnotation *annotation in arrAnnotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x-1500, annotationPoint.y-1500, 3000, 3000);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    CGFloat deltaX = flyTo.size.width / 8;
    CGFloat deltaY = flyTo.size.height / 8;
    flyTo.origin.x -= deltaX;
    flyTo.origin.y -= deltaY;
    flyTo.size.width += 2*deltaX;
    flyTo.size.height += 2*deltaY;
    //TODO BUG
    MAMapRect maFlyTo = [CommonUtility maMapRectByMKMapRect:flyTo];
    [self.mapViewBase setVisibleMapRect:maFlyTo animated:NO];
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

#pragma mark    --  取附近商户
- (void) goApiRequest_nearMerchant{
    
    [self.nearMerchantList removeAllObjects];
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setObject:[NSString stringWithFormat:@"%3.10f",self.mapViewBase.centerCoordinate.latitude] forKey:@"Lat"];
    [dicParams setObject:[NSString stringWithFormat:@"%3.10f",self.mapViewBase.centerCoordinate.longitude] forKey:@"Lng"];
    [dicParams setValue:@"0" forKey:@"StartIndex"];
    [dicParams setValue:@"10" forKey:@"Number"];
    [dicParams setValue:@"2" forKey:@"OrderTypeId"];    //  -- 离我最近
    
    //  --算地图可视区域范围 ：以中心方圆多少公里
    CLLocation *centerLoc = [[CLLocation alloc] initWithLatitude:mapViewBase.centerCoordinate.latitude longitude:mapViewBase.centerCoordinate.longitude];
    CLLocation *upperBLoc = [[CLLocation alloc] initWithLatitude:mapViewBase.centerCoordinate.latitude - mapViewBase.region.span.latitudeDelta longitude:mapViewBase.centerCoordinate.longitude];
    CLLocationDistance rDistance = [centerLoc distanceFromLocation:upperBLoc];
    NSString *distanceStr = [NSString stringWithFormat:@"%f", rDistance/1000];
    
    [dicParams setValue:distanceStr forKey:@"Scope"];         //  -- 表示搜索范围，以KM为单位

//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_MerchantList class:@"resMod_CallBack_MerchantList"
////              params:dicParams isShowLoadingAnimal:NO hudShow:@"搜索中..."];SearchMerchantList
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestSearchMerchantList:dicParams ModelClass:@"resMod_CallBack_MerchantList" showLoadingAnimal:NO hudContent:@"搜索中" delegate:self];
}

#pragma mark    --  取商户对应的券
- (void) goApiRequest_TicketsByMerchant:(NSString *) _merchantid{
    
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:_merchantid forKey:@"MerchantId"];
    [dicParams setValue:@"0" forKey:@"StartIndex"];
    [dicParams setValue:@"-1" forKey:@"Number"];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_TicketListByMerchant class:@"resMod_CallBack_TicketListByMerchant"
//              params:dicParams  isShowLoadingAnimal:NO hudShow:@"正在加载"];
//    GetMerchantTicketList
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMerchantTicketList:dicParams ModelClass:@"resMod_CallBack_TicketListByMerchant" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if([ApiName isEqualToString:kApiMethod_MerchantList]){
        resMod_CallBack_MerchantList * backObj = [[resMod_CallBack_MerchantList alloc] initWithDic:retObj];
        [self.nearMerchantList addObjectsFromArray: backObj.ResponseData];
        [self initAnnotations];
    }
    if ([ApiName isEqualToString:kApiMethod_TicketListByMerchant]) {
        resMod_CallBack_TicketListByMerchant * backObj = [[resMod_CallBack_TicketListByMerchant alloc] initWithDic:retObj];
        self.m_tickets = backObj.ResponseData;
        [self onDataSourceChanged_mtickets];
    }
    [self hudWasHidden:HUD];
}


- (void) onDataSourceChanged_mtickets{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
