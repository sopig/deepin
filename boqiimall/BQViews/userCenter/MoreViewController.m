//
//  MoreViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-4-30.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MoreViewController.h"
#import "EC_UISwitch.h"

#define heightForSection   40
#define heightRow   45

#define moreTitles  @"仅wifi下显示图片:3672:icon_more_wifi|版本更新:3673:icon_more_vupdate|喜欢我们，鼓励打分:3674:icon_more_dafen|分享给朋友:3675:icon_more_share|客服热线:3676:icon_more_call"

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadNavBarView];
    [self setTitle:@"设 置"];
    [self.view setBackgroundColor:color_body];
   // [self loadNavBarView:@"设 置"];
    [self loadView_UI];
    [MobClick event:@"myBoqii_intercalate"];
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
//


- (void) loadView_UI{
    
    rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight-kNavBarViewHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:rootScrollView];
    
    NSArray * arrTitles = [moreTitles componentsSeparatedByString:@"|"];
    
    UIView * viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightRow*arrTitles.count)];
    [viewTop setBackgroundColor:[UIColor whiteColor]];
    [rootScrollView addSubview:viewTop];
    
    int i=0;
    for (NSString * skey in arrTitles) {
        
        NSArray * txtinfo = [skey componentsSeparatedByString:@":"];
        
        [self commonUI:CGRectMake(0, heightRow*i, __MainScreen_Width, heightRow)
            targetView:viewTop
              btnTitle:txtinfo[0]
                btnTag:[txtinfo[1] intValue]
               btnIcon:txtinfo[2]];
        
        if (i==0) {
            EC_UISwitch * btnSwitch_wifi = [EC_UISwitch buttonWithType:UIButtonTypeCustom];
            [btnSwitch_wifi setTag:8796];
            [btnSwitch_wifi setOn: [BQ_global showImgOnlyWIFI] ? YES:NO];
            [btnSwitch_wifi setBackgroundColor:[UIColor clearColor]];
            [btnSwitch_wifi setFrame: CGRectMake(__MainScreen_Width-62,heightRow*i+7, 51, 31)];
            [btnSwitch_wifi addTarget:self action:@selector(onOnlyWifiClick:) forControlEvents:UIControlEventTouchUpInside];
            [viewTop addSubview:btnSwitch_wifi];
        }
        else if(i==1){
            lblversion = [[UILabel alloc] initWithFrame:CGRectMake(__MainScreen_Width-120, heightRow*i, 90, heightRow)];
            [lblversion setBackgroundColor:[UIColor clearColor]];
            [lblversion setTextAlignment:NSTextAlignmentRight];
            [lblversion setText:@"版本检测"];
            [lblversion setTextColor:color_717171];
            [lblversion setFont:defFont14];
            [viewTop addSubview:lblversion];
        }
        else if(i==4){
            UILabel * lblTEL=[[UILabel alloc] initWithFrame:CGRectMake(120, heightRow*i, 200, heightRow)];
            [lblTEL setBackgroundColor:[UIColor clearColor]];
            [lblTEL setText:@"400-820-6098"];
            [lblTEL setAlpha:0.8];
            [lblTEL setTextAlignment:NSTextAlignmentLeft];
            [lblTEL setTextColor: color_fc4a00];
            [lblTEL setFont:defFont(NO, 18)];
            [viewTop addSubview:lblTEL];
        }
        
        i++;
        [UICommon Common_line:CGRectMake(0, heightRow*i-0.5, __MainScreen_Width, 0.5)
                   targetView:viewTop backColor:color_d1d1d1];
    }
    
    UIImageView * imgDetail=[[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width/2-(242/4),heightRow*arrTitles.count+40, 242/2, 161/2)];
    [imgDetail setBackgroundColor:[UIColor clearColor]];
    [imgDetail setImage:[UIImage imageNamed:@"moreBQLogo.png"]];
    [rootScrollView addSubview:imgDetail];
    
    UILabel * lblcom = [[UILabel alloc] initWithFrame:CGRectMake(115, imgDetail.frame.origin.y+70, 100, 40)];
    [lblcom setBackgroundColor:[UIColor clearColor]];
    [lblcom setText:@"波奇宠物"];
    [lblcom setTextColor:color_b3b3b3];
    [lblcom setFont:defFont(NO, 13)];
    [rootScrollView addSubview:lblcom];
    
    UILabel * lblVer = [[UILabel alloc] initWithFrame:CGRectMake(175, imgDetail.frame.origin.y+81, 100, 20)];
    [lblVer setBackgroundColor:[UIColor clearColor]];
    [lblVer setText:[NSString stringWithFormat:@"V%@",APP_VERSION]];
    [lblVer setTextColor:color_b3b3b3];
    [lblVer setFont:defFont(NO, 13)];
    [rootScrollView addSubview:lblVer];
    
//    UILabel * lblurl=[[UILabel alloc] initWithFrame:CGRectMake(0, imgDetail.frame.origin.y+93, __MainScreen_Width, 20)];
//    [lblurl setBackgroundColor:[UIColor clearColor]];
//    [lblurl setText:@"www.boqii.com"];
//    [lblurl setTextAlignment:NSTextAlignmentCenter];
//    [lblurl setTextColor:color_b3b3b3];
//    [lblurl setFont:defFont(NO, 15)];
//    [rootScrollView addSubview:lblurl];
    
    
//    //  -- 下面客户电话
//    UIView * viewbottom = [[UIView alloc] initWithFrame:CGRectMake(0, lblurl.frame.origin.y+36, __MainScreen_Width, heightRow)];
//    [viewbottom setBackgroundColor:[UIColor whiteColor]];
//    [rootScrollView addSubview:viewbottom];
//    
//    [self commonUI:CGRectMake(0, 0, __MainScreen_Width, heightRow)
//        targetView:viewbottom btnTitle:@"客服热线：" btnTag:47923 btnIcon:@"icon_more_call"];
//    UILabel * lblTEL=[[UILabel alloc] initWithFrame:CGRectMake(120, 0, 200, heightRow)];
//    [lblTEL setBackgroundColor:[UIColor clearColor]];
//    [lblTEL setText:@"400-820-6098"];
//    [lblTEL setTextAlignment:NSTextAlignmentLeft];
//    [lblTEL setTextColor:[UIColor convertHexToRGB:@"52bdef"]];
//    [lblTEL setFont:defFont(NO, 17)];
//    [viewbottom addSubview:lblTEL];
    
    [rootScrollView setContentSize:CGSizeMake(__MainScreen_Width, heightRow*arrTitles.count + 100)];
}

