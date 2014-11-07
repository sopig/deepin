//
//  BQTelephoneCheckViewController.m
//  boqiimall
//
//  Created by 张正超 on 14-8-11.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQTelephoneCheckViewController.h"
#import "BQGetAuthCodeButton.h"
#import "BQCustomBarButtonItem.h"
#import "BQPayPasswordCheckViewController.h"

@interface BQTelephoneCheckViewController ()
{
    UITextField *authTextFiled;  //验证码输入框
    UITextField *telephoneTextField;//手机号输入
    BQGetAuthCodeButton *getCodeButton;
    int    timerSencond;//定时器控制变量
    BOOL hadSendCode;
}
@end

@implementation BQTelephoneCheckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}





- (void)loadUIWithState:(UISTATE)state
{
    NSString *title = @"";
    self.view.backgroundColor = color_body;
    
    
    UIView *textBgView1 = [[UIView alloc]initWithFrame:CGRectMake(10, 12+kNavBarViewHeight, 300, 50)];
    textBgView1.layer.cornerRadius = 5.0f;
    textBgView1.layer.borderColor = color_dedede.CGColor;
    textBgView1.layer.borderWidth = 0.5;
    textBgView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textBgView1];
    
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    iconImageView.image = [UIImage imageNamed:@"phone_icon.png"];
    [textBgView1 addSubview:iconImageView];

    if (state == isHasCheckToModify || state == isHasNoMobileToBind) {
        
         title = @"绑定手机";
         self.title = title;
        [self setTitle:title];
        telephoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(51, 5, 200, 40)];
        telephoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        telephoneTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        telephoneTextField.layer.cornerRadius = 3.0f;
        telephoneTextField.placeholder = @"输入手机号";
        telephoneTextField.font = defFont14;
        telephoneTextField.textColor = [UIColor convertHexToRGB:@"dbdbdb"];
        [textBgView1 addSubview:telephoneTextField];
    }
    else if (state == isHasMobileToCheck){
        title = @"安全验证";
        self.title = title;
        [self setTitle:title];
        NSRange range;
        range.location = 3;
        range.length = 4;
        NSString *telNumString = [[UserUnit shareLogin].m_userMobile stringByReplacingCharactersInRange:range withString:@" **** "];
        UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(51, 5, 200, 40)];
        phoneLabel.text = telNumString;
        phoneLabel.layer.cornerRadius = 3.0f;
        phoneLabel.font = defFont14;
        
        phoneLabel.textColor = [UIColor blackColor];
        
        [textBgView1 addSubview:phoneLabel];
    }
    
    
    UIView *textBgView2 = [[UIView alloc]initWithFrame:CGRectMake(10, 74+kNavBarViewHeight, 300, 50)];
    textBgView2.layer.cornerRadius = 5.0f;
    textBgView2.layer.borderColor = color_dedede.CGColor;
    textBgView2.layer.borderWidth = 0.5;
    textBgView2.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:textBgView2];
    
    authTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(12, 5, 260 - 150, 40)];

