//
//  MapBaseViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-8.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "BQIBaseViewController.h"
#import "resMod_MerchantInfo.h"


@interface EC_MAPointAnnotation : MAPointAnnotation
@property (nonatomic, strong) NSString * merchantid;
@property (nonatomic, strong) NSString * merchantPhone;
@property (nonatomic, strong) NSString * merchantName;
@property (nonatomic, strong) NSString * merchantAddress;
@property (nonatomic, assign) BOOL b_isShow;
@end


@interface MapBaseViewController : BQIBaseViewController<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic, strong) MAMapView         * mapViewBase;

@property (nonatomic, strong) AMapSearchAPI     * searchApi;

@property (nonatomic, strong) NSMutableArray    * annotationsBase;

@property (nonatomic, strong) NSMutableArray    * nearMerchantList;

@property (nonatomic, strong) NSMutableArray    * m_tickets;


- (void)setMapRectByAnnotations:(NSMutableArray *) arrAnnotations;
- (void)searchPathForDriveOrWalk:(AMapSearchType) searchtype
                      nav_origin:(AMapGeoPoint*) _navorigin
                 nav_destination:(AMapGeoPoint*) _navdestination;


- (void) initAnnotations;
- (void) goApiRequest_nearMerchant;
- (void) goApiRequest_TicketsByMerchant:(NSString *) _merchantid;

- (void) onDataSourceChanged_mtickets;
@end
