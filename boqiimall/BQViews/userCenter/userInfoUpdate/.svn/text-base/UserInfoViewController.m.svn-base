//
//  UserInfoViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-14.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "UserInfoViewController.h"
#import "BQTelephoneCheckViewController.h"
#import "BQCustomBarButtonItem.h"
#import "BQWithDrawsCashViewController.h"

#define heightRow   50
#define TagNickNameLabel    9000
#define TagSexLabel         9001
#define TagPhoneNumberLabel 9002
#define TagPassWordLabel    9003
#define TagUserBalanceLabel 9004

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUserInfo];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self loadNavBarView];
    self.title = @"个人资料";
    [self.view setBackgroundColor:color_body];
    
   // [self loadNavBarView:@"个人资料"];
    
    rootScrollView = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:rootScrollView];
    
    UIView * viewContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightRow*6)];
    [viewContent setBackgroundColor:[UIColor whiteColor]];
    [rootScrollView addSubview:viewContent];
    
    
    /********************账户****************************************/
    UILabel * lbl_zf = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, heightRow)];
    [lbl_zf setBackgroundColor:[UIColor clearColor]];
    [lbl_zf setText:@"账户"];
    [lbl_zf setFont:defFont15];
    [lbl_zf setTextColor:color_717171];
    [viewContent addSubview:lbl_zf];
    
    UILabel * lbl_UserName = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 150, heightRow)];
    [lbl_UserName setBackgroundColor:[UIColor clearColor]];
    [lbl_UserName setText: [UserUnit userName]];
    [lbl_UserName setFont:defFont15];
    [lbl_UserName setTextColor:color_989898];
    [lbl_UserName setTextAlignment:NSTextAlignmentRight];
    [viewContent addSubview:lbl_UserName];
    [UICommon Common_line:CGRectMake(0, heightRow-0.5, __MainScreen_Width, 0.5) targetView:viewContent backColor:color_d1d1d1];
    /********************昵称****************************************/
    UILabel * lbl_nc = [[UILabel alloc] initWithFrame:CGRectMake(10, heightRow, 150, heightRow)];
    [lbl_nc setBackgroundColor:[UIColor clearColor]];
    [lbl_nc setText:@"昵称"];
    [lbl_nc setFont:defFont15];
    [lbl_nc setTextColor:color_717171];
    [viewContent addSubview:lbl_nc];
    
    UIButton *btn_nc = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_nc.frame = CGRectMake(10,heightRow, self.view.frame.size.width, heightRow);
    [btn_nc addTarget:self action:@selector(onModifyNicknameClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewContent addSubview:btn_nc];
    
    UILabel * lbl_nickName = [[UILabel alloc] initWithFrame:CGRectMake(140, heightRow, 150, heightRow)];
    lbl_nickName.tag = TagNickNameLabel;
    [lbl_nickName setBackgroundColor:[UIColor clearColor]];
    [lbl_nickName setText: [UserUnit userNick]];
    [lbl_nickName setFont:defFont15];
    [lbl_nickName setTextColor:color_989898];
    [lbl_nickName setTextAlignment:NSTextAlignmentRight];
    [viewContent addSubview:lbl_nickName];
    
    UIImageView *imageView_nc = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn_nc.frame)-40,17,15,15)];
    imageView_nc.image = [UIImage imageNamed:@"right_icon.png"];
    [btn_nc addSubview:imageView_nc];
    [UICommon Common_line:CGRectMake(0, heightRow*2-0.5, __MainScreen_Width, 0.5) targetView:viewContent backColor:color_d1d1d1];
    
    /********************性别****************************************/
    UILabel * lbl_xb = [[UILabel alloc] initWithFrame:CGRectMake(10, heightRow*2, 150, heightRow)];
    [lbl_xb setBackgroundColor:[UIColor clearColor]];
    [lbl_xb setText:@"性别"];
    [lbl_xb setFont:defFont15];
    [lbl_xb setTextColor:color_717171];
    [viewContent addSubview:lbl_xb];
    
    UIButton *btn_xb = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_xb.frame = CGRectMake(10,heightRow*2, self.view.frame.size.width, heightRow);
    [btn_xb addTarget:self action:@selector(onModifySexClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewContent addSubview:btn_xb];
    
    UILabel * lbl_sex = [[UILabel alloc] initWithFrame:CGRectMake(140, heightRow*2, 150, heightRow)];
    lbl_sex.tag = TagSexLabel;
    [lbl_sex setBackgroundColor:[UIColor clearColor]];
//    [UserUnit saveUserSex:isex==1?@"男":@"女"];

    [lbl_sex setText:@"男"];
    [lbl_sex setFont:defFont15];
    [lbl_sex setTextColor:color_989898];
    [lbl_sex setTextAlignment:NSTextAlignmentRight];
    
    UIImageView *imageView_sex = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn_xb.frame)-40,17,15,15)];
    imageView_sex.image = [UIImage imageNamed:@"right_icon.png"];
    [btn_xb addSubview:imageView_sex];
    
    [viewContent addSubview:lbl_sex];
    [UICommon Common_line:CGRectMake(0, heightRow*3-0.5, __MainScreen_Width, 0.5) targetView:viewContent backColor:color_d1d1d1];
    
    /********************手机号****************************************/
    
    UILabel * lbl_sjh = [[UILabel alloc] initWithFrame:CGRectMake(10, heightRow*3, 150, heightRow)];
    [lbl_sjh setBackgroundColor:[UIColor clearColor]];
    [lbl_sjh setText:@"手机号"];
    [lbl_sjh setFont:defFont15];
    [lbl_sjh setTextColor:color_717171];
    [viewContent addSubview:lbl_sjh];

    //  --18712345678
    UILabel * lbl_tel = [[UILabel alloc] initWithFrame:CGRectMake(140, heightRow*3, 150, heightRow)];
    lbl_tel.tag = TagPhoneNumberLabel;
    [lbl_tel setBackgroundColor:[UIColor clearColor]];
    [lbl_tel setText: [UserUnit userMobile].length==0 ? @"未绑定": [NSString stringWithFormat:@"%@ **** %@",
                                                                 [[UserUnit userMobile] substringWithRange:NSMakeRange(0, 3)],
                                                                 [[UserUnit userMobile] substringFromIndex:7]]];
    [lbl_tel setFont:defFont15];
    [lbl_tel setTextColor:color_989898];
    [lbl_tel setTextAlignment:NSTextAlignmentRight];
    [viewContent addSubview:lbl_tel];
    
    
    UIButton *btn_tel = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_tel.frame = CGRectMake(10,heightRow*3, self.view.frame.size.width, heightRow);
    [btn_tel addTarget:self action:@selector(onModifyTelClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewContent addSubview:btn_tel];
    
    
    UIImageView *imageView_tel = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn_tel.frame)-40,17,15,15)];
    imageView_tel.image = [UIImage imageNamed:@"right_icon.png"];
    [btn_tel addSubview:imageView_tel];
    [UICommon Common_line:CGRectMake(0, heightRow*4-0.5, __MainScreen_Width, 0.5) targetView:viewContent backColor:color_d1d1d1];
    
    /********************支付密码****************************************/
    UILabel * lbl_pwt = [[UILabel alloc] initWithFrame:CGRectMake(10, heightRow*4, 150, heightRow)];
    [lbl_pwt setBackgroundColor:[UIColor clearColor]];
    [lbl_pwt setText:@"支付密码"];
    [lbl_pwt setFont:defFont15];
    [lbl_pwt setTextColor:color_717171];
    [viewContent addSubview:lbl_pwt];
    
    //  --18712345678
    UILabel * lbl_pw = [[UILabel alloc] initWithFrame:CGRectMake(140, heightRow*4, 150, heightRow)];
    lbl_pw.tag = TagPassWordLabel;
    [lbl_pw setBackgroundColor:[UIColor clearColor]];
    [lbl_pw setText: [UserUnit userMobile].length==0 ? @"未绑定":@"已绑定"];
    [lbl_pw setFont:defFont15];
    [lbl_pw setTextColor:color_989898];
    [lbl_pw setTextAlignment:NSTextAlignmentRight];
    [viewContent addSubview:lbl_pw];
    
    UIButton *btn_paypwd = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_paypwd.frame = CGRectMake(10,heightRow*4, self.view.frame.size.width, heightRow);
    [btn_paypwd addTarget:self action:@selector(onModifyPayPwdClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewContent addSubview:btn_paypwd];
    
    UIImageView *imageView_pw = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn_paypwd.frame)-40,17,15,15)];
    imageView_pw.image = [UIImage imageNamed:@"right_icon.png"];
    [btn_paypwd addSubview:imageView_pw];
    [UICommon Common_line:CGRectMake(0, heightRow*5-0.5, __MainScreen_Width, 0.5) targetView:viewContent backColor:color_d1d1d1];
    
    
    /********************我的余额****************************************/
    
    BQCustomBarButtonItem *balanceItem = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(10, heightRow*5, self.view.frame.size.width , heightRow)];
    balanceItem.titleRect = CGRectMake(0, 0, 150, heightRow);
    balanceItem.titleLabel.text = @"我的余额";
    balanceItem.titleLabel.textColor = color_717171;
    balanceItem.titleLabel.font = defFont15;
    balanceItem.titleLabel.textAlignment = NSTextAlignmentLeft;
    [viewContent addSubview:balanceItem];
    balanceItem.delegate = self;
    balanceItem.selector = @selector(withdrawsCash:);
    
    
    UILabel *balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, heightRow*5, 150, heightRow)];
    balanceLabel.textColor = color_fc4a00;
    balanceLabel.textAlignment = NSTextAlignmentRight;
    balanceLabel.font = defFont17;
    balanceLabel.text = [ NSString stringWithFormat:@"%@ 元",[UserUnit userBalance]];
    balanceLabel.tag = TagUserBalanceLabel;
    [viewContent addSubview:balanceLabel];
    
    
    
    UIImageView *imageView_balance = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(balanceItem.frame)-40,17,15,15)];
    imageView_balance.image = [UIImage imageNamed:@"right_icon.png"];
    [balanceItem addSubview:imageView_balance];
    [UICommon Common_line:CGRectMake(0, heightRow*6-0.5, __MainScreen_Width, 0.5) targetView:viewContent backColor:color_d1d1d1];
    
    
    
    /********************注销当前账号****************************************/
    UIButton * btn_quit = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_quit setFrame:CGRectMake(8, viewContent.frame.size.height+15, def_WidthArea(8), 50)];
    [btn_quit setBackgroundColor:color_fc4a00];
    [btn_quit setTitle:@"注销当前账号" forState:UIControlStateNormal];
    [btn_quit.titleLabel setFont:defFont15];
    [btn_quit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_quit addTarget:self action:@selector(onButton_QuitClick:) forControlEvents:UIControlEventTouchUpInside];
    btn_quit.layer.cornerRadius = 3.0f;
    [rootScrollView addSubview:btn_quit];
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshUI) name:@"refreshUserInfo" object:nil];
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

