//
//  DropDownFilterView.h
//  BoqiiLife
//
//  Created by YSW on 14-5-7.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "resMod_GetFilterCategory.h"


@protocol DropDownFilterViewDelegate <NSObject>

@optional
- (void) onFilterButtonForDelegateClick:(NSString *) filterKey;
/***********************************
 *      id_ParentTableview : 父tableview的值
 *      id_subTableView :    子tableview的值
 ***********************************/
- (void) onDelegateForSearch;

@end


//  -- button扩展 .........................
@interface EC_FilterButton : UIButton{
    UIImageView * img_icon;
}
@property (strong,nonatomic) UILabel * lbl_TitleKey;    //  -- 作加回传的key值
- (void) setTitleKey:(NSString *) value;
- (void) setTitleAndIconFrame:(NSString *) _title;
- (void) setTitleIcon:(BOOL) isHightle;
@end


//  --  下拉筛选 .........................
@interface DropDownFilterView : UIView<UITableViewDelegate,UITableViewDataSource>{
    
    UIView * selfParentView;
    UIView * viewTopFilter;
    UIView * lbl_bottomshadow;
    
    UITableView * parentTableView;
    UITableView * subTableview;
    
    NSArray * arrFilterTitle;
    
    NSMutableArray * arrDataSource;
    resMod_CategoryList * arrDataSourceSub;
    
    //  -- 索引部分
    UIView * viewTabIndex;
    NSMutableArray * dicSubRowIndex;

    
    resMod_filterWhere * filterWhere;           //用来保存筛选条件
    
    UIColor * color_ParentTable;
    UIColor * color_SubTable;
    
    UIButton * btnTransparent;      //--透明背景层
    
    EC_FilterButton * currentSelButton;    //--当前选中的FileButton
    
    DDFilterType ddFType;   //--是两栏还是只有一栏

    UITableViewCell * CellCurrentParent_SimpleFilter;   //-- Simple模式   当前选中父cell
    UITableViewCell * CellCurrentParent_ComplexFilter;  //-- Complex模式  当前选中父cell
    
    int iFilterTitleNum;
    int heightTop;
    float HeightTable;      //--菜单高度
    float widthParentTable; //--左菜单宽
    float widthSubTable;    //--子菜单宽 [如果有]
    
    BOOL isClose;
}

@property (assign,nonatomic) id<DropDownFilterViewDelegate> filterDelegate;
@property (strong,nonatomic) NSArray * arrFilterTitle;

//存放最后选择的值
@property (strong,nonatomic) NSMutableDictionary * dic_SelectValue;


#pragma mark    --
- (id)initWithFrame:(CGRect)frame addViewRef:(UIView*) targetView
       filterHeight:(int) fheight filterTitle:(NSArray *) titles dicSelect:(NSMutableDictionary *) dicselects;

- (void) loadFilterDataSoure:(NSString *)filterKey tableSouce:(NSMutableArray*)_arrData FilterType:(DDFilterType)_fType;

- (void) OpenOrCloseFilter:(BOOL) isExpansion;
@end


