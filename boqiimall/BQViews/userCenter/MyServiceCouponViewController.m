//
//  MyServiceCouponViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-15.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MyServiceCouponViewController.h"

#define requestPageNum 10
#define heightForHead 40
#define heightForCell 96
#define buttonFilterTag 9778
#define buttonTitles  @"未使用:1|已使用:2|已过期:3"

@implementation MyServiceCouponViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        ticketStatus = @"1";
        arrMyTicketList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [MobClick event:@"myBoqii_myGoodsOrder_myBoughtservice"];
    //[self loadNavBarView];
    [self setTitle:@"我购买的服务券"];
    [self.view setBackgroundColor:[UIColor whiteColor]];

   // [self loadNavBarView:@"我购买的服务券"];
    
    [self.view addSubview:[self loadView_TopTicketstatus]];

    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0,heightForHead+kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight - kNavBarViewHeight-heightForHead) style:UITableViewStylePlain];
    [rootTableView setTag:2000];
    rootTableView.backgroundColor = color_bodyededed;
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:rootTableView];
    [self.view sendSubviewToBack:rootTableView];
    
    [self goApiRequest:@""];
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

//  -- 上面的服务券状态
- (UIView *) loadView_TopTicketstatus{
    UIView * HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, heightForHead)];
    [HeadView setBackgroundColor:[UIColor clearColor]];
    
    UIView * ShadowBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, __MainScreen_Width, heightForHead-1)];
    [ShadowBg setBackgroundColor:[UIColor whiteColor]];
    ShadowBg.layer.shadowColor = [UIColor blackColor].CGColor;
    ShadowBg.layer.shadowOffset = CGSizeMake(0, 0.5);
    ShadowBg.layer.shadowOpacity = 0.3;
    ShadowBg.layer.shadowRadius = 0.8;
    [HeadView addSubview:ShadowBg];

    NSArray * arrTxtStatus = [buttonTitles componentsSeparatedByString:@"|"];
    float fWidth = (__MainScreen_Width-10)/arrTxtStatus.count;
    int i=0;
    for (NSString * titleProper in arrTxtStatus) {
        NSArray * stxt = [titleProper componentsSeparatedByString:@":"];
        int xpoint = 7+i*fWidth;

        UIButton * serviceStatusType = [UIButton buttonWithType:UIButtonTypeCustom];
        [serviceStatusType setTag: buttonFilterTag+[stxt[1] intValue]];
        [serviceStatusType setFrame: CGRectMake(xpoint, 0, fWidth-4, heightForHead)];
        [serviceStatusType setTitle: stxt[0] forState:UIControlStateNormal];
        [serviceStatusType.titleLabel setFont:defFont14];
        [serviceStatusType setTitleColor: [UIColor convertHexToRGB:i==0 ? @"FC4A00" : @"3c3c3c"]
                                forState: UIControlStateNormal];
//        [serviceStatusType setBackgroundImage: def_ImgStretchable( i==0 ? @"tab_1_press":@"tab_1_nomal", 10, 10)
//                                     forState: UIControlStateNormal];
        [serviceStatusType addTarget:self action:@selector(onCouponStatusClick:)
                    forControlEvents:UIControlEventTouchUpInside];
        [HeadView addSubview:serviceStatusType];

        if (i+1!=arrTxtStatus.count) {
            [UICommon Common_line:CGRectMake(fWidth-0.5, heightForHead/2-7, 0.5, 15)
                       targetView:serviceStatusType backColor: color_d1d1d1];
        }
        
        if (i==0) {
            currentStatus = serviceStatusType;
        }
        ++i;
    }
    
    return HeadView;
}

#pragma  mark   --  事件区
//  --
- (void) onCouponStatusClick:(id) sender{
    UIButton * btnstatus = (UIButton*) sender;
    
    [btnstatus setTitleColor: [UIColor convertHexToRGB:@"FC4A00"] forState:UIControlStateNormal];
    [currentStatus setTitleColor: [UIColor convertHexToRGB:@"3c3c3c"] forState:UIControlStateNormal];
    
    if (btnstatus!=currentStatus) {
        ticketStatus = [NSString stringWithFormat:@"%d",btnstatus.tag-buttonFilterTag];
        [arrMyTicketList removeAllObjects];
        [self goApiRequest:@"正在加载"];
    }
    
    if ([ticketStatus isEqualToString:@"1"]) { [MobClick event:@"userCenter_mySrv_notUsed"]; }
    if ([ticketStatus isEqualToString:@"2"]) { [MobClick event:@"userCenter_mySrv_used"]; }
    if ([ticketStatus isEqualToString:@"3"]) { [MobClick event:@"userCenter_mySrv_overdue"]; }
    
    currentStatus = btnstatus;
}


