//
//  ServiceCouponDetailViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-15.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "ServiceCouponDetailViewController.h"
#import "TicketCommentViewController.h"

#define heightForHead   100
#define heightCellHead  40



#define kTicketID_ParaKey @"param_TicketId"
//#define kUserID_ParaKey @"param_UserId"
#define kPropImgUrl_ParaKey @"propImgUrl"
#define kTicketTitle_ParaKey @"TicketTitle"
#define kTicketPrice_ParaKey @"TicketPrice"


#define rtlabel 0
#define WebView 1


#if WebView
@interface ServiceCouponDetailViewController ()
{
    CGFloat _webViewHeight1;
    CGFloat _webViewHeight2;
    
    UIWebView *_webView1;
    UIWebView *_webView2;
    
    
    int _webview1LoadNum;
    int _webview2LoadNum;
    
    BOOL _isReload;
}
@end
#endif

@implementation ServiceCouponDetailViewController
@synthesize param_mytickid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"服务券详情"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
  //  [self loadNavBarView:@"服务券详情"];
    self.param_mytickid = [self.receivedParams objectForKey:@"param_myTickID"];
    self.mytickPrice = [self.receivedParams objectForKey:@"ticket_price"];
#if WebView
    _webViewHeight1 = 10;
    _webViewHeight2 = 10;
    _isReload = NO;
    
    _webView1 = [[UIWebView alloc]initWithFrame:CGRectZero];
    _webView1.dataDetectorTypes = UIDataDetectorTypeNone;
    
    _webView2 = [[UIWebView alloc]initWithFrame:CGRectZero];
    _webView2.dataDetectorTypes = UIDataDetectorTypeNone;
    
    
    _webview1LoadNum = 0;
    _webview2LoadNum = 0;
#endif
    
    if (self.param_mytickid.length==0) {
        [self HUDShow:@"服务券id不可为空" delay:1.5];
        [self goBack:nil];
        return;
    }
    
    rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 3+kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight -3) style:UITableViewStylePlain];
    [rootTableView setBackgroundColor:[UIColor clearColor]];
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [rootTableView setShowsVerticalScrollIndicator: NO];
    
    [self goApiRequest];
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

- (void)onDetailClick:(id) sender{
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] initWithObjectsAndKeys
                                :[NSString stringWithFormat:@"%d",myticket.TicketInfo.TicketID],kTicketID_ParaKey, nil];
    [self pushNewViewController:@"ServiceDetailViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:params];
}

- (void)onCallClick:(id) sender{
    
    if (myticket.TicketMerchant.MerchantTele.length==0) {
        [self HUDShow:@"暂无此商家联系方式" delay:1.5];
        return;
    }
    
    NSString * stel = [myticket.TicketMerchant.MerchantTele stringByReplacingOccurrencesOfString:@"-" withString:@""];
    stel = [stel stringByReplacingOccurrencesOfString:@"," withString:@""];
    stel = [stel stringByReplacingOccurrencesOfString:@" " withString:@""];
    EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"拨 打"
                                                                          message:stel
                                                                cancelButtonTitle:@"取消"
                                                                    okButtonTitle:@"呼叫"];
    alertView.delegate1 = self;
    [alertView setTag:9839];
    [alertView show];

}

//打电话
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //  --打电话
    if (alertView.tag == 9839) {
        if(buttonIndex == 1) {
            NSString * stel = [myticket.TicketMerchant.MerchantTele stringByReplacingOccurrencesOfString:@"-" withString:@""];
            stel = [stel stringByReplacingOccurrencesOfString:@"," withString:@""];
            stel = [stel stringByReplacingOccurrencesOfString:@" " withString:@""];
            stel = [NSString stringWithFormat:@"tel://%@",stel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stel]];
        }
    }
}

//查看其他商户
- (void)didTapOnOtherMerchantButton:(id)sender
{
    if (myticket.HasOtherMerchant > 0)
        
    {
    
        NSMutableDictionary *params=[[NSMutableDictionary alloc] initWithObjectsAndKeys
                                                 :[NSString stringWithFormat:@"%d",myticket.TicketInfo.TicketID],kTicketID_ParaKey, nil];
        [self pushNewViewController:@"BQTicketOtherMerchantListViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:params];
    }
    
}


#pragma mark    --  api 请求 加调
-(void) goApiRequest{
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:param_mytickid forKey:@"MyTicketId"];
    if (_lon!=-10000000.00 && _lat !=-10000000.00) {
        [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lat] forKey:@"Lat"];
        [dicParams setObject:[NSString stringWithFormat:@"%3.10f",_lon] forKey:@"Lng"];
    }
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMyTicketDetail:dicParams ModelClass:@"resMod_CallBack_GetMyTicketDetail" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    if ([ApiName isEqualToString:kApiMethod_MyTicketDetail]) {
        resMod_CallBack_GetMyTicketDetail * backObj = [[resMod_CallBack_GetMyTicketDetail alloc] initWithDic:retObj];
        myticket = backObj.ResponseData;
        [self.view addSubview:rootTableView];
        [rootTableView reloadData];
    }
}


