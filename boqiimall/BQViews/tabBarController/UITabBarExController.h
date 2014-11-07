//
//  UITabBarExController.h
//  ule_specSale
//
//  Created by YSW.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EC_UICustomAlertView.h"

#import "IndexBqiMallController.h"
#import "IndexViewController.h"
#import "ShoppingCartViewController.h"
#import "myCenterViewController.h"

#import "MyMallOrderListController.h"
#import "MyOrderViewController.h"

@interface UINavigationBar (UINavigationBarImage)

@end

@interface UITabBarExController : UITabBarController<UITabBarControllerDelegate,EC_UICustomAlertViewDelegate>
{
    
//    UINavigationController *      _navCtrl_Page1;
//    UINavigationController *      _navCtrl_Page2;
//    UINavigationController *      _navCtrl_Page3;
//    UINavigationController *      _navCtrl_Page4;
    
    IndexBqiMallController  *tab_nav1;
    IndexViewController     *tab_nav2;
    ShoppingCartViewController *tab_nav3;
    myCenterViewController  *tab_nav4;
    
    UIImageView *                   _backgroundView;
}

@property (nonatomic, assign) int	currentSelectedIndex;
@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) NSString       *sNotificationMsg;

- (void)setTabBarBackground:(int)index;


@end
