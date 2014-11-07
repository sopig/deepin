//
//  ShoppingCartViewController.m
//  boqiimall
//
//  Created by ysw on 14-10-14.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "resMod_Mall_GoodsForApiParams.h"
#import "OfflineGoods.h"
#import "OfflineShoppingCart.h"


#define cellMinHeight   86
#define WarnHeight      25
#define CalculateHeight 50

#define tagForWarn      7766

@implementation ShoppingCartViewController
@synthesize tmpLastOperationGoodsid;
@synthesize tmpLastOperationGoodsSpecId;
@synthesize tmpLastOperationIndexPath;
@synthesize tmpOperationCell,txtCurrentProductNum;
@synthesize m_CartDetail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isRootPage = YES;
        viewContentHeight = kMainScreenHeight - kNavBarViewHeight - 50;
        
        arr_GroupList = [[NSMutableArray alloc] initWithCapacity:0];
        dic_ActionName= [[NSDictionary alloc] initWithObjectsAndKeys:
                         @"活动|1E9E49"       ,@"actionid_0",
                         @"满减|FD5E44"       ,@"actionid_1",
                         @"折扣|1E9E49"       ,@"actionid_2",
                         @"折扣价|FF387F"     ,@"actionid_3",
                         @"多买多惠|556FB5"    ,@"actionid_4",
                         @"赠品|E3000F"       ,@"actionid_5",
                         @"团购|E3000F"       ,@"actionid_6",
                         @"满赠|FD5E44"       ,@"actionid_7",
                         @"换购|FEB037"       ,@"actionid_8",nil];
    }
    return self;
}

- (void)goBack:(id)sender {
    [MobClick event:@"shoppingCart_return"];
    [super goBack:sender];
}

- (void) setPageProperty{
    b_isFromPush = [[self.receivedParams objectForKey:@"param_isFromPush"] isEqualToString:@"1"] ? YES:NO;
    if (b_isFromPush) {
        isRootPage = NO;
        viewContentHeight = kMainScreenHeight - kNavBarViewHeight;
    }
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [rootScrollView setFrame:CGRectMake(0, kNavBarViewHeight,__MainScreen_Width,viewContentHeight)];
    [viewWarn setHidden:![UserUnit isUserLogin]];
    
    if (b_isFromGoBack) {
        b_isFromGoBack = NO;
    }
    else{
        if (![UserUnit isUserLogin]) {  //显示本地数据库列表
            [self offline_GetGoodsFromDatabase];
        }
        else {                         //上传本地数据库列表
            NSMutableArray *offlineItemsArray = [OfflineShoppingCart queryAll];
            if (offlineItemsArray.count == 0) {
                [self goApiRequest_GetCartDetail:NO];
            }
            else {
                [self goApiRequest_BatchAddToShoppingCart:offlineItemsArray];
            }
        }
    }
}

- (void)viewDidLoad {
    [self setPageProperty];
    [super viewDidLoad];
    [self.view setBackgroundColor:color_bodyededed];
    [self setTitle:@"购物车"];
    
    //  --
    rootScrollView = [[EC_UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight,__MainScreen_Width,viewContentHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [rootScrollView setDelegate:self];
    [self.view addSubview:rootScrollView];
    
    //  --  ........
    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0, 0,__MainScreen_Width,viewContentHeight-CalculateHeight-([UserUnit isUserLogin]?WarnHeight-1:0)) style:UITableViewStylePlain];
    [rootTableView setTag:11111];
    rootTableView.backgroundColor = [UIColor clearColor];
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [rootScrollView addSubview:rootTableView];
    
    //  --  提示区 :   江浙沪满200元免运费，还差53.00元
    [self loadView_Warn];
    
    //  --  结算区 .
    //  --  kMainScreenHeight-CalculateHeight-(b_isFromPush?0:50)
    viewCalculate = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(rootScrollView.frame)-CalculateHeight,__MainScreen_Width, CalculateHeight)];
    [viewCalculate setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:viewCalculate];
    [self loadView_Calculate];
    
    //  --  键盘
    [self loadView_keybordButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //  --  更换活动
    [self loadView_change];
}

//  --登录成功
- (void)LoginSuccessPushViewController:(NSString *)m_str param:(id)m_param{
    if ([m_str isEqualToString:@"onCalculateClick"]) {
        [self onCalculateClick:nil];
    }
}

#pragma mark    --  shop cart Delegate
//  --  选中行
- (void)onDelegateCellRowProductChecked:(id) cell
{
    self.tmpOperationCell = (TableCell_ShopCart*)cell;
    
    if (self.tmpOperationCell.cellResourceData.IsClickable) {
        if (![UserUnit isUserLogin]) {
            [self offline_UpdateGoodsDatabase:self.tmpOperationCell.cellResourceData];
        }
        else {
            [txtCurrentProductNum resignFirstResponder];
            [self goApiRequest_GetCartDetail:YES];
        }
    }
    else{
        NSString * sreason = self.tmpOperationCell.cellResourceData.ReasonForCannotOperate;
        if (sreason && sreason.length>0) {
            [self HUDShow:sreason delay:2];
        }
    }
}

//  -- 更改数量
- (void)onDelegateChangeProNum:(id) cell{
    [MobClick event:@"shoppingCart_changeQuantity"];
    self.tmpOperationCell = (TableCell_ShopCart*)cell;
    self.txtCurrentProductNum = self.tmpOperationCell.txt_proNum;
    
    if (self.tmpOperationCell.txt_proNum>0) {
        [lbl_limitNum setText:[NSString stringWithFormat:@"该商品限购 %d 件",self.tmpOperationCell.cellResourceData.GoodsLimit]];
    }
    else{
        [lbl_limitNum setText:@""];
    }
}

