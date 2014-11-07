//
//  FindLoginPwdViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "FindLoginPwdViewController.h"
#import "ResponseBase.h"

#define HeightTopView 130
#define rowHeight   40

@implementation FindLoginPwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        hadSendCode = NO;
        timerSencond = -100;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"找回密码"];
  //  [self setTitle:@"找回密码"];
    [self.view setBackgroundColor:color_body];
   // [self loadNavBarView:@"找回密码"];
    
    rootScrollView = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:rootScrollView];
    
    
    viewTop = [[UIView alloc] initWithFrame:CGRectMake(12, 12, __MainScreen_Width - 12*2, 46)];
    [viewTop setBackgroundColor:[UIColor whiteColor]];
    viewTop.layer.cornerRadius = 5.0f;
    [rootScrollView addSubview:viewTop];

    viewTop.layer.borderColor = [UIColor convertHexToRGB:@"dbdbdb"].CGColor;
    viewTop.layer.borderWidth = 0.5;
    
    
    viewSecond = [[UIView alloc] initWithFrame:CGRectMake(12, 18 + HeightTopView/2 - 19, __MainScreen_Width - 12*2, 46)];
    [viewSecond setBackgroundColor:[UIColor whiteColor]];

    viewSecond.layer.borderColor = [UIColor convertHexToRGB:@"dbdbdb"].CGColor;
    viewSecond.layer.borderWidth = 0.5;
    
    viewSecond.layer.cornerRadius = 5.0f;
    [rootScrollView addSubview:viewSecond];
    


    
    //  -- 手机账号
    [self addCommonTextView: CGRectMake(5, 5, def_WidthArea(24), rowHeight)
                 targetView: viewTop
            securetextEntry: NO
                txtFieldTag: 888
               keyBoardType: UIKeyboardTypeNumberPad
                placeHolder: @"手机号码"
                   lefticon: @"phone_icon.png"
              addshowPwdBtn: NO];

//    [UICommon Common_line:CGRectMake(0, 15+rowHeight+10 , __MainScreen_Width, 1) targetView:viewTop backColor:[UIColor convertHexToRGB:@"F6F6F6"]];
    
    //  -- 输入验证码框.
    [self addCommonTextView: CGRectMake(5, 5, def_WidthArea(80), rowHeight)
                 targetView: viewSecond
            securetextEntry: NO
                txtFieldTag: 999
               keyBoardType: UIKeyboardTypeDefault
                placeHolder: @"输入验证码"
                   lefticon: @""
              addshowPwdBtn: NO];
    

    //  -- 获取验证码.
    btn_GetCode = [[UIButton alloc] initWithFrame:CGRectMake(198, 15+rowHeight+28.5 - 19 + 0.22 , 110-0.5,  HeightTopView/2-20 - 0.44 )];
    [btn_GetCode setBackgroundColor:[UIColor clearColor]];
    [btn_GetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn_GetCode.titleLabel setFont: defFont14];
