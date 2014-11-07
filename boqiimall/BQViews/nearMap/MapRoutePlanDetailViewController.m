//
//  MapRoutePlanDetailViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-17.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MapRoutePlanDetailViewController.h"
#import "CommonUtility.h"
#import "LineDashPolyline.h"

#define heightToolBar 50

#define TAG_BACK_VIEW       310
#define TAG_CENTER_IMG      311
#define TAG_TOP_LINE        312
#define TAG_UNDER_LINE      313
#define TAG_MESSAGE_LAB     314

@implementation MapRoutePlanDetailViewController
@synthesize para_AMapSearchType;
@synthesize mapPath;
@synthesize path_origin;
@synthesize path_destination;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isShowNavBar = NO;
        isRootPage = YES;
        isOpenPathDetail = NO;
        fcontentHeight = IOS7_OR_LATER ? __MainScreenFrame.size.height:__MainScreen_Height;
    }
    return self;
}

- (void) goBack:(id)sender{
    [super goBack:sender];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.view sendSubviewToBack:self.navBarView];
//    [self.view sendSubviewToBack:self.navBarView];
    [self.navBarView setHidden:YES];
    [self NavController_Show:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
  //  [self.navBarView setHidden:YES];
    [self setTitle:@""];
    
    self.mapPath = [self.receivedParams objectForKey:@"params_mapPath"];
    self.path_origin = [self.receivedParams objectForKey:@"param_origin"];
    self.path_destination = [self.receivedParams objectForKey:@"param_destination"];
    self.para_AMapSearchType = [self.receivedParams objectForKey:@"param_searchType"];
    
    [self.mapViewBase setFrame:CGRectMake(0, 0, kMainScreenHeight, fcontentHeight)];
    [self initBackButton];
    [self initBottomView];
    [self drawPathOnMap];
}

- (void)initBackButton{
    //  --  浮层返回按钮
    UIButton * gobackBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, IOS7_OR_LATER ? 30 :20, 40, 40)];
    [gobackBtn setBackgroundColor:[UIColor blackColor]];
    gobackBtn.layer.cornerRadius = 5;
    [gobackBtn setAlpha:0.7];
    [gobackBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    [imgIcon setBackgroundColor:[UIColor clearColor]];
    [imgIcon setImage:[UIImage imageNamed:@"icon_back_white.png"]];
    [gobackBtn addSubview:imgIcon];
    [self.view addSubview:gobackBtn];
}

//  --  下面路线列表明细.
- (void)initBottomView {
    toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0,fcontentHeight-heightToolBar,__MainScreen_Width, heightToolBar)];
    [toolBarView setBackgroundColor:[UIColor blackColor]];
    [toolBarView setAlpha:0.7];
    [self.view addSubview:toolBarView];
    
    [UICommon Common_line:CGRectMake(5, heightToolBar-1, def_WidthArea(5), 1) targetView:toolBarView backColor:color_717171];
    
    //  -- ......
    btnPathDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPathDetail.backgroundColor = [UIColor clearColor];
    [btnPathDetail setFrame:CGRectMake(0, 0, __MainScreen_Width, heightToolBar)];
    [btnPathDetail addTarget:self action:@selector(showPathDetail:) forControlEvents:UIControlEventTouchUpInside];
    imgDetailButtonBg = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2-18, 0, 32, 16)];
    [imgDetailButtonBg setBackgroundColor:[UIColor clearColor]];
    [imgDetailButtonBg setImage:[UIImage imageNamed:@"btn_opendetail"]];
    [btnPathDetail addSubview:imgDetailButtonBg];
    [toolBarView addSubview:btnPathDetail];
    
    //  -- ......
    pathTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, __MainScreen_Width, 30)];
    pathTitle.backgroundColor = [UIColor clearColor];
    pathTitle.textColor = [UIColor whiteColor];
    pathTitle.textAlignment = NSTextAlignmentCenter;
    [pathTitle setFont:[UIFont boldSystemFontOfSize:15]];
    pathTitle.text = @"全程1000米";
    [toolBarView addSubview:pathTitle];
    
    //  --  路线层.
    tablePath = [[UITableView alloc] initWithFrame:CGRectMake(0, fcontentHeight, __MainScreen_Width, 0) style:UITableViewStylePlain];
    [tablePath setHidden:YES];
    tablePath.backgroundColor = [UIColor clearColor];
    tablePath.separatorStyle = UITableViewCellSeparatorStyleNone;
    tablePath.delegate = self;
    tablePath.dataSource = self;
    [self.view addSubview:tablePath];
}