//    authTextFiled.layer.borderColor = [UIColor redColor].CGColor;
//    authTextFiled.layer.borderWidth = 1;
    
    authTextFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    authTextFiled.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    authTextFiled.layer.cornerRadius = 3.0f;
    authTextFiled.placeholder = @" 输入验证码";
    authTextFiled.font = defFont14;  
    authTextFiled.textColor = [UIColor convertHexToRGB:@"dbdbdb"];
    
    [textBgView2 addSubview:authTextFiled];
    
    
    getCodeButton = [[BQGetAuthCodeButton alloc]initWithFrame:CGRectMake(300 - 150, 0, 150, 50)];
    
    if (state == isHasMobileToCheck) {
        [getCodeButton addTarget:self action:@selector(onGetCodeClickforCheck:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (state == isHasNoMobileToBind) {
        [getCodeButton addTarget:self action:@selector(onGetCodeClickforBind:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (state == isHasCheckToModify)
    {
        [getCodeButton addTarget:self action:@selector(onGetCodeClickforModifyTelephone:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [textBgView2 addSubview:getCodeButton];
    
    
    NSString *checkButtonTitle = @"";
    UIButton *checkAuthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (state == isHasMobileToCheck) {
        [checkAuthButton addTarget:self action:@selector(checkAuth:) forControlEvents:UIControlEventTouchUpInside];
        checkButtonTitle = @"验 证";
    }
    else if (state == isHasCheckToModify ){
        [checkAuthButton addTarget:self action:@selector(modifyBindTelephone:) forControlEvents:UIControlEventTouchUpInside];
         checkButtonTitle = @"完成绑定";
    }
    else if (state == isHasNoMobileToBind){
        [checkAuthButton addTarget:self action:@selector(bindTelephone:) forControlEvents:UIControlEventTouchUpInside];
        checkButtonTitle = @"完成绑定";
    
    }
    
    checkAuthButton.frame = CGRectMake(10, 136+kNavBarViewHeight, 300, 50);
    [checkAuthButton setBackgroundColor:color_fc4a00];
    [checkAuthButton setTitle:checkButtonTitle forState:UIControlStateNormal];
    [checkAuthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkAuthButton.titleLabel.font = defFont(NO, 16);
    checkAuthButton.layer.cornerRadius = 3.0f;
    [self.view addSubview:checkAuthButton];

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(handleTimer:) userInfo:nil repeats: YES];
    
    
    
    if (state == isHasMobileToCheck) {
        NSString *payPasswordString = @"通过支付密码验证";
        CGSize defSize = CGSizeMake(300, 40);
        CGSize itemSize = [payPasswordString sizeWithFont:defFont14 constrainedToSize:defSize lineBreakMode:NSLineBreakByWordWrapping];

        BQCustomBarButtonItem *payPassWordCheckItem = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(320/2 - itemSize.width/2, 188+kNavBarViewHeight, itemSize.width, 40)];
        payPassWordCheckItem.titleLabel.text = payPasswordString;
        payPassWordCheckItem.titleLabel.textColor = color_989898;
        payPassWordCheckItem.titleLabel.font = defFont14;
        payPassWordCheckItem.titleRect = CGRectMake(0, 0, itemSize.width, 40);
        //    payPassWordCheckItem.layer.borderColor = [UIColor blackColor].CGColor;
        //    payPassWordCheckItem.layer.borderWidth = 1;
        payPassWordCheckItem.Color = [UIColor clearColor];
        payPassWordCheckItem.delegate = self;
        payPassWordCheckItem.selector = @selector(payPasswordCheckClick:);
        
        [self.view addSubview:payPassWordCheckItem];

    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _businessState =  [[self.receivedParams objectForKey:@"businessState"] integerValue];
    
    if ([[UserUnit userMobile] isEqualToString:@""]) {
        [self loadUIWithState:isHasNoMobileToBind];
    }
    else{
        [self loadUIWithState:isHasMobileToCheck];
    }

    timerSencond = -100;
    hadSendCode = NO;
   
   
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recvNotification:) name:@"BQTelephoneCheckViewController" object:nil];

}

-(void)loadNavBarView
{
    [super loadNavBarView];
}

//- (void)loadNavBarView:(NSString *)title
//{
//    [self loadNavBarView];
//    [self setTitle:title];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self resignKeyBoard];

    //验证验证码
    ResponseBase *backObject = [[ResponseBase alloc] initWithDic:retObj];
    if ([ApiName isEqualToString:kApiMethod_CheckAuthCode]) {
        
           [self HUDShow:backObject.ResponseMsg delay:1.5];
            [self checkToNextStep];
    }

    if ([ApiName isEqualToString:kApiMethod_SendAuthCodeForRegister]) {
     
           [self HUDShow:backObject.ResponseMsg delay:1.5];
            hadSendCode = YES;
    }

    if ([ApiName isEqualToString:kApiMethod_BindTelephone] || [ApiName isEqualToString:kApiMethod_ModifyBindTelephone]) {
  
        [self HUDShow:backObject.ResponseMsg delay:1.5];
        [UserUnit writeTelephoneNum:telephoneTextField.text];

        [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:2];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshUserInfo" object:nil]; //通知刷新个人信息页
    }
}


-(void) interfaceExcuteError:(NSError*)error apiName:(NSString*)ApiName{
    
    [super interfaceExcuteError:error apiName:ApiName];
    [self resignKeyBoard];
    
//    NSString * warnMsg = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
//    if (warnMsg.length>30) {
//      
//        [self HUDShow:@"服务器出错 请稍后重试" delay:kShowMsgAfterDelay];
//        return;
//    }
//    
//    if ([ApiName isEqualToString:kApiMethod_SendAuthCodeForRegister]) {
//   
//        [self HUDShow:warnMsg.length==0 ? @"系统错误" :warnMsg delay:kShowMsgAfterDelay];
//              hadSendCode = NO;
//    }
//    
//    if ([ApiName isEqualToString:kApiMethod_CheckAuthCode]) {
//
//        [self HUDShow:warnMsg.length==0 ? @"系统错误" :warnMsg delay:kShowMsgAfterDelay];
//        
//    }
//    
//    if ([ApiName isEqualToString:kApiMethod_ModifyBindTelephone] || [ApiName isEqualToString:kApiMethod_BindTelephone]) {
//  
//        [self HUDShow:warnMsg.length==0 ? @"系统错误" :warnMsg delay:kShowMsgAfterDelay];
////        [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:kShowMsgAfterDelay];
//    }
    
    
}



#pragma mark - 

- (void)checkToNextStep{

    if (_businessState == authCodeHasCheckToModifyTelePhoneNum) {
        timerSencond = -100;
        [self refreshUIforState:isHasCheckToModify];
    }
    else if (_businessState == authCodeHasCheckToSetPayPassword){
        timerSencond = -100;
        NSMutableDictionary *dictPara = [NSMutableDictionary dictionary];
        [dictPara setValue:[NSNumber numberWithInt:isSetPayPassword] forKey:@"UISTATE"];
        [self pushNewViewController:@"BQPayPasswordCheckViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:dictPara];
        
    }
}


- (void) handleTimer: (NSTimer *) timer{
    
    if (timerSencond>0) {
        timerSencond--;
        [getCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重新获取",timerSencond] forState:UIControlStateNormal];
        [getCodeButton setBackgroundImage:def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5) forState:UIControlStateNormal];
        if (timerSencond==0) {
            timerSencond = -100;
        }
    }
    else if( timerSencond == -100){
        [getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [getCodeButton setBackgroundImage:def_ImgStretchable(@"test_get_code_bg.png", 5, 5) forState:UIControlStateNormal];
    }
}

#pragma mark - 获得已有手机号安全验证码
- (void) onGetCodeClickforCheck:(id) sender{
    
    if ( timerSencond != -100 ) {   //  -- 说明这个时候还没到60秒
        return;
    }
    
    timerSencond = 120;
    
    [getCodeButton setBackgroundImage:def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5) forState:UIControlStateNormal];
    
    NSMutableDictionary * dicParams = [self prepareParamsForAuthCodeWith:modifyBindTelephoneCode isNeedAuthCode:NO isTextField:NO];
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_SendAuthCodeForRegister class:@"ResponseBase"
//              params:dicParams  isShowLoadingAnimal:NO  hudShow:@"正在获取"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestSendAuthCode:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在获取" delegate:self];
}


#pragma mark - 获得需要绑定的手机号验证码
- (void) onGetCodeClickforBind:(id) sender{
    
    if ( timerSencond != -100 ) {   //  -- 说明这个时候还没到60秒
        return;
    }
    if ( telephoneTextField.text.length == 0) {
        [self HUDShow:@"请输入手机号" delay:1];
        return;
    }
    if (telephoneTextField.text.length != 11) {
        [self HUDShow:@"请输入正确的手机号" delay:1];
        return;
    }
    timerSencond = 120;
    [getCodeButton setBackgroundImage:def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5) forState:UIControlStateNormal];
    
    
    NSMutableDictionary * dicParams = [self prepareParamsForAuthCodeWith:bindTelePhoneCode isNeedAuthCode:NO isTextField:NO];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_SendAuthCodeForRegister class:@"ResponseBase"
//              params:dicParams  isShowLoadingAnimal:NO hudShow:@"正在获取"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestSendAuthCode:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在获取" delegate:self];
}

#pragma mark -
- (void) onGetCodeClickforModifyTelephone:(id) sender{
    
    if ( timerSencond != -100 ) {   //  -- 说明这个时候还没到60秒
        return;
    }
    if ( telephoneTextField.text.length == 0) {
        [self HUDShow:@"请输入手机号" delay:1];
        return;
    }
    if (telephoneTextField.text.length != 11) {
        [self HUDShow:@"请输入正确的手机号" delay:1];
        return;
    }
    timerSencond = 120;
    [getCodeButton setBackgroundImage:def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5) forState:UIControlStateNormal];
    
    
    NSMutableDictionary * dicParams = [self prepareParamsForAuthCodeWith:modifyBindTelephoneCode isNeedAuthCode:NO isTextField:YES];
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_SendAuthCodeForRegister class:@"ResponseBase"
//              params:dicParams isShowLoadingAnimal:NO hudShow:@"正在获取"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestSendAuthCode:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在获取" delegate:self];

}


#pragma mark -
- (void)payPasswordCheckClick:(id)sender{
    
    if ([UserUnit userHasPayPassword] == 0) {
        [self HUDShow:@"支付密码还未设置,请先设置支付密码" delay:2];
        return;
    }
    else{
        
        [self toCheckPayPassWord];
    }
}


- (void)toCheckPayPassWord{
      [self pushNewViewController:@"BQPayPasswordCheckViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:[self prepareDictParam:isCheckPayPassword]];
}

- (NSMutableDictionary*)prepareDictParam:(PAYUISTATE)state{
    NSMutableDictionary *dictPara = [NSMutableDictionary dictionary];
    [dictPara setValue:[NSNumber numberWithInt:state] forKey:@"UISTATE"];
    
    [dictPara setValue:[NSNumber numberWithInt:_businessState] forKey:@"businessState"];
    
    return [dictPara mutableCopy];
}

#pragma mark -  验证按钮 验证原有手机号收到的验证码是否正确

- (void)checkAuth:(id)sender{
    
    if (authTextFiled.text.length == 0) {
        [self HUDShow:@"请输入验证码" delay:1];
        return;
    }
    NSMutableDictionary * dicParams = [self prepareParamsForAuthCodeWith:modifyBindTelephoneCode isNeedAuthCode:YES isTextField:NO] ;
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_CheckAuthCode class:@"ResponseBase"
//              params:dicParams  isShowLoadingAnimal:NO hudShow:@"正在验证"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestCheckAuthCode:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在验证" delegate:self];
    
}

#pragma mark -
- (void)modifyBindTelephone:(id)sender{
    
    if (authTextFiled.text.length == 0) {
        [self HUDShow:@"请输入验证码" delay:1];
        return;
    }
    
    NSMutableDictionary * dicParams = [self prepareParamsForBindTelephone] ;

//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_ModifyBindTelephone class:@"ResponseBase"
//              params:dicParams isShowLoadingAnimal:NO hudShow:@"正在绑定"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestModifyBindTelephone:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在绑定" delegate:self];
    
    
}

#pragma mark -

- (void)bindTelephone:(id)sender{
    
    if (authTextFiled.text.length == 0) {
        [self HUDShow:@"请输入验证码" delay:1];
        return;
    }
    NSMutableDictionary * dicParams = [self prepareParamsForBindTelephone];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_BindTelephone class:@"ResponseBase"
//              params:dicParams isShowLoadingAnimal:NO hudShow:@"正在绑定"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestBindTelephone:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在绑定" delegate:self];
    
}


#pragma mark - 

- (NSMutableDictionary*)prepareParamsForAuthCodeWith:(SendAuthCode)code isNeedAuthCode:(BOOL)isNeed isTextField:(BOOL)isText
{
    
    NSMutableDictionary * dicParams = [NSMutableDictionary dictionary] ;
    
    NSString *typeString = @"";
    NSString *accountString = @"";

    if (code == bindTelePhoneCode) {
        typeString = @"1";
        accountString = telephoneTextField.text;
    }
    else if (code == modifyBindTelephoneCode){
        typeString = @"2";
        
        if (isText) {
             accountString = telephoneTextField.text;
        }
        else if (!isText){
          accountString = [UserUnit userMobile];
        }
    }
    else if (code == modifyPayPasswordCode){
        typeString = @"3";
        accountString = [UserUnit userMobile];
    }
    
    [dicParams setValue:accountString forKey:@"Account"];
    [dicParams setValue:typeString forKey:@"Type"];
    if (isNeed) {
        [dicParams setValue:authTextFiled.text forKey:@"AuthCode"];
    }
    return [dicParams mutableCopy];
}

#pragma mark -
- (NSMutableDictionary*)prepareParamsForBindTelephone
{
    
    NSMutableDictionary * dicParams = [NSMutableDictionary dictionary] ;

    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:telephoneTextField.text forKey:@"Telephone"];
    [dicParams setValue:authTextFiled.text forKey:@"AuthCode"];
    
    return [dicParams mutableCopy];
}



#pragma mark -
- (void)refreshUIforState:(UISTATE)uiState
{
    for (int i = 0; i < self.view.subviews.count; i++) {
        UIView *view = [self.view.subviews objectAtIndex:i];
        [view removeFromSuperview];
    }
    
    for (UIView *view in self.navBarView.subviews)
    {
        [view removeFromSuperview];
    }
    
    
    [self loadNavBarView];
    [self loadUIWithState:uiState];
}


- (void)recvNotification:(NSNotification *)notification{
    if ([notification.name isEqualToString:@"BQTelephoneCheckViewController"]) {
        UISTATE state = (UISTATE) [notification.object intValue];
        [self refreshUIforState:state];
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
  [self resignKeyBoard];
}

- (void)resignKeyBoard{
    [telephoneTextField resignFirstResponder];
    [authTextFiled resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
