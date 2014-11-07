//
//  LoginViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-4-29.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "LoginViewController.h"
#import <ShareSDK/ShareSDK.h>
//#import <Parse/Parse.h>
#import "BQCustomBarButtonItem.h"

#import "MallProductCommentController.h"

#import "WXHandle.h"


#define kUsername @"usernameForLogin"


@interface LoginViewController ()<WXHandleDelegate>

@end

@implementation LoginViewController
@synthesize rootScrollView;
@synthesize txt_userName;
@synthesize txt_userPwd;
@synthesize btn_forgetPwd;
@synthesize btn_login;

@synthesize loginDelegate;
@synthesize pushContollerString;
@synthesize param;

@synthesize isShareSdkLogin;
@synthesize shareSDKLogin_nickname;
@synthesize shareSDKLogin_sex;
#define HeightTopView   92
#define HeightFastLogin 120
#define kXstartPoint 47
#define rowHeight   46
#define kForgotButtonXsize 110
#define txtPlaceHolder  @"888:手机号/邮箱/用户名:account_icon.png|999:密码:password_icon.png"
//#define fastLoginInfo   @"632:新浪微博:sina_icon.png|633:腾讯QQ :qq_icon.png|634:支付宝:alipay_icon.png"
#define fastLoginInfo   @"632:新浪微博:sina_icon.png|635:微信:wechat_login.png"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isShowTxtPwd = NO;
        self.isShareSdkLogin = NO;
    }
    return self;
}

- (void)goBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *usernameStr = [[NSUserDefaults standardUserDefaults] objectForKey:kUsername];
    self.txt_userName = (UITextField*)[viewTop viewWithTag:888];
    self.txt_userName.text = usernameStr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"波奇用户登录"];
    [self.view setBackgroundColor:color_bodyededed];
   // [self loadNavBarView:@"波奇用户登录"];
    
    rootScrollView = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:rootScrollView];
    
   // [self addRightNav];
    
    viewTop = [[UIView alloc] initWithFrame:CGRectMake(12, 12, __MainScreen_Width - 12*2, HeightTopView)];
    viewTop.layer.cornerRadius = 5.0f;
    
    viewTop.layer.borderColor = [UIColor convertHexToRGB:@"dbdbdb"].CGColor;
    viewTop.layer.borderWidth = 0.5;
    
    [viewTop setBackgroundColor:[UIColor whiteColor]];
    [rootScrollView addSubview:viewTop];
    [UICommon Common_line:CGRectMake(0, HeightTopView/2+2, __MainScreen_Width - 12*2, 0.5)
               targetView:viewTop backColor:color_bodyededed];

    
    int i=0;
    int yPoint = 0 ;
    NSArray * arrTxt = [txtPlaceHolder componentsSeparatedByString:@"|"];
    for (NSString * stmp in arrTxt) {
        NSArray * stxt = [stmp componentsSeparatedByString:@":"];
//        yPoint = rowHeight*i + 15 + i*18;
         yPoint = rowHeight*i ;
        [self addCommonTextView: CGRectMake(0, yPoint, def_WidthArea(15), rowHeight)
                     targetView: viewTop
                securetextEntry: i==1 ? YES : NO
                    txtFieldTag: stxt[0]
                    placeHolder: stxt[1]
                       lefticon: stxt[2]
                  addshowPwdBtn: i==1 ? YES : NO];
        
//        yPoint += rowHeight + 10;
        i++;
    }
    
    
    btn_login = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_login setFrame:CGRectMake(12, HeightTopView+24, def_WidthArea(12), 46)];
    [btn_login setBackgroundColor:[UIColor convertHexToRGB:@"FC3500"]];
    [btn_login setTitle:@"登 录" forState:UIControlStateNormal];
    [btn_login.titleLabel setFont:defFont18];
    [btn_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_login addTarget:self action:@selector(onButton_LoginClick:) forControlEvents:UIControlEventTouchUpInside];
    btn_login.layer.cornerRadius = 3.0f;
    [rootScrollView addSubview:btn_login];
    
    btn_forgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_forgetPwd setBackgroundColor:[UIColor clearColor]];
    [btn_forgetPwd setFrame:CGRectMake(kForgotButtonXsize, btn_login.frame.origin.y+50, 100, 30)];
    [btn_forgetPwd setTitle:@"忘记密码 ?" forState:UIControlStateNormal];
    [btn_forgetPwd.titleLabel setFont:defFont15];
    [btn_forgetPwd setTitleColor:[UIColor convertHexToRGB:@"989898"] forState:UIControlStateNormal];
    [btn_forgetPwd addTarget:self action:@selector(onButton_ForgetPwdClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollView addSubview:btn_forgetPwd];
    
    [self addFastLogin];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(onFastLoginSuccessFromWeb:)
                                                 name: @"onFastLoginSuccessFromWeb" object: nil];
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    [self._titleLabel setFrame:CGRectMake(60, 2, 200, 40)];
    BQCustomBarButtonItem *barItem = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(260, 7, 60, 30)];
    barItem.titleRect = CGRectMake(20, 0, 40, 30);
    barItem.titleLabel.text = @"注册";
    barItem.titleLabel.font = defFont15;
    barItem.titleLabel.textColor = color_fc4a00;
    barItem.delegate = self;
    barItem.selector = @selector(onButton_RegisterClick:);
    [self.subNavBarView addSubview:barItem];
}

