//
//  MerchantDetailViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-6.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MerchantDetailViewController.h"
#import "resMod_TicketInfo.h"

#import <ShareSDK/ShareSDK.h>


@interface MerchantDetailViewController () <ISSViewDelegate,ISSShareViewDelegate,UIWebViewDelegate>
{
    UIWebView *_merchantDescriberWebview;
    float _heightForMerchantDescribe;
//    RTLabel *_merchantDescriber;
    int _merchantLoadNum;
    
    UIWebView *_trafficWebview;
    float _heightForTraffic;
//    RTLabel *_traffic;
    int _trafficLoadNum;
    
}
@end


@implementation MerchantDetailViewController
@synthesize sMerchantId;
@synthesize URLMerchant;
@synthesize MerchantsIntroduced;
@synthesize Traffic;
@synthesize TheSurrounding;

#define heightRowHead   45
#define heightCellSpace 10
#define ticketTag       29
#define tagSpace    @"||boqi|"


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mod_merchantInfo = [[resMod_MerchantInfo alloc] init];
    }
    return self;
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Hidden:self.tabBarController];
}

-(void)HUDdelayDo {
    //    [self goBack:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadNavBarView];
    self.title = @"商户详情";
    self.sMerchantId = [self.receivedParams objectForKey:@"param_MerchantId"];
    self.URLMerchant = [self.receivedParams objectForKey:@"param_URLMerchant"];
    [self loadView_UI];
    
    _merchantDescriberWebview = [[UIWebView alloc]initWithFrame:CGRectZero];
    _merchantDescriberWebview.scrollView.scrollEnabled = NO;
    _merchantDescriberWebview.tag = 4;
    _merchantDescriberWebview.delegate = self;
    _heightForMerchantDescribe = 0.0f;
//    _merchantDescriber=[[RTLabel alloc] initWithFrame:CGRectZero];
    _merchantLoadNum = 0;
    _merchantDescriberWebview.dataDetectorTypes = UIDataDetectorTypeNone;
//    _merchantDescriberWebview.layer.borderColor = [UIColor blackColor].CGColor;
//    _merchantDescriberWebview.layer.borderWidth = 1;
    
    _trafficWebview = [[UIWebView alloc]initWithFrame:CGRectZero];
    _trafficWebview.scrollView.scrollEnabled = NO;
    _trafficWebview.tag = 5;
    _trafficWebview.delegate = self;
    _heightForTraffic = 0.0f;
//    _traffic = [[RTLabel alloc]initWithFrame:CGRectZero];
    _trafficLoadNum = 0;
    
    _trafficWebview.dataDetectorTypes = UIDataDetectorTypeNone;
    
    
    
    
    if (self.URLMerchant.length>0) {
//        [self ApiRequestWithURL:self.URLMerchant class:@"resMod_CallBack_MerchantDetail" hudShow:@"正在加载"];
          [[APIMethodHandle shareAPIMethodHandle]goApiRequestWithURL:self.URLMerchant ModelClass:@"resMod_CallBack_MerchantDetail" hudContent:@"正在加载" delegate:self];
    }
    else{
        if (self.sMerchantId.length==0) {
            [self HUDShow:@"商户ID不可为空" delay:1.5 dothing:YES];
        }
        
        NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dicParams setValue:self.sMerchantId forKey:@"MerchantId"];
        if (_lon!=-10000000.00 && _lat !=-10000000.00) {
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lat] forKey:@"Lat"];
            [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lon] forKey:@"Lng"];
        }
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMerchantDetail:dicParams ModelClass:@"resMod_CallBack_MerchantDetail" showLoadingAnimal:YES hudContent:@"正在加载" delegate:self];
        
    
    }
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    
    [self._titleLabel setFrame:CGRectMake(70, 2, 180, 40)];
    UIView * navFuntion = [[UIView alloc] initWithFrame:CGRectMake(240, 0, 80, 44)];
    [navFuntion setBackgroundColor:[UIColor clearColor]];
    UIButton * btn_share = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 35, 44)];
    [btn_share setTag:1787];
    [btn_share setBackgroundColor:[UIColor clearColor]];
    [btn_share setImage:[UIImage imageNamed:@"icon_share.png"] forState:UIControlStateNormal];
    [btn_share addTarget:self action:@selector(onTopBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navFuntion addSubview:btn_share];
    [self.subNavBarView addSubview:navFuntion];
}

