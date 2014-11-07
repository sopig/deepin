//
//  SMRecommendViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"

//  -- 活动推荐页，例如首页banner
@interface SMRecommendViewController : BQIBaseViewController<UITableViewDelegate,UITableViewDataSource>{

    UIView * view_NoData;
    UILabel * lbl_NoData;
    UIActivityIndicatorView * indicatorView;
    
    UITableView * rootTableView;
    
    NSMutableArray * m_ServiceList;
    NSMutableArray * m_MerchantList;
}

@property (strong, nonatomic) NSString * apiUrl_ticket;
@property (strong, nonatomic) NSString * apiUrl_merchant;
@end