//- (void)loadNavBarView:(NSString *)title
//{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 2, 200, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = title;
//    [bgView addSubview:titleLabel];
//    
//    BQCustomBarButtonItem *barItem = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(260, 7, 60, 30)];
//    barItem.titleRect = CGRectMake(20, 0, 40, 30);
//    barItem.titleLabel.text = @"注册";
//    barItem.titleLabel.font = defFont15;
//    barItem.titleLabel.textColor = color_fc4a00;
//    barItem.delegate = self;
//    barItem.selector = @selector(onButton_RegisterClick:);
//    [bgView addSubview:barItem];
//    [self.navBarView addSubview:bgView];
//}



#pragma mark   --- event
- (IBAction) onButton_ForgetPwdClick:(id)sender{
    [MobClick event:@"userLogin_forget"];
    [self pushNewViewController:@"FindLoginPwdViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
}

//  -- go login
- (IBAction) onButton_LoginClick:(id)sender{
    
    self.isShareSdkLogin = NO;
    
    self.txt_userName = (UITextField*)[viewTop viewWithTag:888];
    self.txt_userPwd  = (UITextField*)[viewTop viewWithTag:999];
    [self.txt_userName resignFirstResponder];
    [self.txt_userPwd resignFirstResponder];
    if (self.txt_userName.text.length==0) {
        [self HUDShow:@"账户不可为空" delay:1.5];
        return;
    }
    else if(self.txt_userPwd.text.length==0){
        [self HUDShow:@"密码不可为空" delay:1.5];
        return;
    }
    
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] init];
    [dicParams setObject:self.txt_userName.text forKey:@"UserName"];
    [dicParams setObject:[NSString YKMD5:self.txt_userPwd.text]  forKey:@"Password"];
//    [self ApiRequest:kApiMethod_Login class:@"resMod_CallBack_LoginOrRegister" params:dicParams];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestUserLogin:dicParams ModelClass:@"resMod_CallBack_LoginOrRegister" showLoadingAnimal:NO hudContent:@"正在登录" delegate:self];
}

