//
//  NearbyViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-4-30.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "PullToRefreshTableView.h"
#import "DropDownFilterView.h"
#import "resMod_GetFilterCategory.h"
#import "EC_SegmentedView.h"


@interface NearbyViewController : BQIBaseViewController<UITableViewDelegate,UITableViewDataSource,DropDownFilterViewDelegate,EC_SegmentedViewDelegate>{
    
    EC_SegmentedView *segtitleView;
    UIButton * btn_navMap;
    
    DropDownFilterView * filterView;
    ServiceOrMerchant smCurrentType;
    
    PullToRefreshTableView * rootTableView;
    
    NSMutableArray * m_ServiceList;
    NSMutableArray * m_MerchantList;
    
    NSMutableDictionary * topSwithFilters;
    NSMutableDictionary * dicFilterData;
    NSMutableDictionary * dicFilterResult;
    
    BOOL b_isFirstSwitch;
    BOOL b_isPushRefresh;
//    BOOL isFromGoback;          //如果是后退进入页面就不刷新
}

@property(strong ,nonatomic) NSString * searchKeyWords;
@end
