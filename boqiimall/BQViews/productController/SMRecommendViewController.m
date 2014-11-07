//
//  SMRecommendViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "SMRecommendViewController.h"
#import "resMod_TicketInfo.h"
#import "TableCell_Common.h"

#define heightForCell   100

@implementation SMRecommendViewController
@synthesize apiUrl_ticket;
@synthesize apiUrl_merchant;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        m_ServiceList = [[NSMutableArray alloc] initWithCapacity:0];
        m_MerchantList = [[NSMutableArray alloc] initWithCapacity:0];
        self.apiUrl_ticket = @"";
        self.apiUrl_merchant = @"";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Hidden:self.tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"活动推荐"];
    [self.view setBackgroundColor:color_bodyededed];
    
    self.apiUrl_ticket = [self.receivedParams objectForKey:@"param_URLTicket"];
    self.apiUrl_merchant = [self.receivedParams objectForKey:@"param_URLMerchant"];
    
    if (self.apiUrl_ticket.length>0) {
//        [self ApiRequestWithURL:self.apiUrl_ticket class:@"resMod_CallBack_TicketList" hudShow:@"正在加载"];
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestWithURL:self.apiUrl_ticket ModelClass:@"resMod_CallBack_TicketList" hudContent:@"正在加载" delegate:self];
    }
    if (self.apiUrl_merchant.length>0) {
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestWithURL:self.apiUrl_merchant ModelClass:@"resMod_CallBack_MerchantList" hudContent:@"正在加载" delegate:self];

//        [self ApiRequestWithURL:self.apiUrl_merchant class:@"resMod_CallBack_MerchantList" hudShow:@"正在加载"];
    }
    
    //  --无数据

    
    [self loadNoData];
    
    rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    [rootTableView setBackgroundColor:[UIColor clearColor]];
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [rootTableView setShowsVerticalScrollIndicator: NO];
    [self.view addSubview:rootTableView];
}

//
//- (void)loadNavBarView
//{
//    
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = @"活动推荐";
//    [bgView addSubview:titleLabel];
//    [self.navBarView addSubview:bgView];
//}



- (void) loadNoData{
    view_NoData = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight-kNavBarViewHeight)];
    [view_NoData setBackgroundColor:[UIColor whiteColor]];
    [view_NoData setHidden:YES];
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:
                     CGRectMake(__MainScreen_Width/2-20, 20, 40, 40)];
    indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    indicatorView.hidesWhenStopped = YES;
    [view_NoData addSubview:indicatorView];
    [indicatorView startAnimating];
    
    lbl_NoData = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, __MainScreen_Width, 20)];
    [lbl_NoData setTextAlignment:NSTextAlignmentCenter];
    [lbl_NoData setText: @"努力加载中..."];//--@"抱歉，暂无您想要相关服务产品"
    [lbl_NoData setFont:[UIFont systemFontOfSize:12]];
    [lbl_NoData setTextColor:[UIColor convertHexToRGB:@"999999"]];
    [view_NoData addSubview:lbl_NoData];
    [self.view addSubview:view_NoData];
}

//  -- 加载与完成时显示
- (void) setNoDataMessageIsShow:(BOOL) isShow{
    if (isShow) {
        [indicatorView startAnimating];
        [lbl_NoData setText:@"努力加载中..."];
    }
    else{
        [indicatorView stopAnimating];
        [lbl_NoData setText:@"抱歉，暂无您想要相关服务或产品"];
    }
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    
    if([ApiName isEqualToString:self.apiUrl_ticket]){
        resMod_CallBack_TicketList * backObj = [[resMod_CallBack_TicketList alloc] initWithDic:retObj];
        [m_ServiceList addObjectsFromArray:backObj.ResponseData];
        
        [self.lodingAnimationView stopLoadingAnimal];
        [self setNoDataMessageIsShow: m_ServiceList.count==0 ? NO :YES];
    }
    
    else if([ApiName isEqualToString:self.apiUrl_merchant]){
        resMod_CallBack_MerchantList * backObj = [[resMod_CallBack_MerchantList alloc] initWithDic:retObj];
        [m_MerchantList addObjectsFromArray: backObj.ResponseData];
        
        [self.lodingAnimationView stopLoadingAnimal];
        [self setNoDataMessageIsShow: m_MerchantList.count==0 ? NO :YES];
    }
    
    [rootTableView reloadData];
}

