//
//  ShoppingCartViewController.h
//  boqiimall
//
//  Created by ysw on 14-10-14.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EC_UIScrollView.h"
#import "EC_UICustomAlertView.h"
#import "PullToRefreshTableView.h"
#import "resMod_Mall_ShoppingCart.h"
#import "TableCell_ShopCart.h"
#import "ChangeBuyOrActionView.h"

@interface ShoppingCartViewController : BQIBaseViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,TableCell_ShopCartDelegate,ChangeBuyOrActionViewDelegate>{
    
    EC_UIScrollView        * rootScrollView;
    PullToRefreshTableView * rootTableView;
    ChangeBuyOrActionView  * changeView;
    
    UIButton * btnDel;
    UIButton * btnCheckAll;
    
    UIView  * viewWarn;
    UIView  * viewCalculate;
    
    UILabel * lbl_totalPrice;
    UILabel * lbl_Discount;
    UIButton* btn_calculate;
    
    UIView  * keybordView;
    UILabel * lbl_limitNum;
    
    BOOL b_isFromPush;
    BOOL b_isFromGoBack;
    BOOL b_isCheckedAllProducts;
    
    float viewContentHeight;
    
    NSMutableArray * arr_GroupList;
    NSDictionary   * dic_ActionName;
}

@property (strong, nonatomic) resMod_Mall_ShoppingCart    * m_CartDetail;

@property (strong, nonatomic) TableCell_ShopCart    * tmpOperationCell;
@property (strong, nonatomic) UITextField           * txtCurrentProductNum;

/********     记住上次操作时的商品信息，待在次加载数据时 定位并滚到所在行   ing    *******/
@property (assign, nonatomic) int           tmpLastOperationGoodsid;
@property (strong, nonatomic) NSString    * tmpLastOperationGoodsSpecId;
@property (strong, nonatomic) NSIndexPath * tmpLastOperationIndexPath;
/********     记住上次操作时的商品信息，待在次加载数据时 定位并滚到所在行   end   *******/

@end
