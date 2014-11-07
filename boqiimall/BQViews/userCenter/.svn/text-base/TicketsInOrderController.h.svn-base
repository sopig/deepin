//
//  TicketsInOrderController.h
//  BoqiiLife
//
//  Created by YSW on 14-6-9.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "PullToRefreshTableView.h"
#import "TableCell_UserCenter.h"

#import "resMod_MyTickets.h"

@interface TicketsInOrderController : BQIBaseViewController<UITableViewDelegate,UITableViewDataSource,TableCellUserCenterDelegate>{
    
    PullToRefreshTableView * rootTableView;
    
    UIButton * currentStatus;
    
    NSMutableArray * arrTickets;
}

@property (strong, nonatomic) NSString * sOrderId;
@end
