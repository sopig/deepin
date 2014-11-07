//
//  myCenterViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-4-30.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "myCenterViewController.h"
#import "resMod_UserInfo.h"
#import "UIImage+ImageUtil.h"

#import "BQImagePickerViewController.h"

#define heightForCell   47
#define heightPadding  10

#define txtOrderMallOrLife  (APPVERSIONTYPE ? @"商城订单|服务券订单":@"服务券订单")
#define txtOrderStatus      (APPVERSIONTYPE ? @"待付款|处理中|待付款|已购买":@"全部订单|待付款|已购买")
#define txtALLOrderTag      5656
#define txtOrderTag         7878

#define RADIUS 90
#define SEL_IMG_KEY @"com.boqii.tolly.portrait"

@implementation myCenterViewController
@synthesize heightForHead;
@synthesize dic_DataPlist;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.heightForHead  = 220/2;
        
        self.isRootPage = YES;
        [self getDataFromPlist];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if ([UserUnit isUserLogin]) {
        [self apiUpdataUserInfo];
    }
    else{
        [rootTableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的波奇"];
    [self.view setBackgroundColor:color_bodyededed];
    
    //  -- 设置
    UIButton * btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnMore setFrame:CGRectMake(10, 2, 30, 40)];
    [btnMore setImage:[UIImage imageNamed:@"iconSetup.png"] forState:UIControlStateNormal];
    [btnMore setBackgroundColor:[UIColor clearColor]];
    [btnMore addTarget:self action:@selector(onMoreClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:btnMore];
    self.navigationItem.rightBarButtonItem = r_bar;
    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
    
    //  --  table.......
    rootTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight,__MainScreen_Width, __ContentHeight_noTab) style:UITableViewStylePlain];
    [rootTableView setBackgroundColor:[UIColor clearColor]];
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [rootTableView setShowsVerticalScrollIndicator: NO];
    [self.view addSubview:rootTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(apiUpdataUserInfo) name:@"updataUserInfo" object: nil];
}

-(void)loadNavBarView {
    [super loadNavBarView];

    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setFrame:CGRectMake(275, 2, 40, 40)];
    [settingBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [settingBtn setImage:[UIImage imageNamed:@"iconSetup.png"] forState:UIControlStateNormal];
    [settingBtn setBackgroundColor:[UIColor clearColor]];
    [settingBtn addTarget:self action:@selector(onMoreClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:settingBtn];
}

- (void) setTopHeadView:(UIView *) targetView{
    
    BOOL islogin = [UserUnit isUserLogin];
    
    if (HeadView) {
        [HeadView removeFromSuperview];
        HeadView = nil;
    }

    HeadView = [[BQImageview alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightForHead)];
    [HeadView setBackgroundColor:[UIColor clearColor]];
    HeadView.delegate = self;
    HeadView.selector = @selector(onHeadClick:);
    HeadView.userInteractionEnabled =YES;
    [targetView addSubview:HeadView];
    
    userLogo = [[BQImageview alloc] init];
    [userLogo setFrame:CGRectMake([UserUnit isUserLogin] ? 10:(__MainScreen_Width/2-99), 25, 60, 60)];
 
    NSString*top = [[NSUserDefaults standardUserDefaults]objectForKey:SEL_IMG_KEY];
    
    if(![UserUnit isUserLogin] || [[NSUserDefaults standardUserDefaults]objectForKey:SEL_IMG_KEY]== nil){
        [userLogo setImage:[UIImage imageNamed: [NSString stringWithFormat:@"UserPhoto.png"]]];
    }
    else if ([[NSUserDefaults standardUserDefaults]objectForKey:SEL_IMG_KEY]!= nil) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"avatar_square_%d.jpg",[top integerValue]]];
        [userLogo setImage:[img roundedCornerImage:RADIUS borderSize:1]];
    }
    
    [userLogo setBackgroundColor:[UIColor clearColor]];
    userLogo.selector = @selector(onPickerPortrait);
    userLogo.delegate = self;
    [HeadView addSubview:userLogo];
    
    float ypoint = islogin ? 30 : heightForHead/2-15;
    float xpoint = islogin ? 80 : 128;
    [UICommon Common_UILabel_Add:CGRectMake(xpoint, ypoint, __MainScreen_Width, 30) targetView:HeadView
                         bgColor:[UIColor clearColor] tag:235
                            text:islogin ? [UserUnit userNick] : @"点击登录"
                           align:-1 isBold:NO fontSize:18 tColor:[UIColor whiteColor]];
    
    if (islogin) {
        [UICommon Common_UILabel_Add:CGRectMake(80, 55, 80, 30) targetView:HeadView
                             bgColor:[UIColor clearColor] tag:236
                                text:@"账户余额："
                               align:-1 isBold:NO fontSize:14 tColor:[UIColor whiteColor]];
        [UICommon Common_UILabel_Add:CGRectMake(80+70, 56, __MainScreen_Width/2, 30) targetView:HeadView
                             bgColor:[UIColor clearColor] tag:236
                                text:[self convertPrice:[[UserUnit userBalance] floatValue]]
                               align:-1 isBold:NO fontSize:16 tColor:[UIColor whiteColor]];
    }
}

