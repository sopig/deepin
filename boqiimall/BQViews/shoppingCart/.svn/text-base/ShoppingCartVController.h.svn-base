//
//  ShoppingCartVController.h
//  BoqiiLife
//
//  Created by YSW on 14-6-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "EC_UIScrollView.h"
#import "EC_UICustomAlertView.h"
#import "PullToRefreshTableView.h"
#import "TableCell_MallCart.h"
#import "resMod_Mall_ShoppingCart.h"


@interface ShoppingCartVController : BQIBaseViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,TableCell_CartDelegate,UIScrollViewDelegate,EC_UICustomAlertViewDelegate>{
    
    EC_UIScrollView        * rootScrollView;
    PullToRefreshTableView * rootTableView;
    
    UIView  * viewWarn;
    UIView  * viewCalculate;
    
    UIButton * btnDel;
    UIButton * btnCheckAll;
    UILabel * lbl_totalPrice;
    UILabel * lbl_Discount;
    UIButton * btn_calculate;
    
    BOOL    b_isFromGoBack;
    BOOL    b_isFromPush;
    BOOL    b_isPullRefresh;
    BOOL    b_isCheckedAllProducts;
    float   viewContentHeight;
    
    
    EC_UIScrollView * ViewChangeProNum;
    UITextField * txtProNum;
    
    resMod_Mall_ShoppingCart * m_CartDetail;
    NSMutableArray * arr_GoodsList;
    
    
    //  --只用于更改数量时 回调
    TableCell_MallCart * cellForChangeNum;
}

@end