#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float sizeHeight=120;
    if (indexPath.row == 1)
    {
        sizeHeight = 46+sizeHeight;
    }
    if (indexPath.row == 2){
#if WebView
        sizeHeight = _webViewHeight1 + 45 + 30;
#endif
        
#if rtlabel
        RTLabel *tmpLabel = [[RTLabel alloc] initWithFrame:CGRectMake(16, 40, def_WidthArea(20), 100)];
        tmpLabel.text = myticket.TicketInfo.MyTicketDetail;
        CGSize optimumSize = [tmpLabel optimumSize];
        sizeHeight = 40 + optimumSize.height + 15;
#endif
        
    }
    if (indexPath.row == 3){
#if WebView
        sizeHeight = _webViewHeight2 + 45 + 35;
#endif
        
#if rtlabel
        RTLabel *tmpLabel = [[RTLabel alloc] initWithFrame:CGRectMake(16, 40, def_WidthArea(20), 100)];
        tmpLabel.text = myticket.TicketInfo.MyTicketRemind;
        CGSize optimumSize = [tmpLabel optimumSize];
        sizeHeight = 40 + optimumSize.height + 15;
#endif
}
    
    return sizeHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return heightForHead;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton * HeadView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightForHead)];
    [HeadView setBackgroundColor:[UIColor whiteColor]];
    [HeadView addTarget:self action:@selector(onDetailClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * productImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 100, 76)];
    [productImg setBackgroundColor:[UIColor clearColor]];
    productImg.layer.borderColor = color_d1d1d1.CGColor;
    productImg.layer.borderWidth = 1.0;
    NSString * proimgUrl = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:myticket.TicketInfo.TicketImg];
    [productImg sd_setImageWithURL:[NSURL URLWithString: proimgUrl]
                  placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
    [HeadView addSubview:productImg];

    UILabel * lbl_productTitle = [[UILabel alloc] initWithFrame:CGRectMake(productImg.frame.size.width+20, 8, __MainScreen_Width-140, 40)];
    [lbl_productTitle setTextColor:color_333333];
    [lbl_productTitle setFont:defFont14];
    [lbl_productTitle setLineBreakMode:NSLineBreakByCharWrapping];
    [lbl_productTitle setNumberOfLines:0];
    [lbl_productTitle setBackgroundColor:[UIColor clearColor]];
    [lbl_productTitle setText:myticket.TicketInfo.TicketTitle]; //@"【上海】机械舞基础教学机械舞基础教学"
    [HeadView addSubview:lbl_productTitle];
    
    UIImageView * icon_godetail = [[UIImageView alloc] init];
    [icon_godetail setFrame:CGRectMake(__MainScreen_Width-20, heightForHead/2-7, 15, 15)];
    [icon_godetail setBackgroundColor:[UIColor clearColor]];
    [icon_godetail setImage:[UIImage imageNamed:@"right_icon.png"]];
    [HeadView addSubview:icon_godetail];
    
    [UICommon Common_line:CGRectMake(0,HeadView.frame.size.height-1, __MainScreen_Width,1) targetView:HeadView backColor:color_ededed];//添加像素条
    
    return HeadView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString * Identifier = @"CouponDetail";
    NSInteger irow = indexPath.row;
    
    UITableViewCell * cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];

    
    [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width, 10)
                   targetView:cell.contentView backColor:color_ededed];

    NSString * cellTitle;
    NSString * cellIcon;
    if(irow==0){
        
        
        cellTitle = @"凭证号";
        cellIcon = @"ticket_number_icon";
        
        [UICommon Common_UILabel_Add:CGRectMake(12, heightCellHead+15, 200, 40)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1001
                                text:myticket.MyTicketNo //@"9888 8888 88"
                               align:-1 isBold:NO fontSize:22 tColor:color_4e4e4e];
        
        [UICommon Common_UILabel_Add:CGRectMake(12, 92, 150, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1001
                                text:myticket.MyTicketStatus
                               align:-1 isBold:NO fontSize:14 tColor:color_b3b3b3];


#define MYTICKET_IS_NOT_COMMENT 0
#define MYTICKET_IS_USED 1
        
//        if ([[self.receivedParams objectForKey:@"ticketStatus"] isEqualToString:@"2"] && myticket.IsCommented == MYTICKET_IS_NOT_COMMENT)
        if (myticket.IsUsed == MYTICKET_IS_USED && myticket.IsCommented == MYTICKET_IS_NOT_COMMENT)
        {
            UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
            commentButton.backgroundColor = color_fc4a00;
            commentButton.frame = CGRectMake(__MainScreen_Width - 80, 70, 70, 30);
            commentButton.layer.cornerRadius = 3;
            [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [commentButton setTitle:@"点评" forState:UIControlStateNormal];
            commentButton.titleLabel.font = defFont16;
            
            [commentButton addTarget:self action:@selector(CommentClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:commentButton];
        }
        
    }
    else if(irow==1){
        cellTitle = @"适用商户";
        cellIcon = @"icon_house";
//        cellIcon = @"icon_call_ora.png";
        [UICommon Common_UILabel_Add:CGRectMake(12, heightCellHead+18, 260, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:2001
                                text: myticket.TicketMerchant.MerchantName //@"宾夕法尼亚宠物店"
                               align:-1 isBold:NO fontSize:14 tColor:color_333333];
        
        [UICommon Common_UILabel_Add:CGRectMake(12, heightCellHead+18+20, 230, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:2002
                                text: myticket.TicketMerchant.MerchantAddress // @"杨浦区包头南路9078弄09号"
                               align:-1 isBold:NO fontSize:14 tColor:color_b3b3b3];
        
        [UICommon Common_UILabel_Add:CGRectMake(12, heightCellHead+18+18+20, 150, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:2003
                                text: [self convertDistance:myticket.TicketMerchant.MerchantDistance]
                               align:-1 isBold:NO fontSize:14 tColor:color_b3b3b3];

        [UICommon Common_line:CGRectMake(__MainScreen_Width-60, heightCellHead+20, 1, 52)
                   targetView:cell.contentView backColor:color_ededed];
        
        UIButton * btn_call = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_call setFrame:CGRectMake(__MainScreen_Width-82, heightCellHead+6, 70, 78)];
        [btn_call setBackgroundColor:[UIColor clearColor]];
        [btn_call.titleLabel setFont: defFont14];
        [btn_call addTarget:self action:@selector(onCallClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * callBg = [[UIImageView alloc] initWithFrame:CGRectMake(35, 23, 35, 35)];
        [callBg setImage:[UIImage imageNamed:@"icon_call_ora.png"]];
        [btn_call addSubview:callBg];
        [cell.contentView addSubview:btn_call];
        
        UILabel *upLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, __MainScreen_Width,1)];
        upLine.backgroundColor = color_ededed;
        [cell.contentView addSubview:upLine];
        
        UIButton *otherMerchantbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 121, __MainScreen_Width, 44)];
        [otherMerchantbtn setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:otherMerchantbtn];
        [otherMerchantbtn addTarget:self action:@selector(didTapOnOtherMerchantButton:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, __MainScreen_Width*3/4.0,40)];
        [detailLabel setBackgroundColor:[UIColor clearColor]];
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.textColor = color_fc4a00;
        detailLabel.text = [NSString stringWithFormat:@"查看全部%d家商铺",myticket.HasOtherMerchant];
        [otherMerchantbtn addSubview:detailLabel];
        
        UIImageView * icon_godetail = [[UIImageView alloc] init];
        [icon_godetail setFrame:CGRectMake(__MainScreen_Width-20, 120+15, 15, 15)];
        [icon_godetail setBackgroundColor:[UIColor clearColor]];
        [icon_godetail setImage:[UIImage imageNamed:@"right_icon.png"]];
        
        [cell.contentView addSubview:icon_godetail];
        UILabel *downLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 120+45, __MainScreen_Width,1)];
        downLine.backgroundColor = color_ededed;
        [cell.contentView addSubview:downLine];
    }
    else if(irow==2){
        cellTitle = @"本单详情";
        cellIcon = @"icon_list";

#if WebView
        NSURL *url = [NSURL URLWithString:myticket.TicketInfo.MyTicketDetail];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        if (_webview1LoadNum <= 4) {
            [_webView1 loadRequest:request];
            _webview1LoadNum++;
        }
        [_webView1 setBackgroundColor:[UIColor clearColor]];
         _webView1.delegate = self ;
        _webView1.tag = irow;
        _webView1.scrollView.scrollEnabled = NO;
        
        [cell.contentView addSubview:_webView1];
        [_webView1 sizeThatFits:CGSizeZero];
#endif
        
#if rtlabel
        
        RTLabel *tmpLabel = [[RTLabel alloc] initWithFrame:CGRectMake(16, heightCellHead, def_WidthArea(32), 100)];
        [tmpLabel setParagraphReplacement:@""];
        tmpLabel.text = myticket.TicketInfo.MyTicketDetail;
        CGSize optimumSize = [tmpLabel optimumSize];
        [tmpLabel setTextColor:color_989898];
        [tmpLabel setFrame:CGRectMake(16, heightCellHead, def_WidthArea(20), optimumSize.height)];
        [cell.contentView addSubview:tmpLabel];
#endif
    }
    else if(irow==3)
    {
        cellTitle = @"特别提醒";
        cellIcon = @"icon_warn";
        
#if WebView
        NSURL *url = [NSURL URLWithString:myticket.TicketInfo.MyTicketRemind];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        if (_webview2LoadNum <= 4) {
             [_webView2 loadRequest:request];
        }
        [_webView2 setBackgroundColor:[UIColor clearColor]];
        _webView2.delegate = self ;
        _webView2.tag = irow;
        _webView2.scrollView.scrollEnabled = NO;
        [cell.contentView addSubview:_webView2];
        [_webView2 sizeThatFits:CGSizeZero];
#endif
        
#if rtlabel
        
        RTLabel *tmpLabel = [[RTLabel alloc] initWithFrame:CGRectMake(16, heightCellHead, def_WidthArea(32), 100)];
        [tmpLabel setParagraphReplacement:@""];
        tmpLabel.text = myticket.TicketInfo.MyTicketRemind;
        CGSize optimumSize = [tmpLabel optimumSize];
        [tmpLabel setTextColor:color_989898];
        [tmpLabel setFrame:CGRectMake(16, heightCellHead, def_WidthArea(20), optimumSize.height)];
        [cell.contentView addSubview:tmpLabel];
#endif    

    }
    
    UIImageView * iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 17.5, 25, 25)];
    [iconImg setBackgroundColor:[UIColor clearColor]];
    [iconImg setImage:[UIImage imageNamed:cellIcon]];
    [cell.contentView  addSubview:iconImg];
    [UICommon Common_UILabel_Add:CGRectMake(iconImg.frame.size.width+16, 10, 100, heightCellHead)
                      targetView:cell.contentView bgColor:[UIColor clearColor] tag:1000
                            text:cellTitle align:-1 isBold:NO fontSize:15 tColor:color_333333];
    [UICommon Common_line:CGRectMake(0, 10+heightCellHead, __MainScreen_Width, 1)
               targetView:cell.contentView backColor:color_ededed];
    
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)CommentClick:(id)sender
{

    NSString *commentViewController = @"TicketCommentViewController";
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setObject:[NSString stringWithFormat:@"%d",myticket.TicketInfo.TicketID] forKey:kTicketID_ParaKey];
    
    NSString *TicketPrice = [NSString stringWithFormat:@"%.2f",myticket.TicketInfo.TicketPrice];
    [paramDict setObject:TicketPrice forKey:kTicketPrice_ParaKey];
    NSString *proimgUrl = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:myticket.TicketInfo.TicketImg];
    
    [paramDict setObject:proimgUrl forKey:kPropImgUrl_ParaKey];
    [paramDict setObject:myticket.TicketInfo.TicketTitle forKey:kTicketTitle_ParaKey];

    [self pushNewViewController:commentViewController isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:paramDict];
    
}


#pragma mark - webView Delegate

#if WebView

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
#if 1
    if (webView.tag == 2) {
        
        NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
        _webViewHeight1 = [heightStr floatValue];
        if (_webViewHeight1 < 100) {
            _webViewHeight1 = 100;
        }
        
//        if (_isReload)
        {
            webView.frame = CGRectMake(16, 45, def_WidthArea(20), _webViewHeight1 + 30);
        }
        
    }
    else if (webView.tag == 3){
        NSString *heightStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
        _webViewHeight2 = [heightStr floatValue];
//        UIKeyboardAppearance
        
        if (_webViewHeight2 < 100) {
            _webViewHeight2 = 100;
        }
        
//        if (_isReload)
        {
            webView.frame = CGRectMake(16, 45, def_WidthArea(20), _webViewHeight2  + 35);
        }
        
//        if (!_isReload)
        {
            [rootTableView reloadData];
            _isReload = YES;
        }
    }
#endif
    
#if 0
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
#endif
}
#endif

@end
