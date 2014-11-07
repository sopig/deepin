//
//  ShoppingCartVController.m
//  BoqiiLife
//
//  Created by YSW on 14-6-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "ShoppingCartVController.h"
#import "resMod_Mall_GoodsForApiParams.h"
#import "resMod_Mall_SettleAccounts.h"
#import "OfflineGoods.h"
#import "OfflineShoppingCart.h"
#import "resMod_Mall_BatchAddToShoppingCart.h"


#define dicKey          @"CellIndexPath"
#define tagForWarn      7766
#define heightForCell   105
#define heightGift      40+86

@implementation ShoppingCartVController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isRootPage = YES;
        viewContentHeight=kMainScreenHeight - kNavBarViewHeight - 44;
        arr_GoodsList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void) setPageProperty{
    b_isFromPush = [[self.receivedParams objectForKey:@"param_isFromPush"] isEqualToString:@"1"] ? YES:NO;
    if (b_isFromPush) {
        isRootPage = NO;
        viewContentHeight=kMainScreenHeight - kNavBarViewHeight;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    if (b_isFromPush)
        [self tabBar_Hidden:self.tabBarController];
    else
        [self tabBar_Show:self.tabBarController];
    
    [viewWarn setHidden:![UserUnit isUserLogin]];
    //[rootTableView setHidden:![UserUnit isUserLogin]];
    
    //    if (![UserUnit isUserLogin] ) {
    //        [self.noDataView noDataViewIsHidden:NO warnImg:@"" warnMsg:@"进入购物车，请先登录"];
    //        [self goLogin:@"" param:nil delegate:self];
    //        [self setWarnLables:@"" money1:0 tip2:@"" money2:0 totalPrice:0 discountPrice:0];
    //        [btn_calculate setTitle:@"结算" forState:UIControlStateNormal];
    //        [arr_GoodsList removeAllObjects];
    //        b_isCheckedAllProducts = NO;
    //        [btnCheckAll setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"] forState:UIControlStateNormal];
    //        return;
    //    }
    
    if (b_isFromGoBack) {
         b_isFromGoBack = NO;
        
    } else{
        
        if (![UserUnit isUserLogin]) {  //显示本地数据库列表
            [self getOfflineGoodsFromDatabase];
        }
        else {                         //上传本地数据库列表
            NSMutableArray *offlineItemsArray = [OfflineShoppingCart queryAll];
            if (offlineItemsArray.count == 0)
            {
                [self goApiRequest_GetCartDetail:YES hudshow:self.lodingAnimationView.hasDisplayed?@"正在加载":@""];
            }
            else {
                [self goApiRequest_BatchAddToShoppingCart:offlineItemsArray];
            }
        }
        
    }
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [self setPageProperty];
    
    [super viewDidLoad];
    [self loadNavBarView];
    self.title = @"购物车";
    [self.view setBackgroundColor:color_bodyededed];
    
  //  [self loadNavBarView:@"购物车"];
    //  -- 删除
//    btnDel = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnDel setFrame:CGRectMake(6, 2, 40, 40)];
//    [btnDel setTitle:@"删除" forState:UIControlStateNormal];
//    [btnDel setTitleColor:color_333333 forState:UIControlStateNormal];
//    [btnDel.titleLabel setFont:defFont15];
//    [btnDel setBackgroundColor:[UIColor clearColor]];
//    [btnDel addTarget:self action:@selector(onButtonDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:btnDel];
//    self.navigationItem.rightBarButtonItem = r_bar;
//    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
    
 
    rootScrollView = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, viewContentHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [rootScrollView setDelegate:self];
    [self.view addSubview:rootScrollView];
    
    //  --  ........
    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0,0,__MainScreen_Width,rootScrollView.frame.size.height) style:UITableViewStylePlain];
    [rootTableView setTag:11111];
    rootTableView.backgroundColor = [UIColor clearColor];
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [rootScrollView addSubview:rootTableView];
    
    //--
    txtProNum = [[UITextField alloc] initWithFrame:CGRectZero];
    [txtProNum setTag:89567];
    [txtProNum setDelegate:self];
    [txtProNum setBackgroundColor:[UIColor whiteColor]];
    [txtProNum setTextAlignment:NSTextAlignmentCenter];
    [txtProNum setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    txtProNum.keyboardType=UIKeyboardTypeNumberPad;
    txtProNum.text = @"1";
    txtProNum.layer.borderColor = color_d1d1d1.CGColor;
    txtProNum.layer.borderWidth = 0.5f;
    
    //  --  提示区 :   江浙沪满200元免运费，还差53.00元
    [self loadView_Warn];
    
    //  --  结算区 .
    if (b_isFromPush)
    {
        viewCalculate = [[UIView alloc]initWithFrame:CGRectMake(0, kMainScreenHeight  - 50, __MainScreen_Width, 50)];
        
    }
    else
    {
        viewCalculate = [[UIView alloc]initWithFrame:CGRectMake(0, kMainScreenHeight - 44 - 50, __MainScreen_Width, 50)];
    }
    
    [viewCalculate setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewCalculate];
    [self loadView_Calculate];
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    if (!b_isFromPush)
    {
        [self.backBtn setHidden:YES];
    }
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setFrame:CGRectMake(275, 2, 40, 40)];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:color_333333 forState:UIControlStateNormal];
    [deleteBtn.titleLabel setFont:defFont15];
    [deleteBtn setBackgroundColor:[UIColor clearColor]];
    [deleteBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [deleteBtn addTarget:self action:@selector(onButtonDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:deleteBtn];
}


//- (void)loadNavBarView:(NSString *)title
//{
//    UIView *navbarView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    if (b_isFromPush)
//    {
//        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//        [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//        [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//        [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//        [navbarView addSubview:backBtn];
//    }
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = title;
//    [navbarView addSubview:titleLabel];
//    
//    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [deleteBtn setFrame:CGRectMake(275, 2, 40, 40)];
//    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//    [deleteBtn setTitleColor:color_333333 forState:UIControlStateNormal];
//    [deleteBtn.titleLabel setFont:defFont15];
//    [deleteBtn setBackgroundColor:[UIColor clearColor]];
//    [deleteBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//    [deleteBtn addTarget:self action:@selector(onButtonDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [navbarView addSubview:deleteBtn];
//    [self.navBarView addSubview:navbarView];
//}

//从本地数据库读取离线商品列表

- (void)getOfflineGoodsFromDatabase
{
    
    NSMutableArray *offlineItemsArray = [OfflineShoppingCart queryAll];
    if (offlineItemsArray.count !=  0)
    {
        [self goApiRequest_GetOfflineGoodsDetails:offlineItemsArray];
    }
    else
    {
        [arr_GoodsList removeAllObjects];
        [rootTableView reloadData];
        [self.noDataView noDataViewIsHidden:arr_GoodsList==nil||arr_GoodsList.count==0 ? NO:YES
                                    warnImg:@"" warnMsg:@"您的购物车还是空的，赶紧给爱宠挑点什么吧！"];
    }

}


#pragma mark    --  cell delegate
//  --  选中行
- (void)onDelegateCellRowProductChecked:(id) cell ischecked:(BOOL)_ischeck{
    
    TableCell_MallCart * cellRow = cell;
    NSIndexPath * indexpath = [rootTableView indexPathForCell:cellRow];
    
    resMod_Mall_ShoppingCartGoodsInfo * protmp = arr_GoodsList[indexpath.row];
    protmp.b_isChecked = _ischeck;

    //  --  更改是否全选状态 begin
    int i_allCheckedState =0;
    for (resMod_Mall_ShoppingCartGoodsInfo * keyGoods in arr_GoodsList) {
        if(keyGoods.b_isChecked){
            i_allCheckedState ++;
        }
    }
    b_isCheckedAllProducts = i_allCheckedState==arr_GoodsList.count ? YES:NO;
    [btnCheckAll setImage:[UIImage imageNamed:b_isCheckedAllProducts?@"checkbox_greensel.png":@"checkbox_greenUnsel.png"] forState:UIControlStateNormal];
    //  --  更改是否全选状态 end
    
    [self goApiRequest_GetCartMoneyInfo];
    
    
}

//  --  改变购物车商品数量 ：cell delegate
- (void)onDelegateChangeProNumClick:(id) cell{
    
    [txtProNum becomeFirstResponder];
    
    cellForChangeNum = cell;
    
    if (cellForChangeNum!=nil) {
        NSIndexPath * indexpath = [rootTableView indexPathForCell:cellForChangeNum];
        int limitnum = [arr_GoodsList[indexpath.row] GoodsLimit];
        int pronum   = [cellForChangeNum.btn_proNum.titleLabel.text intValue];
        txtProNum.text = [NSString stringWithFormat:@"%d",limitnum>pronum?pronum:limitnum];
        
        [self alertViewChangeProductNum:pronum limit:limitnum];
    }
}

//  -- 收起赠品点击
- (void) onDelegateShowOrHideGiftClick:(id)cell{
    TableCell_MallCart * cellRow = cell;
    NSIndexPath * indexpath = [rootTableView indexPathForCell:cellRow];
    resMod_Mall_ShoppingCartGoodsInfo * proinfo = arr_GoodsList[indexpath.row];
    proinfo.b_isShowGift = !proinfo.b_isShowGift;
    cellRow.IsOpenGiftView = proinfo.b_isShowGift;

    NSIndexSet * nset=[[NSIndexSet alloc]initWithIndex:0];
    [rootTableView reloadSections:nset withRowAnimation:UITableViewRowAnimationAutomatic];
}

//  -- 赠品详情
- (void) onDelegateGiftClick:(NSString*) giftid{
    b_isFromGoBack = YES;
    [self pushNewViewController:@"MallProductDetailController" isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:giftid,@"paramGoodsID", nil]];
}

