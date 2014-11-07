//
//  SMHomeListViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-6.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "PullToRefreshTableView.h"
#import "DropDownFilterView.h"
#import "resMod_GetFilterCategory.h"
#import "EC_SegmentedView.h"


@interface SMHomeListViewController : BQIBaseViewController<UITableViewDelegate,UITableViewDataSource,DropDownFilterViewDelegate,EC_SegmentedViewDelegate>{
    
    EC_SegmentedView * segtitleView;

    DropDownFilterView * filterView;
    ServiceOrMerchant smCurrentType;

    PullToRefreshTableView * rootTableView;
    
    NSMutableArray * m_ServiceList;
    NSMutableArray * m_MerchantList;
   
    NSMutableDictionary * topSwithFilters;
    NSMutableDictionary * dicFilterData;
    NSMutableDictionary * dicFilterResult;
    
    BOOL b_isFirstSwitch;
    BOOL b_isPullRefresh;
}

@property(strong ,nonatomic) NSString * searchKeyWords;
@property(strong ,nonatomic) NSString * param_serviceSortTypeId;
@property(strong ,nonatomic) NSString * param_typename;
@end