- (void) onButton_RegisterClick:(id) sender{
    [MobClick event:@"userLogin_register"];

    [self pushNewViewController:@"RegisterViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
}

- (void) onShowPwdClick:(UIButton *) sender{
    
    isShowTxtPwd = !isShowTxtPwd;
    UITextField * txttmp = (UITextField*)[viewTop viewWithTag:999];
    if (isShowTxtPwd) {
        [txttmp setSecureTextEntry:NO];
        [sender setImage:[UIImage imageNamed:@"visible_icon_sel.png"] forState:UIControlStateNormal];
    }else{
        [txttmp setSecureTextEntry:YES];
        [sender setImage:[UIImage imageNamed:@"visible_icon.png"] forState:UIControlStateNormal];
    }
}

- (void) onButton_FastLoginClick:(id) sender{
    
    self.isShareSdkLogin = YES;
    
    UIButton * btnTmp = (UIButton*)sender;
    switch (btnTmp.tag) {
        case 632:{      //  --新浪微博登录
            [MobClick event:@"userLogin_weibo"];
            [self shareSDKLogin:ShareTypeSinaWeibo];
        }
            break;
        case 633:{      //  --QQ登录
            [MobClick event:@"userLogin_qq"];
            [self shareSDKLogin:ShareTypeQQSpace];
        }
            break;
        case 634:{      //  --支付宝登录
            [MobClick event:@"userLogin_alipay"];
            [self pushNewViewController:@"WebDetailViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                          setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:loginByAlipay,@"param_url",@"支付宝登录",@"param_title",@"100",@"param_isFromLogin", nil]];
        }
            break;
        
        case 635:{   //微信登录
            [MobClick event:@"userLogin_wechat"];
            if (![WXApi isWXAppInstalled]) {
                EC_UICustomAlertView *alert = [[EC_UICustomAlertView alloc]initWithTitle:@"温馨提示！" message:@"您还没有安装微信，推荐您去安装微信" cancelButtonTitle:@"否" okButtonTitle:@"是"];
                alert.delegate1 = self;
                [alert show];
                return;
            }
            
            [self shareSDKLogin:ShareTypeWeixiSession];
            
        }
        default:
            break;
    }
}


-(void)alertView:(EC_UICustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [alertView hide];
    }
    else if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        [alertView hide];
    }
}
//  --  登陆后代理
- (void) onLoginSuccessDelegete{
    
    if (self.pushContollerString && ![self.pushContollerString isEqualToString:@""]) {

        [self dismissViewControllerAnimated:NO completion:nil];
        
        if (loginDelegate && [loginDelegate respondsToSelector:@selector(LoginSuccessPushViewController:param:)]) {
            [loginDelegate LoginSuccessPushViewController:pushContollerString param:param];
        }
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    self.pushContollerString = nil;      //置空
}


//  --注册按钮.
- (void) addRightNav{
    
    if (IOS7_OR_LATER) {
        UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(onButton_RegisterClick:)];
        [r_bar setTitlePositionAdjustment:UIOffsetMake(-5, 0) forBarMetrics:UIBarMetricsDefault];
        r_bar.tintColor = color_fc4a00;
        
        self.navigationItem.rightBarButtonItem = r_bar;
        
        //    [[UIBarButtonItem appearance] setTitleTextAttributes:
        //    @{ UITextAttributeFont: [UIFont systemFontOfSize:15.0],
        //
        //       UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]} forState:UIControlStateNormal];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes: @{ UITextAttributeFont: [UIFont systemFontOfSize:15.0f],UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]}  forState:UIControlStateNormal];
    }
    else{
        BQCustomBarButtonItem *barItem = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        barItem.titleRect = CGRectMake(22, 0, 40, 30);
        
        
        barItem.titleLabel.text = @"注册";
        barItem.titleLabel.font = defFont15;
        barItem.titleLabel.textColor = color_fc4a00;

        barItem.delegate = self;
        barItem.selector = @selector(onButton_RegisterClick:);
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barItem];
        
        self.navigationItem.rightBarButtonItem = barButtonItem;
    }
}



#pragma mark - uinavigationbar delegate

//- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item{
// 
//}
//
//- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item{
// 
//}


//  --load 快捷登录.
- (void) addFastLogin{
    UIView * fastLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, __ContentHeight_noTab-HeightFastLogin, __MainScreen_Width, HeightFastLogin)];
    [fastLoginView setBackgroundColor:[UIColor clearColor]];
    [rootScrollView addSubview:fastLoginView];
    
    //
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 120, 15)];
    titleLabel.text = @"使用合作账号登录";
    titleLabel.font = defFont15;
    titleLabel.textColor = [UIColor convertHexToRGB:@"575757"];
    [fastLoginView addSubview:titleLabel];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    //左边分割线
    [UICommon Common_line:CGRectMake(12, 7, 75+7, 0.5) targetView:fastLoginView backColor:color_d1d1d1];
    //右边分割线
    [UICommon Common_line:CGRectMake(220+7, 7, 88, 0.5) targetView:fastLoginView backColor:color_d1d1d1];
    
    int i=0;
    int yPoint = 0 ;
    int xPoint = 0 ;
    NSArray * arrTxt = [fastLoginInfo componentsSeparatedByString:@"|"];
    for (NSString * stmp in arrTxt) {
        NSArray * stxt = [stmp componentsSeparatedByString:@":"];

        xPoint =  kXstartPoint*i + 98 + i*25; //
        yPoint = rowHeight;
        
        UIButton * btn_fastlogin = [[UIButton alloc] initWithFrame:CGRectMake(xPoint, yPoint, 50, 50)];
        [btn_fastlogin setTag:[stxt[0] intValue]];
        [btn_fastlogin setImage:[UIImage imageNamed:stxt[2]] forState:UIControlStateNormal];
        [btn_fastlogin addTarget:self action:@selector(onButton_FastLoginClick:) forControlEvents:UIControlEventTouchUpInside];
        [fastLoginView addSubview:btn_fastlogin];
        i++;
    }
}

#pragma mark    --  第三方登录
/*
 实现用户第三方登录主要使用ShareSDK中授权相关功能来实现。其整个实现的流程如下所示：
 
 1.使用ShareSDK中的hasAuthorizedWithType方法来判断用户是否已经登录。如果尚未登录则进入步骤2，否则进入步骤4。
 2.使用ShareSDK中的authWithType方法来对用户进行授权。
 3.授权成功后，调用ShareSDK中的getUserInfoWithType方法来获取用户信息，并将取到的用户信息与服务器中本地帐号信息进行关联。
 4.登录应用主界面。
 在注销登录时可以使用ShareSDK中的cancelAuthWithType方法来实现。如果需要重新登录跳转回步骤1重新执行。
 
 */