#pragma mark    --  event

//  --  反选所有
- (void)onCheckAllProduct{
    if (arr_GoodsList&&arr_GoodsList.count>0) {
        b_isCheckedAllProducts = !b_isCheckedAllProducts;
        [btnCheckAll setImage:[UIImage imageNamed:b_isCheckedAllProducts?@"checkbox_greensel.png":@"checkbox_greenUnsel.png"] forState:UIControlStateNormal];
        
        for (resMod_Mall_ShoppingCartGoodsInfo * keyGoods in arr_GoodsList) {
            keyGoods.b_isChecked = b_isCheckedAllProducts;
        }
        
        [self goApiRequest_GetCartMoneyInfo];
        [rootTableView reloadData];
    }
}

- (void)onCheckAllProductWithoutUserId
{
    if (arr_GoodsList&&arr_GoodsList.count>0) {
        b_isCheckedAllProducts = !b_isCheckedAllProducts;
        [btnCheckAll setImage:[UIImage imageNamed:b_isCheckedAllProducts?@"checkbox_greensel.png":@"checkbox_greenUnsel.png"] forState:UIControlStateNormal];
        
        for (resMod_Mall_ShoppingCartGoodsInfo * keyGoods in arr_GoodsList) {
            keyGoods.b_isChecked = b_isCheckedAllProducts;
        }
        
        [rootTableView reloadData];
    }
}

//--    删除购物车商品
- (void)onButtonDeleteClick:(id) sender{
    
    NSMutableArray * arrproduct = [self getProductsForApiParams];
    if ([UserUnit isUserLogin])
    {
        if (arrproduct.count>0) {
            EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"提 示"
                                                                                  message:@"确定删除所选商品吗？"
                                                                        cancelButtonTitle:@"取消"
                                                                            okButtonTitle:@"删除"];
            alertView.delegate1 = self;
            alertView.tag = 8966;
            [alertView show];
        }
    }
    else
    {
        for (resMod_Mall_ShoppingCartGoodsInfo *goods in arrproduct)
        {
            OfflineGoods *item = [[OfflineGoods alloc] init];
            item.goodsID = goods.GoodsId;
            item.goodsSpecId =  goods.GoodsSpecId;
            [OfflineShoppingCart deleteGoods:item];
        }
        [self getOfflineGoodsFromDatabase];
    }
}

