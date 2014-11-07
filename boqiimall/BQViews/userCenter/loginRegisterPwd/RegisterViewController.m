//
//  RegisterViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-13.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "RegisterViewController.h"
#import "ResponseBase.h"
#import "BQCustomBarButtonItem.h"


#define HeightTopView 92
#define rowHeight   46
#define txtPlaceHolder  @"888:手机号:phone_icon.png|999:6-20位，建议数字、字母、符号组合:password_icon.png"


@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isAgreen = YES;
        timerSencond = -100;
        hadSendCode = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"注册波奇用户"];
    [self.view setBackgroundColor:color_body];
   // [self loadNavBarView:@"注册波奇用户"];
    rootScrollView = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:rootScrollView];
    
    
   // [self addRightNav];
    
    viewTop = [[UIView alloc] initWithFrame:CGRectMake(12, 12, __MainScreen_Width - 12*2, HeightTopView)];
    [viewTop setBackgroundColor:[UIColor whiteColor]];
    viewTop.layer.cornerRadius = 5.0f;
    
    viewTop.layer.borderColor = [UIColor convertHexToRGB:@"dbdbdb"].CGColor;
    viewTop.layer.borderWidth = 0.5;
   
    
    [rootScrollView addSubview:viewTop];
    
    viewSecond = [[UIView alloc] initWithFrame:CGRectMake(12, HeightTopView + 24, __MainScreen_Width - 12*2, rowHeight)];
    [viewSecond setBackgroundColor:[UIColor whiteColor]];
    
    viewSecond.layer.borderColor = [UIColor convertHexToRGB:@"dbdbdb"].CGColor;
    viewSecond.layer.borderWidth = 0.5;
    
    viewSecond.layer.cornerRadius = 5.0f;
    [rootScrollView addSubview:viewSecond];
    
    
    int i=0;
    int yPoint = 0 ;
    NSArray * arrTxt = [txtPlaceHolder componentsSeparatedByString:@"|"];
    for (NSString * stmp in arrTxt) {
        NSArray * stxt = [stmp componentsSeparatedByString:@":"];
//        yPoint = rowHeight*i + 10 + i*10;
         yPoint = rowHeight*i;
        [self addCommonTextView: CGRectMake(0, yPoint, def_WidthArea(15), rowHeight)
                     targetView: viewTop
                securetextEntry: i==1 ? YES : NO
                    txtFieldTag: [stxt[0] intValue]
                   keyBoardType: i==0 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault
                    placeHolder: stxt[1]
                       lefticon: stxt[2]
                  addshowPwdBtn: i==1? YES : NO];
        
        yPoint += rowHeight ;
        if (i == 0) {
              [UICommon Common_line:CGRectMake(0, yPoint , __MainScreen_Width - 24, 0.5) targetView:viewTop backColor:color_bodyededed];
        }
        i++;
    }
  
    
    [self addCommonTextView: CGRectMake(8, 0, def_WidthArea(50), rowHeight)
                 targetView: viewSecond
            securetextEntry: NO
                txtFieldTag: 1010
               keyBoardType: UIKeyboardTypeDefault
                placeHolder: @"输入验证码"
                   lefticon: @""
              addshowPwdBtn: NO];
    
    
    
    
    //  -- 获取验证码.
    btn_GetCode = [[UIButton alloc] initWithFrame:CGRectMake(198, HeightTopView + 24 + 0.5  , 110 -0.5 , rowHeight - 1)];
    
    [btn_GetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    btn_GetCode.layer.cornerRadius = 3.0f;
    [btn_GetCode.titleLabel setFont: defFont15];
    
    [btn_GetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_GetCode setBackgroundImage: def_ImgStretchable(@"test_get_code_bg.png", 5, 5) forState:UIControlStateNormal];
    [btn_GetCode addTarget:self action:@selector(onGetCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollView addSubview:btn_GetCode];
    
    //  -- 注册.
    btn_register = [[UIButton alloc] initWithFrame:CGRectMake(12, HeightTopView + HeightTopView/2 + 36 , def_WidthArea(12), 46)];
    [btn_register setBackgroundColor:[UIColor convertHexToRGB:@"fc4a00"]];
    [btn_register setTitle:@"注 册" forState:UIControlStateNormal];
    [btn_register setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_register.layer.cornerRadius = 3.0f;
    [btn_register addTarget:self action:@selector(onRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollView addSubview:btn_register];
    
    //  -- 同意协议.
    btn_read = [[UIButton alloc] initWithFrame:CGRectMake(12, btn_register.frame.origin.y+50, 25, 25)];
    
    
    [btn_read setBackgroundColor:[UIColor clearColor]];

    [btn_read setImage:[UIImage imageNamed:@"check_icon_yes.png"] forState:UIControlStateNormal];
    [btn_read addTarget:self action:@selector(onReadClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollView addSubview:btn_read];
    
    [UICommon Common_UILabel_Add:CGRectMake(40, btn_read.frame.origin.y-2, 120, 30) targetView:rootScrollView
                         bgColor:[UIColor clearColor] tag:0
                            text:@"我已阅读并同意"
                           align:-1 isBold:YES fontSize:12 tColor:[UIColor convertHexToRGB:@"575757"]];
    
    UIButton * btn_xieyi = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_xieyi setFrame:CGRectMake(100, btn_read.frame.origin.y-2, 150, 30)];
    [btn_xieyi setBackgroundColor:[UIColor clearColor]];
    [btn_xieyi setTitle:@"《波奇网服务协议》" forState:UIControlStateNormal];
    [btn_xieyi setTitleColor:[UIColor convertHexToRGB:@"fc4a00"] forState:UIControlStateNormal];
    [btn_xieyi.titleLabel setFont:defFont(NO, 12)];
    [btn_xieyi addTarget:self action:@selector(goProtocol:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollView addSubview:btn_xieyi];
    
    
    //----------------------        定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(handleTimer:) userInfo:nil repeats: YES];
}


- (void)loadNavBarView
{
    [super loadNavBarView];
    BQCustomBarButtonItem *barItem = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(260, 7, 60, 30)];
    barItem.titleRect = CGRectMake(20, 0, 40, 30);
    barItem.titleLabel.text = @"登录";
    barItem.titleLabel.font = defFont15;
    barItem.titleLabel.textColor = color_fc4a00;
    barItem.delegate = self;
    barItem.selector = @selector(onButton_LoginClick:);
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
//    barItem.titleLabel.text = @"登录";
//    barItem.titleLabel.font = defFont15;
//    barItem.titleLabel.textColor = color_fc4a00;
//    barItem.delegate = self;
//    barItem.selector = @selector(onButton_LoginClick:);
//    [bgView addSubview:barItem];
//    [self.navBarView addSubview:bgView];
//}

//  --查看协议
- (void) goProtocol:(id) sender{
    NSString * url = [NSString stringWithFormat:@"http://%@/%@/%@",kHostUrl_boqiiLife,kApiUrl(api_BOQIILIFE),kApiMethod_GetRegAgreement];
    [self pushNewViewController:@"WebDetailViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:url,@"param_url",
                                 @"波奇用户协议",@"param_title",nil]];
}

//  -- 同意协议
- (void) onReadClick:(id) sender{
    isAgreen = !isAgreen;
    if (isAgreen) {
        [btn_read setImage:[UIImage imageNamed:@"check_icon_yes.png"] forState:UIControlStateNormal];
    }
    else{
        [btn_read setImage:[UIImage imageNamed:@"check_icon.png"] forState:UIControlStateNormal];
    }
}

//  -- 60秒后重新发送
- (void) handleTimer: (NSTimer *) timer{
    
    if (timerSencond>0) {
        timerSencond--;
        [btn_GetCode setTitle:[NSString stringWithFormat:@"%d秒后重新获取",timerSencond] forState:UIControlStateNormal];
        [btn_GetCode setBackgroundImage:def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5) forState:UIControlStateNormal];
        if (timerSencond==0) {
            timerSencond = -100;
        }
    }
    else if( timerSencond == -100){
        [btn_GetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn_GetCode setBackgroundImage:def_ImgStretchable(@"test_get_code_bg.png", 5, 5) forState:UIControlStateNormal];
    }
}

//  -- 获取验证码
- (void) onGetCodeClick:(id) sender{
    
    if ( timerSencond != -100 ) {   //  -- 说明这个时候还没到60秒
        return;
    }
    
    UITextField * txtAuthCode = (UITextField*)[viewTop viewWithTag:888];
    if (txtAuthCode.text.length==0) {
        [self HUDShow:@"请输入注册手机号" delay:1.5];
        return;
    }else if(txtAuthCode.text.length!=11){
        [self HUDShow:@"手机号格式不正确" delay:1.5];
        return;
    }
    
    timerSencond = 120;

     [btn_GetCode setBackgroundImage:def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5) forState:UIControlStateNormal];
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:txtAuthCode.text forKey:@"Account"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestSendAuthCode:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在获取" delegate:self];
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_SendAuthCodeForRegister class:@"ResponseBase"
//              params:dicParams isShowLoadingAnimal:NO hudShow:@"正在获取"];
}

//  -- 注册
- (void) onRegisterClick:(id) sender{
    
    UITextField * txtUsername = (UITextField*)[viewTop viewWithTag:888];
    UITextField * txtPwd      = (UITextField*)[viewTop viewWithTag:999];
    UITextField * txtAuthCode = (UITextField*)[viewSecond viewWithTag:1010];
    
    [txtUsername resignFirstResponder];
    [txtPwd resignFirstResponder];
    [txtAuthCode resignFirstResponder];

    if (txtUsername.text.length==0) {
        [self HUDShow:@"请输入注册手机号" delay:1.5];
        return;
    }
    else if(txtPwd.text.length==0){
        [self HUDShow:@"请设置登录密码"  delay:1.5];
        return;
    }
    else if(txtAuthCode.text.length==0){
        [self HUDShow:@"请输入手机验证码" delay:1.5];
        return;
    }
    else if (!hadSendCode) {
        [self HUDShow:@"请先获取验证码" delay:1.5];
        return;
    }
    else if (!isAgreen){
        [self HUDShow:@"请阅读并同意协议" delay:1.5];
        return;
    }
    
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:txtUsername.text forKey:@"UserName"];
    [dicParams setValue:[NSString YKMD5:txtPwd.text] forKey:@"Password"];
    [dicParams setValue:txtAuthCode.text forKey:@"AuthCode"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestUserRegister:dicParams ModelClass:@"resMod_CallBack_LoginOrRegister" showLoadingAnimal:NO hudContent:@"正在注册" delegate:self];
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_UserRegister class:@"resMod_CallBack_LoginOrRegister"
//              params:dicParams isShowLoadingAnimal:NO hudShow:@"正在注册"];
}

