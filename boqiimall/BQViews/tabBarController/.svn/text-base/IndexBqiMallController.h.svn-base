//
//  IndexBqiMallController.h
//  BoqiiLife
//
//  Created by YSW on 14-6-17.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "PullToRefreshTableView.h"
#import "FirstOpenApp_CheckMallCategory.h"

#import "resMod_Mall_IndexData.h"
#import "TableCell_Mosaic.h"


@interface IndexBqiMallController : BQIBaseViewController<TableCellMosaicDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,CheckMallCategoryDelegate>{
    
    PullToRefreshTableView * rootTableView;
    UIScrollView * scrollview_banner;
    
    
    UIView * viewMallCates;
    UIView * viewMallSubCates;
    UIView * catesSelectBg;
    UILabel * lblSelCatesName;
    
    resMod_Mall_IndexResponseData * indexData;
    UIPageControl  * pageControl;       // bannerPage
//    NSMutableArray * m_BannerArr;
//    NSMutableArray * m_MainArr;
//    NSMutableArray * m_RecommendList;
    
    UIButton * currentSelCate;
    
    
    int TimeNum;
    BOOL Tend;
    int pageControlCurrent;
}

@property (strong,nonatomic)    NSMutableArray * m_BannerArr;
@property (strong,nonatomic)    NSMutableArray * m_MainArr;
@property (strong,nonatomic)    NSMutableArray * m_RecommendList;
//@property (assign,nonatomic)    BOOL    isPopRootFromNotification;
@end
