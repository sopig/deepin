//
//  ShareAppViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-28.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "ShareAppViewController.h"
#import <ShareSDK/ShareSDK.h>

#define defSharetype @"icon_share_weibo|icon_share_qqzone|icon_share_qqwb"

@implementation ShareAppViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isharetype = -100;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"分享到社交网站"];
    [self addRightNav];
    
    txtContent = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, def_WidthArea(10), 120)];
    [txtContent setTag:2000];
    [txtContent setDelegate:self];
    [txtContent setText:BQShareContent];
    [txtContent setBackgroundColor:[UIColor clearColor]];
    [txtContent setFont:defFont15];
    [txtContent setTextColor:color_4e4e4e];
    txtContent.layer.borderColor = color_d1d1d1.CGColor;
    txtContent.layer.borderWidth = 1;
    txtContent.layer.cornerRadius = 4.0f;
    [self.view addSubview:txtContent];
    [txtContent release];
    
    UILabel * lbl_fxd = [[UILabel alloc] init];
    [lbl_fxd setFrame:CGRectMake(10, txtContent.frame.size.height+18, 50, 20)];
    [lbl_fxd setBackgroundColor:[UIColor clearColor]];
    [lbl_fxd setText:@"分享到："];
    [lbl_fxd setTextColor:color_717171];
    [lbl_fxd setFont:defFont12];
    [self.view addSubview:lbl_fxd];
    [lbl_fxd release];
    
    //  --新浪微博分享
    btn_sharewb = [[UIButton alloc] initWithFrame:CGRectMake(55,txtContent.frame.size.height+10, 35, 35)];
    [btn_sharewb setTag:1000];
    [btn_sharewb setBackgroundColor:[UIColor clearColor]];
    [btn_sharewb setImage:[UIImage imageNamed:@"icon_share_weibo_hidden"] forState:UIControlStateNormal];
    [btn_sharewb addTarget:self action:@selector(onShareTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_sharewb];
    [btn_sharewb release];
    
    //  --qq空间分享
    btn_shareqqzone = [[UIButton alloc] initWithFrame:CGRectMake(90,txtContent.frame.size.height+10, 35, 35)];
    [btn_shareqqzone setTag:1001];
    [btn_shareqqzone setBackgroundColor:[UIColor clearColor]];
    [btn_shareqqzone setImage:[UIImage imageNamed:@"icon_share_qqzone_hidden"] forState:UIControlStateNormal];
    [btn_shareqqzone addTarget:self action:@selector(onShareTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_shareqqzone];
    [btn_shareqqzone release];
    
    //  --qq微博分享
    btn_shareqqwb = [[UIButton alloc] initWithFrame:CGRectMake(125,txtContent.frame.size.height+10, 35, 35)];
    [btn_shareqqwb setTag:1002];
    [btn_shareqqwb setBackgroundColor:[UIColor clearColor]];
    [btn_shareqqwb setImage:[UIImage imageNamed:@"icon_share_qqwb_hidden"] forState:UIControlStateNormal];
    [btn_shareqqwb addTarget:self action:@selector(onShareTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_shareqqwb];
    [btn_shareqqwb release];
    
    
    lbl_txtLength = [[UILabel alloc] init];
    [lbl_txtLength setFrame:CGRectMake(__MainScreen_Width-210, txtContent.frame.size.height+18, 200, 20)];
    [lbl_txtLength setBackgroundColor:[UIColor clearColor]];
    [lbl_txtLength setTextAlignment:NSTextAlignmentRight];
    [lbl_txtLength setText:[NSString stringWithFormat:@"还可输入%d字",140-txtContent.text.length]];
    [lbl_txtLength setTextColor:color_717171];
    [lbl_txtLength setFont:defFont14];
    [self.view addSubview:lbl_txtLength];
    [lbl_txtLength release];
}

//  --分享按钮.
- (void) addRightNav{
    UIButton * btn_register = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 45, 35)];
    [btn_register setBackgroundColor:[UIColor whiteColor]];
    [btn_register setTitle:@"分享" forState:UIControlStateNormal];
    [btn_register.titleLabel setFont:defFont14];
    [btn_register setTitleColor:color_fc4a00 forState:UIControlStateNormal];
    btn_register.layer.cornerRadius = 5.0f;
    [btn_register addTarget:self action:@selector(onButton_ShareClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:btn_register];
    self.navigationItem.rightBarButtonItem = r_bar;
    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
    
    [r_bar release];
    [btn_register release];
}

//  --授权按钮
- (void) onShareTypeClick:(id) sender{
    UIButton * btntmp = (UIButton*)sender;
    ShareType btnShareType = ShareTypeSinaWeibo;
    [self HUDShow:@"授权中..."];
    switch (btntmp.tag) {
        case 1000:  {
            btnShareType = ShareTypeSinaWeibo;
            if (b_agreenSharewb) {
                
                [self setBtnImg:NO bst:btnShareType];
                [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
                return;
            }
        }
            break;
        case 1001:  {
            btnShareType = ShareTypeQQSpace;
            if (b_agreenShareqqzone) {
                
                [self setBtnImg:NO bst:btnShareType];
                [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
                return;
            }
        }
            break;
        case 1002:  {
            btnShareType = ShareTypeTencentWeibo;
            if (b_agreenShareqqwb) {
                
                [self setBtnImg:NO bst:btnShareType];
                [ShareSDK cancelAuthWithType:ShareTypeTencentWeibo];
                return;
            }
        }
            break;
        default:
            break;
    }
    
    [ShareSDK getUserInfoWithType:btnShareType
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {

                               [self setBtnImg: result bst:btnShareType];

                               [self HUDShow: result ? @"授权成功，去分享吧" : @"授权失败" delay:2];
                           }];
}

- (void) onButton_ShareClick{

    ishareCount = 0;
    [txtContent resignFirstResponder];
    
    if (txtContent.text.length>10)  {
        
        ishareCount = b_agreenSharewb       ? ishareCount+1 : ishareCount;
        ishareCount = b_agreenShareqqzone   ? ishareCount+1 : ishareCount;
        ishareCount = b_agreenShareqqwb     ? ishareCount+1 : ishareCount;
        
        if (ishareCount==0) {
            [self HUDShow:@"请先授权" delay:2];
            return;
        }
        
        if (b_agreenSharewb) {
            [self shareSDK_Share:ShareTypeSinaWeibo];
        }
        if(b_agreenShareqqzone){
            [self shareSDK_Share:ShareTypeQQSpace];
        }
        if(b_agreenShareqqwb){
            [self shareSDK_Share:ShareTypeTencentWeibo];
        }
    }
    else{
        [self HUDShow:@"内容不可少于10字" delay:2];
    }
}

- (void) setBtnImg:(BOOL) authResult bst:(ShareType) btnShareType{
    if (btnShareType == ShareTypeSinaWeibo) {
        b_agreenSharewb = authResult;
        [btn_sharewb setImage:[UIImage imageNamed: authResult ? @"icon_share_weibo":@"icon_share_weibo_hidden"]
                     forState:UIControlStateNormal];
    }
    else if (btnShareType == ShareTypeQQSpace) {
        b_agreenShareqqzone = authResult;
        [btn_shareqqzone setImage:[UIImage imageNamed: authResult ? @"icon_share_qqzone":@"icon_share_qqzone_hidden"]
                         forState:UIControlStateNormal];
    }
    else if (btnShareType == ShareTypeTencentWeibo) {
        b_agreenShareqqwb = authResult;
        [btn_shareqqwb setImage:[UIImage imageNamed: authResult ? @"icon_share_qqwb":@"icon_share_qqwb_hidden"]
                       forState:UIControlStateNormal];
    }
}

- (void) shareSDK_Share:(ShareType) stype{
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@%@",txtContent.text,APP_APPSTOREURL]
                                       defaultContent:@"波奇宠物服务分享"
                                                image:[ShareSDK pngImageWithImage:[UIImage imageNamed:@"shareimg.png"]]
                                                title:@"波奇宠物分享"
                                                  url:APP_APPSTOREURL
                                          description:txtContent.text
                                            mediaType:SSPublishContentMediaTypeNews];
    [ShareSDK shareContent: publishContent
                      type: stype
               authOptions: nil
             statusBarTips: NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSResponseStateSuccess) {
                            ishareCount--;
                            if (ishareCount==0) {
                                [self HUDShow:@"分享成功" delay:2 dothing:YES];
                            }
                        }
                        else if (state == SSResponseStateFail) {
                            [self HUDShow:[NSString stringWithFormat:@"分享失败 %@",[error errorDescription]]delay:2];
                        }
                    }];
}

-(void)HUDdelayDo {
    [self goBack:nil];
}


#pragma mark - TextField delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSInteger sLength = 140 - range.length - text.length - txtContent.text.length;
    if(textView.tag == 2000){
        if ( textView.text.length < 140 ){
            [lbl_txtLength setText:[NSString stringWithFormat:@"还可输入%d字",sLength]];
        }
    }

    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