//  --  更换优惠方式 or 换购
- (void) onDelegateChangeType:(id) cell btnTag:(int)btag{
    [txtCurrentProductNum resignFirstResponder];
    self.tmpOperationCell = (TableCell_ShopCart*)cell;
    
    NSIndexPath * indexpath = [rootTableView indexPathForCell:self.tmpOperationCell];
    resMod_Mall_ShoppingCartGroupList * tmpgroup = arr_GroupList[indexpath.section];
    
    [self goApiRequest_GetChangeBuyList:self.tmpOperationCell.cellResourceData.GoodsId
                               actionid:self.tmpOperationCell.cellResourceData.ActionId
                             groupprice:tmpgroup.GroupPrice];
    // 。。。
    changeView.changetype   = btag==778866 ? 1:0;
    changeView.pGoodsId     = self.tmpOperationCell.cellResourceData.GoodsId;
    changeView.pGoodsSpecId = self.tmpOperationCell.cellResourceData.GoodsSpecId;
    changeView.pGoodsType   = self.tmpOperationCell.cellResourceData.GoodsType;
    changeView.pGroupPrice  = tmpgroup.GroupPrice;
    changeView.pActionId    = self.tmpOperationCell.cellResourceData.ActionId;
    changeView.pChangeBuyId = self.tmpOperationCell.cellResourceData.ChangeBuyId;
}

#pragma mark    --  change buy 换购or优惠 delegate
- (void) onDelegateChangeActionDidChecked:(NSMutableDictionary*) apiParams{
    
    if (self.tmpOperationCell) {
        self.tmpOperationCell.cellResourceData.ActionId    = [[apiParams objectForKey:@"ActionId"] intValue];
        self.tmpOperationCell.cellResourceData.ChangeBuyId = [[apiParams objectForKey:@"ChangeBuyId"] intValue];
        self.tmpOperationCell.cellResourceData.TimeStamp   = (long)[[NSDate date] timeIntervalSince1970];
    }
    
    [self goApiRequest_ChangeBuyGoods:apiParams];
}

#pragma mark    --  shop cart 事件区
//  --  删除
- (void)onButtonDeleteClick:(id) sender{
    
    [MobClick event:@"shoppingCart_delete"];
    
    [txtCurrentProductNum resignFirstResponder];
    
    NSMutableArray * arrproduct = [self getProductsForApiParams];
    if ([UserUnit isUserLogin]) {
        if (arrproduct.count>0) {
            EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"提 示"
                                                                                  message:@"确定删除所选商品吗？"
                                                                        cancelButtonTitle:@"取消"
                                                                            okButtonTitle:@"删除"];
            alertView.delegate1 = self;
            alertView.tag = 8966;
            [alertView show];
        }
        else{
            EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"提 示"
                                                                                  message:@"请选择要删除的商品"
                                                                        cancelButtonTitle:nil
                                                                            okButtonTitle:@"确定"];
            alertView.delegate1 = self;
            [alertView show];
        }
    }
    else {
        for (resMod_Mall_ShoppingCartGoodsInfo *goods in arrproduct) {
            OfflineGoods *item = [[OfflineGoods alloc] init];
            item.goodsID = goods.GoodsId;
            item.goodsSpecId =  goods.GoodsSpecId;
            [OfflineShoppingCart deleteGoods:item];
        }
        [self offline_GetGoodsFromDatabase];
    }
}

//  --  反选所有组 商品
- (void)onCheckAllGroupProduct{
    if (arr_GroupList && arr_GroupList.count>0) {
        b_isCheckedAllProducts = !b_isCheckedAllProducts;
        [btnCheckAll setImage:[UIImage imageNamed:b_isCheckedAllProducts?@"checkbox_greensel.png":@"checkbox_greenUnsel.png"] forState:UIControlStateNormal];
         OfflineGoods *item = [[OfflineGoods alloc] init];
        for (resMod_Mall_ShoppingCartGroupList * keyGroup in arr_GroupList) {
            for(resMod_Mall_ShoppingCartGoodsInfo * keyGoodinfo in keyGroup.GoodsList){
                keyGoodinfo.IsSelected = b_isCheckedAllProducts;
                if (![UserUnit isUserLogin])
                {
                    item.goodsID = keyGoodinfo.GoodsId;
                    item.goodsSpecId =  keyGoodinfo.GoodsSpecId;
                    item.goodsType = keyGoodinfo.GoodsType;
                    item.totalNum = keyGoodinfo.GoodsNum;
                    item.addedDate = [NSDate date];
                    item.selected = keyGoodinfo.IsSelected;
                    item.changeBuyId = keyGoodinfo.ChangeBuyId;
                    item.actionId = keyGoodinfo.ActionId;
                    [OfflineShoppingCart updateGoods:item];
                }
            }
        }
        [self goApiRequest_GetCartDetail:YES];
    }
}

//  -- 结算
- (void)onCalculateClick:(id) sender{
    [MobClick event:@"shoppingCart_settlement"];
    if ([UserUnit isUserLogin]) {
        
        NSMutableArray * dicParams = [self getProductsForApiParams];
        
        if (dicParams.count>0) {
            for (resMod_Mall_GoodsForApiParams * goodsinfo in dicParams) {
                if (goodsinfo.limitNum>0 && goodsinfo.GoodsNum>goodsinfo.limitNum) {
                    [self HUDShow:[NSString stringWithFormat:@"所选商品中有超过限购数量,请检查"] delay:2];
                    return;
                }
            }
            b_isFromGoBack = YES;
            [self pushNewViewController:@"MallOrderSubmitController" isNibPage:NO hideTabBar:YES setDelegate:NO
                          setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:dicParams,@"param_proinfo", nil]];
        }
        else{
            [self HUDShow:@"请选择需购买的商品" delay:2];
        }
    }
    else{
        [MobClick event:@"userCenter_login"];
        [self goLogin:@"onCalculateClick" param:nil delegate:self];
    }
}

