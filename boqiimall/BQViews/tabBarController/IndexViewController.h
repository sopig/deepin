//
//  IndexViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-4-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//  生活馆首页

#import "BQIBaseViewController.h"
#import "PullToRefreshTableView.h"
#import "TableCell_Index.h"
#import "resMod_IndexData.h"
#import "EC_UICustomAlertView.h"

//  -- button扩展 .........................
@interface EC_LifeSubCatesButton : UIButton
@property (strong,nonatomic) NSString * cateType;
@property (assign,nonatomic) int cateID;
@property (assign,nonatomic) NSString * cateName;
@end


@interface IndexViewController : BQIBaseViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MBProgressHUDDelegate,TableCell_IndexDelegate,EC_UICustomAlertViewDelegate,EC_UICustomAlertViewDelegate>{
    
    UIButton * btn_city;
    
    PullToRefreshTableView * tableView_Root;
    UIScrollView  * scrollview_banner;          // -- 大banner
    UIButton * viewCityBG;
    UIView * viewCityContent;

    NSMutableArray * m_openCitys;       // 开通城市
    NSMutableArray * m_BannerList;      // bannerData
    UIPageControl  * pageControl;       // bannerPage
    
    NSMutableArray * m_HotList;
    NSMutableArray * m_LowPriceList;
    NSMutableArray * m_ServiceCatesList;
    
    
    BOOL isFirstComeInPage;
    BOOL isShowOpenCity;
    int TimeNum;
    BOOL Tend;
    int pageControlCurrent;
    BOOL isAllowLoading;             //是否刷新
}

@property (strong,nonatomic) NSString * checkedCityID;
@property (strong,nonatomic) NSString * checkedCityName;
@property (strong,nonatomic) NSMutableDictionary * dic_ServiceCategory;

@end