//  -- 密码可见
- (void) onShowPwdClick:(id) sender{
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


#pragma mark    --  api 请求 加调

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    if ([ApiName isEqualToString:kApiMethod_SendAuthCodeForRegister]) {
        
        [self HUDShow:@"验证码发送成功" delay:1.5];
        hadSendCode = YES;
    }
    else if([ApiName isEqualToString:kApiMethod_UserRegister]){
        resMod_CallBack_LoginOrRegister * callObj = [[resMod_CallBack_LoginOrRegister alloc] initWithDic:retObj];
        callBackUserinfo = callObj.ResponseData;
        
        if (callBackUserinfo) {
            UITextField * txtUsername = (UITextField*)[viewTop viewWithTag:888];
            //  -- 登录成功
            [UserUnit saveUserLoginInfo:callBackUserinfo.UserId
                        isSharesdkLogin:NO
                               userName:txtUsername.text
                               userNick:callBackUserinfo.NickName
                                userSex:callBackUserinfo.Sex
                             userMobile:txtUsername.text
                              userEmail:@""
                                balance:@"0.0"
                               allorder:0
                             unpayOrder:0
                             payedOrder:0
                              unpayMall:0
                            DealingMall:0
                            HasPayPassword:0];
            
            [self HUDShow:@"注册成功" delay:kShowMsgAfterDelay];
            [self dismissViewControllerAnimated:YES completion:^{
                //[self pushNewViewController:@"" isNibPage:NO hideTabBar:NO setDelegate:NO setPushParams:nil];
            }];
        }
    }
}

