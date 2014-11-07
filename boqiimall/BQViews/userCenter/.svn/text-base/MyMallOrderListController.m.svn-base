//
//  MyMallOrderListController.m
//  boqiimall
//
//  Created by YSW on 14-6-26.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "MyMallOrderListController.h"

#define     requestPageNum      6
#define     buttonFilterTag     23783
#define     heightForHead       45
#define     heightForCell       200
#define     orderStatusTitles   @"全部订单:1|待付款:2|处理中:3|已完成:4|已取消:5"

@implementation MyMallOrderListController
@synthesize iOrderType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        needRefresh = YES;
        arr_MallOrderList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Hidden:self.tabBarController];

    if (needRefresh) {
        [self goApiRequest_mallOrders:YES hudShow: isBack?@"正在加载":@""];
    }
    needRefresh = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MobClick event:@"myBoqii_myGoodsOrder_myMallOrder"];
   // [self loadNavBarView];
    [self setTitle:@"我的商城订单"];
    [self.view setBackgroundColor:color_bodyededed];
    
   // [self loadNavBarView:@"我的商城订单"];
    
    if ([self.receivedParams objectForKey:@"param_mallOrderType"]) {
        self.iOrderType = [self.receivedParams objectForKey:@"param_mallOrderType"];
    }
    else {
        self.iOrderType = @"1";
    }
    
    [self.view addSubview:[self loadView_TopOrderStatus]];

    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0,heightForHead+kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight-heightForHead-kNavBarViewHeight) style:UITableViewStylePlain];
    [rootTableView setTag:2000];
    rootTableView.backgroundColor = [UIColor clearColor];
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:rootTableView];
}

//- (void)loadNavBarView:(NSString *)title
//{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = title;
//    [bgView addSubview:titleLabel];
//    [self.navBarView addSubview:bgView];
//}
#pragma mark    --  event   click
//  -- orderstatus.
- (void) onMallOrderStatusClick:(id) sender{
    
    UIButton * btnstatus = (UIButton*) sender;
    if ([btnstatus.titleLabel.text isEqualToString:@"待付款"])
    {
        [MobClick event:@"myBoqii_myGoodsOrder_payingOrder_pay"];
    }
    if ([btnstatus.titleLabel.text isEqualToString:@"全部订单"])
    {
        [MobClick event:@"myBoqii_myGoodsOrder_allOrder"];
        
    }
    if ([btnstatus.titleLabel.text isEqualToString:@"处理中"])
    {
        [MobClick event:@"myBoqii_myGoodsOrder_disposingOrder"];
    }
    if ([btnstatus.titleLabel.text isEqualToString:@"已完成"])
    {
        [MobClick event:@"myBoqii_myGoodsOrder_completedOrder"];
        
    }
    if ([btnstatus.titleLabel.text isEqualToString:@"已取消"])
    {
        [MobClick event:@"myBoqii_myGoodsOrder_canceledOrder"];
        
    }

    self.iOrderType = [NSString stringWithFormat:@"%d",btnstatus.tag-buttonFilterTag];
    
    [btnstatus setTitleColor: [UIColor convertHexToRGB:@"FC4A00"] forState:UIControlStateNormal];
    [currentStatus setTitleColor: [UIColor convertHexToRGB:@"3c3c3c"] forState:UIControlStateNormal];
    
    if (btnstatus!=currentStatus) {
        [arr_MallOrderList removeAllObjects];
        [self goApiRequest_mallOrders:YES hudShow:@"正在加载"];
    }
    
    //  ....
    currentStatus = btnstatus;
}