//--    删本地
- (void) DelCellRowAndLocalData{
    
    if (b_isCheckedAllProducts) {
        [self goApiRequest_GetCartDetail:YES hudshow:@"正在加载"];
    }
    else{
        NSMutableArray * arrDeleteRows = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray * arrDeleteData = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSInteger irow =0;
        NSInteger iSection =0;
        for (resMod_Mall_ShoppingCartGoodsInfo * keyGoods in arr_GoodsList) {
            
            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:irow inSection:iSection];
            if (keyGoods.b_isChecked && indexpath) {
                [arrDeleteRows addObject:indexpath];
                [arrDeleteData addObject: arr_GoodsList[indexpath.row]];
            }
            irow ++;
        }
        if (arrDeleteRows.count>0) {
            [arr_GoodsList removeObjectsInArray:arrDeleteData];
            
            [rootTableView beginUpdates];
            [rootTableView deleteRowsAtIndexPaths:arrDeleteRows withRowAnimation:UITableViewRowAnimationTop];
            [rootTableView endUpdates];
        }
    }
}

//  --  改变购物车商品数量 : 确定\取消更改数量
- (void)onChangeProNumClick:(id) sender{
    
    UIButton * btnTmp = (UIButton*)sender;
    [txtProNum resignFirstResponder];
    
    UIView * view_567483 = [ViewChangeProNum viewWithTag:567483];
    view_567483.layer.shouldRasterize = YES;
    [UIView animateWithDuration:0.1 animations:^{
        view_567483.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            view_567483.alpha = 0;
            view_567483.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        } completion:^(BOOL finished2){
            [ViewChangeProNum removeFromSuperview];
            ViewChangeProNum = nil;
        }];
    }];

    
    if (btnTmp.tag == 8989+1) {
        
        if ([self checkTicketLimitNumber:[txtProNum.text intValue]]) {
            if (cellForChangeNum!=nil) {
                if ([UserUnit isUserLogin])
                {
                    NSIndexPath * indexpath = [rootTableView indexPathForCell:cellForChangeNum];
                    [self goApiRequest_ModifyProductNum:indexpath.row];
                }
                else
                {
                    NSIndexPath * indexpath = [rootTableView indexPathForCell:cellForChangeNum];
                    [self updateOfflineGoodsDatabase:indexpath.row];
                }
               
            }
        }
    }
}
#pragma mark 更新离线购物车本地数据库
//更新离线购物车本地数据库
- (void)updateOfflineGoodsDatabase:(NSInteger)row
{
    
    resMod_Mall_ShoppingCartGoodsInfo * selectedGoods = [arr_GoodsList objectAtIndex:row];
    
    OfflineGoods *item = [[OfflineGoods alloc] init];
    item.goodsID = selectedGoods.GoodsId;
    item.goodsSpecId =  selectedGoods.GoodsSpecId;
    item.goodsType = selectedGoods.GoodsType;
    item.totalNum = [txtProNum.text intValue];
    item.addedDate = [NSDate date];
    
    [OfflineShoppingCart updateGoods:item];
    [self getOfflineGoodsFromDatabase];
    
    
    
    [self HUDShow:@"更改数量成功" delay:2];
    
    
}

//  -- 数 量 加 减
- (void)onAddOrDiscountNumClick:(id) sender{

    UIButton * btnTmp = (UIButton *)sender;
    int iNum= [txtProNum.text intValue];
    switch (btnTmp.tag) {
        case 597:{
            if (iNum==1||iNum<1) {
                txtProNum.text = @"1";
            }else{
                txtProNum.text = [NSString stringWithFormat:@"%d",--iNum];
            }
        }
            break;
        case 598: {
            ++iNum;
            [self checkTicketLimitNumber:iNum];
        }
            break;
            
        default:
            break;
    }
    
    NSIndexPath * indexpath = [rootTableView indexPathForCell:cellForChangeNum];
    int _limitNum = [arr_GoodsList[indexpath.row] GoodsLimit];
    UIButton * btn_597 = (UIButton*)[ViewChangeProNum viewWithTag:597];
    UIButton * btn_598 = (UIButton*)[ViewChangeProNum viewWithTag:598];
    if (iNum<2) {
        [btn_597 setBackgroundImage:[UIImage imageNamed:@"icon_reduce_normal.png"] forState:UIControlStateNormal];
        [btn_598 setBackgroundImage:[UIImage imageNamed:@"icon_add_highlight.png"] forState:UIControlStateNormal];
    }
    else if(_limitNum>iNum){
        [btn_597 setBackgroundImage:[UIImage imageNamed:@"icon_reduce_highlight.png"]forState:UIControlStateNormal];
        [btn_598 setBackgroundImage:[UIImage imageNamed:@"icon_add_highlight.png"] forState:UIControlStateNormal];
    }
    else if(_limitNum==iNum){
        [btn_598 setBackgroundImage:[UIImage imageNamed:@"icon_add_normal.png"] forState:UIControlStateNormal];
    }
}