-(void) interfaceExcuteError:(NSError*)error apiName:(NSString*)ApiName{
    
    NSString * warnMsg = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
    if (warnMsg.length>30) {
        [self HUDShow:@"服务器出错 请稍后重试" delay:kShowMsgAfterDelay];
        return;
    }
    
    if ([ApiName isEqualToString:kApiMethod_SendAuthCodeForRegister]) {
        [self HUDShow:warnMsg.length==0 ? @"系统错误" :warnMsg delay:kShowMsgAfterDelay];
        hadSendCode = NO;
    }
    if ([ApiName isEqualToString:kApiMethod_UserRegister]){
        [self HUDShow:warnMsg.length==0 ? @"系统错误" :warnMsg delay:kShowMsgAfterDelay];
    }
}


#pragma mark    --  三个 common txt
- (void) addCommonTextView:(CGRect) cgFrame
                targetView:(UIView *) _targetView
           securetextEntry:(BOOL) b_isEntry
               txtFieldTag:(int) _tag
              keyBoardType:(UIKeyboardType) boardType
               placeHolder:(NSString *) place
                  lefticon:(NSString*) iconName
             addshowPwdBtn:(BOOL) b_show
{
    UIView * txtBackView = [[UIView alloc] initWithFrame:cgFrame];
    [txtBackView setTag:89974];
    [txtBackView setBackgroundColor:[UIColor clearColor]];
    [_targetView addSubview:txtBackView];
    
//    txtBackView.layer.borderColor = [UIColor orangeColor].CGColor;
//    txtBackView.layer.borderWidth = 1;
    
    
    int txt_xPoint = 20;
    if (iconName.length>0) {
        txt_xPoint = 58;
        UIImageView * imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7, 35, 35)];
        [imgIcon setBackgroundColor:[UIColor clearColor]];
        [imgIcon setImage: [UIImage imageNamed:iconName]];
        [txtBackView addSubview:imgIcon];
    }
    
    UITextField * txtField = [[UITextField alloc] initWithFrame:CGRectMake(txt_xPoint, 7, cgFrame.size.width - 55 - 10 , 35)];
    
