//
//  UITabBarExController.m
//  ule_specSale
//
//  Created by YSW on 13-7-26.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UITabBarExController.h"

//#import "IndexBqiMallController.h"
//#import "IndexViewController.h"
//#import "ShoppingCartVController.h"
//#import "myCenterViewController.h"



#define kDateForAppRating @"kDateForAppRating"
#define kIntervalTimeForAppRating 60*60*24*14   //两周时间提示一次评价
//#define kIntervalTimeForAppRating 60*6

//@implementation UINavigationBar (UINavigationBarImage)
//- (void)drawRect:(CGRect)rect {
//    UIImage *image = [[UIImage imageNamed:@"bg_common.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:6];
//    [image drawInRect:CGRectMake(0, 0, 320, 44)];
//}
//@end

@implementation UITabBarExController
@synthesize sNotificationMsg;

- (id)init {
    self = [super init];
    if (self)
    {
        tab_nav1 = [[IndexBqiMallController alloc] init];
        tab_nav2 = [[IndexViewController alloc]init];
        tab_nav3 = [[ShoppingCartViewController alloc]init];
        tab_nav4 = [[myCenterViewController alloc]init];

//        IndexBqiMallController  *tab_nav1 = [[IndexBqiMallController alloc] init];
//        IndexViewController     *tab_nav2 = [[IndexViewController alloc]init];
////        ShoppingCartVController *tab_nav3 = [[ShoppingCartVController alloc]init];
//        ShoppingCartViewController *tab_nav3 = [[ShoppingCartViewController alloc] init];
//        myCenterViewController  *tab_nav4 = [[myCenterViewController alloc]init];
        
//        _navCtrl_Page1 = [[UINavigationController alloc] initWithRootViewController:tab_nav1];
//        _navCtrl_Page2 = [[UINavigationController alloc] initWithRootViewController:tab_nav2];
//        _navCtrl_Page3 = [[UINavigationController alloc] initWithRootViewController:tab_nav3];
//        _navCtrl_Page4 = [[UINavigationController alloc] initWithRootViewController:tab_nav4];
        
//        _navCtrl_Page1.hidesBottomBarWhenPushed = YES;
//        _navCtrl_Page2.hidesBottomBarWhenPushed = YES;
//        _navCtrl_Page3.hidesBottomBarWhenPushed = YES;
//        _navCtrl_Page4.hidesBottomBarWhenPushed = YES;
        
//        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
//            [_navCtrl_Page1.navigationBar setBackgroundImage:[[UIImage imageNamed:@"NavBg_f4f4f4_ios7.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:6] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//            [_navCtrl_Page2.navigationBar setBackgroundImage:[[UIImage imageNamed:@"NavBg_ffffff_ios7.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:6] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//            [_navCtrl_Page3.navigationBar setBackgroundImage:[[UIImage imageNamed:@"NavBg_ffffff_ios7.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:6] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//            [_navCtrl_Page4.navigationBar setBackgroundImage:[[UIImage imageNamed:@"NavBg_ffffff_ios7.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:6] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//        }
//        else{
//            [_navCtrl_Page1.navigationBar setBackgroundImage:def_ImgStretchable(@"NavBg_ffffff.png", 5, 20)
//                                               forBarMetrics:UIBarMetricsDefault];
//            [_navCtrl_Page2.navigationBar setBackgroundImage:def_ImgStretchable(@"NavBg_ffffff.png", 5, 20)
//                                               forBarMetrics:UIBarMetricsDefault];
//            [_navCtrl_Page3.navigationBar setBackgroundImage:def_ImgStretchable(@"NavBg_ffffff.png", 5, 20)
//                                               forBarMetrics:UIBarMetricsDefault];
//            [_navCtrl_Page4.navigationBar setBackgroundImage:def_ImgStretchable(@"NavBg_ffffff.png", 5, 20)
//                                               forBarMetrics:UIBarMetricsDefault];
//        }
        
        //  -- 去黑线 加阴影
        id appearance = [UINavigationBar appearance];
        [appearance setShadowImage:[UIImage imageNamed:@"shadow_down.png"]];
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
#if APPVERSIONTYPE
//        [items addObject:_navCtrl_Page1];
//        [items addObject:_navCtrl_Page2];
//        [items addObject:_navCtrl_Page3];
//        [items addObject:_navCtrl_Page4];
        
        [items addObject:tab_nav1];
        [items addObject:tab_nav2];
        [items addObject:tab_nav3];
        [items addObject:tab_nav4];
#else
        [items addObject:_navCtrl_Page2];
        [items addObject:_navCtrl_Page4];
#endif
        self.viewControllers = items;
        
#if ! __has_feature(objc_arc)
        [items release]; //Mark
        
        [tab_nav1 release];
        [tab_nav1 release];
        [tab_nav1 release];
        [tab_nav1 release];
#endif
        
        [self setSelectedIndex:0];
    }
    return self;
}

