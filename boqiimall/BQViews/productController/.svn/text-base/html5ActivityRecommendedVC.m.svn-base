//
//  html5ActivityRecommendedVC.m
//  boqiimall
//
//  Created by ysw on 14-9-1.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "html5ActivityRecommendedVC.h"

#define OBJSELNAME    @"objSEL://"
#define StringForSeparated @"||BOQII||"

@implementation html5ActivityRecommendedVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

   // [self loadNavBarView];
    strUrl = [self.receivedParams objectForKey:@"param_Html5URL"];
    NSString * sTitle = [self.receivedParams objectForKey:@"param_TITLE"];
    if (strUrl.length==0) {
        [self HUDShow:@"URL为空" delay:1.5 dothing:YES];
        return ;
    }
    if (sTitle.length>0) {
        
        [self setTitle: sTitle];
    }
   // [self loadNavBarView:sTitle];
    
    webHtml5_View = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight-kNavBarViewHeight)];
    webHtml5_View.suppressesIncrementalRendering = YES;
    webHtml5_View.delegate = self;
    webHtml5_View.userInteractionEnabled = YES;
    webHtml5_View.scalesPageToFit = YES;
    webHtml5_View.backgroundColor = [UIColor clearColor];
    [self.view addSubview:webHtml5_View];
    
    NSMutableString *htmlFromUrl = [NSMutableString stringWithContentsOfURL:[NSURL URLWithString:strUrl]
                                                                   encoding:NSUTF8StringEncoding error:nil];

    NSString *JsFunctionString = [NSString stringWithFormat:@"<script type=\"text/javascript\"> var Boqii = { JumpListPage : function(itype,apiurl){ document.location=\"method%@pushListPageFromHtml5%@\"+itype+\"%@\"+apiurl;}, JumpDetailPage : function(itype,apiurl){ document.location=\"method%@pushDetailPageFromHtml5%@\"+itype+\"%@\"+apiurl; } } </script>",OBJSELNAME,StringForSeparated,StringForSeparated,OBJSELNAME,StringForSeparated,StringForSeparated];
    
    [htmlFromUrl appendString:JsFunctionString];
    [webHtml5_View loadHTMLString:htmlFromUrl baseURL:nil];
    
//    NSURL *url = [NSURL URLWithString:strUrl];
//    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:40.0];
//    [webHtml5_View loadRequest:request];
}



//- (void)loadNavBarView:(NSString *)title
//{
//    
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



#pragma mark    --  web View delegate && call back

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self HUDShow:@"正在加载..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hudWasHidden:HUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self hudWasHidden:HUD];
};

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *requestString = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSArray *components = [requestString componentsSeparatedByString:StringForSeparated];
    
    if ([components count] ==3 ) {
        NSArray * arrSEL = [components[0] componentsSeparatedByString:OBJSELNAME];
        NSString * SELName = arrSEL&&arrSEL.count>0 ? arrSEL[1]:@"";
    
        NSString * stype = components[1];
        NSString * apiurl = components[2];
        NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:stype,@"ITYPE",apiurl,@"APIURL",nil];

        if ([SELName isEqualToString:@"pushListPageFromHtml5"]) {
            [self pushListPageFromHtml5:dic];
            return NO;
        }
        else if([SELName isEqualToString:@"pushDetailPageFromHtml5"]){
            [self pushDetailPageFromHtml5:dic];
            return NO;
        }
    }
    return YES;
}


#pragma mark    --  规则跳转app页面

/*  跳转 app 列表页
 *  itype 跳转类型: 【1: 商品列表；2:商户列表; 3:服务券列表】
 *  surl: 【请求url】
 */
- (void)pushListPageFromHtml5:(NSDictionary *) dicParams{
    
    int itype = [[dicParams objectForKey:@"ITYPE"] intValue];
    NSString * apiurl = [dicParams objectForKey:@"APIURL"];
    if ([apiurl isKindOfClass:[NSNull class]] || apiurl.length==0) {
        [self HUDShow:@"请求URL为空" delay:2];
        return;
    }
    
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString * targetViewController = [[NSString alloc] init];
    BOOL b_HideTabbar=NO;
    switch (itype) {
        case 1:{
            [pms setValue:apiurl forKey:@"param_URLProductList"];
            [pms setValue:@"全部" forKey:@"paramSelClassName"];
            targetViewController = @"MallProductListVController";
            b_HideTabbar = YES;
        }
            break;
        case 2:{
            [pms setValue:apiurl forKey:@"param_URLMerchant"];
            targetViewController = @"SMRecommendViewController";
            b_HideTabbar = YES;
        }
            break;
        case 3:{
            [pms setValue:apiurl forKey:@"param_URLTicket"];
            targetViewController = @"SMRecommendViewController";
            b_HideTabbar = YES;
        }
            break;
            
        default:    break;
    }
    
    
    if (targetViewController.length==0) {
        [self HUDShow:@"跳转页不可为空" delay:1.5];
    } else {
        [self pushNewViewController:targetViewController isNibPage:NO hideTabBar:b_HideTabbar setDelegate:NO setPushParams:pms];
    }
}

/*  跳转 app 详情页
 *  itype 跳转类型：【1: 商品详情；2:商户详情；3:服务券详情】
 *  surl: 【请求url】
 */
- (void)pushDetailPageFromHtml5:(NSDictionary *) dicParams{
    
    int itype = [[dicParams objectForKey:@"ITYPE"] intValue];
    NSString * apiurl = [dicParams objectForKey:@"APIURL"];
    if ([apiurl isKindOfClass:[NSNull class]] || apiurl.length==0) {
        [self HUDShow:@"请求URL为空" delay:2];
        return;
    }
    
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString * targetViewController = [[NSString alloc] init];
    BOOL b_HideTabbar=NO;
    switch (itype) {
        case 1:{
            [pms setValue:apiurl forKey:@"param_URLProductDetail"];
            targetViewController = @"MallProductDetailController";
            b_HideTabbar = YES;
        }
            break;
        case 2:{
            [pms setValue:apiurl forKey:@"param_URLMerchant"];
            targetViewController = @"MerchantDetailViewController";
            b_HideTabbar = YES;
        }
            break;
        case 3:{
            [pms setValue:apiurl forKey:@"param_URLService"];
            targetViewController = @"ServiceDetailViewController";
            b_HideTabbar = YES;
        }
        default:    break;
    }
    
    
    if (targetViewController.length==0) {
        [self HUDShow:@"跳转页不可为空" delay:1.5];
    } else {
        [self pushNewViewController:targetViewController isNibPage:NO hideTabBar:b_HideTabbar setDelegate:NO setPushParams:pms];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end



