//
//  ProjectShowViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-10.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "resMod_TicketInfo.h"

@interface ProjectShowViewController : BQIBaseViewController<UIWebViewDelegate>{
    
    resMod_TicketInfo * ticketInfo;
    UIButton  * btn_buy;
    UIWebView * _webView;
}

@end