#pragma mark    --  Mall Product Delegate
- (void) onDelegateMallOrderListProductClick:(int)pid{
    needRefresh = NO;
    [self pushNewViewController:@"MallProductDetailController" isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",pid],@"paramGoodsID", nil]];
}

- (void) onDelegateMallOrderListOperateButtonClick:(id) sender{
    
    UIButton * btntmp = (UIButton*) sender;

    UITableViewCell * cell = CELL_SUBVIEW_TABLEVIEW(btntmp,rootTableView);;
//    if (IOS7_OR_LATER) {
//        cell = (UITableViewCell*)[[[btntmp superview] superview] superview];
//    }
//    else{
//        cell = (UITableViewCell*)[[btntmp superview] superview];
//    }
    NSIndexPath * indexpath = [rootTableView indexPathForCell:cell];
    resMod_Mall_MyGoodsOrderInfo * orderinfo = arr_MallOrderList[indexpath.row];
    
    if (orderinfo!=nil) {
        if (btntmp.tag==1000) {
            
            if (orderinfo.OrderStatusInt==2) {      //  -- 取消订单
                iCancleOrderID = orderinfo.OrderId;
                EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"提 示"
                                                                                      message:@"确定取消该订单吗?"
                                                                            cancelButtonTitle:@"否"
                                                                                okButtonTitle:@"是"];
                alertView.delegate1 = self;
                alertView.tag = 8966;
                [alertView show];
            }
            else if(orderinfo.OrderStatusInt==4){   //  -- 去评论
                
                [MobClick event:@"myBoqii_myGoodsOrder_allOrder_comment"];
                isBack = YES;
                [self pushNewViewController:@"MallProductCommentController" isNibPage:NO hideTabBar:YES setDelegate:NO
                              setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",orderinfo.OrderId],@"param_OrderID", nil]];
            }
        }
        if (btntmp.tag==2000) {
            
             [MobClick event:@"myBoqii_myGoodsOrder_allOrder_buyAgain"];
            if (orderinfo.OrderStatusInt==5) {      //  -- 再次购买
//                [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_BuyAgain class:@"ResponseBase"
//                          params:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                  [UserUnit userId],@"UserId",
//                                  [NSString stringWithFormat:@"%d",orderinfo.OrderId],@"OrderId",nil]
//                          isShowLoadingAnimal:NO hudShow:@"正在加载"];
                
                [[APIMethodHandle shareAPIMethodHandle]goApiRequestShoppingMallOrderReBuy:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                                                                                            [UserUnit userId],@"UserId",
                                                                                           [NSString stringWithFormat:@"%d",orderinfo.OrderId],@"OrderId",nil] ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
                
            }
            else if (orderinfo.OrderStatusInt==2 && [btntmp.titleLabel.text isEqualToString:@"付款"]) {
                
                isBack = YES;
                //  --  去付款
                [MobClick event:@"myBoqii_myGoodsOrder_payingOrder_pay"];
                NSMutableDictionary * dicparam = [[NSMutableDictionary alloc]init];
                [dicparam setObject:[NSString stringWithFormat:@"%d",orderinfo.OrderId] forKey:@"param_orderid"];
                [dicparam setObject:[NSString stringWithFormat:@"%.2f",orderinfo.OrderPrice] forKey:@"param_orderprice"];
                [dicparam setObject:@"100" forKey:@"param_isFromOrderList"];
                [dicparam setObject:orderinfo.IsUseBalance?@"100":@"0" forKey:@"param_isUsedBalance"];
                [dicparam setObject:[NSString stringWithFormat:@"%.2f",orderinfo.BalanceUsed] forKey:@"param_BalanceUsed"];
                [self pushNewViewController:@"MallOrderPaymentVC" isNibPage:NO hideTabBar:YES setDelegate:NO
                              setPushParams:dicparam];
            }
            else if (orderinfo.OrderStatusInt==4) { //&& orderinfo.OrderLogisticsUrl.length>0
                
                needRefresh = NO;
                //  --  查看物流
                [MobClick event:@"myBoqii_myGoodsOrder_completedOrder_logistics"];
                
                NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
                [param setValue:[NSString stringWithFormat:@"%d",orderinfo.OrderId] forKey:@"param_OrderId"];
                [self pushNewViewController:@"LogisticsViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:param];
            }
        }
    }
}

#pragma mark    --  ui

//  -- 上面的订单状态
- (UIView *) loadView_TopOrderStatus{
    UIView * HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, heightForHead)];
    [HeadView setBackgroundColor: [UIColor whiteColor]];
    
    UIView * ShadowBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, __MainScreen_Width, heightForHead-1)];
    [ShadowBg setBackgroundColor:[UIColor whiteColor]];
    ShadowBg.layer.shadowColor = [UIColor blackColor].CGColor;
    ShadowBg.layer.shadowOffset = CGSizeMake(0, 0.5);
    ShadowBg.layer.shadowOpacity = 0.3;
    ShadowBg.layer.shadowRadius = 0.8;
    [HeadView addSubview:ShadowBg];
    
    NSArray * arrTxtStatus = [orderStatusTitles componentsSeparatedByString:@"|"];
    float fWidth = __MainScreen_Width/arrTxtStatus.count;
    int i=0;
    for (NSString * sa in arrTxtStatus) {
        NSArray * arrtmp = [sa componentsSeparatedByString:@":"];
        NSString * stxt = arrtmp[0];
        
        int xpoint = i*fWidth;
        int butTag = buttonFilterTag + [arrtmp[1] intValue];
        
        UIButton * serviceStatusType = [UIButton buttonWithType:UIButtonTypeCustom];
        [serviceStatusType setBackgroundColor: [UIColor clearColor]];
        [serviceStatusType setFrame:CGRectMake(xpoint, 0, fWidth, heightForHead)];
        [serviceStatusType setTag:butTag];
        [serviceStatusType setTitle:stxt forState:UIControlStateNormal];
        [serviceStatusType.titleLabel setFont: defFont13];
        [serviceStatusType setTitleColor: [UIColor convertHexToRGB:@"3c3c3c"] forState: UIControlStateNormal];
        [serviceStatusType addTarget:self action:@selector(onMallOrderStatusClick:)
                    forControlEvents:UIControlEventTouchUpInside];
        [HeadView addSubview:serviceStatusType];
        
        
        [UICommon Common_line:CGRectMake(fWidth-0.5, heightForHead/2-7, 0.5, 15)
                   targetView:serviceStatusType backColor: color_d1d1d1];
        
        if (i+1==[self.iOrderType intValue]) {
            [serviceStatusType setTitleColor: color_fc4a00 forState: UIControlStateNormal];
            currentStatus = serviceStatusType;
        }
        ++i;
    }
    return HeadView;
}