-(void) interfaceExcuteError:(NSError*)error apiName:(NSString*)ApiName{
    
    [super interfaceExcuteError:error apiName:ApiName];
    
    [self.lodingAnimationView stopLoadingAnimal];
    [self setNoDataMessageIsShow:NO];
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger irownum=0;
    if (self.apiUrl_ticket.length>0) {
        irownum = m_ServiceList.count;
        [view_NoData setHidden: irownum==0 ? NO : YES];
    }
    else if(self.apiUrl_merchant.length>0){
        irownum = m_MerchantList.count;
        [view_NoData setHidden: irownum==0 ? NO : YES];
    }
    
    return irownum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightForCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * lbl_HeadView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 2)];
    [lbl_HeadView setBackgroundColor:color_body];
    return lbl_HeadView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * Identifier1 = @"ServiceCell";
    NSString * Identifier2 = @"MerchantCell";
    
    int irow = indexPath.row;
    if (self.apiUrl_ticket.length>0) {
        TableCell_Common1 * cell = (TableCell_Common1*)[tableView dequeueReusableCellWithIdentifier:Identifier1];
        if ( !cell ) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_Common" owner:self options:nil];
            for(id oneObject in nib) {
                if([oneObject isKindOfClass:[TableCell_Common1 class]]) {
                    cell = (TableCell_Common1 *)oneObject;
                    
                    [UICommon Common_line:CGRectMake(0,heightForCell-2, __MainScreen_Width,0.5) targetView:cell.contentView backColor:color_d1d1d1];
                    
                    [cell.lbl_awayFrom setHidden:YES];
                    [cell.lbl_roadName setHidden:YES];
                }
            }
        }
        if (m_ServiceList.count>0) {
            resMod_TicketInfo * tmpTicketinfo= m_ServiceList[irow];
            
            [cell.lbl_title setText:tmpTicketinfo.TicketTitle];
            [cell setTitleFrame:tmpTicketinfo.TicketTitle];
            
            NSString * proimgUrl = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:tmpTicketinfo.TicketImg];
            [cell.ProductImg sd_setImageWithURL:[NSURL URLWithString:proimgUrl]
                               placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
            [cell.lbl_salePrice setText:[self convertPrice:tmpTicketinfo.TicketPrice]];
            [cell.lbl_marketPrice setText:[self convertPrice:tmpTicketinfo.TicketOriPrice]];
            
            CGSize tSize = [[self convertPrice:tmpTicketinfo.TicketOriPrice] sizeWithFont:defFont12 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            [cell.lbl_delLine setFrame:CGRectMake(cell.lbl_marketPrice.frame.origin.x-1, cell.lbl_marketPrice.frame.origin.y+10, tSize.width+3, 1)];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(self.apiUrl_merchant.length>0){
        TableCell_Common2 * cell = (TableCell_Common2*)[tableView dequeueReusableCellWithIdentifier:Identifier2];
        if ( !cell ) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_Common" owner:self options:nil];
            for(id oneObject in nib) {
                if([oneObject isKindOfClass:[TableCell_Common2 class]]) {
                    cell = (TableCell_Common2 *)oneObject;
                    
                    [UICommon Common_line:CGRectMake(0,heightForCell-2, __MainScreen_Width,0.5) targetView:cell.contentView backColor:color_d1d1d1];
                    
                    [cell.lbl_awayFrom setHidden:YES];
                    [cell.lbl_roadName setHidden:YES];
                }
            }
        }
        if (m_MerchantList.count>0) {
            resMod_MerchantInfo * tmpMerchantinfo = m_MerchantList[irow];
            
            NSString * proimgUrl = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:tmpMerchantinfo.MerchantImg];
            [cell.ProductImg sd_setImageWithURL:[NSURL URLWithString:proimgUrl]
                               placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
            
            [cell.lbl_title     setText:tmpMerchantinfo.MerchantTitle];
            [cell.lbl_viewTimes setText:[NSString stringWithFormat:@"浏览%d次",tmpMerchantinfo.ScanNumbers]];
            [cell.lbl_perPrice  setText:[self convertPrice:tmpMerchantinfo.AverageComsume]];
            [cell setIconFrame_QuanYi:tmpMerchantinfo.MerchantTitle Characteristic:tmpMerchantinfo.Characteristic];
        }
        [cell setBackgroundColor:[UIColor clearColor]];        
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int iRow = indexPath.row;
    if (self.apiUrl_ticket.length>0) {
        
        resMod_TicketInfo * tmpTicketinfo= m_ServiceList[iRow];
        NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys
                                        :[NSString stringWithFormat:@"%d",tmpTicketinfo.TicketId],@"param_TicketId", nil];
        [self pushNewViewController:@"ServiceDetailViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:params];
    }
    else if(self.apiUrl_merchant.length>0){
        resMod_MerchantInfo * tmpMerchantinfo= m_MerchantList[iRow];
        NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithObjectsAndKeys
                                        :[NSString stringWithFormat:@"%d",tmpMerchantinfo.MerchantId],@"param_MerchantId", nil];
        [self pushNewViewController:@"MerchantDetailViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:params];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