//  --  删本地
//- (void) delCellRowAndLocalData{
//    
//    if (b_isCheckedAllProducts) {
//        [self goApiRequest_GetCartDetail];
//    }
//    else {
//        NSMutableArray * arrDeleteRows = [[NSMutableArray alloc] initWithCapacity:0];
//        NSMutableArray * arrDeleteData = [[NSMutableArray alloc] initWithCapacity:0];
//        
//        NSInteger irow =0;
//        NSInteger iSection =0;
//        for (resMod_Mall_ShoppingCartGroupList * keyGroups in arr_GroupList) {
//            for (resMod_Mall_ShoppingCartGoodsInfo * keyGoods in keyGroups.GoodsList) {
//                
//                NSIndexPath * indexpath = [NSIndexPath indexPathForRow:irow inSection:iSection];
//                if (keyGoods.IsSelected && indexpath) {
//                    [arrDeleteRows addObject:indexpath];
//                    [arrDeleteData addObject: keyGoods];
//                }
//                irow ++;
//            }
//            
//            if (arrDeleteRows.count>0) {
//                [keyGroups.GoodsList removeObjectsInArray:arrDeleteData];
//                
//                [rootTableView beginUpdates];
//                [rootTableView deleteRowsAtIndexPaths:arrDeleteRows withRowAnimation:UITableViewRowAnimationTop];
//                [rootTableView endUpdates];
//            }
//        }
//        iSection ++;
//    }
//}

//  --  更新下面全选按钮 状态
- (void) setButtonCheckAllStatus{
    
    NSInteger isection = 0;
    NSInteger irow = 0;
    self.tmpLastOperationIndexPath = nil;
    
    int productTotalCount = 0;
    int productSelectCount = 0;
    for (resMod_Mall_ShoppingCartGroupList * keyGroup in arr_GroupList) {
        irow = 0;
        for(resMod_Mall_ShoppingCartGoodsInfo * keyGoodinfo in keyGroup.GoodsList){
            
            if (keyGoodinfo.IsSelected) {
                productSelectCount++;
            }
            
            //  --匹配 是否 为 上次操作商品。
            if (keyGoodinfo.GoodsId == tmpLastOperationGoodsid
                && [keyGoodinfo.GoodsSpecId isEqualToString:tmpLastOperationGoodsSpecId]) {
                self.tmpLastOperationIndexPath = [NSIndexPath indexPathForRow:irow inSection:isection];
            }
            
            productTotalCount++;
            irow++;
        }
        isection++;
    }
    
    b_isCheckedAllProducts = productTotalCount>0 ? productTotalCount==productSelectCount : NO;
    [btn_calculate setTitle: productSelectCount>0 ? [NSString stringWithFormat:@"结算(%d)",productSelectCount] : @"结算"
                   forState: UIControlStateNormal];
    [btnCheckAll setImage:[UIImage imageNamed:b_isCheckedAllProducts ? @"checkbox_greensel":@"checkbox_greenUnsel"]
                 forState:UIControlStateNormal];
}

//  --  验证数量
- (BOOL) checkGoodsLimitNumber:(int) proNum{
    
    int _limitNum = self.tmpOperationCell.cellResourceData.GoodsLimit;
    
    if (_limitNum>0 && proNum > _limitNum) {
        [self HUDShow:[NSString stringWithFormat:@"限购 %d 件",_limitNum] delay:2];
        self.txtCurrentProductNum.text = [NSString stringWithFormat:@"%d",self.tmpOperationCell.cellResourceData.GoodsNum];
        return NO;
    }
    else{
        if (proNum<1) {
            [self HUDShow:@"1件起售" delay:2];
        }
        self.txtCurrentProductNum.text = [NSString stringWithFormat:@"%d",proNum<1?1:proNum];
        return YES;
    }
}

#pragma mark    --  VIEW 视图控制加载区
//  -- bar view

- (void)loadNavBarView
{
    [super loadNavBarView];
    
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

- (void)loadView_Warn{
    // kMainScreenHeight-CalculateHeight-WarnHeight-(b_isFromPush?0:50)
    viewWarn = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rootScrollView.frame)-CalculateHeight-WarnHeight, __MainScreen_Width, WarnHeight)];
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

