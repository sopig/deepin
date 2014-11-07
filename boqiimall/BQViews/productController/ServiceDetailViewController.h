//
//  ServiceDetailViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-6.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "resMod_TicketInfo.h"
#import "LoginViewController.h"

@interface ServiceDetailViewController : BQIBaseViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,LoginDelegate,ISSViewDelegate,ISSShareViewDelegate,UIWebViewDelegate>{
    
    UIButton * btn_Collection;  // 收藏按钮
    
    UITableView * detailTableView;
    NSMutableDictionary * dicCellHeight;
    
    UIScrollView   * scrollBanner;      // 
    UIPageControl  * pageControl;       // bannerPage
    
//    UIView * maskView;
    
    NSString * iTicketID;
    resMod_TicketInfo * mod_TicketInfo;
    
    
    NSArray * arrBannerList;
    int TimeNum;
    BOOL Tend;
    BOOL isCollected;   //-- 是否收藏
    int pageControlCurrent;
}

@property (strong, nonatomic) NSString * iTicketID;
@property (strong, nonatomic) NSString * URLService;
- (void) onBuyClick:(id) sender;

@end