//  -- 结算
- (void)onCalculateClick:(id) sender{
    
    NSMutableArray * dicParams = [self getProductsForApiParams];
    
    if (dicParams.count>0) {
        
        int i=1;
        for (resMod_Mall_GoodsForApiParams * goodsinfo in dicParams) {
            if (goodsinfo.limitNum>0 && goodsinfo.GoodsNum>goodsinfo.limitNum) {
                [self HUDShow:[NSString stringWithFormat:@"第 %d 条商品超过限购数量",i] delay:2];
                return;
            }
            i++;
        }
        
        [self pushNewViewController:@"MallOrderSubmitController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:dicParams,@"param_proinfo", nil]];
    }
    else{
        [self HUDShow:@"请选择需购买的商品" delay:2];
    }
}

//  --  验证购买数量
- (BOOL) checkTicketLimitNumber:(int) proNum{
    
    NSIndexPath * indexpath = [rootTableView indexPathForCell:cellForChangeNum];
    int _limitNum = [arr_GoodsList[indexpath.row] GoodsLimit];
    
    if (_limitNum>0 && proNum > _limitNum) {
        [self HUDShow:[NSString stringWithFormat:@"限购 %d 件",_limitNum] delay:2];
        txtProNum.text = [NSString stringWithFormat:@"%d",_limitNum];
        return NO;
    }
    else{
        if (proNum<1) {
            [self HUDShow:@"1件起售" delay:2];
        }
        txtProNum.text = [NSString stringWithFormat:@"%d",proNum<1?1:proNum];
        return YES;
    }
}

#pragma mark    --  ui

- (void)alertViewChangeProductNum:(int) goodsNum limit:(int) limitNum{
    
//    [txtProNum becomeFirstResponder];
    
    ViewChangeProNum = [[EC_UIScrollView alloc] init];
    ViewChangeProNum.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    ViewChangeProNum.frame = CGRectMake(0, 0, __MainScreen_Width, __MainScreenFrame.size.height);
    [ViewChangeProNum setDelegate:self];
    UIWindow *currWindow = [[UIApplication sharedApplication] keyWindow];
    [currWindow addSubview:ViewChangeProNum];
    
    //  __MainScreenFrame.size.height/2-395/4
    UIView * viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, __MainScreenFrame.size.height/2-395/4, def_WidthArea(15), 395/2)];
    [viewContent setTag:567483];
    [viewContent setBackgroundColor:[UIColor whiteColor]];
    viewContent.layer.cornerRadius = 3.0;
    [ViewChangeProNum addSubview:viewContent];
    
    UIButton * lblTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    [lblTitle setFrame:CGRectMake(0, 0, viewContent.frame.size.width, 83/2)];
    [lblTitle setBackgroundColor: color_bodyededed];
    lblTitle.layer.cornerRadius = 3.0;
    [lblTitle setTitle:@"修改数量" forState:UIControlStateNormal];
    [lblTitle setTitleColor:color_333333 forState:UIControlStateNormal];
    [viewContent addSubview:lblTitle];
    
    [UICommon Common_line:CGRectMake(0, 83/2,viewContent.frame.size.width,0.5) targetView:viewContent backColor:color_d1d1d1];
    
    
    //--数量 : 减
    UIButton * btn_discount = [[UIButton alloc] initWithFrame:CGRectMake(60, lblTitle.frame.size.height+20, 38, 40)];
    [btn_discount setBackgroundColor:[UIColor whiteColor]];
    [btn_discount setTag:597];
    [btn_discount setBackgroundImage:[UIImage imageNamed:goodsNum>1?@"icon_reduce_highlight":@"icon_reduce_normal"]
                            forState:UIControlStateNormal];
    [btn_discount setBackgroundImage:[UIImage imageNamed:@"icon_reduce_sel"] forState:UIControlStateHighlighted];
    [btn_discount addTarget:self action:@selector(onAddOrDiscountNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewContent addSubview:btn_discount];
    
    //--
    [txtProNum setFrame:CGRectMake(106, btn_discount.frame.origin.y, 84, 40)];
    [viewContent addSubview:txtProNum];
    
    //--数量 : 加
    UIButton * btn_sum = [[UIButton alloc] initWithFrame:CGRectMake(204, btn_discount.frame.origin.y, 38, 40)];
    [btn_sum setBackgroundColor:[UIColor whiteColor]];
    [btn_sum setTag:598];
    [btn_sum setBackgroundImage:[UIImage imageNamed:goodsNum>limitNum?@"icon_add_normal":@"icon_add_highlight"]
                       forState:UIControlStateNormal];
    [btn_sum setBackgroundImage:[UIImage imageNamed:@"icon_add_sel"] forState:UIControlStateHighlighted];
    [btn_sum addTarget:self action:@selector(onAddOrDiscountNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewContent addSubview:btn_sum];
    
    [UICommon Common_UILabel_Add:CGRectMake((viewContent.frame.size.width-120)/2, 105, 120, 40)
                      targetView:viewContent bgColor:[UIColor clearColor] tag:9090
                            text:[NSString stringWithFormat:@"限购 %d 件",limitNum]
                           align:0 isBold:NO fontSize:14 tColor:color_fc4a00];
    
//    [UICommon Common_UILabel_Add:CGRectMake(125, 105, viewContent.frame.size.width-125, 40)
//                      targetView:viewContent bgColor:[UIColor clearColor] tag:9091
//                            text:@"数量超过限购数量" align:-1 isBold:NO fontSize:14 tColor:color_989898];
    
    for (int i=0; i<2; i++) {
        UIButton * btnOprate = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnOprate setTag:8989+i];
        [btnOprate setFrame:CGRectMake(i==0?25:155, viewContent.frame.size.height-45, 112, 35)];
        [btnOprate setBackgroundColor:i==0?color_989898:color_fc4a00];
        [btnOprate setTitle: i==0?@"取 消":@"确 认" forState:UIControlStateNormal];
        [btnOprate.titleLabel setFont:defFont16];
        [btnOprate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnOprate.layer.cornerRadius = 3.0;
        [btnOprate addTarget:self action:@selector(onChangeProNumClick:) forControlEvents:UIControlEventTouchUpInside];
        [viewContent addSubview:btnOprate];
    }
    
    
    //        animal
    [UIView animateWithDuration:0.3 animations:^{
        viewContent.alpha = 1;
    }];
    
    viewContent.alpha = 0;
    viewContent.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
    [UIView animateWithDuration:0.2 animations:^{
        viewContent.alpha = 1;
        viewContent.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        //  -- UIViewAnimationCurveEaseOut
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            viewContent.alpha = 1;
            viewContent.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished2) {
            viewContent.layer.shouldRasterize = NO;
        }];
    }];
    //        end
}

