//
//  WebDetailViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-13.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "LoginViewController.h"

@interface WebDetailViewController : BQIBaseViewController<UIWebViewDelegate,LoginDelegate>{
    
    UIWebView * _webView;
    
    
    
    NSString * strUrl;
    
    UIButton * goCarButton;
    UILabel * lbl_carnum;
    
    id      ProductInfo;
    BOOL    isFromLogin;     //标识是否为支付宝登录成功后跳转的页面
    BOOL    isLoginSuccess;  //标识第三方登录已经成功
    BOOL    isFromMallProductDetail;    //商城产品详情
}

@end