- (void)loadView_Calculate{
    UIView * viewAlphabg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width-80, 50)];
    [viewAlphabg setBackgroundColor:[UIColor blackColor]];
    [viewAlphabg setAlpha:0.7];
    [viewCalculate addSubview:viewAlphabg];
    
    btnCheckAll = [UIButton  buttonWithType:UIButtonTypeCustom];
    [btnCheckAll setBackgroundColor:[UIColor clearColor]];
    [btnCheckAll setFrame:CGRectMake(0, 0, 50, 50)];
    [btnCheckAll setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"] forState:UIControlStateNormal];
    [btnCheckAll addTarget:self action:@selector(onCheckAllGroupProduct) forControlEvents:UIControlEventTouchUpInside];
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

//  -- 每组商品 的 活动优惠和结果
- (float) loadView_ResultForPerGroupActivity:(UIView*) targetview
                           PreferentialInfo:(NSMutableArray *) perdata
                               ActionResult:(NSString *) acresult {
    
    for (UIView * subview in targetview.subviews) {
        [subview removeFromSuperview];
    }
    
    float paddingForLable = 8;
    float xpoint = 38;
    float ypoint = 0;
    int i=0;
    for (resMod_Mall_CartPreferentialInfo * perinfo in perdata) {
        
        NSString * spreferential=[dic_ActionName objectForKey:[NSString stringWithFormat:@"actionid_%d",perinfo.ActionId]];
        NSArray * arrpre = [spreferential componentsSeparatedByString:@"|"];
        
        CGSize tsize = [arrpre[0] sizeWithFont:defFont12 constrainedToSize:CGSizeMake(MAXFLOAT, 18)];
        
        //  -- 单个活动 活动介绍
        [UICommon Common_UILabel_Add:CGRectMake(xpoint, ypoint + paddingForLable + 2, tsize.width+4, 16)
                          targetView:targetview
                             bgColor:[UIColor convertHexToRGB:arrpre[1]]
                                 tag:99001
                                text:arrpre[0]
                               align:0 isBold:NO fontSize:12 tColor:[UIColor whiteColor]];
        
        CGRect cgframe1 = CGRectMake(xpoint+tsize.width+12, ypoint + paddingForLable, __MainScreen_Width-xpoint-tsize.width-6-24, 20);
        [UICommon Common_UILabel_Add:cgframe1
                          targetView:targetview
                             bgColor:[UIColor clearColor] tag:99002
                                text:perinfo.ActionTitle
                               align:-1 isBold:NO fontSize:12 tColor:color_333333];
        
        ypoint += cgframe1.size.height + paddingForLable;
        i++;
    }
    
    //  --结果
    CGRect cgframe2 = CGRectMake(xpoint, ypoint, __MainScreen_Width-xpoint-8, acresult.length>0 ? 30:0);
    [UICommon Common_UILabel_Add:cgframe2 targetView:targetview bgColor:[UIColor clearColor] tag:99003
                            text:acresult align:-1 isBold:NO fontSize:12 tColor:[UIColor redColor]];
    
    return ypoint + cgframe2.size.height;
}

//  -- 换购 or 更换优惠活动
- (void) loadView_change{
    changeView = [[ChangeBuyOrActionView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 0)];
    [changeView setBackgroundColor:[UIColor clearColor]];
    changeView.delegateChangeBuy = self;
}

//  -- 键盘上方控制 视图&按钮
- (void) loadView_keybordButton{
    keybordView = [[UIView alloc]initWithFrame:CGRectMake(0, kMainScreenHeight, __MainScreen_Width, 45.0f)];
    [keybordView setBackgroundColor:[UIColor whiteColor]];
    keybordView.layer.borderColor = [UIColor convertHexToRGB:@"C5C5C5"].CGColor;
    keybordView.layer.borderWidth = 0.5f;
    [self.view addSubview:keybordView];
    
    lbl_limitNum = [[UILabel alloc] init];
    [lbl_limitNum setFrame:CGRectMake(60, 2, def_WidthArea(60), keybordView.frame.size.height-2)];
    [lbl_limitNum setBackgroundColor:[UIColor clearColor]];
    [lbl_limitNum setTextAlignment:NSTextAlignmentCenter];
    [lbl_limitNum setFont:defFont(YES, 12)];
    [lbl_limitNum setTextColor:color_989898];
    [keybordView addSubview:lbl_limitNum];
    
    UIButton * btn_Cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Cancle setFrame:CGRectMake(10, 0, 50, keybordView.frame.size.height)];
    [btn_Cancle setTag:2014];
    [btn_Cancle setTitle:@"取消" forState:UIControlStateNormal];
    [btn_Cancle.titleLabel setFont:defFont14];
    [btn_Cancle setTitleColor:color_333333 forState:UIControlStateNormal];
    [btn_Cancle setBackgroundColor:[UIColor clearColor]];
    [btn_Cancle addTarget:self action:@selector(onKeyboryViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [keybordView addSubview:btn_Cancle];
    
    UIButton * btn_ok = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_ok setFrame:CGRectMake(__MainScreen_Width-60, 0, 50, keybordView.frame.size.height)];
    [btn_ok setTag:2015];
    [btn_ok setTitle:@"确定" forState:UIControlStateNormal];
    [btn_ok.titleLabel setFont:defFont14];
    [btn_ok setTitleColor:color_333333 forState:UIControlStateNormal];
    [btn_ok setBackgroundColor:[UIColor clearColor]];
    [btn_ok addTarget:self action:@selector(onKeyboryViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [keybordView addSubview:btn_ok];
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr_GroupList ? arr_GroupList.count:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    resMod_Mall_ShoppingCartGroupList * grouplist = arr_GroupList[section];
    return grouplist ? grouplist.GoodsList.count:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //  cell 基高
    float fheight = cellMinHeight;
    //  单品下面的活动说明区 高度.
    float fheight_ViewActivity = 0;//30*3;
    //  单品活动结果区 高度.
    float fheight_ViewResultsOfActivitiesForPerProduct = 0;//(10+38);
    //  每组活动结果  高度.
    float fheight_ViewResultsOfActivitiesForPerGroup   = 0;
    
    resMod_Mall_ShoppingCartGroupList * grouplist = arr_GroupList[indexPath.section];
    if (grouplist.GoodsList && grouplist.GoodsList.count>0) {
        
        resMod_Mall_ShoppingCartGoodsInfo * goodsinfo = grouplist.GoodsList[indexPath.row];

        fheight_ViewActivity = goodsinfo.PreferentialInfo.count*(20+6);
        fheight_ViewActivity += (fheight_ViewActivity>0 ? 5:0);
        
        fheight_ViewResultsOfActivitiesForPerProduct = goodsinfo.IsPreferential ? 25+7+7:0;
        fheight_ViewResultsOfActivitiesForPerProduct += goodsinfo.IsChangeBuy ? 25+7+(fheight_ViewResultsOfActivitiesForPerProduct==0?7:0):0;
        fheight_ViewResultsOfActivitiesForPerProduct = (goodsinfo.ActionResult.length>0 && fheight_ViewResultsOfActivitiesForPerProduct==0)? 25+7+7:fheight_ViewResultsOfActivitiesForPerProduct;
        
        BOOL b_isLastRow  = indexPath.row+1==grouplist.GoodsList.count;
        if (b_isLastRow) {
            fheight_ViewResultsOfActivitiesForPerGroup = grouplist.PreferentialInfo.count*(8+20);
            fheight_ViewResultsOfActivitiesForPerGroup += grouplist.ActionResult.length>0 ? 30:0;
            
            fheight_ViewResultsOfActivitiesForPerGroup += (fheight_ViewResultsOfActivitiesForPerGroup>0 ? 8:0);
        }
    }
    return fheight + fheight_ViewActivity + fheight_ViewResultsOfActivitiesForPerProduct +fheight_ViewResultsOfActivitiesForPerGroup;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 1)];
    [footview setBackgroundColor:[UIColor clearColor]];
    
    //  --每组分隔线
    UILabel * lblSectionSpaceLine = [[UILabel alloc] init];
    [lblSectionSpaceLine setFrame:CGRectMake(0, footview.frame.size.height-1, __MainScreen_Width, 1)];
    [lblSectionSpaceLine setBackgroundColor:[UIColor convertHexToRGB:@"C5C5C5"]];
    [footview addSubview:lblSectionSpaceLine];
    return footview;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int isection = indexPath.section;
    int irow     = indexPath.row;
    NSString * IdentifierCell = @"ShopCartCell";
    
    TableCell_ShopCart *cell = (TableCell_ShopCart*)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    if ( cell==nil ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_ShopCart" owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[TableCell_ShopCart class]]) {
                cell = (TableCell_ShopCart *)oneObject;
                cell.delegateCart = self;
                
                //  -- 每行商品的分隔线
                UILabel * lblSpaceLine = [[UILabel alloc] initWithFrame:CGRectMake(cell.productIMG.frame.origin.x, 0, __MainScreen_Width-cell.productIMG.frame.origin.x-9, 0.5)];
                [lblSpaceLine setTag:999];
                [lblSpaceLine setBackgroundColor: [UIColor convertHexToRGB:@"c5c5c5"]];
                [cell.contentView addSubview:lblSpaceLine];

                //  --  每组活动结果 ： 控制显示 于该组最后一行商品下面
                UIView * view_ResultForPerGroupActivity = [[UIView alloc] init];
                [view_ResultForPerGroupActivity setTag:99999992];
                [view_ResultForPerGroupActivity setFrame:CGRectMake(0, 0, __MainScreen_Width, 0)];
                [view_ResultForPerGroupActivity setBackgroundColor:color_fbf7f7];//color_dedede
                [cell.contentView addSubview:view_ResultForPerGroupActivity];
            }
        }
    }
    
    UILabel* lbl_999 = (UILabel*)[cell.contentView viewWithTag:999];
    [lbl_999 setHidden: irow>0 ? NO:YES];
    UIView * view_99999992 = (UIView*)[cell.contentView viewWithTag:99999992];
    [view_99999992 setHidden:YES];
    
    resMod_Mall_ShoppingCartGroupList * grouplist = arr_GroupList[isection];
    if (grouplist) {
        
        BOOL b_isLastRow = NO;
        if (grouplist.GoodsList && grouplist.GoodsList.count>0) {
            
            b_isLastRow  = irow+1==grouplist.GoodsList.count;
            
            resMod_Mall_ShoppingCartGoodsInfo * goodsinfo = grouplist.GoodsList[irow];
            if ([goodsinfo isKindOfClass: [resMod_Mall_ShoppingCartGoodsInfo class]]) {
                
                cell.cellResourceData = goodsinfo;
            
                [cell setBtnCheckImage];
                [cell.productIMG sd_setImageWithURL:[NSURL URLWithString:goodsinfo.GoodsImg]
                                   placeholderImage:[UIImage imageNamed:@"placeHold_75x75.png"]];
                [cell.lbl_title     setText:goodsinfo.GoodsTitle];
                [cell.lbl_salePrice setText:[self convertPrice:goodsinfo.GoodsPrice]];
                [cell.txt_proNum    setText:[NSString stringWithFormat:@"%d",goodsinfo.GoodsNum]];
                
                //  --规格
                NSString * spec = @"";
                int i=0;
                for (resMod_Mall_CartGoodsProperty * sproperty in goodsinfo.GoodsSpec) {
                    spec = [NSString stringWithFormat:@"%@%@%@",spec,(i>0?@"，":@""),sproperty.Value];
                    i++;
                }
                [cell.lbl_proSpec setText:[NSString stringWithFormat:@"%@%@", (spec.length>0?@"规格: ":@"") ,spec]];
                
                //  --下面的活动说明，活动结果，活动更换区
                [cell setViewActivity];
                [cell setViewResultsOfActivities];
            }
            
            
            //  -- 最后一行时，加载该组合的活动结果
            if (b_isLastRow) {
                
                float heightforgroup = [self loadView_ResultForPerGroupActivity:view_99999992
                                                               PreferentialInfo:grouplist.PreferentialInfo
                                                                   ActionResult:grouplist.ActionResult];
                [view_99999992 setHidden:heightforgroup>0?NO:YES];
                [view_99999992 setFrame:CGRectMake(0, CGRectGetMaxY(cell.view_ResultsOfActivities.frame)+8, __MainScreen_Width, heightforgroup)];
            }
        }
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (arr_GroupList && arr_GroupList.count>indexPath.section) {
        b_isFromGoBack = YES;
        resMod_Mall_ShoppingCartGroupList * tmpgroup = arr_GroupList[indexPath.section];
        NSString * proid = [NSString stringWithFormat:@"%d",[tmpgroup.GoodsList[indexPath.row] GoodsId]];
        [self pushNewViewController:@"MallProductDetailController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:proid,@"paramGoodsID", nil]];
    }
}

#pragma mark    --  api接口用的params
-(NSMutableArray *) getProductsForApiParams{
    NSMutableArray * proinfoForApiParams = [[NSMutableArray alloc] initWithCapacity:0];
    for (resMod_Mall_ShoppingCartGroupList * keygroups in arr_GroupList) {
        for (resMod_Mall_ShoppingCartGoodsInfo * keyGoods in keygroups.GoodsList) {
            if (keyGoods.IsSelected) {
                resMod_Mall_GoodsForApiParams * protmp = [[resMod_Mall_GoodsForApiParams alloc] init];
                protmp.GoodsId = keyGoods.GoodsId;
                protmp.GoodsNum = keyGoods.GoodsNum;
                protmp.limitNum = keyGoods.GoodsLimit;
                protmp.GoodsType = keyGoods.GoodsType;
                protmp.GoodsSpecId = keyGoods.GoodsSpecId;
                [proinfoForApiParams addObject:protmp];
            }
        }
    }
    return proinfoForApiParams;
}

#pragma mark    --  api 请 求 & 回 调.

//  -- 离线购物车: 用户登录后合并到购物车
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
        [[APIMethodHandle shareAPIMethodHandle] goApiRequestBatchAddToShoppingCart:apiParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"" delegate:self];
    }
}

