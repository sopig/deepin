//
//  BQWithDrawsCashViewController.m
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-17.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQWithDrawsCashViewController.h"

#import "EC_UIScrollView.h"
#import "EC_UITextField.h"
#import "resMod_GetWithDrawCashRule.h"
#import "BQCustomBarButtonItem.h"
#import "BQWithdrawsHistoryViewController.h"

#import <UIImage-Helpers.h>
#import <NZAlertView.h>

#define TOP_BG_VIEW_HEIGHT 96
#define ROW_HEIGHT 46
#define CONTENT_SCROLLVIEW_HEIGHT __MainScreen_Height - 10 +38.5+10 - TOP_BG_VIEW_HEIGHT

#define ALIPAY_TEXTFIELD_BASE_TAG 9000
#define BANKPAY_TEXTFIELD_BASE_TAG 8000
typedef NS_ENUM(NSUInteger, CurrentMode)
{
    AlipayMode = 1,
    CreditCartMode,
    WithdrawsHistoryMode
};

@interface BQWithDrawsCashViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    UIView *_topBgView;
    UISegmentedControl *_segment;
    UIScrollView *_contentScrollView ;
    
    resMod_GetWithDrawCashRule *_ruleModel;
    RTLabel *_balanceLabel;
    RTLabel *_ruleLabel;
    
    CurrentMode _mode;
}
@end

@implementation BQWithDrawsCashViewController

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
    // Do any additional setup after loading the view.
    //[self loadNavBarView];
    self.title = @"提现申请";
     _ruleModel = [[resMod_GetWithDrawCashRule alloc]init];
    [self goApiRequest_GetWithDrawCashRuleForMode:AlipayMode];// 初始化默认
    _mode = AlipayMode;
    self.view.backgroundColor = color_bodyededed;
    [self MainViewConfigure];
    [self alipayViewConfigure];
    [self creditCartViewConfigure];
   // [self navView];
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    [self._titleLabel setFrame:CGRectMake(70, 2, 180, 40)];
    BQCustomBarButtonItem *barItem = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(250, 7, 60, 30)];
    barItem.titleRect = CGRectMake(0, 0, 60, 30);
    barItem.titleLabel.text = @"提现记录";
    barItem.titleLabel.font = defFont15;
    barItem.titleLabel.textColor = color_989898;
    barItem.delegate = self;
    barItem.selector = @selector(WithdrawsHistory:);
    [self.subNavBarView addSubview:barItem];
}

//主界面 UI
- (void)MainViewConfigure
{
    _topBgView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, TOP_BG_VIEW_HEIGHT)];
    _topBgView.backgroundColor = color_8fc31f;
    [self.view addSubview:_topBgView];
    
    float coinWidth = 25,coinHeight = 16;
    UIImageView *coinImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, kNavBarViewHeight+TOP_BG_VIEW_HEIGHT/2 - coinHeight-6, coinWidth, coinHeight)];
    coinImageView.image = [UIImage imageNamed:@"coin.png"];
    [self.view addSubview:coinImageView];
    
#if 0
    NSDictionary *titleAttribute = @{
                                (NSString*)kCTFontAttributeName:[UIFont systemFontOfSize:18],
                                (NSString*)kCTForegroundColorAttributeName:(id)[UIColor convertHexToRGB:@"ffffff"].CGColor
                                };
    CGSize balaceLabelSize = [title sizeWithAttributes:titleAttribute];
#endif
    
    NSString *balanceTitle = [NSString stringWithFormat:@"<font size=18 color='#ffffff'>今日可提现金额:</font><b><font size=25 color='#ffffff'>  %.2f</font></b><font color='#ffffff' size=18> 元</font>",_ruleModel.AvailableCash];
    _balanceLabel = [[RTLabel alloc]initWithFrame:CGRectZero];
    _balanceLabel.text = balanceTitle;
    _balanceLabel.lineBreakMode = kCTLineBreakByCharWrapping;
    [self.view addSubview:_balanceLabel];
//    CGSize balanceSize = [_balanceLabel optimumSize];
//    _balanceLabel.frame = CGRectMake(10 + coinWidth + 10, TOP_BG_VIEW_HEIGHT/2 - balanceSize.height -3,balanceSize.width , balanceSize.height);
    _balanceLabel.frame = CGRectMake(10+25+10, kNavBarViewHeight+TOP_BG_VIEW_HEIGHT/2 - TOP_BG_VIEW_HEIGHT/2 + 13 , __MainScreen_Width - 10, TOP_BG_VIEW_HEIGHT/2-6);