- (void)loadView_Warn{
    if (b_isFromPush)
    {
        viewWarn = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight-50-25, __MainScreen_Width, 25)];
    }
    else
    {
        viewWarn = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight-44-50-25, __MainScreen_Width, 25)];
    }
    
    [viewWarn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [self.view addSubview:viewWarn];
    
    for (int i=0; i<4; i++) {
        UILabel * lbl_warn = [[UILabel alloc] initWithFrame:CGRectZero];
        [lbl_warn setTag:tagForWarn+i];
        [lbl_warn setBackgroundColor:[UIColor clearColor]];
        [lbl_warn setTextColor: i==1||i==3? color_8fc31f:[UIColor whiteColor]];
        [lbl_warn setText:@"江浙沪满"];
        [lbl_warn setFont:defFont(NO, 13)];
        [lbl_warn setTextAlignment:NSTextAlignmentCenter];
        [viewWarn addSubview:lbl_warn];
    }
}

- (void)loadView_Calculate{
    UIView * viewAlphabg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width-80, 50)];
    [viewAlphabg setBackgroundColor:[UIColor blackColor]];
    [viewAlphabg setAlpha:0.7];
    [viewCalculate addSubview:viewAlphabg];
    
    btnCheckAll = [UIButton  buttonWithType:UIButtonTypeCustom];
    [btnCheckAll setBackgroundColor:[UIColor clearColor]];
    [btnCheckAll setFrame:CGRectMake(0, 0, 50, 50)];
    [btnCheckAll setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"] forState:UIControlStateNormal];
    [btnCheckAll addTarget:self action:@selector(onCheckAllProduct) forControlEvents:UIControlEventTouchUpInside];
    [viewCalculate addSubview:btnCheckAll];
    
    [UICommon Common_UILabel_Add:CGRectMake(50, 5, 60, 20)
                      targetView:viewCalculate bgColor:[UIColor clearColor] tag:8997
                            text:@"总金额:" align:-1 isBold:NO fontSize:14 tColor:color_b3b3b3];
    
    lbl_totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 120, 20)];
    [lbl_totalPrice setBackgroundColor:[UIColor clearColor]];
    [lbl_totalPrice setTextColor:[UIColor whiteColor]];
    [lbl_totalPrice setText:@"0.00元"];
    [lbl_totalPrice setFont:defFont(YES, 14)];
    [lbl_totalPrice setTextAlignment:NSTextAlignmentLeft];
    [viewCalculate addSubview:lbl_totalPrice];
    
    lbl_Discount = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 120, 20)];
    [lbl_Discount setBackgroundColor:[UIColor clearColor]];
    [lbl_Discount setTextColor:color_b3b3b3];
    [lbl_Discount setText:@"已优惠: 0.00元"];
    [lbl_Discount setFont:defFont(NO, 12)];
    [lbl_Discount setTextAlignment:NSTextAlignmentLeft];
    [viewCalculate addSubview:lbl_Discount];
    
    btn_calculate = [UIButton  buttonWithType:UIButtonTypeCustom];
    [btn_calculate setBackgroundColor:color_fc4a00];
    [btn_calculate setFrame:CGRectMake(__MainScreen_Width-80, 0, 80, 50)];
    [btn_calculate setTitle:@"结算" forState:UIControlStateNormal];
    [btn_calculate.titleLabel setFont:defFont15];
    [btn_calculate addTarget:self action:@selector(onCalculateClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewCalculate addSubview:btn_calculate];
    
    [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width, 0.5) targetView:viewCalculate backColor:[UIColor whiteColor]];
}


#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_GoodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    resMod_Mall_ShoppingCartGoodsInfo * proinfo = arr_GoodsList[indexPath.row];
    float fSpecheight = proinfo.GoodsSpec.count>0 ? 14 : 0;
    float fGiftheight = proinfo.GoodsPresents.count>0 ? (proinfo.b_isShowGift ? heightGift : 50):0;
    return heightForCell + fSpecheight + fGiftheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 70;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Height, 10)];
    [footView setBackgroundColor:[UIColor clearColor]];
    return footView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * IdentifierCell = @"CartProductListCell";
    
    TableCell_MallCart *cell = (TableCell_MallCart*)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    if ( cell==nil ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_MallCart" owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[TableCell_MallCart class]]) {
                cell = (TableCell_MallCart *)oneObject;
                cell.cartDelegate = self;
                
                UILabel * lblSpaceLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 0.5)];
                [lblSpaceLine setTag:949];
                [lblSpaceLine setBackgroundColor:color_d1d1d1];
                [cell.contentView addSubview:lblSpaceLine];
            }
        }
    }
    
    if (arr_GoodsList.count>0) {
        
        resMod_Mall_ShoppingCartGoodsInfo * goodsinfo = arr_GoodsList[indexPath.row];
        
        [cell.productIMG sd_setImageWithURL:[NSURL URLWithString: goodsinfo.GoodsImg]
                           placeholderImage:[UIImage imageNamed:@"placeHold_75x75.png"]];
        cell.lbl_title.text = goodsinfo.GoodsTitle;
        cell.lbl_salePrice.text = [self convertPrice:goodsinfo.GoodsPrice];
        cell.IsOpenGiftView = goodsinfo.b_isShowGift;
        
        NSString * spec = @"";
        int i=0;
        for (resMod_Mall_CartGoodsProperty * sproperty in goodsinfo.GoodsSpec) {
            spec = [NSString stringWithFormat:@"%@%@%@: %@",spec,(i>0?@", ":@""),sproperty.Key,sproperty.Value];
            i++;
        }
        [cell.lbl_proSpec setText:spec];
        [cell.btn_proNum setTitle:[NSString stringWithFormat:@"%d",goodsinfo.GoodsNum] forState:UIControlStateNormal];
        
        [cell setCellRowCheckStatus: goodsinfo.b_isChecked];
        [cell setTitleFrame: cell.lbl_title.text];
        [cell setGiftData:goodsinfo.GoodsPresents];
    }
    
    UILabel * lblSpaceLine = (UILabel*)[cell.contentView viewWithTag:949];
    [lblSpaceLine setFrame:CGRectMake(0, 0, __MainScreen_Width, indexPath.row==0 ?0:0.5)];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (arr_GoodsList && arr_GoodsList.count>indexPath.row) {
        NSString * proid = [NSString stringWithFormat:@"%d",[arr_GoodsList[indexPath.row] GoodsId]];
        [self pushNewViewController:@"MallProductDetailController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:proid,@"paramGoodsID", nil]];
    }
}