//  -- 购物车信息
- (void)goApiRequest_GetCartDetail:(BOOL) isneedgroupinfo{

    NSString * sjsonGroupsInfo = @"";
    if (isneedgroupinfo) {
        for (resMod_Mall_ShoppingCartGroupList * keygroups in arr_GroupList) {
            NSString * sjsonGoodsinfo = @"";
            for (resMod_Mall_ShoppingCartGoodsInfo * keyGoods in keygroups.GoodsList) {
                
                sjsonGoodsinfo = [NSString stringWithFormat:@"%@%@{\"GoodsId\": %d,\"GoodsNum\": %d,\"GoodsSpecId\": \"%@\", \"GoodsType\": %d,\"IsSelected\": %d ,\"ChangeBuyId\": %d,\"ActionId\": %d,\"TimeStamp\": %lld}",sjsonGoodsinfo,sjsonGoodsinfo.length>0?@",":@"",keyGoods.GoodsId,keyGoods.GoodsNum,keyGoods.GoodsSpecId,keyGoods.GoodsType,keyGoods.IsSelected,keyGoods.ChangeBuyId,keyGoods.ActionId,keyGoods.TimeStamp];
            }
            sjsonGroupsInfo = [NSString stringWithFormat:@"%@%@{\"GoodsInfo\":[%@], \"ActionId\":%d}",sjsonGroupsInfo,sjsonGroupsInfo.length>0?@",":@"",sjsonGoodsinfo,keygroups.ActionId];
        }
    }
    
    NSMutableDictionary * apiParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    if ([UserUnit isUserLogin]) {
        [apiParams setValue:[UserUnit userId] forKey:@"UserId"];
    }
    [apiParams setValue:[NSString stringWithFormat:@"[%@]",sjsonGroupsInfo] forKey:@"GroupInfo"];
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingCartDetail:apiParams
                                                                  ModelClass:@"resMod_CallBackMall_ShoppingCart"
                                                           showLoadingAnimal:YES hudContent:@"正在加载" delegate:self];
}