- (void) shareSDKLogin:(ShareType) shareType{
    
    if (shareType == ShareTypeWeixiSession) {
        WXHandle *handle = [WXHandle shareWXHandle];
        [handle sendAuthRequest];
        handle.delegate = self;
    }
    else{
        
        //1.判断是否已经登陆
        if ([ShareSDK hasAuthorizedWithType:shareType]) {
            [self onLoginSuccessDelegete];
            return;
        }
        
        id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:YES scopes:nil powerByHidden:YES followAccounts:nil authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:nil];
        
        //2.获得授权
        [ShareSDK authWithType:shareType options:authOptions result:^(SSAuthState state, id<ICMErrorInfo> error) {
            if (state == SSAuthStateSuccess) {
                [self HUDShow:@"获取授权成功，请稍等..." delay:1];
                //3.获得用户信息与本地账户关联
                [ShareSDK getUserInfoWithType:shareType
                                  authOptions:authOptions
                                       result:^(BOOL result,id<ISSPlatformUser> issuser,id<ICMErrorInfo> error) {
                                           if (result) {
                                               
                                               self.shareSDKLogin_nickname = [issuser nickname];
                                               self.shareSDKLogin_sex = [issuser gender]==0 ? @"男" : ([issuser gender]==1 ? @"女" : @"未知");
                                               NSString *stype = shareType == ShareTypeSinaWeibo ? @"sina" : @"qq";
                                               NSDictionary * dicParams = [[NSDictionary alloc] initWithObjectsAndKeys:stype,@"channeltype",
                                                                           [issuser uid],@"userid", [[ShareSDK getCredentialWithType:shareType] token],@"Token" ,nil];
                                               
                                               [self goApiRequest_fastLogin:dicParams];
                                           }
                                           else{
                                               [self HUDShow:[error errorDescription] delay:3];
                                           }
                                       }];
            }
            else if (state == SSAuthStateCancel){
                [self HUDShow:@"您已经取消登陆" delay:1];
            }
            else if (state == SSAuthStateBegan){
                [self HUDShow:@"正在登陆，请稍等" delay:1];
            }
            else if (state == SSAuthStateFail){
                [self HUDShow:[error errorDescription] delay:1];
                //            [self HUDShow:@"获取授权失败，请重新操作" delay:1];
            }
        }];
    }
}


#pragma mark ----

//  -- web页面登录成功
- (void) onFastLoginSuccessFromWeb:(NSNotification *) _pNotification{
    [self goApiRequest_fastLogin:(NSDictionary*)_pNotification.object];
}
//  -- 第三方登录接口
-(void) goApiRequest_fastLogin:(NSDictionary *) __Params{
    
    if (!__Params || __Params.count==0) {
        [self HUDShow:@"快捷登录用户信息为空" delay:1];
        return;
    }
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] init];
    [dicParams setObject:[__Params objectForKey:@"userid"] forKey:@"UID"];
    [dicParams setObject:[__Params objectForKey:@"channeltype"]  forKey:@"ChannelType"];
    [dicParams setObject:[__Params objectForKey:@"Token"] forKey:@"AccessToken"];
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestFastLogin:dicParams ModelClass:@"resMod_CallBack_LoginOrRegister" showLoadingAnimal:NO hudContent:@"正在登录" delegate:self];
}



-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [self hudWasHidden:HUD];
    if ([ApiName isEqualToString:kApiMethod_Login] || [ApiName isEqualToString:kApiMethod_FastLogin]) {
        resMod_CallBack_LoginOrRegister * backObj = [[resMod_CallBack_LoginOrRegister alloc] initWithDic:retObj];
        userInfo = backObj.ResponseData;
        
        if (userInfo!=nil) {
            if (!self.isShareSdkLogin)
            {
                [[NSUserDefaults standardUserDefaults] setObject:self.txt_userName.text forKey:kUsername];
            }
            
            //  -- 登录成功
            [UserUnit saveUserLoginInfo: userInfo.UserId
                        isSharesdkLogin: self.isShareSdkLogin
                               userName: self.isShareSdkLogin ? userInfo.NickName : self.txt_userName.text
                               userNick: self.isShareSdkLogin ? shareSDKLogin_nickname : userInfo.NickName
                                userSex: self.isShareSdkLogin ? shareSDKLogin_sex : userInfo.Sex
                             userMobile: userInfo.Telephone
                              userEmail: @""
                                balance: [NSString stringWithFormat:@"%.2f",userInfo.Balance]
                               allorder: userInfo.AllOrderNum
                             unpayOrder: userInfo.UnpayOrderNum
                             payedOrder: userInfo.PayedOrderNum
                              unpayMall: userInfo.ShoppingMallUnpayNum
                            DealingMall: userInfo.ShoppingMallDealingNum
                            HasPayPassword:userInfo.HasPayPassword];
            [self HUDShow:@"登录成功" delay:kShowMsgAfterDelay];
            [self onLoginSuccessDelegete];
        }
        else{
            [self HUDShow:@"服务器返回信息为空" delay:2];
        }
    }
}

