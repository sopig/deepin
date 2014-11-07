//
//  MyAddressListController.m
//  boqiimall
//
//  Created by YSW on 14-6-30.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "MyAddressListController.h"

#define heightRow   123

@implementation MyAddressListController
@synthesize Delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        m_AddressList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)goBack:(id)sender{
    if (isFromSubmitOrder) {
        if ([self.Delegate respondsToSelector:@selector(OnDelegateSelectedAddress:)])   {
            
            BOOL isFound= NO;
            for (resMod_AddressInfo * addinfo in m_AddressList) {
                if (addinfo.AddressId == selAddressID) {
                    [self.Delegate OnDelegateSelectedAddress:addinfo];
                    isFound = YES;
                    break;
                }
            }
            if (!isFound)  {
                [self.Delegate OnDelegateSelectedAddress:nil];
            }
        }
    }
    [super goBack:sender];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Hidden:self.tabBarController];
    
    [self goApiRequest_addressList:@"正在获取地址信息"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self loadNavBarView];
    [self setTitle:@"收货人信息"];
    [self.view setBackgroundColor:color_bodyededed];
    
  //  [self loadNavBarView:@"收货人信息"];
    
    isFromSubmitOrder = [[self.receivedParams objectForKey:@"param_isFromSubmitOrder"] isEqualToString:@"1"] ? YES : NO;
    selAddressID = [[self.receivedParams objectForKey:@"param_AddressId"] intValue];

   // [self navRight_addNewAddress];
    
    rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
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