;

    _ruleLabel = [[RTLabel alloc]initWithFrame:CGRectZero];
    NSString *ruleString = [NSString stringWithFormat:@"<b><font size=12 color='#def7a9'>提现规则: 20元起提，每日限额500元，每日限提1次，APP首次登录返现金额不可提现</font></b>"];
    _ruleLabel.lineBreakMode = kCTLineBreakByCharWrapping;
    _ruleLabel.text = ruleString;
    [self.view addSubview:_ruleLabel];
    CGSize ruleSize = [_ruleLabel optimumSize];
    ruleSize.width > __MainScreen_Width -10 ? (_ruleLabel.frame = CGRectMake(10, kNavBarViewHeight+TOP_BG_VIEW_HEIGHT/2 + 3, __MainScreen_Width - 10, TOP_BG_VIEW_HEIGHT/2-6)):(_ruleLabel.frame = CGRectMake(10, kNavBarViewHeight+TOP_BG_VIEW_HEIGHT/2 + 3, ruleSize.width, TOP_BG_VIEW_HEIGHT/2-6));
    
    
    NSArray *items = @[@"提现到支付宝",@"提现到银行卡"];
    _segment = [[UISegmentedControl alloc]initWithItems:items];
    _segment.tintColor = [UIColor convertHexToRGB:@"74838e"];

    if(IOS7_OR_LATER){
        _segment.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    }
    else
    {
        [_segment setBackgroundImage:[UIImage imageWithColor:[UIColor convertHexToRGB:@"989898"]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [_segment setBackgroundImage:[UIImage imageWithColor:[UIColor convertHexToRGB:@"74838e"]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        
        [_segment setDividerImage:[UIImage imageWithColor:[UIColor convertHexToRGB:@"74838e"]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected  barMetrics:UIBarMetricsDefault];
        
        
        [_segment setTitleTextAttributes:@{
                                                                  UITextAttributeTextColor: [UIColor convertHexToRGB:@"ffffff"],
                                                                  UITextAttributeFont: [UIFont systemFontOfSize:16],
                                                                  UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)] }
                                                       forState:UIControlStateNormal];
        
        [_segment setTitleTextAttributes:@{
                                                                  UITextAttributeTextColor: [UIColor convertHexToRGB:@"ffffff"],
                                                                  UITextAttributeFont: [UIFont systemFontOfSize:16],
                                                                  UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)]}
                                                       forState:UIControlStateSelected];
        
        

    }
    _segment.frame = CGRectMake(10, kNavBarViewHeight+TOP_BG_VIEW_HEIGHT+10, 300, 38.5);
    _segment.selectedSegmentIndex = 0;
    [_segment addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    
    [_segment addObserver:self forKeyPath:@"selectedSegmentIndex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    [UICommon Common_line:CGRectMake(0, kNavBarViewHeight+TOP_BG_VIEW_HEIGHT+10 + 38 +10, __MainScreen_Width, 0.5) targetView:self.view backColor:color_d1d1d1];
    
    
    
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,  kNavBarViewHeight+TOP_BG_VIEW_HEIGHT + 10 +38.5+10, __MainScreen_Width, CONTENT_SCROLLVIEW_HEIGHT)];
    _contentScrollView.delegate = self;
    _contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width*items.count,  CONTENT_SCROLLVIEW_HEIGHT);
    _contentScrollView.pagingEnabled = YES;
    [self.view addSubview:_contentScrollView];
    
}


//提现到支付宝UI
- (void)alipayViewConfigure
{
     NSArray*leftTitleStrArray = @[@"*提 现 金 额 :",@"*支付宝账号 :",@"*姓          名 :",@"*支 付 密 码 :"];
     [self configureViewWithTitleArray:leftTitleStrArray mainViewRect:CGRectMake(0, 0, __MainScreen_Width, CONTENT_SCROLLVIEW_HEIGHT) baseTag:ALIPAY_TEXTFIELD_BASE_TAG currentMode:AlipayMode];
}