////  --  查看凭证
//- (void)onOrderDetailClick:(UITableViewCell *) selCell{
//    TableCell_UserCenter * cell = (TableCell_UserCenter*) selCell;
//    NSIndexPath * indexPath = [rootTableView indexPathForCell:cell];
//    NSString * sOrderTicketId = [NSString stringWithFormat:@"%d",[arrMyTicketList[indexPath.row] MyTicketId]];
//    
//    if (sOrderTicketId.length>0) {
//        [self pushNewViewController:@"ServiceCouponDetailViewController" isNibPage:NO
//                         hideTabBar:YES
//                        setDelegate:NO
//                      setPushParams:[[NSMutableDictionary alloc]initWithObjectsAndKeys:sOrderTicketId,@"param_myTickID", nil]];
//    }
//}


#pragma mark    --  api 请求 加调

-(void) goApiRequest:(NSString*) _hudmsg{
    int startIndex = b_isPullRefresh?0:arrMyTicketList.count;
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:ticketStatus forKey:@"OrderType"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", startIndex] forKey:@"StartIndex"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", requestPageNum] forKey:@"Number"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMyTicketList:dicParams ModelClass:@"resMod_CallBack_MyTicketList" showLoadingAnimal:YES hudContent:_hudmsg delegate:self];
    
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_MyTicketList class:@"resMod_CallBack_MyTicketList"
//              params:dicParams isShowLoadingAnimal:YES hudShow:_hudmsg];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];

    if ([ApiName isEqualToString:kApiMethod_MyTicketList]) {
        resMod_CallBack_MyTicketList * backObj = [[resMod_CallBack_MyTicketList alloc] initWithDic:retObj];
        int callNum = backObj.ResponseData.count;
        if (b_isPullRefresh) {
            b_isPullRefresh = NO;
            [arrMyTicketList removeAllObjects];
        }
        [arrMyTicketList addObjectsFromArray: backObj.ResponseData];
        
        [self.noDataView setHidden:arrMyTicketList.count==0 ? NO :YES];
        [rootTableView reloadData: callNum==10 ? NO:YES allDataCount:arrMyTicketList.count];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
}

-(void) interfaceExcuteError:(NSError*)error apiName:(NSString*)ApiName{
    
    [rootTableView reloadData: arrMyTicketList.count==0 ? NO : YES allDataCount:arrMyTicketList.count];

    [super interfaceExcuteError:error apiName:ApiName];
    b_isPullRefresh = NO;
}


#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int iRowCount = arrMyTicketList.count;
    return iRowCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightForCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString * Identifier = @"serviceCouponOrderCell";

    TableCell_UserCenter * cell = (TableCell_UserCenter*)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if ( !cell ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_UserCenter" owner:self options:nil];
        for(id oneObject in nib) {
            if([oneObject isKindOfClass:[TableCell_UserCenter class]]) {
                cell = (TableCell_UserCenter *)oneObject;
                cell.userCenterDelegate = self;
                
                cell.backgroundColor = color_bodyededed;
                cell.opaque = YES;
                
                [cell.lbl_godetail setTextColor:color_989898];
                [cell.lbl_Status setHidden:YES];
                
                [UICommon Common_line:CGRectMake(8, heightForCell-1, __MainScreen_Width-8, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
            }
        }
    }
    
    int irow = indexPath.row;
    if (arrMyTicketList.count>0) {
        resMod_MyTicketInfo * tickinfo = arrMyTicketList[irow];
        
        NSString * proimgUrl = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:tickinfo.MyTicketImg];
        [cell.ProductImg sd_setImageWithURL:[NSURL URLWithString:proimgUrl]
                           placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
        [cell.lbl_ProductTitle setText:tickinfo.MyTicketTitle];
        [cell.lbl_Price setText:[self convertPrice:tickinfo.MyTicketPrice]];

        [cell.lbl_godetail setText:[ticketStatus intValue]==1?@"未使用" : ([ticketStatus intValue]==2 ? @"已使用":@"已过期")];
    }

    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int ir = indexPath.row;
    NSString * sTickid = [NSString stringWithFormat:@"%d",[arrMyTicketList[ir] MyTicketId]];
    NSString * ticketPrice = [NSString stringWithFormat:@"%f",[arrMyTicketList[ir] MyTicketPrice]];
    NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
    [paraDict setObject:sTickid forKey:@"param_myTickID"];
    [paraDict setObject:ticketStatus forKey:@"ticketStatus"];
    [paraDict setObject:ticketPrice forKey:@"ticket_price"];
    [self pushNewViewController:@"ServiceCouponDetailViewController" isNibPage:NO
                     hideTabBar:YES
                    setDelegate:NO
                  setPushParams:paraDict];
}

// ....
#pragma mark    --  scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [rootTableView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [rootTableView tableViewDidDragging];
    if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
        b_isPullRefresh = YES;
        [rootTableView tableViewIsRefreshing];
        [self goApiRequest:@""];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger returnKey = [rootTableView tableViewDidEndDragging];
    if (returnKey == k_RETURN_LOADMORE){    // 上拉加载更多
        [self goApiRequest:@""];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