//  --  画 路 线.
- (void)drawPathOnMap {
    
    pathTitle.text = [NSString stringWithFormat:@"导航全程 %@", [self convertDistance:(float)self.mapPath.distance]];
    [self.mapViewBase removeOverlays:self.mapViewBase.overlays];
    
    NSArray *polylines = nil;
    polylines = [CommonUtility polylinesForPath:self.mapPath];
    [self.mapViewBase addOverlays:polylines];
    self.mapViewBase.visibleMapRect = [CommonUtility mapRectForOverlays:polylines];
    
    
    //  -- ......................
//    for (int i=0; i<2; i++) {
//        AMapGeoPoint * pi = path_destination;
        CLLocationCoordinate2D location2D=CLLocationCoordinate2DMake(path_destination.latitude, path_destination.longitude);
        MAPointAnnotation *sPoint = [[MAPointAnnotation alloc] init];
        sPoint.coordinate = location2D;
        [self.annotationsBase addObject:sPoint];
//    }
    //  --   add annotations
    [self.mapViewBase addAnnotations:self.annotationsBase];
}


//  -- 显示下面抽屉层
- (void)showPathDetail:(id)sender {
    
    isOpenPathDetail = !isOpenPathDetail;
    heightForTablePath = 0;
    [tablePath setHidden:NO];
    [tablePath reloadData];
    
    [UIView animateWithDuration:0.3 animations:^{
        if (isOpenPathDetail) {
            [imgDetailButtonBg setImage:[UIImage imageNamed:@"btn_closedetail"]];
            [toolBarView setFrame:CGRectMake(0, fcontentHeight-heightForTablePath-heightToolBar,__MainScreen_Width,heightToolBar+heightForTablePath)];
            [tablePath setFrame:CGRectMake(0, fcontentHeight-heightForTablePath, __MainScreen_Width, heightForTablePath)];
        }
        else{
            [imgDetailButtonBg setImage:[UIImage imageNamed:@"btn_opendetail"]];
            [toolBarView setFrame:CGRectMake(0, fcontentHeight-heightToolBar,__MainScreen_Width,heightToolBar)];
            [tablePath setFrame:CGRectMake(0, fcontentHeight, __MainScreen_Width, heightForTablePath)];
        }
    }];
}

#pragma mark    --  aMap   MAMapViewDelegate

//  --  annotation   生成
-(MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *pointReuseIndetifier = @"pointIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.enabled = YES;           // 是否响应 Touch 事件.
        annotationView.canShowCallout= NO;      // 控制轻击按钮是否生成一个注解视图，默认为Yes－开启.
        annotationView.rightCalloutAccessoryView=[UIButton buttonWithType:UIButtonTypeCustom];
        
        annotationView.image = [UIImage imageNamed:@"Annotation_ora"];
        annotationView.centerOffset = CGPointMake(0, -14.5);
        return annotationView;
    }
    return nil;
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineView *overlayView = [[MAPolylineView alloc] initWithPolyline:overlay];
        overlayView.lineWidth   = 6;
        overlayView.strokeColor = [UIColor colorWithRed:0.3 green:0.6 blue:1.0 alpha:0.9];
        overlayView.lineJoin = kCGLineJoinRound;
        
        return overlayView;
    }
    return nil;
}



