//
//  BQPayPasswordCheckViewController.m
//  boqiimall
//
//  Created by 张正超 on 14-8-11.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQPayPasswordCheckViewController.h"
#import "BQCustomBarButtonItem.h"
#import "BQTelephoneCheckViewController.h"
#import "UserInfoViewController.h"


@interface BQPayPasswordCheckViewController ()<UITextFieldDelegate>
{
    UITextField *passwordTextField;
    BOOL isShowTxtPwd;
}
@end

@implementation BQPayPasswordCheckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    for (int i = 0; i < self.view.subviews.count; i++) {
//        [[self.view.subviews objectAtIndex:i] removeFromSuperview];
//    }
//    UIButton *button = (UIButton*)[self.view viewWithTag:9876];
//    [button removeFromSuperview];
//}

- (void)loadUIforState:(PAYUISTATE)state
{
    
    NSString *title = @"";
    self.view.backgroundColor = color_body;
    
    if (state == isSetPayPassword ||state == isModifyPayPassword) {
        title = @"设置支付密码";
    }
    else if (state == isCheckPayPassword){
        title = @"验证支付密码";
    }
    
   // [self loadNavBarView];
    [self setTitle:title];
   // self.title = title;
    
  //  [self loadNavBarView:title];
    
    UIView *textBgView = [[UIView alloc]initWithFrame:CGRectMake(10, 12+kNavBarViewHeight, 300, 50)];
    textBgView.layer.cornerRadius = 5.0f;
    textBgView.layer.borderColor = color_dedede.CGColor;
    textBgView.layer.borderWidth = 0.5;
    textBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textBgView];
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    iconImageView.image = [UIImage imageNamed:@"password_icon.png"];
    [textBgView addSubview:iconImageView];
    
    
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, 200, 50)];
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    passwordTextField.delegate = self;
    passwordTextField.layer.cornerRadius = 3.0f;
    NSString *placeHold = @"";
    if (state == isSetPayPassword || state == isModifyPayPassword) {
        placeHold = @"设置支付密码";
    }
    else if (state == isCheckPayPassword){
        placeHold = @"密码";
    }
    passwordTextField.placeholder = placeHold;
    passwordTextField.font = defFont14;
    passwordTextField.textColor = [UIColor convertHexToRGB:@"dbdbdb"];
    passwordTextField.secureTextEntry = YES;
    [textBgView addSubview:passwordTextField];
   
    
    UIButton * showPwdButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 5, 40, 40)];
    [showPwdButton setBackgroundColor:[UIColor clearColor]];
    [showPwdButton setImage:[UIImage imageNamed:@"visible_icon.png"] forState:UIControlStateNormal];
    [showPwdButton addTarget:self action:@selector(onShowPwdClick:) forControlEvents:UIControlEventTouchUpInside];
    [textBgView addSubview:showPwdButton];

    if (state == isSetPayPassword || state == isModifyPayPassword)
    {
        UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 64+kNavBarViewHeight, 296, 40)];
        tipsLabel.backgroundColor = [UIColor clearColor];
        tipsLabel.font = defFont14;
        tipsLabel.textColor = color_989898;
        tipsLabel.text = @"由字母和数字或者符号至少两种组合的8-20位字符，区分大小写";
        tipsLabel.numberOfLines = 0;
        [self.view addSubview:tipsLabel];
    }
    
    UIButton *checkAuthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkAuthButton setBackgroundColor:color_fc4a00];
    NSString *buttonTitle = @"";
    CGRect rect = CGRectZero;
    if (state == isSetPayPassword || state == isModifyPayPassword) {
        buttonTitle = @"提 交";
        rect = CGRectMake(10, 110+kNavBarViewHeight, 300, 50);
    }
    else if (state == isCheckPayPassword){
        buttonTitle = @"验 证";
        rect = CGRectMake(10, 72+kNavBarViewHeight, 300, 50);
    }
    checkAuthButton.frame = rect;
    [checkAuthButton setTitle:buttonTitle forState:UIControlStateNormal];
    [checkAuthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkAuthButton.titleLabel.font = defFont(NO, 16);
    checkAuthButton.layer.cornerRadius = 5.0f;
    checkAuthButton.tag = 9876;
    SEL selector;
    if (state == isSetPayPassword) {
        selector = @selector(setPayPassword:);
    }
    else if (state == isCheckPayPassword){
        selector = @selector(checkAuthCode:);
    }
    else if (state == isModifyPayPassword){
        selector = @selector(modifyPayPassword:);
    }
    
    [checkAuthButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkAuthButton];
    
    
    
    if (state == isCheckPayPassword) {
        NSString *telephoneAuthCodeString = @"通过绑定手机验证";
        CGSize defSize = CGSizeMake(300, 40);
        CGSize itemSize = [telephoneAuthCodeString sizeWithFont:defFont14 constrainedToSize:defSize lineBreakMode:NSLineBreakByWordWrapping];
        
        BQCustomBarButtonItem *payPassWordCheckItem = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(320/2 - itemSize.width/2, 124+kNavBarViewHeight, itemSize.width, 40)];
        payPassWordCheckItem.titleLabel.text = telephoneAuthCodeString;
        payPassWordCheckItem.titleLabel.textColor = color_989898;
        payPassWordCheckItem.titleLabel.font = defFont14;
        payPassWordCheckItem.titleRect = CGRectMake(0, 0, itemSize.width, 40);
        payPassWordCheckItem.Color = [UIColor clearColor];
        payPassWordCheckItem.delegate = self;
        payPassWordCheckItem.selector = @selector(telephoneAuthCodeCheckClick:);
        
        [self.view addSubview:payPassWordCheckItem];

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _businessState = [[self.receivedParams objectForKey:@"businessState"] integerValue];
    
    _payUiState = [[self.receivedParams objectForKey:@"UISTATE"]integerValue];
    
    
    if (_payUiState == isSetPayPassword) {
        [self loadUIforState:isSetPayPassword];
    }
    else if (_payUiState == isCheckPayPassword){
        [self loadUIforState:isCheckPayPassword];
    }
    else if (_payUiState == isModifyPayPassword){
        [self loadUIforState:isModifyPayPassword];
    }
    
     isShowTxtPwd = NO;
}