- (void)loadNavBarView
{
    [super loadNavBarView];
    UIButton * btn_addAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_addAddress setFrame:CGRectMake(265, 0, 40, 44)];
    [btn_addAddress setBackgroundColor:[UIColor clearColor]];
    [btn_addAddress setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btn_addAddress setImage:[UIImage imageNamed:@"new_btn.png"] forState:UIControlStateNormal];
    [btn_addAddress addTarget:self action:@selector(onButton_AddNewAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:btn_addAddress];
    
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
//    UIButton * btn_addAddress = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_addAddress setFrame:CGRectMake(265, 0, 40, 44)];
//    [btn_addAddress setBackgroundColor:[UIColor clearColor]];
//    [btn_addAddress setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//    [btn_addAddress setImage:[UIImage imageNamed:@"new_btn.png"] forState:UIControlStateNormal];
//    [btn_addAddress addTarget:self action:@selector(onButton_AddNewAddressClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:btn_addAddress];
//    
//    [self.navBarView addSubview:bgView];
//}


//  --添加新地址.
- (void) navRight_addNewAddress{
    UIButton * btn_addAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_addAddress setFrame:CGRectMake(0, 0, 40, 44)];
    [btn_addAddress setBackgroundColor:[UIColor clearColor]];
    [btn_addAddress setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btn_addAddress setImage:[UIImage imageNamed:@"new_btn.png"] forState:UIControlStateNormal];
    [btn_addAddress addTarget:self action:@selector(onButton_AddNewAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:btn_addAddress];
    self.navigationItem.rightBarButtonItem = r_bar;
    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
}

#pragma mark    --  event
- (void) onButton_AddNewAddressClick:(id)sender{
    [self pushNewViewController:@"EditAddressViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
}

- (void) onAddressOperateClick:(id) sender{
    UIButton * btntmp = (UIButton*) sender;
    UITableViewCell * cell = CELL_SUBVIEW_TABLEVIEW(btntmp,rootTableView);;

    NSIndexPath* indexPath = [rootTableView indexPathForCell:cell];
    resMod_AddressInfo * addressinfo = m_AddressList[indexPath.row];
    
    if (btntmp.tag==1113) { //  -- 设置 为默认
        if (addressinfo.IsDefault==0) {
//            [self ApiRequest:api_BOQIIMALL method:kApiMethod_AddressSetDetault class:@"ResponseBase"
//                      params:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[UserUnit userId],@"UserId",
//                              [NSString stringWithFormat:@"%d",addressinfo.AddressId],@"AddressId", nil]
//                      isShowLoadingAnimal:NO hudShow:@"正在设置"];
//            SetDefaultAddress
            
    
            [[APIMethodHandle shareAPIMethodHandle]goApiRequestSetDefaultAddress:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[UserUnit userId],@"UserId",
                                       [NSString stringWithFormat:@"%d",addressinfo.AddressId],@"AddressId", nil] ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在设置" delegate:self];
        }
    }
    if (btntmp.tag==1114) { //  -- 删除
        
        whileDelAddressCell = CELL_SUBVIEW_TABLEVIEW(btntmp,rootTableView);
        whileDelAddressID = addressinfo.AddressId;
        EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"提 示"
                                                                              message:@"确定删除该地址？"
                                                                    cancelButtonTitle:@"取消"
                                                                        okButtonTitle:@"删除"];
        alertView.delegate1 = self;
        alertView.tag = 8956;
        [alertView show];
    }
    if (btntmp.tag==1115) { //  -- 编缉
        selAddressID = addressinfo.AddressId;
        [self pushNewViewController:@"EditAddressViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc]initWithObjectsAndKeys:addressinfo,@"param_AddressInfo", nil]];
    }
}

//  --删 tablecell
- (void) delRow{
    
    if (whileDelAddressCell!=nil) {
        
        NSIndexPath * indexpath = [rootTableView indexPathForCell:whileDelAddressCell];
        [m_AddressList removeObjectAtIndex:indexpath.row];
        
        [rootTableView beginUpdates];
        [rootTableView deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexpath, nil] withRowAnimation:UITableViewRowAnimationTop];
        [rootTableView endUpdates];
        
        [self.noDataView noDataViewIsHidden:m_AddressList.count==0 ? NO:YES warnImg:@"" warnMsg:@"您还没有添加任何地址信息"];
    }
}


#pragma mark    --  api 请求 加调

-(void) goApiRequest_addressList:(NSString *) loadingMsg{

    [m_AddressList removeAllObjects];

//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_AddressList class:@"resMod_CallBack_AddressList"
//              params:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[UserUnit userId],@"UserId", nil]
//              isShowLoadingAnimal:NO hudShow:loadingMsg];
//    GetUserAddressList
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetUserAddressList:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[UserUnit userId],@"UserId", nil] ModelClass:@"resMod_CallBack_AddressList" showLoadingAnimal:NO hudContent:loadingMsg delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_AddressList]) {
        resMod_CallBack_AddressList * backObj = [[resMod_CallBack_AddressList alloc] initWithDic:retObj];
        
        [m_AddressList addObjectsFromArray:backObj.ResponseData];
        
        if (m_AddressList.count > 1)
        {
            resMod_AddressInfo *defaultAddressInfo = nil;
            for (NSInteger i=0 ; i < m_AddressList.count; i++)
            {
                resMod_AddressInfo *addressInfo = [m_AddressList objectAtIndex:i];
                if (addressInfo.IsDefault)
                {
                    defaultAddressInfo = addressInfo;
                    break;
                }
            }
            if (defaultAddressInfo)
            {
                [m_AddressList removeObject:defaultAddressInfo];
                [m_AddressList insertObject:defaultAddressInfo atIndex:0];
            }
        }
        
        [rootTableView reloadData];

        [self.noDataView noDataViewIsHidden:m_AddressList.count==0 ? NO :YES
                                    warnImg:@"" warnMsg:@"您还没有添加任何地址信息"];
    }
    if ([ApiName isEqualToString:kApiMethod_AddressSetDetault]) {
        [self HUDShow:@"默认设置成功" delay:2];
        [self goApiRequest_addressList:@""];
    }
    if ([ApiName isEqualToString:kApiMethod_AddressDel]) {
        [self delRow];
        [self HUDShow:@"删除成功" delay:2];
    }
    
    [self hudWasHidden:HUD];
}

-(void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];
    
    if ([ApiName isEqualToString:kApiMethod_AddressList]) {
        [self.noDataView noDataViewIsHidden:m_AddressList.count==0 ? NO :YES
                                    warnImg:@"" warnMsg:@"您还没有添加任何地址信息"];
    }
}