#pragma mark - 
- (void)onPickerPortrait{
    
    if ([UserUnit isUserLogin]) {
        BQImagePickerViewController *vc = [[BQImagePickerViewController alloc]init];
        vc.delegate = self;
        vc.selector = @selector(setPortrait:);
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        
            [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
    else{
        [self goLogin:nil param:nil delegate:self];
    }
}

- (void)setPortrait:(id)sender
{
    NSNumber*num = (NSNumber*)sender;
    NSUInteger index = [num integerValue];
    [userLogo setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"avatar_square_%d.jpg",index+1]]roundedCornerImage:RADIUS borderSize:1 ]];
}


#pragma mark    --  数据
- (void) getDataFromPlist{
    
    if (self.dic_DataPlist == nil) {
        NSURL * sCategoryPath = [[NSBundle mainBundle] URLForResource:@"CommonList" withExtension:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:sCategoryPath];
        
        self.dic_DataPlist= [dic objectForKey: APPVERSIONTYPE ? @"userCenterFunctionBQMall":@"userCenterFunctionBQLIFE"];
    }
}



#pragma mark    --  event
- (void) onMoreClick:(id) sender{
    [self pushNewViewController:@"MoreViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
}

- (void) onHeadClick:(id) sender{
    if (![UserUnit isUserLogin]) {
        [MobClick event:@"myBoqii_login"];
        
        [self goLogin:nil param:nil delegate:self];
    }
    else{
        [MobClick event:@"userCenter_userInformation"];
        [self pushNewViewController:@"UserInfoViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
    }
}

- (void) onMyOrderClick:(id) sender{
    
    if (![UserUnit isUserLogin]) {
        [self goLogin:nil param:nil delegate:self];
    }
    else{
        NSMutableDictionary * dic_params = [[NSMutableDictionary alloc]initWithCapacity:1];
        UIButton * btntmp = (UIButton*)sender;
        NSString * pushControllerName = @"";

#if APPVERSIONTYPE
        //  -- 上面两个全部按钮
        if (btntmp.tag == txtALLOrderTag) {
            [MobClick event:@"myBoqii_mallOrder"];
            
            [dic_params setValue:@"1" forKey:@"param_mallOrderType"];
            pushControllerName = @"MyMallOrderListController";
        }
        else if(btntmp.tag == txtALLOrderTag+1){
             [MobClick event:@"myBoqii_serviceOrder"];
            [dic_params setValue:@"1" forKey:@"param_ordertype"];
            pushControllerName = @"MyOrderViewController";
        }
        
        //  -- 下面具体状态按钮
        if (btntmp.tag == txtOrderTag) {
            [MobClick event:@"myBoqii_mallOrder_payingOrder"];
            
            [dic_params setValue:@"2" forKey:@"param_mallOrderType"];
            pushControllerName = @"MyMallOrderListController";
        }
        else if(btntmp.tag == txtOrderTag+1){
            [MobClick event:@"myBoqii_mallOrders_disposingOrder"];
            [dic_params setValue:@"3" forKey:@"param_mallOrderType"];
            pushControllerName = @"MyMallOrderListController";
        }
        else if(btntmp.tag == txtOrderTag+2){
            [MobClick event:@"myBoqii_serviceOrder_payingOrder"];
            
            [dic_params setValue:@"2" forKey:@"param_ordertype"];
            pushControllerName = @"MyOrderViewController";
        }
        else if(btntmp.tag == txtOrderTag+3){
            [MobClick event:@"myBoqii_serviceOrder_boughtOrder"];
            [dic_params setValue:@"3" forKey:@"param_ordertype"];
            pushControllerName = @"MyOrderViewController";
        }
#else
        if (btntmp.tag == txtOrderTag) {
            [dic_params setValue:@"1" forKey:@"param_ordertype"];
            pushControllerName = @"MyOrderViewController";
        }
        else if(btntmp.tag == txtOrderTag+1){
            [dic_params setValue:@"2" forKey:@"param_ordertype"];
            pushControllerName = @"MyOrderViewController";
        }
        else if(btntmp.tag == txtOrderTag+2){
            [dic_params setValue:@"3" forKey:@"param_ordertype"];
            pushControllerName = @"MyOrderViewController";
        }
#endif
        
        [self pushNewViewController:pushControllerName isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:dic_params];
    }
}

#pragma mark    --  api 请 求 回 调.
- (void) apiUpdataUserInfo{

    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetUserData:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[UserUnit userId],@"UserId", nil] ModelClass:@"resMod_CallBack_LoginOrRegister" showLoadingAnimal:NO hudContent:@"" delegate:self];
    
}
- (void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_GetUserData]) {
        resMod_CallBack_LoginOrRegister * backObj = [[resMod_CallBack_LoginOrRegister alloc] initWithDic:retObj];
        resMod_UserInfo * userInfo = backObj.ResponseData;
        
        if (userInfo) {
            //  -- 更新本地用户信息
            [UserUnit saveUserLoginInfo: [UserUnit userId]
                        isSharesdkLogin: [UserUnit isShareSDKLogin]
                               userName: [UserUnit userName]
                               userNick: userInfo.NickName
                                userSex: userInfo.Sex
                             userMobile: userInfo.Telephone
                              userEmail: @""
                                balance: [NSString stringWithFormat:@"%.2f",userInfo.Balance]
                               allorder: userInfo.AllOrderNum
                             unpayOrder: userInfo.UnpayOrderNum
                             payedOrder: userInfo.PayedOrderNum
                              unpayMall: userInfo.ShoppingMallUnpayNum
                            DealingMall: userInfo.ShoppingMallDealingNum
                            HasPayPassword:userInfo.HasPayPassword];
            
            [rootTableView reloadData];
        }
    }
    [self hudWasHidden:HUD];
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dic_DataPlist.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else{
        NSArray * arrfuns = [self.dic_DataPlist objectForKey:[NSString stringWithFormat:@"section%d",section]];
        return arrfuns.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section==0 ? heightForHead + 46+52 : heightForCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section==0 ? 0 : (section==self.dic_DataPlist.count?50:heightPadding);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * tabHead = [[UIView alloc] initWithFrame:CGRectMake(-0.5, 0, __MainScreen_Width+1, heightPadding)];
    [tabHead setBackgroundColor:color_bodyededed];
    tabHead.layer.borderColor = color_d1d1d1.CGColor;
    tabHead.layer.borderWidth = 0.5;
    return tabHead;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int isection = indexPath.section;
    int irow = indexPath.row;

    NSString * Identifier1 = @"myCenterCell";
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier1];

    if (isection>0) {
        NSArray * arrfun = [self.dic_DataPlist objectForKey:[NSString stringWithFormat:@"section%d",isection]];

        if (arrfun.count>0) {
            
            NSArray * tmpArr = [arrfun[irow] componentsSeparatedByString:@"|"];

            UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, heightForCell/2-12, 50/2, 50/2)];
            [iconImg setBackgroundColor:[UIColor clearColor]];
            [iconImg setTag:888];
            [iconImg setImage:[UIImage imageNamed:tmpArr[1]]];
            [cell.contentView addSubview:iconImg];
            
            [UICommon Common_UILabel_Add:CGRectMake(36, 0, 200, heightForCell) targetView:cell.contentView
                                 bgColor:[UIColor clearColor] tag:1000
                                    text:tmpArr[0] align:-1 isBold:NO fontSize:14 tColor: color_4e4e4e];
            
            UILabel * lblPushControl = [[UILabel alloc] initWithFrame:CGRectZero];
            [lblPushControl setTag:999];
            [lblPushControl setText:tmpArr[2]];
            [cell.contentView addSubview:lblPushControl];
            
            UIImageView * goDetail = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width-25, (heightForCell-15)/2, 15, 15)];
            [goDetail setImage:[UIImage imageNamed:@"right_icon.png"]];
            [cell.contentView addSubview:goDetail];
        }
    }
    else if (isection==0) {

        UIImageView * imgbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightForHead)];
        [imgbg setImage:[UIImage imageNamed:@"profile_bg.png"]];
        [cell.contentView addSubview:imgbg];

        //  --头部
        [self setTopHeadView:cell.contentView];
        
        NSArray * arrOrderMallOrLife = [txtOrderMallOrLife componentsSeparatedByString:@"|"];
        int icount = arrOrderMallOrLife.count;
        for (int i=0; i<arrOrderMallOrLife.count; i++) {
            UIButton * lblOrder = [UIButton buttonWithType:UIButtonTypeCustom];
            [lblOrder setTag:txtALLOrderTag+i];
            [lblOrder setFrame:CGRectMake( i*(__MainScreen_Width/icount), heightForHead, __MainScreen_Width/icount, 46)];
            [lblOrder setBackgroundColor:[UIColor convertHexToRGB:@"fef5ed"]];
            [lblOrder setTitle:arrOrderMallOrLife[i] forState:UIControlStateNormal];
            [lblOrder setTitleColor:color_333333 forState:UIControlStateNormal];
            [lblOrder.titleLabel setFont:defFont15];
            [lblOrder addTarget:self action:@selector(onMyOrderClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:lblOrder];
        }
        
        NSArray * arrTxtOrder = [txtOrderStatus  componentsSeparatedByString:@"|"];
        float fWidth = __MainScreen_Width/arrTxtOrder.count;
        int i=0;
        for (NSString * stxt in arrTxtOrder) {
            
            UIButton * btn_orderStatus = [[UIButton alloc] initWithFrame:CGRectMake(fWidth*i, heightForHead+46, fWidth, 52)];
            [btn_orderStatus setTag:txtOrderTag+i];
            [btn_orderStatus setBackgroundColor:[UIColor convertHexToRGB:@"fef5ed"]];
            [btn_orderStatus setTitle:stxt forState:UIControlStateNormal];
            [btn_orderStatus setTitleColor:color_4e4e4e forState:UIControlStateNormal];
            [btn_orderStatus.titleLabel setFont:defFont13];
            [btn_orderStatus setTitleEdgeInsets:UIEdgeInsetsMake(24, 0, 0, 0)];
            [btn_orderStatus addTarget:self action:@selector(onMyOrderClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn_orderStatus];
            
            UIImageView * imgicon = [[UIImageView alloc] initWithFrame:CGRectMake((fWidth-25)/2, 5, 25, 25)];
            [imgicon setBackgroundColor:[UIColor clearColor]];
            [imgicon setImage:[UIImage imageNamed:(i==0||i==2?@"pay_icon.png":(i==1?@"process_icon.png":@"purchased_icon_black.png"))]];
            [btn_orderStatus addSubview:imgicon];
            
            int iorderNum = 0;
            switch (i) {
                case 0: iorderNum = APPVERSIONTYPE ? [UserUnit userOrder_mallUnpay]:[UserUnit userOrder_all];
                    break;
                case 1: iorderNum = APPVERSIONTYPE ? [UserUnit userOrder_mallDealing]:[UserUnit userOrder_unpay];
                    break;
                case 2: iorderNum = APPVERSIONTYPE ? [UserUnit userOrder_unpay]:[UserUnit userOrder_payed];
                    break;
                case 3: iorderNum = APPVERSIONTYPE ? [UserUnit userOrder_payed]:0;
                    break;
                default:
                    break;
            }
            if (iorderNum>0) {
                UIButton * orderNum = [[UIButton alloc] initWithFrame:CGRectMake(fWidth/2+8, 6, 16, 16)];
                [orderNum setBackgroundColor: color_fc4a00];
                [orderNum setTitle:[NSString stringWithFormat:@"%d%@",iorderNum>100?9:iorderNum,iorderNum>100?@"+":@""] forState:UIControlStateNormal];
                [orderNum.titleLabel setFont:defFont(NO, 11)];
                [orderNum setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
                orderNum.layer.cornerRadius = 8.0f;
                [btn_orderStatus addSubview:orderNum];
            }
            
            if (i>0) {
                [UICommon Common_line:CGRectMake(fWidth*i,heightForHead+40+15,0.5,30) targetView:cell.contentView
                            backColor:[UIColor convertHexToRGB:@"cba899"]];
            }
            ++i;
        }
        
        [UICommon Common_line:CGRectMake(0, heightForHead+46, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:[UIColor convertHexToRGB:@"cba899"]];
#if APPVERSIONTYPE
        [UICommon Common_line:CGRectMake(__MainScreen_Width/2, heightForHead, 0.5, 98) targetView:cell.contentView backColor:[UIColor convertHexToRGB:@"cba899"]];
#endif
    }

    if (irow>=0) {
        [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];        
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section>0) {
        
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        UILabel * lbl_999 = (UILabel *)[cell viewWithTag:999];
        NSString * pushController = lbl_999.text;
        
        if (pushController.length>0) {
            NSArray * strs = [pushController componentsSeparatedByString:@":"];
            NSString * sPushControl = strs.count>0?strs[0]:@"";
            if ([UserUnit isUserLogin]) {
                
                if (strs.count==2) {
                    [MobClick event:strs[1]];
                }

                [self pushNewViewController:sPushControl isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
            }
            else{
                [MobClick event:@"userCenter_login"];
                [self goLogin:sPushControl param:nil delegate:self];
            }
        }
    }
}

//  --登录成功
- (void)LoginSuccessPushViewController:(NSString *)m_str param:(id)m_param{
    if (m_str.length>0) {
        [self pushNewViewController:m_str isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
    }
}


#pragma mark    ---    Scroll View Delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    CGFloat offsetY = scrollView.contentOffset.y;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