- (void)loadNavBarView
{
    [super loadNavBarView];
}

//- (void)loadNavBarView:(NSString *)title
//{
//    
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


- (void) onShowPwdClick:(id) sender{
    isShowTxtPwd = !isShowTxtPwd;
    if (isShowTxtPwd) {
        [passwordTextField setSecureTextEntry:NO];
        [sender setImage:[UIImage imageNamed:@"visible_icon_sel.png"] forState:UIControlStateNormal];
    }else{
        [passwordTextField setSecureTextEntry:YES];
        [sender setImage:[UIImage imageNamed:@"visible_icon.png"] forState:UIControlStateNormal];
    }
}



#pragma mark -

- (void)modifyPayPassword:(id)sender{
    
    if (passwordTextField.text.length == 0) {
        [self HUDShow:@"请输入支付密码" delay:1];
        return;
    }
    if (passwordTextField.text.length > 0) {
        NSMutableDictionary * pms = [self prepareParamsFor:isModifyPayPassword];
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_ModifyPayPassword class:@"ResponseBase"
//                  params:pms isShowLoadingAnimal:NO hudShow:@"正在验证"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestModifyPayPassword:pms ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在验证" delegate:self];
        
        
    }
}


- (BOOL)checkPasswordIsValid:(NSString *)password
{
    if (password.length < 8 || password.length > 20)
    {
        return NO;
    }
    
    BOOL isNumber = NO;
    BOOL isChar = NO;
    BOOL isSign = NO;

    NSInteger alength = [password length];
    for (int i = 0; i<alength; i++)
    {
        
        char commitChar = [password characterAtIndex:i];
//      NSString *temp = [password substringWithRange:NSMakeRange(i,1)];
//      const char *u8Temp = [temp UTF8String];

        if((commitChar>64)&&(commitChar<91))
        {
            isChar = YES;
        }
        else if((commitChar>96)&&(commitChar<123))
        {
            isChar = YES;
            
        }else if((commitChar>47)&&(commitChar<58))
        {
            isNumber = YES;
        }else if(commitChar == 32)
        {
            isNumber = NO;
            isChar = NO;
            isSign = NO;
            break;
            
        }
        else
        {
            isSign = YES;
        }
        
    }
    if((isNumber&&isChar)||(isChar&&isSign)||(isNumber&&isSign))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark -

- (void)setPayPassword:(id)sender{
    
    if (passwordTextField.text.length == 0) {
        [self HUDShow:@"请输入支付密码" delay:1];
        return;
    }
    
    if(![self checkPasswordIsValid:passwordTextField.text])
    {
        [self HUDShow:@"请输入正确的密码" delay:1];
        return;
    }
    
    if (passwordTextField.text.length > 0) {
        NSMutableDictionary * pms = [self prepareParamsFor:isSetPayPassword];
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_SetPayPassword class:@"ResponseBase"
//                  params:pms  isShowLoadingAnimal:NO hudShow:@"正在验证"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestSetPayPassword:pms ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在验证" delegate:self];
    }
}


#pragma mark -

- (void)checkAuthCode:(id)sender{
    
    if (passwordTextField.text.length == 0) {
        [self HUDShow:@"请输入支付密码" delay:1];
        return;
    }
    if (passwordTextField.text.length > 0) {
        NSMutableDictionary *dictPara = [self prepareParamsFor:isCheckPayPassword];
//        [self ApiRequest:api_BOQIILIFE method:kApiMethod_CheckPayPwd class:@"ResponseBase"
//                  params:dictPara  isShowLoadingAnimal:NO  hudShow:@"正在验证"];
        
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestCheckPayPassword:dictPara ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在验证" delegate:self];
        
    }
    
}

#pragma mark -
- (NSMutableDictionary*)prepareParamsFor:(PAYUISTATE)state
{
    NSMutableDictionary * dicParams = [NSMutableDictionary dictionary] ;
    if (state == isCheckPayPassword) {
        [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
        [dicParams setValue:[NSString YKMD5:passwordTextField.text] forKey:@"Password"];
    }
    else if (state == isSetPayPassword){
        [dicParams setValue:[UserUnit userId] forKeyPath:@"UserId"];
        [dicParams setValue:passwordTextField.text forKey:@"Password"];
    }
    else if (state == isModifyPayPassword){
        [dicParams setValue:[UserUnit userId] forKeyPath:@"UserId"];
        [dicParams setValue:[UserUnit userMobile] forKey:@"Telephone"];
        [dicParams setValue:passwordTextField.text forKey:@"PayPassword"];
    }
    
    return [dicParams mutableCopy];
}


#pragma mark -
- (void)telephoneAuthCodeCheckClick:(id)sender{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    [self pushNewViewController:@"BQTelephoneCheckViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
    
}


- (void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    
    [self resignKeyBoard];
    if([ApiName isEqualToString:kApiMethod_CheckPayPwd]) //验证支付密码
    {
        ResponseBase *backObject = [[ResponseBase alloc] initWithDic:retObj];//retObj;
        [self HUDShow:backObject.ResponseMsg delay:2];
        
        [self checkToNextStep];
    }
    
    if(   [ApiName isEqualToString:kApiMethod_ModifyPayPassword]
       || [ApiName isEqualToString:kApiMethod_SetPayPassword]) //修改支付密码成功
    {
  
        ResponseBase *backObject = [[ResponseBase alloc] initWithDic:retObj];
        
        [self HUDShow:backObject.ResponseMsg delay:1.5];
        
        [UserUnit writeUserHasPayPassword:1];
        
        [self performSelector:@selector(backToUsrInfo) withObject:nil afterDelay:1.5];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfo" object:nil];
    }
}


- (void)checkToNextStep{
    
    if (_businessState == authCodeHasCheckToModifyTelePhoneNum) {
        [self toSetTelePhoneNum];
    }
    else if (_businessState == authCodeHasCheckToSetPayPassword){
        [self toSetPayPassword];
    }
}

- (void)toSetTelePhoneNum{
    UISTATE state = isHasCheckToModify;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BQTelephoneCheckViewController" object:[NSNumber numberWithInt:state]];
    [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:[NSNumber numberWithBool:YES] afterDelay:2];
}


- (void)toSetPayPassword{
    _payUiState = isModifyPayPassword;
    [self refreshUIforState:_payUiState];

}

- (void)backToUsrInfo{
    NSArray *cvArray = self.navigationController.viewControllers;
    
    for (int i = 0; i <cvArray.count; i++) {
        if ([[cvArray objectAtIndex:i]isKindOfClass:[UserInfoViewController class]]) {
            UserInfoViewController *vc = [cvArray objectAtIndex:i];
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
    
}

- (void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName {
      [self resignKeyBoard];
    
    [super interfaceExcuteError:error apiName:ApiName];
    
    NSString * warnMsg = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
    
    [self HUDShow:warnMsg delay:2];

}


#pragma mark -
- (void)refreshUIforState:(PAYUISTATE)state
{
    for (int i = 0; i < self.view.subviews.count; i++) {
        [[self.view.subviews objectAtIndex:i] removeFromSuperview];
    }
    UIButton *button = (UIButton*)[self.view viewWithTag:9876];
    [button removeFromSuperview];
    
    for (UIView *view in self.navBarView.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self loadUIforState:state];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self resignKeyBoard];
}


- (void)resignKeyBoard{
    [passwordTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
     [self resignKeyBoard];
    
    return YES;
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
