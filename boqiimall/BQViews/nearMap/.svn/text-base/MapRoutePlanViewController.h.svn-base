//
//  MapRoutePlanViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-16.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "EC_SegmentedView.h"
#import <AMapSearchKit/AMapSearchAPI.h>
#import <MAMapKit/MAMapKit.h>

//@protocol MapRoutePlanViewControllerDelegate <NSObject>
//
//@required
//- (void) RoutePlanDelegate:(int) planIndex;
//
//@end


@interface MapRoutePlanViewController : BQIBaseViewController<AMapSearchDelegate,EC_SegmentedViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    EC_SegmentedView * segtitleView;
    
    UITableView * rootTableView;
    UILabel *targetRoad;
    
    UIView * view_NoData;
    UILabel * lbl_NoData;
}

@property (nonatomic, strong) NSString * sTarget;
@property (nonatomic, strong) NSString  * para_AMapSearchType;
@property (nonatomic, strong) AMapRoute * mapRoute;
@property (nonatomic, strong) AMapSearchAPI     * searchApi;
//@property (nonatomic, assign) id<MapRoutePlanViewControllerDelegate> Delegate;
@end
