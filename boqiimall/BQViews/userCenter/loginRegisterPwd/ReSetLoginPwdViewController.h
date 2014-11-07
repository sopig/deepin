//
//  ReSetLoginPwdViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-22.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "EC_UIScrollView.h"

@interface ReSetLoginPwdViewController : BQIBaseViewController<UIScrollViewDelegate,UITextFieldDelegate>{
    
    EC_UIScrollView * rootScrollView;
    
    UIView * viewTop;
    
    UIButton * btn_okRet;
    
    BOOL isShowTxtPwd;
}

@property(strong,nonatomic) NSString * param_userCount;
@property(strong,nonatomic) NSString * param_AuthCode;
@end