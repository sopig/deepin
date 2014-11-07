//
//  MallProductListVController.h
//  BoqiiLife
//
//  Created by YSW on 14-6-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "PullToRefreshTableView.h"
#import "MallProductFilterView.h"


//  -- button扩展 .........................
@interface EC_ProductFilterButton : UIButton
@property (assign,nonatomic) BOOL isSelected;
@property (assign,nonatomic) BOOL isFocus;
@property (strong,nonatomic) NSString * iconName;
@property (strong,nonatomic) UIImageView * img_icon;
- (void) setIconName:(NSString *) _icon;
//- (void) setBtnStatus:(BOOL)_isSelected;
@end


@interface MallProductListVController : BQIBaseViewController<UITableViewDataSource,UITableViewDelegate,MallProductFilterViewDelegate,UITextFieldDelegate>{
    
    UITextField* searchText;
    
    PullToRefreshTableView * rootTableView;
    
    UIView * viewFilter;
    UIScrollView * scrollCategoryForFilter;
    NSMutableArray * arr3thClassList;
    UIButton * btnChecked3thClass;
    
    MallProductFilterView  * ViewMPFilter;
    
    UILabel * lbl_carnum;
    UIButton * goCarButton;
    
    NSMutableDictionary * dicActivityColor;
    NSMutableArray      * arrProductList;
    
    NSMutableDictionary * dicFilterWhere;
    
    int filterTypeID;
    int filterBrandID;
    BOOL b_isRefreshPage;
    BOOL isActivityRecommed;  //活动推荐

    BOOL FilterButtonIsDoubleClick_cates;
    BOOL FilterButtonIsDoubleClick_price;
}
@property (nonatomic,strong) NSString * param_Keyword;
@property (nonatomic,strong) NSString * param_1thClass;
@property (nonatomic,strong) NSString * param_2thClass;
@property (nonatomic,strong) NSString * param_3thClass;
@property (nonatomic,strong) NSString * param_OrderType;
@property (nonatomic,strong) NSString * param_ApiURL;
@property (nonatomic,strong) NSString * param_SelClassName;
@end
