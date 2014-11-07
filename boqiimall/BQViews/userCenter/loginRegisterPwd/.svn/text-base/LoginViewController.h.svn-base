//
//  LoginViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-4-29.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "resMod_UserInfo.h"
#import "EC_UIScrollView.h"

@protocol LoginDelegate <NSObject>

@optional
//  --使用中登录回传事件
- (void)LoginSuccessPushViewController:(NSString *)m_str param:(id)m_param;
@end


@interface LoginViewController : BQIBaseViewController<UIScrollViewDelegate,UITextFieldDelegate>{
    EC_UIScrollView *rootScrollView;
    UIView * viewTop;
    resMod_UserInfo * userInfo;
    
    BOOL isShowTxtPwd;
}

@property (assign, nonatomic) id<LoginDelegate> loginDelegate;
@property (strong, nonatomic) NSString *pushContollerString;        //--登录成功后要push的页面
@property (nonatomic, retain)id  param;

@property (strong, nonatomic) EC_UIScrollView *rootScrollView;
@property (strong, nonatomic) UIButton *btn_login;
@property (strong, nonatomic) UIButton *btn_forgetPwd;
@property (strong, nonatomic) UITextField *txt_userName;
@property (strong, nonatomic) UITextField *txt_userPwd;

//  --只用与第三方登录回传
@property (assign, nonatomic) BOOL isShareSdkLogin;
@property (strong, nonatomic) NSString * shareSDKLogin_nickname;
@property (strong, nonatomic) NSString * shareSDKLogin_sex;

- (void) onButton_ForgetPwdClick:(id) sender;
- (void) onButton_LoginClick:(id) sender;
- (void) onButton_RegisterClick:(id) sender;
- (void) onLoginSuccessDelegete;
@end