#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mapPath.steps.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AMapStep *step = self.mapPath.steps[indexPath.row];
    NSString *message = step.instruction;
    
    RTLabel *tmpLabel = [[RTLabel alloc] initWithFrame:CGRectMake(50, 10, __MainScreen_Width-70, 50)];
    [tmpLabel setParagraphReplacement:@""];
    tmpLabel.text = message;
    CGSize optimumSize = [tmpLabel optimumSize];
    
    //--   设置tableView高度
    heightForTablePath += optimumSize.height + 20;
    if (heightForTablePath>300) {
        heightForTablePath=300;
    }
    [tablePath setContentSize:CGSizeMake(__MainScreen_Width, optimumSize.height)];
    return optimumSize.height + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifierSection = @"packageContructSectionOther";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierSection];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierSection];
        
        UIView *backView = [[UIView alloc] init];
        [backView setBackgroundColor:[UIColor clearColor]];
        backView.tag = TAG_BACK_VIEW;
        
        UIImageView *centerImg = [[UIImageView alloc] init];
        centerImg.tag = TAG_CENTER_IMG;
        centerImg.image = [UIImage imageNamed: [para_AMapSearchType isEqualToString:@"0"] ? @"icon_pathCar_nomal.png":@"icon_pathRen_nomal.png"];
        [backView addSubview:centerImg];
        //竖线
        UILabel *topLine = [[UILabel alloc] init];
        topLine.tag = TAG_TOP_LINE;
        topLine.backgroundColor = [UIColor lightGrayColor];
        [backView addSubview:topLine];
        [topLine setHidden:YES];
        UILabel *underLine = [[UILabel alloc] init];
        underLine.tag = TAG_UNDER_LINE;
        underLine.backgroundColor = [UIColor lightGrayColor];
        [underLine setHidden:YES];
        [backView addSubview:underLine];
        //路线信息
        UILabel *messageLab = [[UILabel alloc] init];
        messageLab.tag = TAG_MESSAGE_LAB;
        messageLab.backgroundColor = [UIColor clearColor];
        messageLab.numberOfLines = 0;
        messageLab.lineBreakMode = NSLineBreakByCharWrapping;
        [messageLab setTextColor:[UIColor whiteColor]];
        [messageLab setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:13]];
        [backView addSubview:messageLab];
        
        [cell.contentView addSubview:backView];
    }
    
    UIImageView *centerImg = (UIImageView *)[cell viewWithTag:TAG_CENTER_IMG];
    UIView *backView = (UIView *)[cell viewWithTag:     TAG_BACK_VIEW];
    UILabel *messageLab = (UILabel *)[cell viewWithTag: TAG_MESSAGE_LAB];
    UILabel *topLine = (UILabel *)[cell viewWithTag:    TAG_TOP_LINE];
    UILabel *underLine = (UILabel *)[cell viewWithTag:  TAG_UNDER_LINE];
    
    AMapStep *step = self.mapPath.steps[indexPath.row];
    NSString *pathMessage = step.instruction;
    if (self.mapPath.steps.count > 0) {
        messageLab.text = pathMessage;       //状态
        UIFont *font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:13];
        CGSize size = [messageLab.text sizeWithFont:font constrainedToSize:CGSizeMake(250, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        
        messageLab.frame = CGRectMake(50.0f, 15.0f, 250.0f, size.height);  //y轴开始距离设置为10像素
        backView.frame  = CGRectMake(5, 0, 310, size.height+30);
        centerImg.frame = CGRectMake(15, (size.height+30)/2-8, 16, 16);
        
        if (indexPath.row == 0) {
            [topLine setHidden:YES];
            [underLine setHidden:NO];
            underLine.frame = CGRectMake(22, (size.height+30)/2+9, 2, (size.height+30)/2-9);
        } else {
            [topLine setHidden:NO];
            [underLine setHidden:NO];
            underLine.frame = CGRectMake(22, (size.height+30)/2+9, 2, (size.height+30)/2-9);
            topLine.frame = CGRectMake(22, 0, 2, (size.height+30)/2-9);
        }
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
