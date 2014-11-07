//
//  MyOrderViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-15.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "resMod_MyOrders.h"
#import "PullToRefreshTableView.h"
#import "TableCell_UserCenter.h"


@interface MyOrderViewController : BQIBaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,TableCellUserCenterDelegate>{
    
    PullToRefreshTableView * rootTableView;
    
    UIButton * currentStatus;
    
    NSMutableArray * arrOrderList;
    
    int     iCancleOrderID;
    BOOL    b_isPullRefresh;
}

@property(strong,nonatomic) NSString * iOrderType;

@end
