//
//  TicketsInOrderController.m
//  BoqiiLife
//
//  Created by YSW on 14-6-9.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "TicketsInOrderController.h"

#define heightForCell   96
#define requestPageNum  8

@implementation TicketsInOrderController
@synthesize sOrderId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        arrTickets = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"服务券列表"];
   // [self loadNavBarView:@"服务券列表"];
    self.sOrderId = [self.receivedParams objectForKey:@"param_orderid"];
    rootTableView = [[PullToRefreshTableView alloc] initWithFrame:CGRectMake(0,kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    rootTableView.isCloseHeader = YES;
    [rootTableView setTag:2000];
    rootTableView.backgroundColor = [UIColor clearColor];
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:rootTableView];
    
    [self goApiRequest];
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

#pragma mark    --  api 请求 加调

-(void) goApiRequest{
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:self.sOrderId forKey:@"OrderId"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", arrTickets.count] forKey:@"StartIndex"];
    [dicParams setValue:[NSString stringWithFormat:@"%d", requestPageNum] forKey:@"Number"];
    
//    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_MyTicketsInOrder class:@"resMod_CallBack_MyTicketList"
//              params:dicParams isShowLoadingAnimal:NO hudShow:@"正在加载"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMyTicketsInOrder:dicParams ModelClass:@"resMod_CallBack_MyTicketList" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    if ([ApiName isEqualToString:kApiMethod_MyTicketsInOrder]) {
        resMod_CallBack_MyTicketList * backObj = [[resMod_CallBack_MyTicketList alloc] initWithDic:retObj];
        int callNum = backObj.ResponseData.count;
        [arrTickets addObjectsFromArray: backObj.ResponseData];
        
        [self.noDataView setHidden:arrTickets.count==0 ? NO :YES];
        [rootTableView reloadData: callNum==10 ? NO : YES allDataCount:arrTickets.count];
    }
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int iRowCount = arrTickets.count;
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
            }
        }
    }
    
    int irow = indexPath.row;
    if(arrTickets.count>0){
        resMod_MyTicketInfo * orderinfo = arrTickets[irow];
        NSString * productImg = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:orderinfo.MyTicketImg];
        [cell.ProductImg sd_setImageWithURL:[NSURL URLWithString:productImg]
                           placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
        [cell.lbl_ProductTitle setText:orderinfo.MyTicketTitle];
        [cell setTitleFrame:orderinfo.MyTicketTitle];
        [cell.lbl_Price setText:[self convertPrice:orderinfo.MyTicketPrice]];
        [cell.lbl_Status setText: orderinfo.MyTicketStatus==1?@"未使用": (orderinfo.MyTicketStatus==2 ? @"已使用":@"已过期")];
    }
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    resMod_MyTicketInfo * orderinfo = arrTickets[indexPath.row];
    
    if (orderinfo.MyTicketId>0) {
        [self pushNewViewController:@"ServiceCouponDetailViewController" isNibPage:NO
                         hideTabBar:YES
                        setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",orderinfo.MyTicketId],@"param_myTickID", nil]];
    }
}

#pragma mark    --  scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [rootTableView tableViewDidDragging];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger returnKey = [rootTableView tableViewDidEndDragging];
    if (returnKey == k_RETURN_LOADMORE){    // 上拉加载更多
        [self goApiRequest];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