#pragma mark    --  api 请求 加调

-(void) goApiRequest_mallOrders:(BOOL) isRefresh hudShow:(NSString*) _hudmsg{
    
    int startidx = arr_MallOrderList.count;
    int ipagenum = requestPageNum;
    if (isBack) {
        isBack = NO;
        startidx = 0;
        ipagenum = arr_MallOrderList.count;
    }
    
    b_isPullRefresh = isRefresh;
    
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:self.iOrderType forKey:@"OrderType"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", startidx] forKey:@"StartIndex"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", ipagenum] forKey:@"Number"];
    
    
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_OrderList class:@"resMod_CallBackMall_MyGoodsOrder"
//              params:dicParams isShowLoadingAnimal:YES hudShow:_hudmsg];
//    GetMyGoodsOrderList
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMyGoodsOrderList:dicParams ModelClass:@"resMod_CallBackMall_MyGoodsOrder" showLoadingAnimal:YES hudContent:_hudmsg delegate:self];
    
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_Mall_OrderList]) {
        resMod_CallBackMall_MyGoodsOrder * backObj = [[resMod_CallBackMall_MyGoodsOrder alloc] initWithDic:retObj];
        int callNum = backObj.ResponseData.count;
        if (b_isPullRefresh) {
            b_isPullRefresh = NO;
            [arr_MallOrderList removeAllObjects];
        }
        [arr_MallOrderList addObjectsFromArray: backObj.ResponseData];
        
        [self.noDataView setHidden:arr_MallOrderList.count==0 ? NO :YES];
        [rootTableView reloadData: callNum<requestPageNum ? YES : NO allDataCount:arr_MallOrderList.count];
        
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_OrderCancle]) {
        isBack = YES;
        [self goApiRequest_mallOrders:YES hudShow:@""];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_BuyAgain]) {
        
        isBack = YES;
        [self pushNewViewController:@"ShoppingCartViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"param_isFromPush", nil]];
    }
}

- (void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];
    
    if ([ApiName isEqualToString:kApiMethod_Mall_OrderList]) {
        b_isPullRefresh = NO;
        [self.noDataView setHidden:arr_MallOrderList.count==0 ? NO :YES];
        [rootTableView reloadData:YES allDataCount:arr_MallOrderList.count];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_OrderCancle]) {
        [self.noDataView setHidden:arr_MallOrderList.count==0 ? NO :YES];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_BuyAgain]) {
        
    }
}