#pragma mark    --  api 请 求 & 回 调.

- (void)goApiRequest_BatchAddToShoppingCart:(NSMutableArray *)offlineItemsArray
{
    if (offlineItemsArray.count > 0)
    {
        NSMutableArray *offlinesGoodsInfoArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < offlineItemsArray.count; i++)
        {
            OfflineGoods *item = [offlineItemsArray objectAtIndex:i];
            resMod_Mall_GoodsForApiParams *goodsInfo = [[resMod_Mall_GoodsForApiParams alloc] init];
            goodsInfo.GoodsId = item.goodsID;
            goodsInfo.GoodsSpecId = item.goodsSpecId;
            goodsInfo.GoodsNum = item.totalNum;
            goodsInfo.GoodsType = item.goodsType;
            [offlinesGoodsInfoArray addObject:goodsInfo];
        }

        NSMutableDictionary *apiParams = [[NSMutableDictionary alloc] init];
        [apiParams setObject:[self convertGoodsInfoForApiParams:offlinesGoodsInfoArray] forKey:@"GoodsInfo"];
        [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
        [[APIMethodHandle shareAPIMethodHandle] goApiRequestBatchAddToShoppingCart:apiParams ModelClass:@"" showLoadingAnimal:NO hudContent:@"" delegate:self];
    }
}
// 获取离线商品详细信息
- (void)goApiRequest_GetOfflineGoodsDetails:(NSMutableArray *)offlineItemsArray
{
    NSMutableArray *offlinesGoodsInfoArray = [[NSMutableArray alloc] init];
    if (offlineItemsArray.count > 0)
    {
        for (int i = 0; i < offlineItemsArray.count; i++)
        {
            OfflineGoods *item = [offlineItemsArray objectAtIndex:i];
            resMod_Mall_GoodsForApiParams *goodsInfo = [[resMod_Mall_GoodsForApiParams alloc] init];
            goodsInfo.GoodsId = item.goodsID;
            goodsInfo.GoodsSpecId = item.goodsSpecId;
            goodsInfo.GoodsNum = item.totalNum;
            goodsInfo.GoodsType = item.goodsType;
            [offlinesGoodsInfoArray addObject:goodsInfo];
        }
        NSMutableDictionary *apiParams = [[NSMutableDictionary alloc] init];
        [apiParams setObject:[self convertGoodsInfoForApiParams:offlinesGoodsInfoArray] forKey:@"GoodsInfo"];
        [[APIMethodHandle shareAPIMethodHandle] goApiRequestGetOfflineShoppingCartDetail:apiParams ModelClass:@"resMod_CallBackMall_ShoppingCart" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
    }
}


#pragma mark error

//此地需要调整，离线购物获取金额不能成功，原有的API需要携带UserId 参数。

//  -- 计算购物车金额
- (void)goApiRequest_GetCartMoneyInfo{
    
    NSMutableArray * arrproduct = [self getProductsForApiParams];
    
    if (arrproduct.count>0) {
        NSMutableDictionary * apiParams = [[NSMutableDictionary alloc] initWithCapacity:0];
        [apiParams setValue:[UserUnit userId] forKey:@"UserId"];
        [apiParams setValue:[self convertGoodsInfoForApiParams:arrproduct] forKey:@"GoodsInfo"];
        [[APIMethodHandle shareAPIMethodHandle] goApiRequestGetShoppingCartMoneyInfo:apiParams ModelClass:@"resMod_CallBackMall_ShoppingCart" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
        
        [btn_calculate setTitle:[NSString stringWithFormat:@"结算(%d)",arrproduct.count]
                       forState:UIControlStateNormal];
    }
    else{
        [btn_calculate setTitle:@"结算" forState:UIControlStateNormal];
        [self setWarnLables:@"" money1:0 tip2:@"" money2:0 totalPrice:0 discountPrice:0];
    }
}
//  -- 修改商品数量
- (void)goApiRequest_ModifyProductNum:(int) idxForArrGoodsList{
    
    resMod_Mall_ShoppingCartGoodsInfo * proinfo = arr_GoodsList[idxForArrGoodsList];
    
    NSMutableDictionary * apiParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [apiParams setValue:[UserUnit userId] forKey:@"UserId"];
    [apiParams setValue:[NSString stringWithFormat:@"%d",proinfo.GoodsId] forKey:@"GoodsId"];
    [apiParams setValue:txtProNum.text forKey:@"GoodsNum"];
    [apiParams setValue:proinfo.GoodsSpecId forKey:@"GoodsSpecId"];
    [apiParams setValue:[NSString stringWithFormat:@"%d",proinfo.GoodsType] forKey:@"GoodsType"];
    
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_ModifyCartGoodsNumber class:@"ResponseBase"
//              params:apiParams  isShowLoadingAnimal:NO hudShow:@"正在更改数量"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestModifyShoppingCartGoodsNumber:apiParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在更改数量" delegate:self];
    
}

//  -- 删除指定商品
- (void)goApiRequest_DeleteCartProduct{
    
    NSMutableArray * arrproduct = [self getProductsForApiParams];

    if (arrproduct.count>0) {
        NSMutableDictionary * apiParams = [[NSMutableDictionary alloc] initWithCapacity:0];
        [apiParams setValue:[UserUnit userId] forKey:@"UserId"];
        [apiParams setValue:[self convertGoodsInfoForApiParams:[self getProductsForApiParams]] forKey:@"GoodsInfo"];
        
//        [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_DeleteCartGoods class:@"ResponseBase"
//                  params:apiParams  isShowLoadingAnimal:NO hudShow:@"正在删除"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestDeleteShoppingCartGoods:apiParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在删除" delegate:self];
        
    }
    else{
        [self HUDShow:@"请选择要删除的商品" delay:2];
    }
}


//  -- 购物车信息
- (void)goApiRequest_GetCartDetail:(BOOL) isRefresh hudshow:(NSString*) _hudshow{
    if (isRefresh)
    {
        b_isPullRefresh = isRefresh;
        b_isCheckedAllProducts = NO;
        [btnCheckAll setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"] forState:UIControlStateNormal];
        [btn_calculate setTitle:@"结算" forState:UIControlStateNormal];
    }
    [self.noDataView setHidden:YES];
    NSMutableDictionary * apiParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [apiParams setValue:[UserUnit userId] forKey:@"UserId"];
    [apiParams setValue:@"0" forKey:@"StartIndex"];
    [apiParams setValue:@"-1" forKey:@"Number"];    //--不分页，-1加载所有
    
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_CartDetail class:@"resMod_CallBackMall_ShoppingCart"
//              params:apiParams isShowLoadingAnimal:YES hudShow: _hudshow];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingCartDetail:apiParams ModelClass:@"resMod_CallBackMall_ShoppingCart" showLoadingAnimal:YES hudContent:_hudshow delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_Mall_CartDetail]) {
        
       
        [self hudWasHidden:HUD];
        resMod_CallBackMall_ShoppingCart * backObj = [[resMod_CallBackMall_ShoppingCart alloc] initWithDic:retObj];
        m_CartDetail = backObj.ResponseData;
        if (m_CartDetail) {
            if (b_isPullRefresh) {
                b_isPullRefresh = NO;
                [arr_GoodsList removeAllObjects];
            }
            [arr_GoodsList addObjectsFromArray:m_CartDetail.GoodsList];
            
            [self setWarnLables:m_CartDetail.TipFront money1:m_CartDetail.TipMoneyFront
                           tip2:m_CartDetail.TipMiddle money2:m_CartDetail.TipMoneyBack
                     totalPrice:m_CartDetail.NeedToPay discountPrice:m_CartDetail.Preferential];
            
            [rootTableView reloadData:YES allDataCount:0];
            [self.lodingAnimationView stopLoadingAnimal];
            
            [self onCheckAllProduct];
        }
        
        [self.noDataView noDataViewIsHidden:arr_GoodsList==nil||arr_GoodsList.count==0 ? NO:YES
                                    warnImg:@"" warnMsg:@"您的购物车还是空的，赶紧给爱宠挑点什么吧！"];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_DeleteCartGoods]) {
        [self HUDShow:@"删除成功" delay:2];
        [self DelCellRowAndLocalData];
        [btn_calculate setTitle:@"结算" forState:UIControlStateNormal];
        [self setWarnLables:@"" money1:0 tip2:@"" money2:0 totalPrice:0 discountPrice:0];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_ModifyCartGoodsNumber]) {
        
        if (cellForChangeNum!=nil) {
            //  --  服务器修改数量成功后，再更新现有
            NSIndexPath * indexpath = [rootTableView indexPathForCell:cellForChangeNum];
            resMod_Mall_ShoppingCartGoodsInfo * protmp = arr_GoodsList[indexpath.row];
            protmp.GoodsNum = [txtProNum.text intValue];
            [cellForChangeNum.btn_proNum setTitle:txtProNum.text forState:UIControlStateNormal];
            
            [self HUDShow:@"更改数量成功" delay:2];
            [self goApiRequest_GetCartMoneyInfo];
        }else{
            [self HUDShow:@"更改数量失败，请重试" delay:2];
        }
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_CartMoney]) {
        resMod_CallBackMall_ShoppingCart * backObj=[[resMod_CallBackMall_ShoppingCart alloc] initWithDic:retObj];
        resMod_Mall_ShoppingCart * moneyinfo = backObj.ResponseData;
        
        [self setWarnLables:moneyinfo.TipFront money1:moneyinfo.TipMoneyFront
                       tip2:moneyinfo.TipMiddle money2:moneyinfo.TipMoneyBack
                 totalPrice:moneyinfo.NeedToPay discountPrice:moneyinfo.Preferential];
        
        [self hudWasHidden:HUD];
    }