//提现到银行卡
- (void)creditCartViewConfigure
{
    NSArray *leftTitleStrArray = @[@"*提 现 金 额 :",@"*银 行 卡 号 :",@"*开  户  名   :",@"*开  户  行   :",@"*支 付 密 码 :"];
    [self configureViewWithTitleArray:leftTitleStrArray mainViewRect:CGRectMake(320, 0, __MainScreen_Width, CONTENT_SCROLLVIEW_HEIGHT) baseTag:BANKPAY_TEXTFIELD_BASE_TAG currentMode:CreditCartMode];
    
}

- (void)configureViewWithTitleArray:(NSArray*)titleArray mainViewRect:(CGRect)rect baseTag:(NSUInteger)baseTag currentMode:(CurrentMode)mode
{
    NSUInteger rowNumber = titleArray.count;
    
    EC_UIScrollView *mainView = [[EC_UIScrollView alloc]initWithFrame:rect];
    mainView.contentSize = CGSizeMake(__MainScreen_Width, (rowNumber+4)*ROW_HEIGHT + 20);
    [_contentScrollView addSubview:mainView];
    
    UIView *_userCommitView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, ROW_HEIGHT*rowNumber)];
    _userCommitView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:_userCommitView];
    
    for (NSUInteger i = 0; i < rowNumber; i++) {
        
        RTLabel *label = [[RTLabel alloc]initWithFrame:CGRectMake(10, 13 + i*ROW_HEIGHT + 3, 80, 20)];
        label.text = [NSString stringWithFormat:@"<font size=12 color='#575757'>%@</font>",titleArray[i]];
        label.textAlignment = kCTJustifiedTextAlignment;
        [_userCommitView addSubview:label];
        
        EC_UITextField *textfield = [[EC_UITextField alloc]initWithFrame:CGRectMake(10 + 80 +10 - 15, 10 + i*ROW_HEIGHT + 3, 180, 20)];
        textfield.textFieldState = ECTextFieldNone;
        textfield.delegate = self;
        textfield.tag = baseTag +i+1;
        [_userCommitView addSubview:textfield];
        i+1 == rowNumber ?(textfield.secureTextEntry = YES):(textfield.secureTextEntry = NO); //输入框是否为密码框
        i+1 == rowNumber ?(textfield.placeholder = @"波奇网支付密码"):(textfield.placeholder = @"");
        i+1 == rowNumber ?(textfield.font = defFont12):(nil);
        
        
        CGRect lineRect = CGRectZero;
        i+1 == rowNumber ?(lineRect = CGRectMake(0, (i+1)*ROW_HEIGHT-0.5, __MainScreen_Width, 0.5)):(lineRect = CGRectMake(10, (i+1)*ROW_HEIGHT-0.5, def_WidthArea(10), 0.5));
        
        [UICommon Common_line:lineRect targetView:_userCommitView backColor:[UIColor convertHexToRGB:@"d8d8d8"]];
        
    }
    

    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(10, (rowNumber+4)*ROW_HEIGHT + 10 - ROW_HEIGHT*4 , 300,  ROW_HEIGHT);
    [commitButton setBackgroundColor:color_fc4a00];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.titleLabel.font = defFont(NO, 16);
    commitButton.layer.cornerRadius = 3.0f;
    SEL commitButtonClick ;
    switch (mode) {
        case AlipayMode:
            commitButtonClick = @selector(aliPayClick:);
            commitButton.tag = ALIPAY_TEXTFIELD_BASE_TAG + 5;
            break;
            
        case CreditCartMode:
            commitButtonClick = @selector(creditPayClick:);
              commitButton.tag = BANKPAY_TEXTFIELD_BASE_TAG + 6;
        default:
            break;
    }
    [commitButton addTarget:self action:commitButtonClick forControlEvents:UIControlEventTouchUpInside];
    
    [mainView addSubview:commitButton];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    CGFloat xPoint = scrollView.contentOffset.x;
    if (xPoint >= 180 && xPoint < 500) {
        _mode = CreditCartMode;
        _segment.selectedSegmentIndex = CreditCartMode-1;
    }else if (xPoint >= 0 && xPoint < 180){
        _mode = AlipayMode;
        _segment.selectedSegmentIndex = AlipayMode-1;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)changeSelect:(UISegmentedControl*)seg
{
    if (seg.selectedSegmentIndex == 0) {
        _mode = AlipayMode;
        [_contentScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
//        [_contentScrollView scrollRectToVisible:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50 - 60) animated:YES];
    }
    else if (seg.selectedSegmentIndex == 1){
        _mode = CreditCartMode;
          [_contentScrollView setContentOffset:CGPointMake(320, 0) animated:NO];
//        [_contentScrollView scrollRectToVisible:CGRectMake(320, 50, self.view.frame.size.width, self.view.frame.size.height - 50 - 60) animated:YES];
    }
}



#pragma mark - API请求
//获取提现到规则
- (void)goApiRequest_GetWithDrawCashRuleForMode:(CurrentMode)mode
{
    NSMutableDictionary *para = (NSMutableDictionary*)@{
                                  @"UserId":[UserUnit userId],
                                  @"Channel":[NSString stringWithFormat:@"%d",mode],
                                  @"Debug":[NSString stringWithFormat:@"%d",1000]
                                  };

    [[APIMethodHandle shareAPIMethodHandle]goApiRequestLifeGetWithDrawCashRule:para ModelClass:@"resMod_CallBack_GetWithDrawCashRule" showLoadingAnimal:NO hudContent:@"Loading..." delegate:self];
}

#pragma mark - API请求结果回调
- (void)interfaceExcuteSuccess:(id)retObj apiName:(NSString *)ApiName
{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    
    [self edittingHandleForState:YES];
    
    if([ApiName isEqualToString:kApiMethod_GetWithDrawCashRule]) //获取提现规则
    {
        
        resMod_CallBack_GetWithDrawCashRule *backObj = [[resMod_CallBack_GetWithDrawCashRule alloc]initWithDic:retObj];
        _ruleModel = backObj.ResponseData;
        [self reloadData];
    }
    
    if([ApiName isEqualToString:kApiMethod_WithDrawCashToAlipay] || [ApiName isEqualToString:kApiMethod_WithDrawCashToCreditCard]) //提现到支付宝 和 银行卡
    {
        [self HUDShow:@"提交成功！" delay:1];
        [self WithdrawsHistory:nil];
    }
    
}

- (void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName {
    [super interfaceExcuteError:error apiName:ApiName];
    [self hudWasHidden:HUD];
    NSString * warnMsg = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
    [self blurProcess:warnMsg];
}


- (void)blurProcess:(NSString *)warnMsg
{
    [self edittingHandleForState:NO];
    NZAlertView *alert = [[NZAlertView alloc]initWithStyle:NZAlertStyleInfo title:@"温馨提示" message:warnMsg];
    alert.alertDuration = MAXFLOAT;
    [alert show];
}

- (void)edittingHandleForState:(BOOL)state
{
    UIColor *backColor = state?color_fc4a00:color_989898;
    
    if (_mode == AlipayMode) {
        
        for (int i = 1; i < 5; i++) {
             EC_UITextField *Text = (EC_UITextField*)[self.view viewWithTag:ALIPAY_TEXTFIELD_BASE_TAG+i];
            Text.userInteractionEnabled = state;
        }
        
        UIButton *commitButton = (UIButton*)[self.view viewWithTag:ALIPAY_TEXTFIELD_BASE_TAG+5];
        commitButton.enabled = state;
        [commitButton setBackgroundColor:backColor];
        
    }else if (_mode == CreditCartMode){
        
        for (int i = 1; i < 6; i++) {
            EC_UITextField *Text = (EC_UITextField*)[self.view viewWithTag:BANKPAY_TEXTFIELD_BASE_TAG+i];
          Text.userInteractionEnabled = state;
        }
        
        UIButton *commitButton = (UIButton*)[self.view viewWithTag:BANKPAY_TEXTFIELD_BASE_TAG+6];
        commitButton.enabled = state;
    
       [commitButton setBackgroundColor:backColor];
    }

}



#pragma mark - textfileld delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 取textfield 的数据

- (NSArray*)getTextfieldDataForMode:(CurrentMode)mode
{
    if (mode == AlipayMode) {
        EC_UITextField *moneyTextField = (EC_UITextField*)[self.view viewWithTag:ALIPAY_TEXTFIELD_BASE_TAG+1];
        EC_UITextField *aliAccountTextField = (EC_UITextField*)[self.view viewWithTag:ALIPAY_TEXTFIELD_BASE_TAG+2];
        EC_UITextField *nameTextField = (EC_UITextField*)[self.view viewWithTag:ALIPAY_TEXTFIELD_BASE_TAG+3];
        EC_UITextField *pwdTextField = (EC_UITextField*)[self.view viewWithTag:ALIPAY_TEXTFIELD_BASE_TAG+4];
        return @[moneyTextField.text,aliAccountTextField.text,nameTextField.text,pwdTextField.text];
        
    }else if (mode == CreditCartMode){
        
        EC_UITextField *moneyTextField = (EC_UITextField*)[self.view viewWithTag:BANKPAY_TEXTFIELD_BASE_TAG+1];
        EC_UITextField *bankCartNoTextField = (EC_UITextField*)[self.view viewWithTag:BANKPAY_TEXTFIELD_BASE_TAG+2];
        EC_UITextField *bankAccountTextField = (EC_UITextField*)[self.view viewWithTag:BANKPAY_TEXTFIELD_BASE_TAG+3];
        EC_UITextField *bankNameTextField = (EC_UITextField*)[self.view viewWithTag:BANKPAY_TEXTFIELD_BASE_TAG+4];
        EC_UITextField *pwdTextField = (EC_UITextField*)[self.view viewWithTag:BANKPAY_TEXTFIELD_BASE_TAG+5];
        return @[moneyTextField.text,bankCartNoTextField.text,bankAccountTextField.text,bankNameTextField.text,pwdTextField.text];
    }
    else{
        return @[];
    }
}


#pragma mark - 按钮事件
- (void)aliPayClick:(id)sender
{
    [MobClick event:@"balanceOfAccount_withdrawCashToAlipay"];
    
    NSArray *dataArray = [self getTextfieldDataForMode:AlipayMode];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSArray *keys = @[@"Cash",@"Account",@"Name",@"PayPassword"];
    for (NSUInteger i = 0; i < dataArray.count; i++) {
        if(i == dataArray.count - 1){
           
            [para setValuesForKeysWithDictionary:@{
                                                   keys[i]: [NSString YKMD5:dataArray[i]]
                                                   }];
        }
        else
        {
            [para setValuesForKeysWithDictionary:@{
                                                   keys[i]:dataArray[i]
                                                   }];
        }
        
    }
    [para setValue:[UserUnit userId] forKey:@"UserId"];
    [para setValue:[NSString stringWithFormat:@"%d",1000] forKey:@"debug"];

    [[APIMethodHandle shareAPIMethodHandle]goApiRequestLifeWithDrawCashToAlipay:para ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在提交，请稍后..." delegate:self];
    
}

- (void)creditPayClick:(id)sender
{
    [MobClick event:@"balanceOfAccount_withdrawCashToBankcard"];
    NSArray *dataArray = [self getTextfieldDataForMode:CreditCartMode];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    NSArray *keys = @[@"Cash",@"Account",@"Name",@"CreditCardBank",@"PayPassword"];
    
    for (NSUInteger i = 0; i < dataArray.count; i++) {
        if(i == dataArray.count - 1){
            
            [para setValuesForKeysWithDictionary:@{
                                                   keys[i]: [NSString YKMD5:(NSString*)dataArray[i]]
                                                   }];
        }
        else{
            [para setValuesForKeysWithDictionary:@{
                                                   keys[i]:dataArray[i]
                                                   }];

        }
    }
    [para setValue:[UserUnit userId] forKey:@"UserId"];
     [para setValue:[NSString stringWithFormat:@"%d",1000] forKey:@"debug"];
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestLifeWithDrawCashToCreditCard:para ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在提交，请稍后..." delegate:self];
}

- (void)WithdrawsHistory:(id)sender
{
//<<<<<<< .mine
     [MobClick event:@"balanceOfAccount_recordOfWithdrawCash"];
  //  BQWithdrawsHistoryViewController *vc = [[BQWithdrawsHistoryViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:^{
//        
//    }];

    [self pushNewViewController:@"BQWithdrawsHistoryViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:nil];
//=======
//    BQWithdrawsHistoryViewController *vc = [[BQWithdrawsHistoryViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:^{
//        
//    }];
//>>>>>>> .r2481
}
//- (void)

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([[change valueForKey:@"new"]integerValue] == [[change valueForKey:@"old"]integerValue]) {
        return;
    }
   
    if ([keyPath isEqualToString:@"selectedSegmentIndex"] && [[object class] isSubclassOfClass:[UISegmentedControl class]]) {
         NSLog(@">>>>>>>%@ ",change);
        switch ([[change valueForKey:@"new"]integerValue]) {
            case 0:
                [self goApiRequest_GetWithDrawCashRuleForMode:AlipayMode];
                break;
            case 1:
                [self goApiRequest_GetWithDrawCashRuleForMode:CreditCartMode];
                break;
                
            default:
                break;
        }
    }
    
    
}


#pragma mark - reloadData

- (void)reloadData
{
    _balanceLabel.alpha = 0;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //
        _balanceLabel.text = [NSString stringWithFormat:@"<font size=18 color='#ffffff'>今日可提现金额:</font><b><font size=25 color='#ffffff'>  %.2f</font></b><font color='#ffffff' size=18> 元</font>",_ruleModel.AvailableCash];
         CGSize balanceSize = [_balanceLabel optimumSize];
        balanceSize.width > __MainScreen_Width -10-25-10 ? _balanceLabel.text = [NSString stringWithFormat:@"<font size=16 color='#ffffff'>今日可提现金额:</font><b><font size=18 color='#ffffff'>  %.2f</font></b><font color='#ffffff' size=13> 元</font>",_ruleModel.AvailableCash]:nil;
        
         balanceSize.width > __MainScreen_Width -10-25-10 ?(_balanceLabel.frame = CGRectMake(10+25+10, kNavBarViewHeight+TOP_BG_VIEW_HEIGHT/2 - TOP_BG_VIEW_HEIGHT/2 + 13 + 6, __MainScreen_Width - 10, TOP_BG_VIEW_HEIGHT/2-6)):(_balanceLabel.frame = CGRectMake(10+25+10, kNavBarViewHeight+TOP_BG_VIEW_HEIGHT/2 - TOP_BG_VIEW_HEIGHT/2 + 13, balanceSize.width, TOP_BG_VIEW_HEIGHT/2-6));

        
        _balanceLabel.alpha = 1;
        
        //
        _ruleLabel.text = [NSString stringWithFormat:@"<b><font size=12 color='#def7a9'>提现规则: %@</font></b>",_ruleModel.Rule];
        CGSize ruleSize = [_ruleLabel optimumSize];
        ruleSize.width > __MainScreen_Width -10 ? (_ruleLabel.frame = CGRectMake(10, kNavBarViewHeight+TOP_BG_VIEW_HEIGHT/2 + 3, __MainScreen_Width - 10, TOP_BG_VIEW_HEIGHT/2-6)):(_ruleLabel.frame = CGRectMake(10, kNavBarViewHeight+TOP_BG_VIEW_HEIGHT/2 + 3, ruleSize.width, TOP_BG_VIEW_HEIGHT/2-6));
        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)dealloc
{
    
    [_segment removeObserver:self forKeyPath:@"selectedSegmentIndex"];
    
}

//#pragma mark - history
//- (void) navView{
//    
//    if (IOS7_OR_LATER) {
//        UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(WithdrawsHistory:)];
//        [r_bar setTitlePositionAdjustment:UIOffsetMake(-5, 0) forBarMetrics:UIBarMetricsDefault];
//        r_bar.tintColor = color_989898;
//        
//        self.navigationItem.rightBarButtonItem = r_bar;
//
//        [self.navigationItem.rightBarButtonItem setTitleTextAttributes: @{ UITextAttributeFont: [UIFont systemFontOfSize:15.0f],UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]}  forState:UIControlStateNormal];
//    }
//    else{
//        BQCustomBarButtonItem *barItem = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
//        barItem.titleRect = CGRectMake(0, 0, 60, 30);
//        
//        barItem.titleLabel.text = @"提现记录";
//        barItem.titleLabel.font = defFont15;
//        barItem.titleLabel.textColor = color_989898;
//        
//        barItem.delegate = self;
//        barItem.selector = @selector(WithdrawsHistory:);
//        
//        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barItem];
//        
//        self.navigationItem.rightBarButtonItem = barButtonItem;
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