// --   获取离线商品详细信息
- (void)goApiRequest_GetOfflineGoodsDetails:(NSMutableArray *)offlineItemsArray {
    
    if (offlineItemsArray.count > 0)
    {
        NSString * sjsonGroupsInfo = @"";
        NSString * sjsonGoodsInfo =@"";
        for (int i = 0; i < offlineItemsArray.count; i++)
        {
            OfflineGoods *item = [offlineItemsArray objectAtIndex:i];
            sjsonGoodsInfo = [NSString stringWithFormat:@"%@%@{\"GoodsId\": %d,\"GoodsNum\": %d,\"GoodsSpecId\": \"%@\", \"GoodsType\": %d, \"IsSelected\": %d,\"ChangeBuyId\": %d,\"ActionId\": %d,\"TimeStamp\": %f}",sjsonGoodsInfo,sjsonGoodsInfo.length>0?@",":@"",item.goodsID,item.totalNum,item.goodsSpecId,item.goodsType,item.selected,item.changeBuyId,item.actionId,[[NSDate date] timeIntervalSince1970]];
        }
        NSMutableDictionary *apiParams = [[NSMutableDictionary alloc] init];
        sjsonGroupsInfo = [NSString stringWithFormat:@"%@%@{\"GoodsInfo\":[%@], \"ActionId\":0}",sjsonGroupsInfo,sjsonGroupsInfo.length>0?@",":@"",sjsonGoodsInfo];
        [apiParams setValue:[NSString stringWithFormat:@"[%@]",sjsonGroupsInfo] forKey:@"GroupInfo"];
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingCartDetail:apiParams
                                                                      ModelClass:@"resMod_CallBackMall_ShoppingCart"
                                                               showLoadingAnimal:YES hudContent:@"正在加载" delegate:self];

    }
}

//  -- 删除指定商品
- (void)goApiRequest_DeleteCartProduct{
    
    NSMutableArray * arrproduct = [self getProductsForApiParams];
    
    if (arrproduct.count>0) {
        NSMutableDictionary * apiParams = [[NSMutableDictionary alloc] initWithCapacity:0];
        [apiParams setValue:[UserUnit userId] forKey:@"UserId"];
        [apiParams setValue:[self convertGoodsInfoForApiParams: arrproduct] forKey:@"GoodsInfo"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestDeleteShoppingCartGoods:apiParams ModelClass:@"ResponseBase"
                                                                 showLoadingAnimal:NO hudContent:@"正在删除" delegate:self];
    }
    else {
        [self HUDShow:@"请选择要删除的商品" delay:2];
    }
}