//- (void)loadNavBarView
//{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 2, 180, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = @"商户详情";
//    [bgView addSubview:titleLabel];
//
//    
//    UIView * navFuntion = [[UIView alloc] initWithFrame:CGRectMake(240, 0, 80, 44)];
//    [navFuntion setBackgroundColor:[UIColor clearColor]];
//    UIButton * btn_share = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 35, 44)];
//    [btn_share setTag:1787];
//    [btn_share setBackgroundColor:[UIColor clearColor]];
//    [btn_share setImage:[UIImage imageNamed:@"icon_share.png"] forState:UIControlStateNormal];
//    [btn_share addTarget:self action:@selector(onTopBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [navFuntion addSubview:btn_share];
//    [bgView addSubview:navFuntion];
//    [[self navBarView] addSubview:bgView];
//}

- (void) loadView_UI{
    
    //[self addBarRightView];
    
    rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    [rootTableView setBackgroundColor:[UIColor whiteColor]];
//    rootTableView.backgroundColor = color_bodyededed;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    [rootTableView setHidden:YES];
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [rootTableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:rootTableView];
    

}

#pragma mark - 

- (void) addBarRightView{
    
        UIView * navFuntion = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
        [navFuntion setBackgroundColor:[UIColor clearColor]];
        UIButton * btn_share = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 40, 44)];
    
        [btn_share setTag:1787];
        [btn_share setBackgroundColor:[UIColor clearColor]];
        [btn_share setImage:[UIImage imageNamed:@"icon_share.png"] forState:UIControlStateNormal];
        [btn_share addTarget:self action:@selector(onTopBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [navFuntion addSubview:btn_share];
        
        UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:navFuntion];
        self.navigationItem.rightBarButtonItem = r_bar;
        self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
    
}

- (void) onTopBarButtonClick:(id) sender{
    UIButton * btn = sender;
    if (btn.tag==1787) {
        [MobClick event:@"MerchantDetail_share"];
        [self ShareService];    //  --分享
    }
}

//  -- 加载该商户的服务券
- (void) addTicketListForCell:(UITableViewCell *) cell{
    int i=1;
    if (mod_merchantInfo.TicketList.count>0) {
        
        [UICommon Common_line:CGRectMake(0, heightRowHead-1, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
        
        for ( resMod_TicketInfo * tickinfo in mod_merchantInfo.TicketList) {
            
            UIImageView * imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(8, 13 + i*heightRowHead, 16, 16)];
            [imgIcon setBackgroundColor:[UIColor clearColor]];
            [imgIcon setImage:[UIImage imageNamed:@"icon_ticket1"]];
            [cell addSubview:imgIcon];
            
            //--    优惠券价格
            [UICommon Common_UILabel_Add:CGRectMake(10+18, i*heightRowHead-1, 105, heightRowHead)
                              targetView:cell.contentView bgColor:[UIColor clearColor] tag:2001
                                    text:[self convertPrice:tickinfo.TicketPrice]
                                   align:-1 isBold:NO fontSize:14 tColor:color_fc4a00];
            
            UIButton * btnTitle = [UIButton buttonWithType: UIButtonTypeCustom];
            [btnTitle setTag:ticketTag+tickinfo.TicketId];
            [btnTitle setFrame:CGRectMake(95, i*heightRowHead-1, __MainScreen_Width-120, heightRowHead)];
            [btnTitle setBackgroundColor:[UIColor clearColor]];
            [btnTitle setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btnTitle setTitle:@"" forState:UIControlStateNormal];
            [btnTitle addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnTitle];
            
            UILabel * lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, btnTitle.frame.size.width, heightRowHead)];
            [lbltitle setBackgroundColor:[UIColor clearColor]];
            [lbltitle setText:tickinfo.TicketTitle];
            lbltitle.backgroundColor = [UIColor clearColor];
            [lbltitle setTextAlignment:NSTextAlignmentLeft];
            [lbltitle setFont:defFont14];
            [lbltitle setTextColor:color_333333];
            [btnTitle addSubview:lbltitle];
            
            
            [UICommon Common_line:CGRectMake(0, i*heightRowHead-1, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
            
            UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width-25, i*heightRowHead+heightRowHead/2-7, 15, 15)];
            [iconImg setImage:[UIImage imageNamed:@"right_icon.png"]];
            [cell.contentView addSubview:iconImg];
            
            i++;
        }
    }
}