//    txtField.layer.borderWidth = 1;
//    txtField.layer.borderColor = [UIColor redColor].CGColor;
    
    
    [txtField setTag: _tag];
    [txtField setBackgroundColor:[UIColor clearColor]];
    [txtField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtField setPlaceholder:place];
    [txtField setDelegate:self];
    [txtField setKeyboardType:boardType];
    [txtField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtField setSecureTextEntry:b_isEntry];
    [txtField setTextColor:color_333333];
    [txtField setFont:defFont15];
    [txtBackView addSubview:txtField];
    
    
    
    if (b_show) {
        [txtField setFrame:CGRectMake(txtField.frame.origin.x , txtField.frame.origin.y, txtField.frame.size.width-40, 35)];
        
//            txtField.layer.borderWidth = 1;
//            txtField.layer.borderColor = [UIColor redColor].CGColor;
        
        UIButton * btn_showPwd = [[UIButton alloc] initWithFrame:CGRectMake(cgFrame.size.width-40, 3, 40, 40)];
        [btn_showPwd setBackgroundColor:[UIColor clearColor]];
        [btn_showPwd setImage:[UIImage imageNamed:@"visible_icon.png"] forState:UIControlStateNormal];
        [btn_showPwd addTarget:self action:@selector(onShowPwdClick:) forControlEvents:UIControlEventTouchUpInside];
        [txtBackView addSubview:btn_showPwd];
        
//        btn_showPwd.layer.borderColor = [UIColor blackColor].CGColor;
//        btn_showPwd.layer.borderWidth = 1;
        
    }
}


- (void) addRightNav{
    
    if (IOS7_OR_LATER) {
        UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(onButton_LoginClick:)];
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
        
        
        barItem.titleLabel.text = @"登录";
        barItem.titleLabel.font = defFont15;
        barItem.titleLabel.textColor = color_fc4a00;
        
        barItem.delegate = self;
        barItem.selector = @selector(onButton_LoginClick:);
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barItem];
        
        self.navigationItem.rightBarButtonItem = barButtonItem;
    }
    
    
}


- (void)onButton_LoginClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
   // [self pushNewViewController:@"LoginViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
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
}

@end
