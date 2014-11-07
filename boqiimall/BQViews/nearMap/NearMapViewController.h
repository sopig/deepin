//
//  NearMapViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-8.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MapBaseViewController.h"

@interface NearMapViewController : MapBaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UIView * toolBarView;
    UILabel * lbl_pName;
    UILabel * lbl_spaceline;
    UILabel * lbl_roadName;
    
    UIButton * btn_searchNear;
    UIButton * btn_userLocal;
    
    UIView * alphaBg;
    
    MAAnnotationView * selAnnotationView;
    EC_MAPointAnnotation * selMAnnotation;
    UIView * ViewCallOut;
    UIImageView *tabBG;
    UILabel * lbl_noTickets;
    UITableView * tableViewTickets;

    //UILabel *titleLabel;
    
    CGPoint rootViewPoint;
    BOOL hasSetMapRect;
    BOOL isFromMerchantPage;
}

@property (nonatomic, strong) AMapRoute * maproute;
@property (nonatomic) CLLocationCoordinate2D startCoordinate;       //--出发点
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate; //--目的地

@end