//    
//    if ([ApiName isEqualToString:kApiMethod_Mall_GetOfflineShoppingCartDetail])
//    {
//        [self hudWasHidden:HUD];
//        resMod_CallBackMall_ShoppingCart * backObj = [[resMod_CallBackMall_ShoppingCart alloc] initWithDic:retObj];
//        m_CartDetail = backObj.ResponseData;
//        if (m_CartDetail) {
//
//            [arr_GoodsList removeAllObjects];
//            [arr_GoodsList addObjectsFromArray:m_CartDetail.GoodsList];
//            [self setWarnLables:m_CartDetail.TipFront money1:m_CartDetail.TipMoneyFront
//                                        tip2:m_CartDetail.TipMiddle money2:m_CartDetail.TipMoneyBack
//                                  totalPrice:m_CartDetail.NeedToPay discountPrice:m_CartDetail.Preferential];
//            
//            [rootTableView reloadData:YES allDataCount:0];
//            if (arr_GoodsList&&arr_GoodsList.count>0) {
//                b_isCheckedAllProducts = !b_isCheckedAllProducts;
//                [btnCheckAll setImage:[UIImage imageNamed:b_isCheckedAllProducts?@"checkbox_greensel.png":@"checkbox_greenUnsel.png"] forState:UIControlStateNormal];
//                
//                for (resMod_Mall_ShoppingCartGoodsInfo * keyGoods in arr_GoodsList) {
//                    keyGoods.b_isChecked = b_isCheckedAllProducts;
//                }
//                [rootTableView reloadData];
//            }
//        }
//        
//        [self.noDataView noDataViewIsHidden:arr_GoodsList==nil||arr_GoodsList.count==0 ? NO:YES
//                                    warnImg:@"" warnMsg:@"您的购物车还是空的，赶紧给爱宠挑点什么吧！"];
//    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_BatchAddToShoppingCart])
    {
        
    
        [OfflineShoppingCart deleteAll];
        [self goApiRequest_GetCartDetail:YES hudshow:self.lodingAnimationView.hasDisplayed?@"正在加载":@""];
    }

}

