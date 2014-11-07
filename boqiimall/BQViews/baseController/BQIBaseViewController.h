//
//  BQIBaseViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-4-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoDataView.h"
#import "LoadingAnimationView.h"

#import "InterfaceAPIDelegate.h"
#import "BaseViewLoadingAnimationDelegate.h"
#import "EC_UICustomAlertView.h"
#import "MBProgressHUD.h"
#import "BQNavBarView.h"

@class LoginViewController;
@protocol BQIBaseViewControllerDelegate <NSObject>
@end

@interface BQIBaseViewController : UIViewController<MBProgressHUDDelegate,InterfaceAPIDelegate,EC_UICustomAlertViewDelegate,BaseViewLoadingAnimationDelegate> {
    
    BOOL                     isShowNavBar;  //是否显示导航
    BOOL                     isRootPage;    //根页面标识符
    MBProgressHUD          * HUD;
    NSMutableDictionary    * receivedParams;//页面接收的参数
    
    
    BQNavBarView *_navBarView;       //自定义NavBar
    UIView *_subNavBarView;
    UILabel *_titleLabel;
    UIButton *backBtn;
}
@property (nonatomic, assign) id<BQIBaseViewControllerDelegate> Delegate;
@property (nonatomic, strong) NoDataView * noDataView;                          // 空数据 页面
@property (nonatomic, strong) LoadingAnimationView * lodingAnimationView;       // 加载时动画
@property (nonatomic, strong) UILabel * lblTitle;                               // 页面标题
@property (nonatomic, strong) BQNavBarView *navBarView;
@property (nonatomic,strong)  UIView *subNavBarView;
@property (nonatomic,strong)  UILabel *_titleLabel;
@property (nonatomic,strong)  UIButton *backBtn;

@property (nonatomic, assign) BOOL     isRootPage;                  //根页面标识符
@property (nonatomic, strong) NSString  * backImgName;              //返回按钮图片名
@property (nonatomic, strong) NSMutableDictionary * receivedParams; //页面接收的参数
@property (nonatomic, strong) NSMutableDictionary * dicAllPages;       //友盟统计 所有view controll


- (void)loadNavBarView;

//  --  push new controller
- (void)pushNewViewController:(NSString *)controllerName
                    isNibPage:(BOOL) _isNib
                   hideTabBar:(BOOL) _bool
                  setDelegate:(BOOL) b_delegate
                setPushParams:(NSMutableDictionary *) _pushParams;
//  --  返回。
- (void)goBack:(id)sender;
- (void)goLogin:(NSString *) loginSuccessPushController param:(id) dicParam delegate:(id) _logindelegate;

#pragma mark    --  NavBar 显示与隐藏
-(void)NavController_Show:(BOOL) showOrHidden animated:(BOOL) animated;
#pragma mark    --  tabar显示与隐藏
- (void)tabBar_Show:(UITabBarController *) tabbarcontroller;
- (void)tabBar_Hidden:(UITabBarController *) tabbarcontroller;

//  -- HUD
- (void) initHUD;
- (void) HUDShow:(NSString*)text;
- (void) HUDShow:(NSString*)text delay:(float)second;
- (void) HUDShow:(NSString*)text delay:(float)second dothing:(BOOL)bDo;
- (void) hudWasHidden:(MBProgressHUD *)hud;

//  -- api 购物车数量
-(void)goApiRequest_GetCartNum;


//  -- 转 钱
- (NSString*) convertPrice:(float) price;
//  -- 转 距离
- (NSString*) convertDistance:(float) distance;
//  -- post 到服务器用到的商品信息
- (NSString*) convertGoodsInfoForApiParams:(NSMutableArray*) paramGoodsList;

@end