#pragma mark    --  share sdk
- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType {
    
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [viewController.navigationItem.leftBarButtonItem setTitle:@""];
    [viewController.navigationItem.leftBarButtonItem setBackgroundImage:def_ImgStretchable(@"icon_back_white", 58/2, 0) forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [viewController.navigationItem.rightBarButtonItem setBackgroundImage:def_ImgStretchable(@"btn_bg_white", 8, 10) forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    NSDictionary * fontAtt =[[NSDictionary alloc] initWithObjectsAndKeys:color_fc4a00,UITextAttributeTextColor,defFont(YES, 14),UITextAttributeFont,[UIColor clearColor],UITextAttributeTextShadowColor, nil];
    [viewController.navigationItem.rightBarButtonItem setTitleTextAttributes:fontAtt forState:UIControlStateNormal];
}
- (void) ShareService{
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@%@",BQShareContent,APP_DOWNLOADURL]
                                       defaultContent:@"波奇宠物服务分享"
                                                image:[ShareSDK pngImageWithImage:[UIImage imageNamed:@"shareimg.png"]]
                                                title:@"波奇宠物"
                                                  url:APP_DOWNLOADURL
                                          description:BQShareContent
                                            mediaType:SSPublishContentMediaTypeNews];
    
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"内容分享"
                                                              oneKeyShareList:[ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeTencentWeibo,nil]
                                                               qqButtonHidden:NO
                                                        wxSessionButtonHidden:NO
                                                       wxTimelineButtonHidden:NO
                                                         showKeyboardOnAppear:YES
                                                            shareViewDelegate:self
                                                          friendsViewDelegate:self
                                                        picViewerViewDelegate:self];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:[ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeWeixiSession,ShareTypeWeixiTimeline,ShareTypeQQ,ShareTypeQQSpace,ShareTypeTencentWeibo,ShareTypeSMS, nil]
                           content:publishContent
                     statusBarTips:NO
                       authOptions:nil
                      shareOptions:shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess) {
                                    [self HUDShow:@"分享成功" delay:2];
                                }
                                else if (state == SSResponseStateFail) {
                                    [self HUDShow:[NSString stringWithFormat:@"分享失败 %@",[error errorDescription]] delay:2];
//                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

#pragma mark    --  事件区

- (void)onButtonClick:(id) sender{
    
    UIButton * btnTmp = (UIButton*)sender;
    
    //  --打电话
    if (btnTmp.tag == 18721) {
        
        [MobClick event:@"lifeMerchantDetail_call"];
    
        if(mod_merchantInfo.MerchantTele.length==0){
            return;
        }
        
        EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"拨 打"
                                                                              message:[mod_merchantInfo.MerchantTele  stringByReplacingOccurrencesOfString:@"," withString:@""]
                                                                    cancelButtonTitle:@"取消"
                                                                        okButtonTitle:@"呼叫"];
        alertView.delegate1 = self;
        [alertView show];
//        maskView = [[UIView alloc] init];
//        maskView.frame = [UIScreen mainScreen].bounds;
//        maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//        UIWindow *currWindow = [[UIApplication sharedApplication] keyWindow];
//        [currWindow addSubview:maskView];
//        
//        UIButton * btnPhoneNum = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btnPhoneNum setTag:2894];
//        [btnPhoneNum setBackgroundColor:[UIColor convertHexToRGB:@"E7F6FD"]];
//        [btnPhoneNum setFrame:CGRectMake(8, __MainScreen_Height-90, def_WidthArea(8), 40)];
//        [btnPhoneNum setTitle:mod_merchantInfo.MerchantTele forState:UIControlStateNormal];
//        [btnPhoneNum.titleLabel setFont:defFont(NO, 20)];
//        [btnPhoneNum setTitleColor:[UIColor convertHexToRGB:@"07a0e8"] forState:UIControlStateNormal];
//        btnPhoneNum.layer.cornerRadius = 4.0f;
//        [btnPhoneNum addTarget:self action:@selector(onCallClick:) forControlEvents:UIControlEventTouchUpInside];
//        [maskView addSubview:btnPhoneNum];
//        
//        UIButton * btnCancle = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btnCancle setTag:9345];
//        [btnCancle setBackgroundColor:[UIColor convertHexToRGB:@"E7F6FD"]];
//        [btnCancle setFrame:CGRectMake(8, __MainScreen_Height-40, def_WidthArea(8), 40)];
//        [btnCancle setTitle:@"取 消" forState:UIControlStateNormal];
//        [btnCancle.titleLabel setFont:defFont(NO, 17)];
//        [btnCancle setTitleColor:[UIColor convertHexToRGB:@"07a0e8"] forState:UIControlStateNormal];
//        btnCancle.layer.cornerRadius = 4.0f;
//        [btnCancle addTarget:self action:@selector(onCallClick:) forControlEvents:UIControlEventTouchUpInside];
//        [maskView addSubview:btnCancle];
    }
    //  -- 跳服务券券详情
    else {
        
        [MobClick event:@"MerchantDetail_serviceTicket"];
        
        NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithObjectsAndKeys
                                     :[NSString stringWithFormat:@"%d",btnTmp.tag-ticketTag],@"param_TicketId", nil];
        [self pushNewViewController:@"ServiceDetailViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
    }
    
}
//- (void)onCallClick:(id) sender{
//    UIButton * btnTmp = (UIButton*)sender;
//    if (btnTmp.tag == 2894) {
//        
//        NSString *url = [[NSString alloc]initWithFormat:@"tel://%@",[mod_merchantInfo.MerchantTele stringByReplacingOccurrencesOfString:@"-" withString:@""]];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByReplacingOccurrencesOfString:@" " withString:@""]]];
//    }
//    else if(btnTmp.tag == 9345){
//        [maskView removeFromSuperview];
//    }
//    [maskView removeFromSuperview];
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 1) {
        [MobClick event:@"MerchantDetail_call"];
        
        NSString *url = [[NSString alloc]initWithFormat:@"tel://%@",[mod_merchantInfo.MerchantTele stringByReplacingOccurrencesOfString:@"-" withString:@""]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    }
}