//  -- txt
- (void) addCommonTextView:(CGRect) cgFrame
                targetView:(UIView *) _targetView
           securetextEntry:(BOOL) b_isEntry
               txtFieldTag:(NSString *) _tag
               placeHolder:(NSString *) place
                  lefticon:(NSString*) iconName
             addshowPwdBtn:(BOOL) b_show
{
    UIView * txtBackView = [[UIView alloc] initWithFrame:cgFrame];
    
//    txtBackView.layer.borderColor = [UIColor redColor].CGColor;
//    txtBackView.layer.borderWidth = 1;
    
    [txtBackView setTag:89974];
    [txtBackView setBackgroundColor:[UIColor clearColor]];
//    txtBackView.layer.borderColor =  [UIColor convertHexToRGB:@"dbdbdb"].CGColor;
//    txtBackView.layer.borderWidth = 1.0;
//    txtBackView.layer.cornerRadius = 3.0f;
    [_targetView addSubview:txtBackView];
    
    int txt_xPoint = 20;
    if (iconName.length>0) {
        txt_xPoint = 58;
        UIImageView * imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7, 35, 35)];
        
//        imgIcon.layer.borderColor = [UIColor redColor].CGColor;
//        imgIcon.layer.borderWidth = 1;
        
        [imgIcon setBackgroundColor:[UIColor clearColor]];
        [imgIcon setImage: [UIImage imageNamed:iconName]];
        [txtBackView addSubview:imgIcon];
    }
    
    UITextField * txtField = [[UITextField alloc] initWithFrame:CGRectMake(txt_xPoint , 7, cgFrame.size.width-55 - 10, 35)];
    
//    txtField.layer.borderColor = [UIColor blackColor].CGColor;
//    txtField.layer.borderWidth = 1;
    
    [txtField setTag:[_tag intValue]];
    [txtField setBackgroundColor:[UIColor clearColor]];
    [txtField setPlaceholder:place];
    [txtField setDelegate:self];
    [txtField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtField setSecureTextEntry:b_isEntry];
    [txtField setTextColor:color_333333];
    [txtField setFont:defFont15];
    [txtBackView addSubview:txtField];
    
    if (b_show) {
        
        [txtField setFrame:CGRectMake(txtField.frame.origin.x, txtField.frame.origin.y, txtField.frame.size.width-40, 35)];
        UIButton * btn_showPwd = [[UIButton alloc] initWithFrame:CGRectMake(cgFrame.size.width-40, 3, 40, 40)];
        [btn_showPwd setBackgroundColor:[UIColor clearColor]];
        [btn_showPwd setImage:[UIImage imageNamed:@"visible_icon.png"] forState:UIControlStateNormal];
        [btn_showPwd addTarget:self action:@selector(onShowPwdClick:) forControlEvents:UIControlEventTouchUpInside];
        [txtBackView addSubview:btn_showPwd];
    }
}


#pragma mark - TextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 微信回调处理

- (void)responseFromPayHandle:(id)object
{
    SendAuthResp *response = (SendAuthResp*)object ;

    NSDictionary*   paras =  @{
              @"appid":tencentWXAppID,
              @"secret":tencentWXAppSecret,
              @"code":response.code,
              @"grant_type":@"authorization_code"
              };
    
    [HttpRequest httpRequestWithAddress:@"https://api.weixin.qq.com/sns/oauth2/access_token" parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
  
        NSDictionary * dicParams = @{
                                     @"channeltype":@"wechat",
                                     @"userid":[jsonObject valueForKey:@"openid"],
                                     @"Token":[jsonObject valueForKey:@"access_token"]
                                     };
        
        [self goApiRequest_fastLogin:dicParams];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self HUDShow:[error valueForKey:NSLocalizedDescriptionKey] delay:1];
    }];
    
    
}

- (void)requestFromPayHandle:(id)object
{
    
}


@end
