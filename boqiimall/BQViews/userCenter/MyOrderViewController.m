//
//  MyOrderViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-15.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MyOrderViewController.h"

#define     requestPageNum  10
#define     heightForCell   96
#define     heightForHead   45

#define     buttonFilterTag 8993
#define     buttonTitles    @"全部订单:1|待付款:2|已付款:3|退款中:4|已退款:5"

@implementation MyOrderViewController
@synthesize iOrderType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        arrOrderList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Hidden:self.tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MobClick event:@"myBoqii_myServiceOrder"];
    
    [self.view setBackgroundColor:color_bodyededed];
  //  [self loadNavBarView];
    [self setTitle:@"我的服务券订单"];
   // [self loadNavBarView:@"我的服务券订单"];
    if ([self.receivedParams objectForKey:@"param_ordertype"]) {
        self.iOrderType = [self.receivedParams objectForKey:@"param_ordertype"];
    }
    else
    { self.iOrderType = @"1"; }
    
    
    [self.view addSubview: [self loadView_TopOrderStatus]];
    
    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0,heightForHead+kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight- kNavBarViewHeight-heightForHead) style:UITableViewStylePlain];
    [rootTableView setTag:2000];
    rootTableView.backgroundColor = [UIColor clearColor];
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:rootTableView];
    
    //-- 数据请求
    [self goApiRequest_GetOrders:@""];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(onPaySuccessRefreshData) name: @"payok" object: nil];
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


//  -- 当从支付页 支付成功 返回时要刷新下数据
- (void) onPaySuccessRefreshData{
    [arrOrderList removeAllObjects];
    [self goApiRequest_GetOrders:@""];
}

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
    
    NSArray * arrTxtStatus = [buttonTitles componentsSeparatedByString:@"|"];
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
        [serviceStatusType addTarget:self action:@selector(onOrderStatusClick:)
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

#pragma  mark   -- 事件区
//  -- orderstatus.
- (void) onOrderStatusClick:(id) sender{
    UIButton * btnstatus = (UIButton*) sender;
    
    self.iOrderType = [NSString stringWithFormat:@"%d",btnstatus.tag-buttonFilterTag];
    [btnstatus setTitleColor: [UIColor convertHexToRGB:@"FC4A00"] forState:UIControlStateNormal];
    [currentStatus setTitleColor: [UIColor convertHexToRGB:@"3c3c3c"] forState:UIControlStateNormal];
    
    if ([self.iOrderType isEqualToString:@"1"]) { [MobClick event:@"myServiceOrder_allOrder"]; }
    if ([self.iOrderType isEqualToString:@"2"]) { [MobClick event:@"myServiceOrder_payingOrder"]; }
    if ([self.iOrderType isEqualToString:@"3"]) { [MobClick event:@"myServiceOrder_payedOrder"]; }
    if ([self.iOrderType isEqualToString:@"4"]) { [MobClick event:@"myServiceOrder_refundingOrder"]; }
    if ([self.iOrderType isEqualToString:@"5"]) { [MobClick event:@"myServiceOrder_refundedOrder"]; }
    
    if (btnstatus!=currentStatus) {
        [arrOrderList removeAllObjects];
        [self goApiRequest_GetOrders:@"正在加载"];
    }
    
    //  ....
    currentStatus = btnstatus;
}

//  --  取消订单
- (void) onCancleOrderClick:(id) sender{

    UIButton * btntmp = (UIButton*) sender;
    
    UITableViewCell * cell = CELL_SUBVIEW_TABLEVIEW(btntmp,rootTableView);;
//    if (IOS7_OR_LATER) {
//        cell = (UITableViewCell*)[[[btntmp superview] superview] superview];
//    }
//    else{
//        cell = (UITableViewCell*)[[btntmp superview] superview];
//    }
    NSIndexPath * indexpath = [rootTableView indexPathForCell:cell];
    resMod_MyOrderInfo * orderinfo = arrOrderList[indexpath.row];
    iCancleOrderID = orderinfo.OrderId;
    
    EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"提示"
                                                                          message:@"确定取消该订单吗？"
                                                                cancelButtonTitle:@"否"
                                                                    okButtonTitle:@"是"];
    [alertView setTag:7658];
    alertView.delegate1 = self;
    [alertView show];
}


//  ------      弹框确认
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 7658) {
        if(buttonIndex == 1) {
            [self goApiRequest_CancleOrderO2O];
        }
        iCancleOrderID  = -1000;
    }
}


//  --  查看凭证
//- (void)onOrderDetailClick:(UITableViewCell *) selCell{
//    TableCell_UserCenter * cell = (TableCell_UserCenter*) selCell;
//    NSIndexPath * indexPath = [rootTableView indexPathForCell:cell];
//    NSString * sOrderTicketId = [arrOrderList[indexPath.row] OrderTicketId];
//    
//    resMod_MyOrderInfo * orderinfo = arrOrderList[indexPath.row];
//
//    //  -- 去付款
//    if (orderinfo.OrderStatus == 2) {
//        NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
//        [pms setValue:orderinfo forKeyPath:@"param_orderinfo"];
//        [pms setValue:@"1" forKeyPath:@"param_isFromUserCenter"];
//        [self pushNewViewController:@"OrderPayViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
//    }
//    //  -- 查看详情 ：凭证
//    if (orderinfo.OrderStatus == 3) {
//        if (sOrderTicketId.length>0) {
//            [self pushNewViewController:@"ServiceCouponDetailViewController" isNibPage:NO
//                             hideTabBar:YES
//                            setDelegate:NO
//                          setPushParams:[[NSMutableDictionary alloc]initWithObjectsAndKeys:sOrderTicketId,@"param_myTickID", nil]];
//        }
//    }
//}

