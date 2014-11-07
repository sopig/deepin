//
//  BQGetAuthCodeButton.m
//  boqiimall
//
//  Created by 张正超 on 14-8-7.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQGetAuthCodeButton.h"

#import "MBProgressHUD.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"


@interface BQGetAuthCodeButton ()<MBProgressHUDDelegate>
{

    id _target;
    SEL _action;
    UIControlEvents _event;
    MBProgressHUD *HUD;
}

@end

@implementation BQGetAuthCodeButton


- (void)_init{
   
    
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    
     self.layer.cornerRadius = 5.0f;
    [self.titleLabel setFont: defFont15];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundImage: def_ImgStretchable(@"test_get_code_bg.png", 5, 5) forState:UIControlStateNormal];
    
//    _timerSencond = -100;

}


- (void)startTimer{
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer:) userInfo:nil repeats: YES];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self _init];
        
    }
    return self;
}



//- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
//
//    _target = target;
//    _action = action;
//    _event = controlEvents;
//    
//}


//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    if (_event & UIControlEventTouchUpInside) {
//        
//        if ([_target respondsToSelector:_action]) {
//            [_target performSelector:_action withObject:self.object];
//        }
//        
//    }
//   
//}

// 60秒后重新发送
- (void) handleTimer: (NSTimer *) timer{
    
    if (_timerSencond>0) {
        _timerSencond--;
    
        self.titleLabel.text = [NSString stringWithFormat:@"%d秒后重新获取",_timerSencond];
//        self.backgroundColor = [UIColor colorWithPatternImage:def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5)];
        self.backgroundColor = [UIColor whiteColor];
        
//        [self setTitle:[NSString stringWithFormat:@"%d秒后重新获取",_timerSencond] forState:UIControlStateNormal];
//        [self setBackgroundImage:def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5) forState:UIControlStateNormal];
        if (_timerSencond==0) {
            _timerSencond = -100;
        }
    }
    else if( _timerSencond == -100){
        
        self.titleLabel.text = @"获取验证码";
        self.backgroundColor = [UIColor colorWithPatternImage:def_ImgStretchable(@"test_get_code_bg.png", 5, 5)];
        
//        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
//        [self setBackgroundImage:def_ImgStretchable(@"test_get_code_bg.png", 5, 5) forState:UIControlStateNormal];
    }
}



- (void) onGetCodeClick:(id) sender{
    
    
    if ( _timerSencond != -100 ) {   //  -- 说明这个时候还没到60秒
        return;
    }
    
    if (self.inputTextFiled.text.length == 0) {
        
        [self HUDShow:@"请输入注册手机号" delay:2];
        return;
    }
    else if (self.inputTextFiled.text.length != 11){
        [self HUDShow:@"手机号格式不正确" delay:2];
        return;
    }
    
    _timerSencond = 120;
    [self setBackgroundImage:def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5) forState:UIControlStateNormal];
    
    NSMutableDictionary * dicParams = [NSMutableDictionary dictionary];
    [dicParams setValue:self.account forKey:@"Account"];
    [dicParams setValue:[NSString stringWithFormat:@"%d",self.type] forKey:@"Type"];

    
   [self ApiRequest:api_BOQIILIFE method:kApiMethod_SendAuthCodeForRegister class:@"ResponseBase" params:dicParams hudShow:@"验证码发送中"];
    
//    [[APIMethodHandle shareAPIMethodHandle]goApiRequestSendAuthCode:dicParams ModelClass:@"ResponseBase" showLoadingAnimal:YES hudContent:@"验证码发送中" delegate:self];
}



#pragma mark - 发送验证码接口请求

- (void) ApiRequest:(EnvApiHost) _envApiHost
             method:(NSString *) _method
              class:(NSString *) _class
             params:(NSMutableDictionary *) _param
            hudShow:(NSString *) showtext
{
    if (![PMGlobal shared].isHttp) {
        [self.delegate HUDShow:@"网络不可用，请检查设置" delay:2];
        return;
    }
    
    NSMutableDictionary * dicParams = _param;
    if (dicParams!=nil)
        [dicParams setObject:_method forKey:APP_ACTIONNAME];
    else
        dicParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:_method,APP_ACTIONNAME, nil];
    
    if (_envApiHost==api_BOQIILIFE) {   //  --  生活馆接口，都加城市id
        NSDictionary * dicCity = [[PMGlobal shared] location_GetUserCheckedCity];
        NSString * cityid = [dicCity objectForKey:@"CityId"];
        [dicParams setObject: cityid.length>0?cityid:@"0" forKey:@"CityId"];
    }
    
    if (showtext.length>0) {
        [self HUDShow: showtext];
    }
    InterfaceAPIExcute *inter = [[InterfaceAPIExcute alloc] initWithAPI:_envApiHost
                                                                apiPath:kApiUrl(_envApiHost)
                                                               retClass:_class
                                                                 Params:dicParams setDelegate:self];
    
    [inter beginRequest];
}


-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    
    [self hudWasHidden:HUD];
    if ([ApiName isEqualToString:kApiMethod_SendAuthCodeForRegister]) {
        [self HUDShow:@"发送成功" delay:1.5 dothing:YES];
//        hadSendCode = YES;
    }
//    else if([ApiName isEqualToString:kApiMethod_CheckAuthCode]){
//        UITextField * txtUserName      = (UITextField*)[viewTop viewWithTag:888];
//        UITextField * txtAuthCode      = (UITextField*)[viewSecond viewWithTag:999];
//        [self pushNewViewController:@"ReSetLoginPwdViewController"
//                          isNibPage:NO hideTabBar:YES setDelegate:NO
//                      setPushParams:[[NSMutableDictionary alloc]initWithObjectsAndKeys:
//                                     txtUserName.text,@"param_userCount",
//                                     txtAuthCode.text,@"param_AuthCode", nil]];
//    }
}


-(void) interfaceExcuteError:(NSError*)error apiName:(NSString*)ApiName{
    
    NSString * warnMsg = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
    if (warnMsg.length>30) {
        [self HUDShow:@"服务器出错 请稍后重试" delay:kShowMsgAfterDelay];
        return;
    }
    
    if ([ApiName isEqualToString:kApiMethod_SendAuthCodeForRegister]) {
        [self HUDShow:warnMsg.length==0 ? @"系统错误" :warnMsg delay:kShowMsgAfterDelay];
//        hadSendCode = NO;
    }
    if ([ApiName isEqualToString:kApiMethod_UserRegister]){
        [self HUDShow:warnMsg.length==0 ? @"系统错误" :warnMsg delay:kShowMsgAfterDelay];
    }
}

#pragma mark - MBProgressHud  提示   如有时间 想换成其他的漂亮一点的提示

-(void) initHUD {
    if (HUD == nil ) {
        HUD = [[MBProgressHUD alloc]initWithView:self];
        [self.HUDTargetView addSubview:HUD];
        HUD.delegate = self;
    }
}

-(void)HUDShow:(NSString*)text {
    
    [self initHUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
}

-(void)HUDShow:(NSString*)text delay:(float)second {
    [self initHUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    [HUD show:YES];
    [HUD hide:YES afterDelay:second];
}


-(void)HUDShow:(NSString*)text delay:(float)second dothing:(BOOL)bDo {
    [self initHUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    [HUD show:YES];
    [HUD hide:YES afterDelay:second dothing:bDo];
}


- (void)hudWasHidden:(MBProgressHUD *)hud{
    [HUD removeFromSuperview];
        HUD = nil;
}


-(void)HUDdelayDo{


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma clang diagnostic pop

@end
