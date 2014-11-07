//
//  MyCollectViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-16.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "PullToRefreshTableView.h"
#import "resMod_MyCollections.h"

#import "EC_SegmentedView.h"
#import "TableCell_UserCenter.h"

//--    请求环境：商城或生活馆
typedef enum {
    collect_BQMALL,
    collect_BQLIFE
} CollectMallOrLife;

@interface MyCollectViewController : BQIBaseViewController<EC_SegmentedViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,TableCellUserCenterDelegate>{
    
    EC_SegmentedView * segtitleView;
    PullToRefreshTableView * TableView_BQLife;
    PullToRefreshTableView * TableView_BQMall;

    
    UIButton * currentStatus;

    NSMutableArray * arrProductCollections;
    NSMutableArray * arrTicketCollections;
    
    UIView * delWarnView;
    
    CollectMallOrLife collecttype;
    UITableViewCell * currentCell;    
    int delProductId;
    int delTickedId;
    
    BOOL b_isPullRefresh;
}

@end
