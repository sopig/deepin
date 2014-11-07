//
//  LogisticsViewController.h
//  boqiimall
//
//  Created by YSW on 14-7-16.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQIBaseViewController.h"

@interface LogisticsViewController : BQIBaseViewController<UIWebViewDelegate> {
    
    UIWebView * _webView;
}

@property (strong,nonatomic) NSString * strUrl;
@property (strong,nonatomic) NSString * param_OrderId;
@end