- (void)setUserInfo{
    UILabel * lbl_nickname = (UILabel*)[self.view viewWithTag:TagNickNameLabel];
    UILabel * lbl_sex = (UILabel*)[self.view viewWithTag:TagSexLabel];
    UILabel * lbl_PhoneNum = (UILabel*)[self.view viewWithTag:TagPhoneNumberLabel];
    UILabel * lbl_Password = (UILabel*)[self.view viewWithTag:TagPassWordLabel];
    UILabel * lbl_Balance = (UILabel*)[self.view viewWithTag:TagUserBalanceLabel];

    
    lbl_nickname.text = [UserUnit userNick];
    lbl_sex.text = [UserUnit userSex];
    lbl_PhoneNum.text = [UserUnit userMobile].length==0 ? @"未绑定": [NSString stringWithFormat:@"%@ **** %@",
                                                                   [[UserUnit userMobile] substringWithRange:NSMakeRange(0, 3)],
                                                                   [[UserUnit userMobile] substringFromIndex:7]];
    lbl_Password.text = [UserUnit userHasPayPassword]?@"已设置":@"未设置";
    lbl_Balance.text = [ NSString stringWithFormat:@"%@ 元",[UserUnit userBalance]];;
//    NSLog(@"%@",[UserUnit userBalance]);
    
}