//  -- 修改商品数量
- (void)goApiRequest_ModifyProductNum:(resMod_Mall_ShoppingCartGoodsInfo *) proinfo{

    NSMutableDictionary * apiParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [apiParams setValue:[UserUnit userId] forKey:@"UserId"];
    [apiParams setValue:[NSString stringWithFormat:@"%d",proinfo.GoodsId] forKey:@"GoodsId"];
    [apiParams setValue:self.txtCurrentProductNum.text forKey:@"GoodsNum"];
    [apiParams setValue:proinfo.GoodsSpecId forKey:@"GoodsSpecId"];
    [apiParams setValue:[NSString stringWithFormat:@"%d",proinfo.GoodsType] forKey:@"GoodsType"];
    
    //    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_ModifyCartGoodsNumber class:@"ResponseBase"
    //              params:apiParams  isShowLoadingAnimal:NO hudShow:@"正在更改数量"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestModifyShoppingCartGoodsNumber:apiParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在更改数量" delegate:self];
}

//  -- 获取换购及优惠列表
- (void)goApiRequest_GetChangeBuyList:(int) pgoodsid actionid:(int)pactionid groupprice:(float) pgroupprice{
    
    NSMutableDictionary * apiParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [apiParams setValue:[NSString stringWithFormat:@"%d",pgoodsid] forKey:@"GoodsId"];
    [apiParams setValue:[NSString stringWithFormat:@"%d",pactionid] forKey:@"ActionId"];
    [apiParams setValue:[NSString stringWithFormat:@"%.2f",pgroupprice] forKey:@"GroupPrice"];

    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetChangeBuyList:apiParams
                                                             ModelClass:@"resMod_CallBackMall_CartChangeBuyList"
                                                      showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
}

//  -- 更换换购或优惠
- (void)goApiRequest_ChangeBuyGoods:(NSMutableDictionary*) apiParams{

    if (apiParams && apiParams.count>0) {
        [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestChangeBuyGoods:apiParams ModelClass:@"ResponseBase"
                                                        showLoadingAnimal:NO hudContent:@"正在更换" delegate:self];
    }
}

//  --  。。。
-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    
    if ([ApiName isEqualToString:kApiMethod_Mall_CartDetailV2]) {
        
        resMod_CallBackMall_ShoppingCart * backObj = [[resMod_CallBackMall_ShoppingCart alloc] initWithDic:retObj];
        self.m_CartDetail = backObj.ResponseData;
        if (self.m_CartDetail) {

            if (self.tmpOperationCell && !b_isCheckedAllProducts) {
                tmpLastOperationGoodsid = self.tmpOperationCell.cellResourceData.GoodsId;
                tmpLastOperationGoodsSpecId = self.tmpOperationCell.cellResourceData.GoodsSpecId;
            }
            
            [arr_GroupList removeAllObjects];
            [arr_GroupList addObjectsFromArray: self.m_CartDetail.GroupList];
            
            if (arr_GroupList && arr_GroupList.count>0)
            {
                if (![UserUnit isUserLogin])
                {
                    OfflineGoods *item = [[OfflineGoods alloc] init];
                    for (resMod_Mall_ShoppingCartGroupList * keyGroup in arr_GroupList)
                    {
                        for(resMod_Mall_ShoppingCartGoodsInfo * keyGoodinfo in keyGroup.GoodsList)
                        {
                           
                            item.goodsID = keyGoodinfo.GoodsId;
                            item.goodsSpecId =  keyGoodinfo.GoodsSpecId;
                            item.goodsType = keyGoodinfo.GoodsType;
                            item.totalNum = keyGoodinfo.GoodsNum;
                            item.addedDate = [NSDate date];
                            item.selected = keyGoodinfo.IsSelected;
                            item.changeBuyId = keyGoodinfo.ChangeBuyId;
                            item.actionId = keyGoodinfo.ActionId;
                            [OfflineShoppingCart updateGoods:item];
                            
                        }
                        
                    }
                }
            }
            
            [rootTableView reloadData:YES allDataCount:0];
            [self.lodingAnimationView stopLoadingAnimal];
            
            //  --  下面的全选按钮
            [self setButtonCheckAllStatus];
            
            //  --  定位 ：滚到上次所操作的cell
            if (self.tmpLastOperationIndexPath && !b_isCheckedAllProducts) {
                [rootTableView scrollToRowAtIndexPath:self.tmpLastOperationIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            }
            
            if (backObj.ResponseMsg.length>0) {
                [self HUDShow:backObj.ResponseMsg delay:3];
            }
        }
        
        [self.noDataView noDataViewIsHidden: (arr_GroupList==nil||arr_GroupList.count==0) ? NO:YES
                                    warnImg: @"" warnMsg:@"您的购物车还是空的，赶紧给爱宠挑点什么吧！"];
        [self setWarnLables:m_CartDetail.TipFront money1:m_CartDetail.TipMoneyFront
                       tip2:m_CartDetail.TipMiddle money2:m_CartDetail.TipMoneyBack
                 totalPrice:m_CartDetail.NeedToPay discountPrice:m_CartDetail.Preferential];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_DeleteCartGoods]) {
        [self HUDShow:@"删除成功" delay:2];
        [self goApiRequest_GetCartDetail:NO];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_GetChangeBuyList]) {
        
        resMod_CallBackMall_CartChangeBuyList * backObj = [[resMod_CallBackMall_CartChangeBuyList alloc] initWithDic:retObj];
        if (backObj.ResponseData.ChangeBuyList.count>0 || backObj.ResponseData.ActionList.count>0) {
            UIWindow * window = [[UIApplication sharedApplication] keyWindow];
            [window addSubview:changeView];
            changeView.ChangeData = backObj.ResponseData;
            [changeView tabReloadData:backObj.ResponseData];
            [changeView resetFrame:window.bounds];
        }
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_ModifyCartGoodsNumber]) {
        [self HUDShow:@"更改数量成功" delay:2];
        [self goApiRequest_GetCartDetail:YES];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_ChangeBuyGoods]) {
        [self HUDShow:@"已更换优惠方式" delay:2];
        [self goApiRequest_GetCartDetail:YES];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_BatchAddToShoppingCart]) {
        
        [OfflineShoppingCart deleteAll];
        [self goApiRequest_GetCartDetail:NO];
    }
    
