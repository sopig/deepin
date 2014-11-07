//
//  LogisticsViewController.m
//  boqiimall
//
//  Created by YSW on 14-7-16.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "LogisticsViewController.h"
#import "resMod_LogisticsInfo.h"

#define heightRow   60

@implementation LogisticsViewController
@synthesize strUrl;
@synthesize param_OrderId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"物流详情"];
    [self.view setBackgroundColor:color_bodyededed];
   // [self loadNavBarView:@"物流详情"];
    self.param_OrderId = [self.receivedParams objectForKey:@"param_OrderId"];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    _webView.suppressesIncrementalRendering = YES;
    _webView.delegate = self;
    _webView.userInteractionEnabled = YES;
    _webView.scalesPageToFit = YES;
    _webView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_webView];
    
    if (self.param_OrderId.length>0) {
        [self goApiRequest_GetLogisticsContent];
    }
}

//- (void)loadNavBarView:(NSString *)title
//{
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

#pragma mark    --  web View delegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self HUDShow:@"正在加载..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self hudWasHidden:HUD];
}
//当结束请求的时候被通知
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self HUDShow:@"加载错误" delay:1.5];
}

#pragma mark    --  api 请求 加调

-(void) goApiRequest_GetLogisticsContent{
    
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:self.param_OrderId forKey:@"OrderId"];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_GetLogisticsContent class:@"resMod_CallBack_LogisticsContent"
//              params:dicParams isShowLoadingAnimal:YES hudShow:@""];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetLogisticsContent:dicParams ModelClass:@"resMod_CallBack_LogisticsContent" showLoadingAnimal:YES hudContent:@"" delegate:self];
    
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_Mall_GetLogisticsContent]) {
        resMod_CallBack_LogisticsContent * backObj = [[resMod_CallBack_LogisticsContent alloc] initWithDic:retObj];
        if(backObj.ResponseData){
            [_webView loadHTMLString:backObj.ResponseData.Content baseURL:nil];
        }
        
        [self.noDataView noDataViewIsHidden:(backObj.ResponseData && backObj.ResponseData.Content.length==0) ? NO :YES
                                    warnImg:@"" warnMsg:@"抱歉，暂无相关物流信息"];
        [self.lodingAnimationView stopLoadingAnimal];
    }
}

-(void) interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName{
    [super interfaceExcuteError:error apiName:ApiName];
    
    [self.lodingAnimationView stopLoadingAnimal];
    [self.noDataView noDataViewIsHidden:NO warnImg:@"" warnMsg:@"抱歉，暂无相关物流信息"];
}
/*
#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString * Identifier = @"LogisticsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
        
        UILabel * lbl_line = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 2, heightRow)];
        [lbl_line setTag:1000];
        [lbl_line setBackgroundColor:color_d1d1d1];
        [cell.contentView addSubview:lbl_line];
        
        UIImageView * imgicon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 12, 12)];
        [imgicon setTag:2000];
        [imgicon setImage:[UIImage imageNamed:@"icon_circleGray.png"]];
        [imgicon setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:imgicon];
        
        [UICommon Common_UILabel_Add:CGRectMake(35, 5, rootTableView.frame.size.width-45, 30)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1111
                                text:@"上海试 感受大自然带来的 感动就像蓝天"
                               align:-1 isBold:NO fontSize:14 tColor:color_4e4e4e];
        
        [UICommon Common_UILabel_Add:CGRectMake(35, heightRow-24, 150, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1112
                                text:@"2014-05-27 20:18:00"
                               align:-1 isBold:NO fontSize:14 tColor:color_989898];
        
        UILabel * lbl_Bottomline = [[UILabel alloc] initWithFrame:CGRectMake(35, 0,rootTableView.frame.size.width-40, 0.5)];
        [lbl_Bottomline setTag:9000];
        [lbl_Bottomline setBackgroundColor:color_d1d1d1];
        [cell.contentView addSubview:lbl_Bottomline];
    }
    
    int iRow = indexPath.row;
    
    UILabel * lbl_1000 = (UILabel*)[cell.contentView viewWithTag:1000];
    UIImageView * img_2000 = (UIImageView*)[cell.contentView viewWithTag:2000];
    UILabel * lbl_9000  = (UILabel*)[cell.contentView viewWithTag:9000];
    [lbl_9000 setHidden:iRow>0 ? NO:YES];
    
    [lbl_1000 setFrame:CGRectMake(lbl_1000.frame.origin.x, iRow==0 ? 14:0, 2, heightRow)];
    [img_2000 setFrame:CGRectMake(10, 13, 12, 12)];
    [img_2000 setImage:[UIImage imageNamed: @"icon_circleGray.png"]];

    if (iRow==9) {
        [lbl_1000 setFrame:CGRectMake(lbl_1000.frame.origin.x,0,lbl_1000.frame.size.width,12)];
        [img_2000 setFrame:CGRectMake(8, 11, 16, 16)];
        [img_2000 setImage:[UIImage imageNamed: @"icon_circleCheck.png"]];
    }
    
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
