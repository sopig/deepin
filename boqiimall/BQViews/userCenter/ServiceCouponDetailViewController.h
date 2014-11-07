//
//  ServiceCouponDetailViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-15.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"

#import "resMod_MyTicketDetail.h"


@interface ServiceCouponDetailViewController : BQIBaseViewController<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>{
    UITableView * rootTableView;
//    UIView * maskView;
    
    resMod_MyTicketDetail * myticket;
}

@property(nonatomic,strong)  NSString * param_mytickid;
@property(nonatomic,readwrite,copy)  NSString * mytickPrice;
@end
