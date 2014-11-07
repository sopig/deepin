//
//  MallProductDetailController.h
//  BoqiiLife
//
//  Created by YSW on 14-6-17.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import <ShareSDK/ShareSDK.h>

#import "PullToRefreshTableView.h"
#import "resMod_Mall_Goods.h"
#import "resMod_Mall_GoodsComment.h"

//  -- button扩展 .........................
@interface EC_ButtonForProDetailHead : UIButton
@property (assign,nonatomic) BOOL isOpenDetail;
@property (strong,nonatomic) UIImageView * rightIcon;
- (void) loadRightIcon:(CGRect) cgframe iconname:(NSString*) sicon;
@end


@interface MallProductDetailController : BQIBaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,ISSViewDelegate,ISSShareViewDelegate>{

    PullToRefreshTableView * tableview_root;
    UIScrollView * scrollview_banner;

    UIButton * goCarButton;
    UIButton * btn_addmore;
    UIButton * btn_collect;
    UIImageView * imgcollect;
    UIView * bottom_buyAndAddCar;
    UILabel * lbl_carnum;
    
    resMod_Mall_GoodsInfo   * ProductInfo;
    NSArray * m_BannerArr;
    NSMutableDictionary * dic_TabRowIsOpen;
    NSMutableArray * m_GoodsComments;
    
    BOOL isGift;
    BOOL isCollected;
    BOOL hasLoadedAllComments;
    
    float ContentHeightByVersion;
    int  rowNum_gift;
    int  rowNum_proinfo;
    int  rowNum_discuss;
    
    
    int TimeNum;
    BOOL Tend;
    int pageControlCurrent;
    
    NSMutableArray *activityColorArray;
    
}
@property (strong,nonatomic)     NSString  * GoodsID;
@property (strong,nonatomic)     NSString  * param_ApiURL;
@end
