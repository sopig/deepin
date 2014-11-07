//
//  RegisterViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-13.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "EC_UIScrollView.h"
#import "resMod_UserInfo.h"


@interface RegisterViewController : BQIBaseViewController<UITextFieldDelegate,UIScrollViewDelegate>{
    
    EC_UIScrollView * rootScrollView;
    BOOL isAgreen;
    
    UIView * viewTop;
    UIView * viewSecond;
    
    UIButton * btn_GetCode;
    UIButton * btn_register;
    UIButton * btn_read;

    BOOL isShowTxtPwd;
    int timerSencond;
    BOOL hadSendCode;
    
    resMod_UserInfo * callBackUserinfo;
}

@end