//    [btn_GetCode setBackgroundColor:color_8fc31f];
    btn_GetCode.layer.cornerRadius = 5.0f;
    [btn_GetCode setBackgroundImage: def_ImgStretchable(@"test_get_code_bg.png", 5, 5) forState:UIControlStateNormal];

    [btn_GetCode addTarget:self action:@selector(onGetCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollView addSubview:btn_GetCode];
    
    //  -- 下一步
    btn_next = [[UIButton alloc] initWithFrame:CGRectMake(12, HeightTopView+10 - 19, def_WidthArea(12), 46)];
    [btn_next setBackgroundColor:[UIColor convertHexToRGB:@"fc4a00"]];
    [btn_next setTitle:@"下一步" forState:UIControlStateNormal];
    [btn_next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_next.layer.cornerRadius = 3.0f;
    [btn_next addTarget:self action:@selector(onNextClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollView addSubview:btn_next];
    
    //----------------------        定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(handleTimer:) userInfo:nil repeats: YES];
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


- (void) onNextClick:(id) sender{
    UITextField * txtUserName      = (UITextField*)[viewTop viewWithTag:888];
    UITextField * txtAuthCode      = (UITextField*)[viewSecond viewWithTag:999];
    [txtUserName resignFirstResponder];
    [txtAuthCode resignFirstResponder];
    if (txtUserName.text.length==0) {
        [self HUDShow:@"请输入手机号" delay:1.5];
        return;
    }
    else if(txtAuthCode.text.length==0){
        [self HUDShow:@"请输入验证码" delay:1.5];
        return;
    }
    
    [MobClick event:@"forgetPassword_phoneNum"];
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:txtUserName.text forKey:@"Account"];
    [dicParams setValue:txtAuthCode.text forKey:@"AuthCode"];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_CheckAuthCode class:@"ResponseBase"
//              params:dicParams  isShowLoadingAnimal:NO hudShow:@"正在验证"];
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestCheckAuthCode:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在验证" delegate:self];
}

- (void) handleTimer: (NSTimer *) timer{
    
    if (timerSencond>0) {
        timerSencond--;
        [btn_GetCode setTitle:[NSString stringWithFormat:@"%d秒后重新获取",timerSencond] forState:UIControlStateNormal];
//        [btn_GetCode setBackgroundImage:def_ImgStretchable(@"btn_Register_hidden", 10, 0) forState:UIControlStateNormal];
        [btn_GetCode setBackgroundImage: def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5) forState:UIControlStateNormal];
        
        if (timerSencond==0) {
            timerSencond = -100;
        }
    }
    else if( timerSencond == -100){
        [btn_GetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
//        [btn_GetCode setBackgroundImage:def_ImgStretchable(@"btn_Register_nomal", 10, 0) forState:UIControlStateNormal];
        [btn_GetCode setBackgroundImage: def_ImgStretchable(@"test_get_code_bg.png", 5, 5) forState:UIControlStateNormal];

    }
}

- (void) onGetCodeClick:(id) sender{
    UITextField * txtUserName      = (UITextField*)[viewTop viewWithTag:888];
    [txtUserName resignFirstResponder];
    if (txtUserName.text.length==0) {
        [self HUDShow:@"请输入手机号" delay:1.5];
        return;
    }

    if ( timerSencond != -100 ) {   //  -- 说明这个时候还没到60秒
        return;
    } else{
        timerSencond = 120;
    }
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:txtUserName.text forKey:@"Account"];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_SendAuthCodeForRegister class:@"ResponseBase" params:dicParams  isShowLoadingAnimal:NO hudShow:@"验证码发送中"];
    
    [[APIMethodHandle shareAPIMethodHandle] goApiRequestSendAuthCode:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"验证码发送中" delegate:self];
    
    
}

- (void) onShowPwdClick:(id) sender{
    
}

#pragma mark    --  api 请求 加调
-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    if ([ApiName isEqualToString:kApiMethod_SendAuthCodeForRegister]) {
        
        [self HUDShow:@"发送成功" delay:1.5 dothing:YES];
        
        hadSendCode = YES;
    }
    else if([ApiName isEqualToString:kApiMethod_CheckAuthCode]){
        UITextField * txtUserName      = (UITextField*)[viewTop viewWithTag:888];
        UITextField * txtAuthCode      = (UITextField*)[viewSecond viewWithTag:999];
        [self pushNewViewController:@"ReSetLoginPwdViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                     txtUserName.text,@"param_userCount",
                                     txtAuthCode.text,@"param_AuthCode", nil]];
    }
}


#pragma mark    --  common txt
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
    
//    txtBackView.layer.borderWidth = 1;
//    txtBackView.layer.borderColor = [UIColor blackColor].CGColor;
//    txtBackView.layer.borderColor =  [UIColor convertHexToRGB:@"CBCBCB"].CGColor;
//    txtBackView.layer.borderWidth = 1.0;
//    txtBackView.layer.cornerRadius = 20.0f;
    [_targetView addSubview:txtBackView];
    
    int txt_xPoint = 20;
    if (iconName.length>0) {
        txt_xPoint = 40;
        UIImageView * imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 35, 35)];
        [imgIcon setBackgroundColor:[UIColor clearColor]];
        [imgIcon setImage: [UIImage imageNamed:iconName]];
        [txtBackView addSubview:imgIcon];
    }
    
    UITextField * txtField = [[UITextField alloc] initWithFrame:CGRectMake(txt_xPoint, 0, cgFrame.size.width-55, 35)];
    [txtField setTag: _tag];
    [txtField setBackgroundColor:[UIColor clearColor]];
    [txtField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtField setPlaceholder:place];
    [txtField setDelegate:self];
    [txtField setKeyboardType:boardType];
    [txtField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtField setSecureTextEntry:b_isEntry];
    [txtField setTextColor:[UIColor convertHexToRGB:@"575757"]];
    [txtField setFont:defFont15];
    [txtBackView addSubview:txtField];
    
    if (b_show) {
        [txtField setFrame:CGRectMake(txtField.frame.origin.x, txtField.frame.origin.y, txtField.frame.size.width-25, txtField.frame.size.height)];
        
//        txtField.layer.borderWidth = 1;
//        txtField.layer.borderColor = [UIColor blackColor].CGColor;
        
        UIButton * btn_showPwd = [[UIButton alloc] initWithFrame:CGRectMake(cgFrame.size.width-50, 0, 50, cgFrame.size.height)];
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

@end