//  --  注销
- (void)onButton_QuitClick:(id) sender{
    [MobClick event:@"myBoqii_userInformation_loginOff"];
    [UserUnit logoutSuccess];
    [self HUDShow:@"注销成功" delay:1.5 dothing:YES];
}

-(void)HUDdelayDo {
    [self goBack:nil];
}

#pragma mark - 跳转修改昵称界面
- (void)onModifyNicknameClick:(UIButton*) sender
{
    [self pushNewViewController:@"ResetUserNickNameVC" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
}
- (void)onModifySexClick:(UIButton*) sender
{
    IBActionSheet *Sex_ActionSheet = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
    [Sex_ActionSheet setButtonTextColor:[UIColor convertHexToRGB:@"383838"]];
    [Sex_ActionSheet setButtonTextColor:[UIColor convertHexToRGB:@"989898"] forButtonAtIndex:2];
    [Sex_ActionSheet setFont:[UIFont systemFontOfSize:15] forButtonAtIndex:2];
    [Sex_ActionSheet showInView:self.view];
//    NSMutableDictionary
}


- (NSMutableDictionary*)prepareParamDict:(TeleBusinessState)state{
    
    NSMutableDictionary *dictPara = [NSMutableDictionary dictionary];
    
    if (state == authCodeHasCheckToSetPayPassword) {
       [dictPara setValue:[NSNumber numberWithInt:authCodeHasCheckToSetPayPassword] forKey:@"businessState"];
    }
    else if (state == authCodeHasCheckToModifyTelePhoneNum){
        [dictPara setValue:[NSNumber numberWithInt:authCodeHasCheckToModifyTelePhoneNum] forKey:@"businessState"];
    }
    
    return [dictPara mutableCopy];
}


- (void)onModifyTelClick:(UIButton*) sender
{
     [self pushNewViewController:@"BQTelephoneCheckViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:[self prepareParamDict:authCodeHasCheckToModifyTelePhoneNum]];
}


- (void)onModifyPayPwdClick:(UIButton*) sender{
    
    if (![NSString isPhoneNum:[UserUnit userMobile]]) {
        [self HUDShow:@"请首先绑定手机号" delay:1];
    }
    else{
        [self pushNewViewController:@"BQTelephoneCheckViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:
        [self prepareParamDict:authCodeHasCheckToSetPayPassword]];
    }
}

- (void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    NSLog(@"Button at index: %d clicked\nIt's title is '%@'", buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    NSString * btnTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (![btnTitle isEqualToString:@"取消"]) {
        isex = buttonIndex+1;
        [self goApiRequest_ModifySex:[NSString stringWithFormat:@"%d",buttonIndex+1]];
    }
}


//提现操作
- (void)withdrawsCash:(id)sender{

    [MobClick event:@"myBoqii_userInformation_balanceOfAccount"];
    
    if (![NSString isPhoneNum:[UserUnit userMobile]]) {
        [self HUDShow:@"请先绑定手机号后使用" delay:1];
        return;
    }
    
    if (![UserUnit userHasPayPassword]) {
        [self HUDShow:@"请先设置支付密码后使用" delay: 1];
        return;
    }
    
    if ([[UserUnit userBalance]floatValue] == 0.0f) {
        [self HUDShow:@"您的余额为0，暂不能提现！" delay:1];
        return;
    }
    
    [self pushNewViewController:@"BQWithDrawsCashViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
}


#pragma mark    --  api 请 求 & 回 调.
-(void)goApiRequest_ModifySex:(NSString *) sex{
    NSMutableDictionary * param  = [[NSMutableDictionary alloc] initWithCapacity:2];
    [param setValue:[UserUnit userId] forKey:@"UserId"];
    [param setValue:sex forKey:@"Sex"];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_ModifySex class:@"ResponseBase"
//              params:param isShowLoadingAnimal:NO hudShow:@"正在修改"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestModifySex:param ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在修改" delegate:self];
    
    
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_ModifySex]) {
        [self HUDShow:@"修改成功" delay:2];
        [UserUnit saveUserSex:isex==1?@"男":@"女"];
        [self setUserInfo];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)refreshUI{
    for (int i = 0; i < self.view.subviews.count; i++) {
        UIView *view = [self.view.subviews objectAtIndex:i];
        [view removeFromSuperview];
    }
    [self viewDidLoad];
}

@end
