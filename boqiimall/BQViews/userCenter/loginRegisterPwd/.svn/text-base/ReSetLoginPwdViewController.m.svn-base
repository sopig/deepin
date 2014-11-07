//
//  ReSetLoginPwdViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-22.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "ReSetLoginPwdViewController.h"
#import "ResponseBase.h"

#define HeightTopView 50
#define rowHeight   40

@implementation ReSetLoginPwdViewController
@synthesize param_userCount;
@synthesize param_AuthCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isShowTxtPwd = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"找回密码"];
    [self.view setBackgroundColor:color_body];
  //  [self loadNavBarView:@"找回密码"];
    
    self.param_userCount = [self.receivedParams objectForKey:@"param_userCount"];
    self.param_AuthCode = [self.receivedParams objectForKey:@"param_AuthCode"];
    
    rootScrollView = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:rootScrollView];
    
    viewTop = [[UIView alloc] initWithFrame:CGRectMake(12, 12, __MainScreen_Width - 12*2, HeightTopView)];
    [viewTop setBackgroundColor:[UIColor whiteColor]];
    [rootScrollView addSubview:viewTop];
    
    viewTop.layer.borderColor = [UIColor convertHexToRGB:@"dbdbdb"].CGColor;
    viewTop.layer.borderWidth = 0.5;
    
//    viewTop.layer.borderColor = [UIColor blackColor].CGColor;
//    viewTop.layer.borderWidth = 1;
    
    //  -- 手机账号
//    [UICommon Common_UILabel_Add:CGRectMake(10, 8, def_WidthArea(8), 30) targetView:viewTop bgColor:[UIColor clearColor] tag:888 text:@"请输入您的密码:" align:-1 isBold:NO fontSize:16 tColor:color_4e4e4e];
//    
//    [UICommon Common_line:CGRectMake(0, rowHeight+5 , __MainScreen_Width, 1) targetView:viewTop backColor:[UIColor convertHexToRGB:@"F6F6F6"]];
    
    //  -- 输入验证码框.
    [self addCommonTextView: CGRectMake(5, 5, def_WidthArea(15), rowHeight)
                 targetView: viewTop
            securetextEntry: YES
                txtFieldTag: 999
               keyBoardType: UIKeyboardTypeDefault
                placeHolder: @"6-20位,建议数字、字母、符号组合"
                   lefticon: @"password_icon.png"
              addshowPwdBtn: YES];
    
    btn_okRet = [[UIButton alloc] initWithFrame:CGRectMake(12, HeightTopView+15 +5, def_WidthArea(12), 46)];
    [btn_okRet setBackgroundColor:[UIColor convertHexToRGB:@"fc4a00"]];
    [btn_okRet setTitle:@"确 认" forState:UIControlStateNormal];
    [btn_okRet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn_okRet.layer.cornerRadius = 3.0f;
    [btn_okRet addTarget:self action:@selector(onOkRetClick:) forControlEvents:UIControlEventTouchUpInside];
    [rootScrollView addSubview:btn_okRet];
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

//  -- 可视密码
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

//  -- 设置
- (void) onOkRetClick:(id) sender{

    UITextField * txtNewPwd  = (UITextField*)[viewTop viewWithTag:999];
    [txtNewPwd resignFirstResponder];
    if (txtNewPwd.text.length==0) {
        [self HUDShow:@"请输入您的新密码" delay:2];
        return;
    }
    if (txtNewPwd.text.length<6) {
        [self HUDShow:@"密码最少6位" delay:2];
        return;
    }
    else if(self.param_userCount.length==0){
        [self HUDShow:@"账户不可为空" delay:2];
        return;
    }
    else if(self.param_AuthCode.length==0){
        [self HUDShow:@"验证码不可为空" delay:2];
        return;
    }

    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:self.param_userCount forKey:@"Account"];
    [dicParams setValue:[NSString YKMD5:txtNewPwd.text] forKey:@"Password"];
    [dicParams setValue:self.param_AuthCode forKey:@"Authcode"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestModifyPassword:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在设置" delegate:self];
    
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_ModifyPassword class:@"ResponseBase"
//              params:dicParams isShowLoadingAnimal:NO hudShow:@"正在设置"];
}


#pragma mark    --  api 请求 加调
-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_ModifyPassword]) {
        [self HUDShow:@"重置成功" delay:2 dothing:YES];
    }
}

-(void)HUDdelayDo {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) interfaceExcuteError:(NSError*)error apiName:(NSString*)ApiName{
    
    if ([ApiName isEqualToString:kApiMethod_ModifyPassword]) {

        [super interfaceExcuteError:error apiName:ApiName];
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
    
//    txtBackView.backgroundColor = [UIColor redColor];
//    txtBackView.layer.borderColor =  [UIColor convertHexToRGB:@"CBCBCB"].CGColor;
//    txtBackView.layer.borderWidth = 1.0;
//    txtBackView.layer.cornerRadius = 20.0f;
    [_targetView addSubview:txtBackView];
    
    int txt_xPoint = 20;
    if (iconName.length>0) {
        txt_xPoint = 40;
        UIImageView * imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        [imgIcon setBackgroundColor:[UIColor clearColor]];
        [imgIcon setImage: [UIImage imageNamed:iconName]];
        [txtBackView addSubview:imgIcon];
    }
    
    UITextField * txtField = [[UITextField alloc] initWithFrame:CGRectMake(txt_xPoint, 5, cgFrame.size.width-55, 26)];
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
        [txtField setFrame:CGRectMake(txtField.frame.origin.x, txtField.frame.origin.y, txtField.frame.size.width-25, txtField.frame.size.height)];
        UIButton * btn_showPwd = [[UIButton alloc] initWithFrame:CGRectMake(cgFrame.size.width-50, 0, 50, cgFrame.size.height)];
        [btn_showPwd setBackgroundColor:[UIColor clearColor]];
        [btn_showPwd setImage:[UIImage imageNamed:@"icon-view-unchecked"] forState:UIControlStateNormal];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
