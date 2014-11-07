//
//  MyMallOrderListController.h
//  boqiimall
//
//  Created by YSW on 14-6-26.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "PullToRefreshTableView.h"
#import "TableCell_UserCenter.h"
#import "resMod_Mall_Order.h"

@interface MyMallOrderListController : BQIBaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,TableCellUserCenterDelegate,EC_UICustomAlertViewDelegate>{
    
    PullToRefreshTableView * rootTableView;
    
    NSMutableArray * arr_MallOrderList;
    
    UIButton * currentStatus;
    BOOL isBack;
    BOOL needRefresh;
    BOOL b_isPullRefresh;
    
    int iCancleOrderID;
}

@property (strong,nonatomic) NSString * iOrderType;
@end