-(void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];

    if ([ApiName isEqualToString:kApiMethod_Mall_CartDetail]) {
        b_isPullRefresh = NO;
    }
}

-(NSMutableArray *) getProductsForApiParams{
    
    NSMutableArray * proinfoForApiParams = [[NSMutableArray alloc] initWithCapacity:0];
    for (resMod_Mall_ShoppingCartGoodsInfo * keyGoods in arr_GoodsList) {
    
        if (keyGoods.b_isChecked)
        {
            resMod_Mall_GoodsForApiParams * protmp = [[resMod_Mall_GoodsForApiParams alloc] init];
            protmp.GoodsId = keyGoods.GoodsId;
            protmp.GoodsNum = keyGoods.GoodsNum;
            protmp.limitNum = keyGoods.GoodsLimit;
            protmp.GoodsType = keyGoods.GoodsType;
            protmp.GoodsSpecId = keyGoods.GoodsSpecId;
            [proinfoForApiParams addObject:protmp];
        }
    }
    
    return proinfoForApiParams;
}


- (void) setWarnLables:(NSString *) tipfront money1:(float)_money1
                  tip2:(NSString*) tipmiddle money2:(float) _money2
            totalPrice:(float) _totalPrice  discountPrice:(float) _disPrice
{
    
    [lbl_totalPrice setText:[self convertPrice:_totalPrice]];
    [lbl_Discount setText:[NSString stringWithFormat:@"已优惠: %@",[self convertPrice:_disPrice]]];
    
    if (tipfront.length!=0 && tipmiddle.length!=0) {
        
        [viewWarn setHidden:NO];
        
        CGSize tsize1 = [tipfront sizeWithFont:defFont13 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
        CGSize tsize2 = [[self convertPrice:_money1] sizeWithFont:defFont13 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
        CGSize tsize3 = [tipmiddle sizeWithFont:defFont13 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
        CGSize tsize4 = [[self convertPrice:_money2] sizeWithFont:defFont13 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];

        float fsize = tsize1.width+ tsize2.width+4 + tsize3.width+4 + (_money2>0?tsize4.width:0);
        UILabel * lbl_1 = (UILabel*)[viewWarn viewWithTag:tagForWarn];
        UILabel * lbl_2 = (UILabel*)[viewWarn viewWithTag:tagForWarn+1];
        UILabel * lbl_3 = (UILabel*)[viewWarn viewWithTag:tagForWarn+2];
        UILabel * lbl_4 = (UILabel*)[viewWarn viewWithTag:tagForWarn+3];
        [lbl_1 setText:tipfront];
        [lbl_2 setText:[self convertPrice:_money1]];
        [lbl_3 setText:tipmiddle];
        [lbl_4 setText:_money2>0?[self convertPrice:_money2]:@""];
        
        float lblHeight = viewWarn.frame.size.height;
        [lbl_1 setFrame:CGRectMake((__MainScreen_Width-fsize)/2, 0, tsize1.width, lblHeight)];
        [lbl_2 setFrame:CGRectMake(lbl_1.frame.origin.x+lbl_1.frame.size.width+2, 0, tsize2.width+4, lblHeight)];
        [lbl_3 setFrame:CGRectMake(lbl_2.frame.origin.x+lbl_2.frame.size.width+2, 0, tsize3.width+4, lblHeight)];
        [lbl_4 setFrame:CGRectMake(lbl_3.frame.origin.x+lbl_3.frame.size.width+2, 0, tsize4.width, lblHeight)];
    }
    else{
        [viewWarn setHidden:YES];
    }
}

#pragma mark - TextField delegate
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (textField.tag == txtProNum.tag) {
//        UIView * viewtmp = [txtProNum superview];
//        [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut
//                         animations:^{}
//                         completion:^(BOOL finished){
//                             [viewtmp setFrame:CGRectMake(viewtmp.frame.origin.x, viewtmp.frame.origin.y+100, def_WidthArea(15), 395/2)];
//                         }];
//    }
//}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (textField.tag== txtProNum.tag) {
//        UIView * viewtmp = [txtProNum superview];
//        [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut
//                         animations:^{}
//                         completion:^(BOOL finished){
//                             [viewtmp setFrame:CGRectMake(viewtmp.frame.origin.x, __MainScreenFrame.size.height/2-395/4, def_WidthArea(15), 395/2)];
//                         }];

        [self checkTicketLimitNumber:[txtProNum.text intValue]];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if (textField.tag== txtProNum.tag) {
        [self checkTicketLimitNumber:[txtProNum.text intValue]];
    }
    return YES;
}


#pragma mark    --  scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [rootTableView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [rootTableView tableViewDidDragging];
    if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
        [rootTableView tableViewIsRefreshing];
        if ([UserUnit isUserLogin])
        {
             [self goApiRequest_GetCartDetail:YES hudshow:@""];
        }
        else
        {
            NSMutableArray *offlineItemsArray = [OfflineShoppingCart queryAll];
            if (offlineItemsArray.count != 0)
            {
                [self goApiRequest_GetOfflineGoodsDetails:offlineItemsArray];
            }
            else
            {
                [rootTableView reloadData:YES allDataCount:0];
            }
        }
       
    }
}

#pragma mark    --  alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 8966) {
        if(buttonIndex == 1) {
            [self goApiRequest_DeleteCartProduct];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
