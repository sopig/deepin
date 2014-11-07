//
//  MapRoutePlanDetailViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-17.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MapBaseViewController.h"

@interface MapRoutePlanDetailViewController : MapBaseViewController<UITableViewDelegate,UITableViewDataSource> {

    UIView * toolBarView;
    UIButton * btnPathDetail;
    UIImageView * imgDetailButtonBg;
    UILabel * pathTitle;
    UITableView * tablePath;

    float fcontentHeight;
    int heightForTablePath;
    BOOL isOpenPathDetail;
}

@property (nonatomic, strong) NSString  * para_AMapSearchType;
@property (nonatomic, strong) AMapPath  * mapPath;
@property (nonatomic) AMapGeoPoint * path_origin;        //--出发点
@property (nonatomic) AMapGeoPoint * path_destination;   //--目的地

@end