#pragma mark    --  api 请求 加调

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_MerchantDetail] || [ApiName isEqualToString:self.URLMerchant]) {
        resMod_CallBack_MerchantDetail * backObj = [[resMod_CallBack_MerchantDetail alloc] initWithDic:retObj];
        mod_merchantInfo = backObj.ResponseData;
        mod_merchantInfo.MerchantDesc = mod_merchantInfo.MerchantDesc.length==0 ? @"暂无信息介绍":mod_merchantInfo.MerchantDesc;
        mod_merchantInfo.MerchantTraffic = mod_merchantInfo.MerchantTraffic.length==0 ? @"暂无交通说明":mod_merchantInfo.MerchantTraffic;
        mod_merchantInfo.MerchantNear = mod_merchantInfo.MerchantNear.length==0 ? @"暂无周边环境介绍":mod_merchantInfo.MerchantNear;
        
        
        self.MerchantsIntroduced = [NSString stringWithFormat:@"商户介绍%@%@",tagSpace,mod_merchantInfo.MerchantDesc];
        self.Traffic = [NSString stringWithFormat:@"交通/到达%@%@",tagSpace,mod_merchantInfo.MerchantTraffic];
        self.TheSurrounding = [NSString stringWithFormat:@"周边小区%@%@",tagSpace,mod_merchantInfo.MerchantNear];
        [rootTableView reloadData];
        [rootTableView setHidden:NO];
        
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger iRow = indexPath.row;
    float fHeight = 0;
    switch (iRow) {
        case 0:     fHeight = 125;
            break;
        case 1:     fHeight = heightRowHead+heightCellSpace;
            break;
        case 2:     fHeight = heightRowHead + mod_merchantInfo.TicketList.count*heightRowHead;
            break;
        case 3:     fHeight = heightRowHead + heightCellSpace;
            break;
        case 4:     {
            NSArray * arrDes = [self.MerchantsIntroduced componentsSeparatedByString:tagSpace];
            if (arrDes.count==2) {
                fHeight = heightRowHead + _heightForMerchantDescribe + heightCellSpace +30;
            }
        }   break;
        case 5:     {
            NSArray * arrDes = [self.Traffic componentsSeparatedByString:tagSpace];

            if (arrDes.count==2) {
                fHeight = heightRowHead + _heightForTraffic + heightCellSpace + 30 ;
            }
        }   break;
        case 6:     {
            NSArray * arrDes = [self.TheSurrounding componentsSeparatedByString:tagSpace];
            if (arrDes.count==2) {
                RTLabel *tmpLabel = [[RTLabel alloc] initWithFrame:CGRectMake(12, heightCellSpace+50, def_WidthArea(10), 50)];
                [tmpLabel setParagraphReplacement:@""];
                tmpLabel.text = arrDes[1];
                CGSize optimumSize = [tmpLabel optimumSize];
                fHeight = heightRowHead + optimumSize.height + heightCellSpace + 30;
            }
        }
            break;
        case 7:     fHeight = heightRowHead + heightCellSpace;
            break;
            
        default:
            break;
    }
    return fHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * Identifier1 = @"ServiceDetailCell";
    NSInteger iRow = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier1];
    
    NSString * titleIcon = @"";
    if (iRow==0) {
        UIImageView *imgBan = [[UIImageView alloc] initWithFrame:CGRectMake(8, 38, 100, 80)];
        [imgBan setTag:1000];
        imgBan.layer.borderColor = color_d1d1d1.CGColor;
        imgBan.layer.borderWidth = 1.0;
        [imgBan setBackgroundColor:[UIColor clearColor]];
        NSString * proimgUrl = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:mod_merchantInfo.MerchantImg];
        [imgBan sd_setImageWithURL:[NSURL URLWithString:proimgUrl] placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
        imgBan.userInteractionEnabled =YES;
        [rootTableView addSubview:imgBan];
        
        //--商户名.
        [UICommon Common_UILabel_Add:CGRectMake(8, 10, def_WidthArea(8), 20) targetView:cell.contentView
                             bgColor:[UIColor clearColor] tag:1001
                                text: mod_merchantInfo.MerchantName
                               align:-1 isBold:YES fontSize:16 tColor:[UIColor blackColor]];
        
        //--商圈
        [UICommon Common_UILabel_Add:CGRectMake(118, 65, 150, 20) targetView:cell.contentView
                             bgColor:[UIColor clearColor] tag:1002
                                text:mod_merchantInfo.BusinessArea
                               align:-1 isBold:NO fontSize:13 tColor:color_717171];
        
        NSString * s_Distance = [self convertDistance:mod_merchantInfo.MerchantDistance];
        if (s_Distance.length>0) {
            //--距离图标
            UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width-80, 67, 13, 13)];
            [iconImg setImage:[UIImage imageNamed: @"icon_local"]];
            [cell.contentView addSubview:iconImg];
        }
        
        //--商户距离
        [UICommon Common_UILabel_Add:CGRectMake(__MainScreen_Width-65, 65, 100, 20) targetView:cell.contentView
                             bgColor:[UIColor clearColor] tag:1003
                                text:s_Distance
                               align:-1 isBold:NO fontSize:13 tColor:color_717171];
        //--人均
        [UICommon Common_UILabel_Add:CGRectMake(118, 93, 200, 20) targetView:cell.contentView
                             bgColor:[UIColor clearColor] tag:1004
                                text:[NSString stringWithFormat:@"平均%@",[self convertPrice:mod_merchantInfo.ConsumePerPerson]]
                               align:-1 isBold:YES fontSize:15 tColor:color_fc4a00];
        //--ScanNumber
        [UICommon Common_UILabel_Add:CGRectMake(__MainScreen_Width-130, 93, 120, 20) targetView:cell.contentView
                             bgColor:[UIColor clearColor] tag:1003
                                text:[NSString stringWithFormat:@"浏览 %d 次",mod_merchantInfo.ScanNumber]
                               align:1 isBold:NO fontSize:13 tColor:color_717171];
    }
    else if( iRow==1 ){     titleIcon = @"myaddress_icon";
        //--地址
        [UICommon Common_UILabel_Add:CGRectMake(10+17+5, heightCellSpace+12, def_WidthArea(30), 20) targetView:cell.contentView
                             bgColor:[UIColor clearColor] tag:1001
                                text:mod_merchantInfo.MerchantAddress
                               align:-1 isBold:NO fontSize:14 tColor:color_333333];
        [UICommon Common_line:CGRectMake(0, heightCellSpace+44, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
    }else if( iRow==2 ){    titleIcon = @"call_icon";
        
        NSString * tel = mod_merchantInfo.MerchantTele.length==0  ? @"暂无联系方式":mod_merchantInfo.MerchantTele;
        UIButton * btnTitle = [UIButton buttonWithType: UIButtonTypeCustom];
        [btnTitle setTag:18721];
        [btnTitle setFrame:CGRectMake(10+17+5, 0, __MainScreen_Width-60, heightRowHead)];
        [btnTitle setBackgroundColor:[UIColor clearColor]];
        [btnTitle setTitle:tel forState:UIControlStateNormal];
        [btnTitle setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btnTitle.titleLabel setFont:defFont14];
//        [btnTitle setTitleColor:[UIColor convertHexToRGB:@"52bdef"] forState:UIControlStateNormal];
        [btnTitle setTitleColor:[UIColor convertHexToRGB:@"fc4a00"] forState:UIControlStateNormal];
        [btnTitle addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnTitle];

        [self addTicketListForCell:cell];
        
    }else if(iRow==3){      titleIcon = @"comment_icon";
               //--点评详情
        [UICommon Common_UILabel_Add:CGRectMake(10+17+5, heightCellSpace+12, def_WidthArea(30), 20) targetView:cell.contentView
                             bgColor:[UIColor clearColor] tag:3001
                                text: [NSString stringWithFormat:@"商户点评(%d)",mod_merchantInfo.CommentNum]
                               align:-1 isBold:NO fontSize:16 tColor:color_333333];
//        [UICommon Common_line:CGRectMake(0, heightCellSpace+44.5, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
        
    }else if(iRow==7){      titleIcon = @"icon_flover";
        [UICommon Common_UILabel_Add:CGRectMake(10+17+8, heightCellSpace, 300, 45) targetView:cell.contentView
                             bgColor:[UIColor clearColor] tag:6001
                                text:@"服务环境"
                               align:-1 isBold:NO fontSize:16 tColor:color_333333];
//        [UICommon Common_line:CGRectMake(0, heightCellSpace+44+0.5, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
    }else{
        NSString * sTitle;
        CGSize tSize;
    
        NSArray * arrDes = [[NSArray alloc] init];
        switch (iRow) {
            case 4:
                titleIcon = @"icon_jishao";
                arrDes = [self.MerchantsIntroduced componentsSeparatedByString:tagSpace];
                break;
            case 5:
                titleIcon = @"icon_pard";
                arrDes = [self.Traffic componentsSeparatedByString:tagSpace];
                break;
            case 6:
                titleIcon = @"icon_build";
                arrDes = [self.TheSurrounding componentsSeparatedByString:tagSpace];
                break;
            default:
                break;
        }
        if (arrDes.count==2) {
            sTitle = arrDes[0];
            
            [UICommon Common_UILabel_Add:CGRectMake(10+17+8, heightCellSpace, __MainScreen_Width, 45)
                              targetView:cell.contentView bgColor:[UIColor clearColor] tag:45001
                                    text:sTitle align:-1 isBold:NO fontSize:16 tColor:color_333333];
            [UICommon Common_line:CGRectMake(0, heightCellSpace+heightRowHead, __MainScreen_Width, 0.5)
                       targetView:cell.contentView backColor:color_d1d1d1];

       NSString *htmlString = [NSString stringWithFormat:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta name=\"description\" content=\"\" /><meta http-equiv=\"X-UA-Compatible\" content=\"IE=EmulateIE7\" /></head><body style=\"color:#989898\">%@</body></html>",arrDes[1]];
#if 1
            if (iRow == 4) {
                if (_merchantLoadNum <=3) {
                    [_merchantDescriberWebview loadHTMLString:htmlString baseURL:nil];
                    _merchantLoadNum++;
                }
                
                [cell.contentView addSubview:_merchantDescriberWebview];


            }
            else if (iRow == 5){
                if (_trafficLoadNum <= 3) {
                    [_trafficWebview loadHTMLString:htmlString baseURL:nil];
                    _trafficLoadNum++;
                }
                
                [cell.contentView addSubview:_trafficWebview];
                
            }
            else
#endif
            {
                RTLabel *tmpLabel=[[RTLabel alloc] initWithFrame:CGRectMake(12, heightCellSpace+heightRowHead, def_WidthArea(10), 50)];
                [tmpLabel setTextColor:[UIColor convertHexToRGB:@"989898"]];
                tmpLabel.text = htmlString;
                tSize = [tmpLabel optimumSize];
                [tmpLabel setFrame:CGRectMake(12, heightCellSpace+50, def_WidthArea(10), tSize.height)];
                [cell.contentView addSubview:tmpLabel];

            }
            
        }
    }
    
    if (iRow!=0 && iRow!=2) {
        [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width, heightCellSpace) targetView:cell backColor:color_ededed];
    }
    if (iRow!=0) {
        //  --  前面小图标
        if (titleIcon.length>0) {
            UIImageView * iconImg =[[UIImageView alloc] initWithFrame:CGRectMake(3, 9+(iRow==2?0:heightCellSpace), 50/2, 50/2)];
            [iconImg setImage:[UIImage imageNamed: titleIcon]];
            [cell.contentView addSubview:iconImg];
        }
    }
    if (iRow==1||iRow==2||iRow==3||iRow==7) {
        int itop = iRow==2 ? 0:heightCellSpace;
        UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width-25, itop+(45/2-6), 15, 15)];
        [iconImg setImage:[UIImage imageNamed:@"right_icon"]];
        [cell.contentView addSubview:iconImg];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
            
        case 1:{
            [MobClick event:@"MerchantDetail_address"];
            [self pushNewViewController:@"NearMapViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                          setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         [[NSMutableArray alloc] initWithObjects:mod_merchantInfo, nil],@"param_merchants",
                                         @"1",@"param_fromMerchant", nil]];
        }
            break;
        case 3:{
            //进入商户消费点评mod_merchantInfo.MerchantId
            NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
            [paramsDict setObject:[NSString stringWithFormat:@"%d",mod_merchantInfo.MerchantId] forKey:@"MerchantId"];
            [self pushNewViewController:@"MerchantCommentViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:paramsDict];
        }
            break;
        case 7:{
            
            [MobClick event:@"MerchantDetail_environment"];
            
            NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
            [param setValue:@"服务环境" forKey:@"param_title"];
            [param setValue:mod_merchantInfo.MerchantServeUrl forKey:@"param_url"];
            [self pushNewViewController:@"WebDetailViewController"
                              isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:param];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - webview delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView.tag == 4) {
        NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
        _heightForMerchantDescribe = [heightStr floatValue] ;  //html
        _merchantDescriberWebview.frame = CGRectMake(12, heightCellSpace+50, def_WidthArea(10), _heightForMerchantDescribe +20);
    }
    
    else if (webView.tag == 5){
    
        NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
        _heightForTraffic = [heightStr floatValue] ;  //html
        _trafficWebview.frame = CGRectMake(12, heightCellSpace+50, def_WidthArea(10), _heightForTraffic +20);
    }
    
    [rootTableView reloadData];
}


@end