#pragma mark    --  api 请求 加调

-(void) goApiRequest_GetOrders:(NSString*) _hudmsg{
    int starIndex = b_isPullRefresh ? 0:arrOrderList.count;
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:self.iOrderType forKey:@"OrderType"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", starIndex] forKey:@"StartIndex"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", requestPageNum] forKey:@"Number"];
    
    
//    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_MyOrderList class:@"resMod_CallBack_MyOrderList"
//              params:dicParams isShowLoadingAnimal:YES hudShow:_hudmsg];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMyOrderList:dicParams ModelClass:@"resMod_CallBack_MyOrderList" showLoadingAnimal:YES hudContent:_hudmsg delegate:self];
    
}

-(void) goApiRequest_CancleOrderO2O{
    if (iCancleOrderID>0) {
        NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
        [dicParams setValue:[NSString stringWithFormat:@"%d",iCancleOrderID] forKey:@"OrderId"];
        
        
//        CancelOrder
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_CancelOrderO2O class:@"ResponseBase"
//                  params:dicParams isShowLoadingAnimal:NO hudShow:@"正在取消"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestLifeCancelOrderO2O:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在取消" delegate:self];
    }
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];

    if ([ApiName isEqualToString:kApiMethod_MyOrderList]) {
        resMod_CallBack_MyOrderList * backObj = [[resMod_CallBack_MyOrderList alloc] initWithDic:retObj];
        int callNum = backObj.ResponseData.count;
        if (b_isPullRefresh) {
            b_isPullRefresh = NO;
            [arrOrderList removeAllObjects];
        }
        [arrOrderList addObjectsFromArray: backObj.ResponseData];
        
        [self.noDataView setHidden:arrOrderList.count==0 ? NO :YES];
        [rootTableView reloadData: callNum>=requestPageNum ? NO : YES allDataCount:arrOrderList.count];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
    if ([ApiName isEqualToString:kApiMethod_CancelOrderO2O]) {
        
        [self HUDShow:@"取消成功" delay:2];
        
        //  -- 取消订单成功, 刷新下
        b_isPullRefresh = YES;
        NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
        [dicParams setValue:self.iOrderType forKey:@"OrderType"];
        [dicParams setValue:@"0" forKey:@"StartIndex"];
        [dicParams setValue:[NSString stringWithFormat:@"%d", arrOrderList.count] forKey:@"Number"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMyOrderList:dicParams ModelClass:@"resMod_CallBack_MyOrderList" showLoadingAnimal:YES hudContent:@"正在加载" delegate:self];
        
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_MyOrderList class:@"resMod_CallBack_MyOrderList"
//                  params:dicParams isShowLoadingAnimal:YES hudShow:@"正在加载"];
    }
}