#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return m_AddressList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString * Identifier = @"addressCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
        [UICommon Common_UILabel_Add:CGRectMake(22, 18, def_WidthArea(22), 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1111
                                text:@"波奇   13956542612"
                               align:-1 isBold:NO fontSize:14 tColor:color_4e4e4e];
        
        [UICommon Common_UILabel_Add:CGRectMake(22, 40, def_WidthArea(22), 40)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1112
                                text:@"上海试 感受大自然带来的 感动就像蓝天对草原的问候 201314"
                               align:-1 isBold:NO fontSize:14 tColor:color_4e4e4e];
        
        
        [UICommon Common_line:CGRectMake(22, heightRow-40, def_WidthArea(22), 0.5) targetView:cell.contentView backColor:color_d1d1d1];
        
        UIButton * btnSetDetault = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnSetDetault setFrame:CGRectMake(24, heightRow-40, 80, 40)];
        [btnSetDetault setTag:1113];
        [btnSetDetault setBackgroundColor:[UIColor clearColor]];
        [btnSetDetault setTitle:@"设置为默认" forState:UIControlStateNormal];
        [btnSetDetault setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btnSetDetault setTitleColor:color_8fc31f forState:UIControlStateNormal];
        [btnSetDetault.titleLabel setFont:defFont15];
        [btnSetDetault addTarget:self action:@selector(onAddressOperateClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnSetDetault];
        
        UIButton * btnDel = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnDel setFrame:CGRectMake(__MainScreen_Width-110, heightRow-40, 50, 40)];
        [btnDel setTag:1114];
        [btnDel setBackgroundColor:[UIColor clearColor]];
        [btnDel setImage:[UIImage imageNamed:@"delete_icon.png"] forState:UIControlStateNormal];
        [btnDel setImage:[UIImage imageNamed:@"delete_icon_sel.png"] forState:UIControlStateHighlighted];
        [btnDel setTitle:@"" forState:UIControlStateNormal];
        [btnDel addTarget:self action:@selector(onAddressOperateClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnDel];
        
        UIButton * btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnEdit setFrame:CGRectMake(__MainScreen_Width-60, heightRow-40, 50, 40)];
        [btnEdit setTag:1115];
        [btnEdit setBackgroundColor:[UIColor clearColor]];
        [btnEdit setImage:[UIImage imageNamed:@"edit_icon_nor.png"] forState:UIControlStateNormal];
        [btnEdit setImage:[UIImage imageNamed:@"edit_icon_sel.png"] forState:UIControlStateHighlighted];
        [btnEdit setTitle:@"" forState:UIControlStateNormal];
        [btnEdit addTarget:self action:@selector(onAddressOperateClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnEdit];
    }
    
    if (m_AddressList.count>0) {
        
        resMod_AddressInfo * addressinfo = m_AddressList[indexPath.row];
        addressinfo.AddressArea = addressinfo.AddressArea!=nil ? addressinfo.AddressArea : @"";
        UIView * view_444 = [cell.contentView viewWithTag:444];
        UILabel * lbl_1111 = (UILabel*)[cell.contentView viewWithTag:1111];
        UILabel * lbl_1112 = (UILabel*)[cell.contentView viewWithTag:1112];
        UIButton * btn_1113 = (UIButton*)[cell.contentView viewWithTag:1113];
        
        [lbl_1111 setText:[NSString stringWithFormat:@"%@   %@",addressinfo.UserName,addressinfo.Mobile.length>0?addressinfo.Mobile:addressinfo.Phone]];
        [lbl_1112 setText:[NSString stringWithFormat:@"%@ %@ %@ %@   %@",addressinfo.AddressProvince,addressinfo.AddressCity,addressinfo.AddressArea,addressinfo.AddressDetail,addressinfo.ZipCode]];
        
        [btn_1113 setTitle: addressinfo.IsDefault==1?@"默认":@"设置为默认" forState:UIControlStateNormal];
        [btn_1113 setTitleColor: addressinfo.IsDefault==1?color_989898:color_8fc31f forState:UIControlStateNormal];
        
        //  --  添加虚线背影
        BOOL isSelted = selAddressID==addressinfo.AddressId;
        [view_444 removeFromSuperview];
        view_444 = [UICommon Common_DottedCornerRadiusView:CGRectMake(12, 10, 592/2, heightRow-10) targetView:cell.contentView tag:444 dottedImgName: isSelted ? @"dottedLineOrange":@"dottedLineWhite"];
        [cell.contentView sendSubviewToBack:view_444];
    }
    
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    resMod_AddressInfo * addressinfo = m_AddressList[indexPath.row];
    selAddressID = addressinfo.AddressId;

    [rootTableView reloadData];

    if (isFromSubmitOrder) {
        [self goBack:nil];
    }
}

#pragma mark    --  alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 8956) {
        if(buttonIndex == 1) {
//            [self ApiRequest:api_BOQIIMALL method:kApiMethod_AddressDel class:@"ResponseBase"
//                      params:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[UserUnit userId],@"UserId",
//                              [NSString stringWithFormat:@"%d",whileDelAddressID],@"AddressId", nil]
//                      isShowLoadingAnimal:NO hudShow:@"正在删除"];
//            DeleteAddress
            
            
            [[APIMethodHandle shareAPIMethodHandle]goApiRequestDeleteAddress:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[UserUnit userId],@"UserId",
                                                                                                           [NSString stringWithFormat:@"%d",whileDelAddressID],@"AddressId", nil]
                                                                  ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在删除" delegate:self];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