#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arr_MallOrderList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightForCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static  NSString * Identifier = @"mallOrderListCell";
    
    TableCell_MallOrder * cell = (TableCell_MallOrder*)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if ( !cell ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_UserCenter" owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[TableCell_MallOrder class]]) {
                cell = (TableCell_MallOrder *)oneObject;
                cell.userCenterMallOrderDelegate = self;
             
                UIImageView * rightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width-33, heightForCell/2-26, 15, 15)];
                [rightIcon setBackgroundColor:[UIColor clearColor]];
                [rightIcon setImage:[UIImage imageNamed:@"right_icon.png"]];
                [cell.contentView addSubview:rightIcon];
            }
        }
    }
    
    if (arr_MallOrderList.count>0) {
        
        resMod_Mall_MyGoodsOrderInfo * orderinfo = arr_MallOrderList[indexPath.row];
        [cell.lbl_OrderNum setText:[NSString stringWithFormat:@"%d",orderinfo.OrderId]];
        [cell.lbl_OrderPrice setText:[self convertPrice:orderinfo.OrderPrice]];
        [cell.lbl_OrderCreateTime setText:orderinfo.OrderTime];
        [cell.lbl_OrderStatus  setText:orderinfo.OrderStatusString];

        [cell.btn_Operate1 setHidden: orderinfo.OrderCanComment==0?YES:NO];
        [cell.btn_Operate1 setTitleColor:color_4e4e4e forState:UIControlStateNormal];
        [cell.btn_Operate1 setBackgroundImage:def_ImgStretchable(@"btn_bg_blackline",6, 6) forState:UIControlStateNormal];
        [cell.btn_Operate1 setFrame:CGRectMake(__MainScreen_Width-140, cell.btn_Operate1.frame.origin.y, 50, cell.btn_Operate1.frame.size.height)];
        [cell.btn_Operate2 setHidden: YES];
        [cell.btn_Operate2 setTitleColor:color_4e4e4e forState:UIControlStateNormal];
        [cell.btn_Operate2 setFrame:CGRectMake(__MainScreen_Width-80, cell.btn_Operate2.frame.origin.y, 50, cell.btn_Operate2.frame.size.height)];
        
        if (orderinfo.OrderStatusInt==2) {                  //  -- 订单待付款
            [cell.btn_Operate1 setHidden:NO];
            [cell.btn_Operate1 setTitle:@"取消订单" forState:UIControlStateNormal];
            [cell.btn_Operate1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [cell.btn_Operate1.titleLabel setFont:defFont13];
            [cell.btn_Operate1 setTitleColor:color_989898 forState:UIControlStateNormal];
            
            if (orderinfo.OrderPaymentId!=2) {              //  -- 货到付款，不能去付款
                [cell.btn_Operate2 setHidden:NO];
                [cell.btn_Operate2 setTitle:@"付款" forState:UIControlStateNormal];
                [cell.btn_Operate1 setFrame:CGRectMake(__MainScreen_Width-150, cell.btn_Operate1.frame.origin.y, 70, cell.btn_Operate1.frame.size.height)];
            }
            else{
                [cell.btn_Operate1 setFrame:CGRectMake(__MainScreen_Width-90, cell.btn_Operate1.frame.origin.y, 70, cell.btn_Operate1.frame.size.height)];
            }
        }
        else if(orderinfo.OrderStatusInt==3){               //  -- 订单处理中
            
        }
        else if(orderinfo.OrderStatusInt==4) {              //  -- 订单已完成
            //&& orderinfo.OrderLogisticsUrl.length>0

            [cell.btn_Operate1 setTitle:@"点评" forState:UIControlStateNormal];
            [cell.btn_Operate2 setHidden:NO];
            [cell.btn_Operate2 setTitle:@"物流" forState:UIControlStateNormal];
        }
        else if (orderinfo.OrderStatusInt==5) {             //  -- 订单取消了
            [cell.btn_Operate2 setHidden:NO];
            [cell.btn_Operate2 setTitle:@"再次购买" forState:UIControlStateNormal];
            [cell.btn_Operate2 setFrame:CGRectMake(__MainScreen_Width-100, cell.btn_Operate2.frame.origin.y, 70, cell.btn_Operate2.frame.size.height)];
        }
        
        [cell loadOrderProductImages:orderinfo.OrderGoods];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    isBack = YES;
    if (arr_MallOrderList && arr_MallOrderList.count>indexPath.row) {
        NSString * pOrderID = [NSString stringWithFormat:@"%d",[arr_MallOrderList[indexPath.row] OrderId]];
        [self pushNewViewController:@"MallOrderDetailViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:pOrderID,@"param_orderid", nil]];
    }
}


#pragma mark    --  scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [rootTableView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [rootTableView tableViewDidDragging];
    if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
        [arr_MallOrderList removeAllObjects];
        [rootTableView tableViewIsRefreshing];
        [self goApiRequest_mallOrders:YES hudShow:@""];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger returnKey = [rootTableView tableViewDidEndDragging];
    if (returnKey == k_RETURN_LOADMORE){    // 上拉加载更多
        [self goApiRequest_mallOrders:NO hudShow:@""];
    }
}

#pragma mark    --  alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 8966) {
        if(buttonIndex == 1) {
            if (iCancleOrderID>0) {
//                [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_OrderCancle class:@"ResponseBase"
//                          params:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[UserUnit userId],@"UserId",
//                                  [NSString stringWithFormat:@"%d",iCancleOrderID],@"OrderId",nil]
//                          isShowLoadingAnimal:NO hudShow:@"正在取消"];
                
                
                [[APIMethodHandle shareAPIMethodHandle]goApiRequestShoppingMallCancelOrder:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[UserUnit userId],@"UserId",
                                                                                                                        [NSString stringWithFormat:@"%d",iCancleOrderID],@"OrderId",nil]
                                                                                ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在取消" delegate:self];
                iCancleOrderID = -1000;
            }
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