-(void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_MyOrderList]) {
        b_isPullRefresh = NO;
    }
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int iRowCount = arrOrderList.count;
    return iRowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightForCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString * Identifier = @"serviceOrderCell";
    
    TableCell_UserCenter * cell = (TableCell_UserCenter*)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if ( !cell ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_UserCenter" owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[TableCell_UserCenter class]]) {
                cell = (TableCell_UserCenter *)oneObject;
                [cell setUserCenterDelegate:self];
                
                [UICommon Common_line:CGRectMake(8, heightForCell-1, __MainScreen_Width-8, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
                
                //  --  取消订单
                UIButton * btn_CancleOrder = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn_CancleOrder setTag:238723];
                [btn_CancleOrder setFrame:CGRectMake(__MainScreen_Width-113, heightForCell-39, 60, 35)];
                [btn_CancleOrder setBackgroundColor:[UIColor clearColor]];
                [btn_CancleOrder setTitle:@"取消订单" forState:UIControlStateNormal];
                [btn_CancleOrder setTitleColor:color_989898 forState:UIControlStateNormal];
                [btn_CancleOrder.titleLabel setFont:defFont12];
                [btn_CancleOrder addTarget:self action:@selector(onCancleOrderClick:)forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn_CancleOrder];
                
                UILabel * lbl_spaceline = [[UILabel alloc] initWithFrame:CGRectMake(__MainScreen_Width-60, 40, 0.5, 15)];
                [lbl_spaceline setHidden:YES];
                [lbl_spaceline setTag:683723];
                [lbl_spaceline setBackgroundColor:color_d1d1d1];
                [cell.contentView addSubview:lbl_spaceline];
            }
        }
    }
    
    int irow = indexPath.row;
    if(arrOrderList.count>0){
        resMod_MyOrderInfo * orderinfo = arrOrderList[irow];
        NSString * proimgUrl = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:orderinfo.OrderImg];
        [cell.ProductImg sd_setImageWithURL:[NSURL URLWithString:proimgUrl]
                           placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
        [cell.lbl_ProductTitle setText:orderinfo.OrderTitle];
        [cell setTitleFrame:orderinfo.OrderTitle];
        [cell.lbl_Price setText:[self convertPrice:orderinfo.OrderPrice]];
        [cell.lbl_Status setText: orderinfo.OrderStatusText];
        [cell.lbl_Status setHidden:NO];
        
        UIButton * btn_238723 = (UIButton*)[cell.contentView viewWithTag:238723];
        [btn_238723 setHidden:YES];
        UILabel * lbl_683723 = (UILabel*)[cell.contentView viewWithTag:683723];
        NSString * sgodetail = @"";
        //待付款
        if (orderinfo.OrderStatus == 2) {
            sgodetail = @"去付款";
            [cell.lbl_godetail setHidden: NO];
            
            [cell.lbl_Status setHidden:YES];
            [btn_238723 setHidden:NO];
        }
        //已付款
        else if(orderinfo.OrderStatus ==3){
            sgodetail = @"查看凭证";
            [cell.lbl_godetail setHidden: NO];
        }
        else{
            [cell.lbl_godetail setHidden: YES];
        }
        
        CGSize godetailSize = [sgodetail sizeWithFont:defFont13 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
        
        [cell.lbl_Status setTextAlignment:NSTextAlignmentRight];
        [cell.lbl_godetail setTextAlignment:NSTextAlignmentRight];
        
        float xpoint = __MainScreen_Width-10-(godetailSize.width>0?godetailSize.width+10:0)-50;
        [cell.lbl_Status setFrame:CGRectMake(xpoint-20,cell.lbl_Status.frame.origin.y, 70,20)];
        [cell.lbl_godetail setFrame:CGRectMake(__MainScreen_Width-10-godetailSize.width, cell.lbl_Status.frame.origin.y, godetailSize.width, 20)];
        [cell.lbl_godetail setText:sgodetail];
        
        [lbl_683723 setHidden:cell.lbl_godetail.hidden];
        [lbl_683723 setFrame:CGRectMake(cell.lbl_godetail.frame.origin.x-5, cell.lbl_Status.frame.origin.y+3, 1, 14)];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    resMod_MyOrderInfo * orderinfo = arrOrderList[indexPath.row];
    
    //  -- 去付款
    if (orderinfo.OrderStatus == 2) {
        [MobClick event:@"myServiceOrder_payingOrder_pay"];
        
        NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
        [pms setValue:orderinfo forKeyPath:@"param_orderinfo"];
        [pms setValue:@"1" forKeyPath:@"param_isFromUserCenter"];
        [pms setObject:orderinfo.IsUseBalance?@"100":@"0" forKey:@"param_isUsedBalance"];
        [pms setObject:[NSString stringWithFormat:@"%.2f",orderinfo.BalanceUsed] forKey:@"param_BalanceUsed"];
        [pms setObject:orderinfo.IsUsedCoupon?@"100":@"0" forKey:@"param_isUsedCoupon"];
        [pms setObject:[NSString stringWithFormat:@"%.2f",orderinfo.CouponPrice] forKey:@"param_CouponPrice"];
        [pms setObject:orderinfo.CouponCode forKey:@"param_CouponCode"];
        [self pushNewViewController:@"OrderPaymentController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
    }
    //  -- 已取消 跳 服务券详情
    else if(orderinfo.OrderStatus ==4 || orderinfo.OrderStatus ==5){
        
        NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys
                                        :[NSString stringWithFormat:@"%d",orderinfo.TicketId],@"param_TicketId", nil];
        [self pushNewViewController:@"ServiceDetailViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:params];
    }
    //  -- 查看详情 ：凭证
    else{
        [MobClick event:@"myServiceOrder_payedOrder_checkVoucher"];
        //  -- 已付款订单   如果购买数量大于1去list页
        if(orderinfo.OrderStatus == 3 && orderinfo.TicketNumber>1){
            [self pushNewViewController:@"TicketsInOrderController" isNibPage:NO hideTabBar:YES setDelegate:NO
                          setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",orderinfo.OrderId],@"param_orderid", nil]];
            return;
        }
        
        if (orderinfo.OrderTicketId.length>0) {
            [self pushNewViewController:@"ServiceCouponDetailViewController" isNibPage:NO
                             hideTabBar:YES
                            setDelegate:NO
                          setPushParams:[[NSMutableDictionary alloc]initWithObjectsAndKeys:orderinfo.OrderTicketId,@"param_myTickID", nil]];
        }
    }
}

#pragma mark    --  scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [rootTableView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [rootTableView tableViewDidDragging];
    if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
        b_isPullRefresh = YES;
        [rootTableView tableViewIsRefreshing];
        [self goApiRequest_GetOrders:@""];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger returnKey = [rootTableView tableViewDidEndDragging];
    if (returnKey == k_RETURN_LOADMORE){    // 上拉加载更多
        [self goApiRequest_GetOrders:@""];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
