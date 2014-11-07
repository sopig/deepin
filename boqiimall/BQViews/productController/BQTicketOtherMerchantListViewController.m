//
//  BQTicketOtherMerchantListViewController.m
//  boqiimall
//
//  Created by iXiaobo on 14-10-27.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQTicketOtherMerchantListViewController.h"
#import "BQTicketOtherMerchantListTableViewCell.h"
#import "resMod_MerchantInfo.h"

@interface BQTicketOtherMerchantListViewController ()

@end

@implementation BQTicketOtherMerchantListViewController
@synthesize ticketId = _ticketId;


- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadNavBarView];
    [self setTitle:@"商户列表"];
    _merchantList = [[NSMutableArray alloc] init];
    NSString *param_TicketId = [self.receivedParams objectForKey:@"param_TicketId"];
    self.ticketId = param_TicketId.integerValue;
   // [self loadNavBarView:@"商户列表"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:color_bodyededed];
    //[_tableView setScrollEnabled:NO];
    [self.view addSubview:_tableView];
    [self goApiRequest_GetTicketOtherMerchantList];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    UIButton *btn_navMap = [[UIButton alloc] initWithFrame:CGRectMake(275, 2, 40, 40)];
    [btn_navMap setBackgroundColor:[UIColor clearColor]];
    [btn_navMap setImage:[UIImage imageNamed:@"nearby_btn.png"] forState:UIControlStateNormal];
    [btn_navMap addTarget:self action:@selector(onNearMapClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:btn_navMap];
}



- (void)onNearMapClick:(id)sender
{
    if (_merchantList.count != 0)
    {
        [self pushNewViewController:@"NearMapViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                     _merchantList,@"param_merchants",
                                     @"0",@"param_fromMerchant",nil]];
    }
    
    
}

#pragma -mark APIMethodHandle

- (void)goApiRequest_GetTicketOtherMerchantList
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%d",_ticketId] forKey:@"TicketId"];
    [params setObject:[NSString stringWithFormat:@"%3.10f",_lat] forKey:@"Lat"];
    [params setObject:[NSString stringWithFormat:@"%3.10f",_lon] forKey:@"Lng"];
    [[APIMethodHandle shareAPIMethodHandle] goApiRequestGetTicketOtherMerchantList:params ModelClass:@"resMod_CallBack_MerchantList" showLoadingAnimal:YES hudContent:@"" delegate:self];
   
}

#pragma -mark APIMethodHandle Delegate

- (void)interfaceExcuteSuccess:(id)retObj apiName:(NSString *)ApiName
{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    [self.lodingAnimationView stopLoadingAnimal];
    if ([ApiName isEqualToString:kApiMethod_GetTicketOtherMerchantList])
    {
        resMod_CallBack_MerchantList * backObj = [[resMod_CallBack_MerchantList alloc] initWithDic:retObj];
        [_merchantList removeAllObjects];
        [_merchantList addObjectsFromArray: backObj.ResponseData];
        [_tableView reloadData];
    }
}

- (void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName
{
    [super interfaceExcuteError:error apiName:ApiName];
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma  -mark UITableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _merchantList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"";
    BQTicketOtherMerchantListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    resMod_MerchantInfo *merchantInfo = [_merchantList objectAtIndex:indexPath.row];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BQTicketOtherMerchantListTableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell._merchantNameLabel.text = merchantInfo.MerchantTitle;
    cell._merchantAddressLabel.text = merchantInfo.MerchantAddress;
    if (merchantInfo.Distance)
    {
        NSInteger distance = merchantInfo.Distance.integerValue;
        if ( distance > 1000)
        {
             cell._mechantDistanceLabel.text = [NSString stringWithFormat:@"%0.2fkm",distance/1000.0];
        }
        else
        {
             cell._mechantDistanceLabel.text = [NSString stringWithFormat:@"%dm",distance];
        }
    }
    else
    {
         cell._mechantDistanceLabel.text = [NSString stringWithFormat:@"0m"];
        
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.seperatorLine setFrame:CGRectMake(0, 63.5, __MainScreen_Width, 0.5)];
    cell.seperatorLine.backgroundColor = color_d1d1d1;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    resMod_MerchantInfo *merchantInfo = [_merchantList objectAtIndex:indexPath.row];
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithObjectsAndKeys :[NSString stringWithFormat:@"%d",merchantInfo.MerchantId],@"param_MerchantId", nil];
    [self pushNewViewController:@"MerchantDetailViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
}


@end