//ansen 配合BaseUserController.h中的UITabBar使用。
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(gotoRoot:)
                                                 name: @"gotoRootNotification"
                                               object: nil];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(showRatingAlertView) withObject:nil afterDelay:3.0];
}

- (void)showRatingAlertView
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kDateForAppRating])
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kDateForAppRating];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        NSDate *lastDate =[[NSUserDefaults standardUserDefaults] objectForKey:kDateForAppRating];
        NSDate *nowDate = [NSDate date];
        if ([nowDate timeIntervalSinceDate:lastDate] >= kIntervalTimeForAppRating)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kDateForAppRating];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"给波奇宠物评价"
                                                                                  message:@"感谢您使用波奇宠物，如果喜欢我们的产品，欢迎您去App Store上给我们评价哦!"                                                                cancelButtonTitle:@"下次再说"
                                                                            okButtonTitle:@"去评价"];
            alertView.delegate1 = self;
            [alertView show];
        }
        
    }
    
}

-(void)alertView:(EC_UICustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_APPSTOREURL]];
    }
    [alertView hide];
}




- (void) gotoRoot:(NSNotification *) loginStatus{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
  //  [self.navigationController popToViewController:self animated:YES];
    self.sNotificationMsg = (NSString*) loginStatus.object;
    if (self.sNotificationMsg.length>0) {
       if ([self.sNotificationMsg isEqualToString:@"goMallOrder"]) {
            [self setSelectedIndex:3];
          // [self performSelector:@selector(selectTabView:) withObject:@"3" afterDelay:0.0];
           //[self selectTabView:3];
        }
        
        if ([self.sNotificationMsg isEqualToString:@"goBoqiiLifeOrder"]) {
            [self setSelectedIndex: APPVERSIONTYPE?3:1];
          //  [self selectTabView:APPVERSIONTYPE?3:1];
            //[self performSelector:@selector(selectTabView:) withObject:[NSString stringWithFormat:@"%d",APPVERSIONTYPE?3:1] afterDelay:0.0];
        }
    }
}


- (void)selectTabView:(NSString *)indexStr
{
    [self setSelectedIndex:indexStr.integerValue];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    if (viewController == tab_nav1) {
        [MobClick event:@"navigationBar_mall"];
        [PMGlobal shared].tabBarIndex = @"0";
        [self setTabBarBackground:1];
    }
    else if(viewController == tab_nav2){
        [MobClick event:@"navigationBar_service"];
        [PMGlobal shared].tabBarIndex = APPVERSIONTYPE?@"1":@"0";
        [self setTabBarBackground: APPVERSIONTYPE?2:1];
    }
    else if(viewController == tab_nav3){
        [MobClick event:@"navigationBar_shoppingCart"];
        [PMGlobal shared].tabBarIndex = @"2";
        [self setTabBarBackground:3];
    }
    else if(viewController == tab_nav4){
        [MobClick event:@"navigationBar_myBoqii"];
        [PMGlobal shared].tabBarIndex = APPVERSIONTYPE?@"3":@"1";
        [self setTabBarBackground: APPVERSIONTYPE?4:2];
    }
    
    return YES;
}

- (void)setNoHighlightTabBar {
    NSArray * tabBarSubviews = [self.tabBar subviews];
    for(int i = [tabBarSubviews count] - 1; i > 0; i--){
        for(UIView * v in [[tabBarSubviews objectAtIndex:i] subviews])
        {
            if(v && [NSStringFromClass([v class]) isEqualToString:@"UITabBarSelectionIndicatorView"])
            {   //the v is the highlight view.
                [v removeFromSuperview];
                break;
            }
        }
    }
}
#pragma mark -
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
    [self setTabBarBackground:selectedIndex+1];
}

- (void)setTabBarBackground:(int)index {
    
    [self setNoHighlightTabBar];
    NSString *strImage = [NSString stringWithFormat:@"tabbar_bg_%d%@",index,@".png"];
    if (!APPVERSIONTYPE) {
        strImage = [NSString stringWithFormat:@"tabbar_bg_BQLIFE_%d%@",index,@".png"];
    }
    if ([self.tabBar respondsToSelector:@selector(setBackgroundImage:)]) {
        
        [self.tabBar setBackgroundColor:[UIColor clearColor]];
        [self.tabBar setBackgroundImage:[UIImage imageNamed:strImage]];
        
        [self.tabBar setShadowImage:[[UIImage imageNamed:@"shadow_up.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:0]];
    }
    else {
        if (_backgroundView == nil) {
            _backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:strImage]];
            _backgroundView.frame = CGRectMake(0.f, 0.f,
                                               self.tabBar.frame.size.width,
                                               self.tabBar.frame.size.height);
            _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self.tabBar addSubview:_backgroundView];
            [self.tabBar sendSubviewToBack:_backgroundView];
            
#if ! __has_feature(objc_arc)
            [_backgroundView release];
#endif
        }
        else
        {
            [_backgroundView setImage:[UIImage imageNamed:strImage]];
        }
    }
}

#if ! __has_feature(objc_arc)
- (void)dealloc {
    [super dealloc];
}
#endif
@end