- (void) onOnlyWifiClick:(EC_UISwitch *) sender{
    sender.on = !sender.on;
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:SHOWIMG_WIFI];
}

- (void) onButtonClick:(id) sender{
    UIButton * btntmp = (UIButton*) sender;
    switch (btntmp.tag) {
        case 3673:{
            [MobClick event:@"intercalate_VersionUpdate"];
            
            NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] init];
            [dicParams setObject:kApiMethod_GetVersionInfo forKey:APP_ACTIONNAME];
            [dicParams setObject:APP_VERSIONNUM forKey:@"Version"];
            if (!APPVERSIONTYPE) {
                [dicParams setObject:@"1" forKey:@"Type"];
            }
            
//            [self ApiRequest:api_BOQIILIFE method:kApiMethod_GetVersionInfo class:@"resMod_CallBack_LastVersion"
//                      params:dicParams isShowLoadingAnimal:NO hudShow:@"正在检测"];
//            GetLastIOSVersion
            
            
            [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetLastIOSVersion:dicParams ModelClass:@"resMod_CallBack_LastVersion" showLoadingAnimal:NO hudContent:@"正在检测" delegate:self];
        }
            break;
        case 3674:  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_APPSTOREURL]];
            break;
        case 3675:
            [MobClick event:@"intercalate_share"];

            [self ShareService];
            break;
        case 3676:
             [MobClick event:@"intercalate_call"];
            [self loadCallView];
            break;
            
        default:
            break;
    }
}

//- (void) GetDataFromPlist{
//    if (dicMoreFunction == nil) {
//        NSURL * sCategoryPath = [[NSBundle mainBundle] URLForResource:@"CommonList" withExtension:@"plist"];
//        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:sCategoryPath];
//
//        dicMoreFunction= [dic objectForKey:@"morePage"];
//    }
//}

- (void) loadCallView{
    
    EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"拨打电话"
                                                                          message:@"400-820-6098"
                                                                cancelButtonTitle:@"取消"
                                                                    okButtonTitle:@"呼叫"];
    alertView.delegate1 = self;
    [alertView setTag:9839];
    [alertView show];
}


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

- (void) commonUI:(CGRect) cgframe
       targetView:(UIView*) _targetView
         btnTitle:(NSString *) __title
           btnTag:(int) itag
          btnIcon:(NSString*) __imgname{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:cgframe];
    [button setTag:itag];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitle:__title forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setTitleColor:color_4e4e4e forState:UIControlStateNormal];
    [button.titleLabel setFont:defFont14];
    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [button setImage:[UIImage imageNamed:__imgname] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_targetView addSubview:button];
    
    UIImageView * imgDetail=[[UIImageView alloc] initWithFrame:CGRectMake(cgframe.size.width-23,heightRow/2-7, 15, 15)];
    [imgDetail setBackgroundColor:[UIColor clearColor]];
    [imgDetail setImage:[UIImage imageNamed:@"right_icon.png"]];
    [button addSubview:imgDetail];
}


#pragma mark    --  api 请 求 回 调.
-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];

    if ([ApiName isEqualToString:kApiMethod_GetVersionInfo]) {
        resMod_CallBack_LastVersion * backObj = [[resMod_CallBack_LastVersion alloc] initWithDic:retObj];
        versionInfo = backObj.ResponseData;
    
        [lblversion setText:@"已是最新版本"];
        if ([versionInfo isKindOfClass:[resMod_LastVersionInfo class]]) {
            if (versionInfo.VersionStatus == 1) {
                EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"版本更新"
                                                                                      message:versionInfo.UpdateMsg
                                                                            cancelButtonTitle:@"现在更新"                                                                             okButtonTitle:nil];
                alertView.delegate1 = self;
                [alertView show];
                [lblversion setText:@"发现新版本"];
            }
            else if(versionInfo.VersionStatus == 2) {
                EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"版本更新"
                                                                                      message:versionInfo.UpdateMsg
                                                                            cancelButtonTitle:@"以后再说"
                                                                                okButtonTitle:@"现在更新"];
                alertView.delegate1 = self;
                [alertView show];
                [lblversion setText:@"发现新版本"];
            }
            else{
                [self HUDShow:@"已是最新版本" delay:2];
            }
        }
    }
}

-(void) interfaceExcuteError:(NSError*)error apiName:(NSString*)ApiName{
    if([ApiName isEqualToString:kApiMethod_GetVersionInfo]) {
        [super interfaceExcuteError:error apiName:ApiName];
    }
}

//更新、推送\打电话
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.title isEqualToString:@"版本更新"]) {
        if(versionInfo.VersionStatus == 1) {
            if(buttonIndex == 0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_APPSTOREURL]];
            }
        }
        else {
            if(buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_APPSTOREURL]];
                exit(0);
            }
        }
    }
    
    //  --打电话
    if (alertView.tag == 9839) {
        if(buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008206098"]];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