//    if([ApiName isEqualToString:kApiMethod_Mall_GetOfflineShoppingCartDetail])
//    {
//      //  [self hudWasHidden:HUD];
//        resMod_CallBackMall_ShoppingCart * backObj = [[resMod_CallBackMall_ShoppingCart alloc] initWithDic:retObj];
//        self.m_CartDetail = backObj.ResponseData;
//        if (self.m_CartDetail) {
//            
//            [arr_GroupList removeAllObjects];
//            [arr_GroupList addObjectsFromArray: self.m_CartDetail.GroupList];
//            
//            [rootTableView reloadData:YES allDataCount:0];
//            [self.lodingAnimationView stopLoadingAnimal];
//            //  --  下面的全选按钮
//            [self setButtonCheckAllStatus];
//        }
//        [self.noDataView noDataViewIsHidden: (arr_GroupList==nil||arr_GroupList.count==0) ? NO:YES
//                                    warnImg: @"" warnMsg:@"您的购物车还是空的，赶紧给爱宠挑点什么吧！"];
//        [self setWarnLables:m_CartDetail.TipFront money1:m_CartDetail.TipMoneyFront
//                       tip2:m_CartDetail.TipMiddle money2:m_CartDetail.TipMoneyBack
//                 totalPrice:m_CartDetail.NeedToPay discountPrice:m_CartDetail.Preferential];
//    }
}

-(void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];
    
    if ([ApiName isEqualToString:kApiMethod_Mall_CartDetailV2]) {
        
    }
}

#pragma mark    --  Offline 离线[未登录] 购物车操作商品列表
//  --从本地数据库读取 商品列表
- (void)offline_GetGoodsFromDatabase {
    NSMutableArray *offlineItemsArray = [OfflineShoppingCart queryAll];
    if (offlineItemsArray.count !=  0) {
        [self goApiRequest_GetOfflineGoodsDetails:offlineItemsArray];
    }
    else {
        
        [arr_GroupList removeAllObjects];
        [rootTableView reloadData];
        [self.noDataView noDataViewIsHidden:arr_GroupList==nil||arr_GroupList.count==0 ? NO:YES
                                    warnImg:@"" warnMsg:@"您的购物车还是空的，赶紧给爱宠挑点什么吧！"];
        [btn_calculate setTitle: @"结算"forState: UIControlStateNormal];
        [btnCheckAll setImage:[UIImage imageNamed:@"checkbox_greenUnsel"] forState:UIControlStateNormal];
        [self setWarnLables:nil money1:0.0 tip2:nil money2:0.0 totalPrice:0.0 discountPrice:0.0];
        
    }
}
//  --更新离线购物车本地数据库
- (void)offline_UpdateGoodsDatabase:(resMod_Mall_ShoppingCartGoodsInfo *)selectedGoods{
    
    if (selectedGoods) {
        OfflineGoods *item = [[OfflineGoods alloc] init];
        item.goodsID = selectedGoods.GoodsId;
        item.goodsSpecId =  selectedGoods.GoodsSpecId;
        item.goodsType = selectedGoods.GoodsType;
        item.totalNum = [self.txtCurrentProductNum.text intValue];
        item.addedDate = [NSDate date];
        item.selected = selectedGoods.IsSelected;
        item.changeBuyId = selectedGoods.ChangeBuyId;
        item.actionId = selectedGoods.ActionId;
        [OfflineShoppingCart updateGoods:item];
        [self offline_GetGoodsFromDatabase];
       // [self HUDShow:@"更改数量成功" delay:2];
    }
}


#pragma mark    --  scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [rootTableView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [rootTableView tableViewDidDragging];
    if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
        [rootTableView tableViewIsRefreshing];
        if ([UserUnit isUserLogin]) {
            [self goApiRequest_GetCartDetail:NO];
        }
        else {
            NSMutableArray *offlineItemsArray = [OfflineShoppingCart queryAll];
            if (offlineItemsArray.count != 0) {
                [self goApiRequest_GetOfflineGoodsDetails:offlineItemsArray];
            }
            else {
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


#pragma mark    --  键盘处理
- (void)handleKeyboardDidShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    CGFloat distanceToMove = kbSize.height;
    
    [self.view bringSubviewToFront:keybordView];
    [UIView animateWithDuration:0.45
                     animations:^{
                         [keybordView setFrame:CGRectMake(0,kMainScreenHeight-50-distanceToMove+5, __MainScreen_Width, 45.0f)];
                     }];
}

- (void)handleKeyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.2
                     animations:^{
                         [keybordView setFrame:CGRectMake(0,kMainScreenHeight, __MainScreen_Width, 45.0f)];
                     }];
}

- (void)onKeyboryViewButtonClick:(id) sender{
    
    UIButton * tmpbtn = (UIButton*)sender;
    if (tmpbtn.tag==2014) {         //  --  取消 更改数量
        [self.txtCurrentProductNum setText:[NSString stringWithFormat:@"%d",self.tmpOperationCell.cellResourceData.GoodsNum]];
    }
    else if(tmpbtn.tag ==2015){     //  --  确定 更改数量
    
        int pronum = [self.txtCurrentProductNum.text intValue];
        if ([self checkGoodsLimitNumber:pronum]) {
            if (self.tmpOperationCell) {
                
                self.tmpOperationCell.cellResourceData.GoodsNum = pronum;
//                [self goApiRequest_ModifyProductNum:self.tmpOperationCell.cellResourceData];
                if ([UserUnit isUserLogin])
                {
                    [self goApiRequest_ModifyProductNum:self.tmpOperationCell.cellResourceData];
                }
                else {
                    [self offline_UpdateGoodsDatabase:self.tmpOperationCell.cellResourceData];
                }
            }
        }
    }
    
    [self.txtCurrentProductNum resignFirstResponder];
}

@end
