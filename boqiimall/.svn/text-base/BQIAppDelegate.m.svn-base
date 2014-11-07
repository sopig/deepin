//
//  BQIAppDelegate.m
//  BoqiiLife
//
//  Created by YSW on 14-4-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIAppDelegate.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import <ShareSDK/ShareSDK.h>
//#import <Parse/Parse.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <RennSDK/RennSDK.h>

#import "UIViewController+MLTransition.h"
#import "WXApi.h"
#import "WeiboApi.h"
#import "APService.h"
#import "BQImageview.h"
#import "BQ_global.h"


#define APP_SHOW_WELCOME_PAGE_KEY @"APP_SHOW_WELCOME_PAGE_KEY"
#define APP_HAS_ALREADY_LANUCH_KEY @"APP_HAS_ALREADY_LANUCH_KEY" //是否已经运行过

#define CHECK_VERSION_IS_SHOW @"CHECK_VERSION_IS_SHOW"


#define IMG_TAG_BASE 12345

@implementation BQIAppDelegate
//@synthesize managedObjectContext = _managedObjectContext;
//@synthesize managedObjectModel = _managedObjectModel;
//@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

@synthesize locationManage;
//@synthesize mkOperation;
@synthesize tabbarController;
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if(!IOS7_OR_LATER){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    }
    else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //  -- crash 日志
    _uncaughtExceptionHandler = NSGetUncaughtExceptionHandler();
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    [MemoryData initialize];
    [self connectionStatus];    // 网络连接
    [self LoadLocation];        // 取经纬度
    [self initUmengTrack];          // 友盟的方法本身是异步执行，所以不需要再异步调用
    [self initJpush:launchOptions]; //  推送

    [ShareSDK registerApp: ShareSDK_APPKEY];     //此方法必须在启动时调用，否则会限制SDK的使用。
//    [Parse setApplicationId:parseAPPID clientKey:parseClientKey];   //  --使用shareSDK登录
    [self initializeShareSDKPlat];
    [WXApi registerApp:tencentWXAppID withDescription:@"boqiiMall"];
    
    [self checkVersion];        //  版本检测
    [self reSetCacheTime];      //  缓存过的接口，但又需每次启动时刷新
    
    // --此句来启用 滑动返回 即可
    if (IOS7_OR_LATER)
    {
        [UIViewController validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    }
    

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isHasAlreadyLanuch = [[defaults objectForKey:APP_HAS_ALREADY_LANUCH_KEY] boolValue];

    tabbarController = [[UITabBarExController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tabbarController];
    [navController setNavigationBarHidden:YES];
    [self.window setRootViewController:navController];
    
    if (APPVERSIONTYPE) {
        if (isHasAlreadyLanuch) {
            float versionInDefault_ForLastRemerber = [[defaults objectForKey:APP_SHOW_WELCOME_PAGE_KEY] floatValue];
            float versionInConfig_ForNeedShowWelcome = [APP_NEED_SHOW_WELCOMEPAGE floatValue];
            if (versionInConfig_ForNeedShowWelcome > versionInDefault_ForLastRemerber) {
                [self loadWelcomePage];
            }
        }
        else{
            [self loadWelcomePage];
        }
    }
    
    SDWebImageManager *shareSDWebImageManager = [SDWebImageManager sharedManager];
    shareSDWebImageManager.delegate = self;
    return YES;
}



//  -- SDWebImageManager
- (BOOL)imageManager:(SDWebImageManager *)imageManager shouldDownloadImageForURL:(NSURL *)imageURL {
    
    BOOL b_download = YES;
    if ([BQ_global showImgOnlyWIFI]) {
        b_download = [[BQ_global netWorkType] isEqualToString:@"WIFI"] ? YES : NO;
    }
    return b_download;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self writeHasRun];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

    [self writeHasRun];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
//    [self checkVersion];
//    [self reSetCacheTime];      // 缓存过的接口，但又需每次启动时刷新
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext {
//    NSError *error = nil;
//    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
//    if (managedObjectContext != nil) {
//        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
//             // Replace this implementation with code to handle the error appropriately.
//             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        } 
//    }
}
#pragma mark    --  极光推送 接收消息 ing
// iPhone 从APNs服务器获取deviceToken后激活该方法.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
}

// 注册push功能失败 后 返回错误信息，执行相应的处理.
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self comingFromNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
   
    [self comingFromNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}

//  本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}
#pragma mark    --  极光推送 接收消息 end

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if([sourceApplication isEqualToString:@"com.tencent.mqq"]
       ||[sourceApplication isEqualToString:@"com.sina.weibo"]){
    
        return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:nil];
    }
    
    if([sourceApplication isEqualToString:@"com.alipay.iphoneclient"]
       || [sourceApplication isEqualToString:@"com.alipay.safepayclient"]){
        [self alipayParse:url application:application];
    }
    
    if ([sourceApplication isEqualToString:@"com.tencent.xin"])
    {
        return [WXApi handleOpenURL:url delegate:[WXHandle shareWXHandle]];
    }
   
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {

//    return [ShareSDK handleOpenURL:url wxDelegate:nil];
    
    [WXApi handleOpenURL:url delegate:[WXHandle shareWXHandle]];
    
    return YES;
}

//  -- 支付宝回调
- (void)alipayParse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    if (result!=nil) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationAliPayResult"
                                                            object:[NSString stringWithFormat:@"%d",result.statusCode]];
    }
//	if (result) {
//		if (result.statusCode == 9000) {
//			
//            /* 交易成功..
//			 * 用公钥验证签名 严格验证请使用result.resultString与result.signString验签
//			 */
//            
//            //            NSString* key = @"签约帐户后获取到的支付宝公钥";
//            //			id<DataVerifier> verifier;
//            //            verifier = CreateRSADataVerifier(key);
//            //
//            //			if ([verifier verifyString:result.resultString withSign:result.signString])
//            //            {
//            //                //验证签名成功，交易结果无篡改
//            //			}
//        }
//        else {
//            //交易失败
//        }
//    }
//    else {
//        //失败
//    }
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	
    AlixPayResult * result = nil;
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
        
        NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		result = [[AlixPayResult alloc] initWithString:query];
	}
	return result;
}
/*
#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BoqiiLife" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BoqiiLife.sqlite"];
    NSError *error = nil;
    
    _persistentStoreCoordinator=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory
// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
*/

# pragma mark   --  初始化工作 数据
/************************************************************
 *                         网 络 连 接
 ************************************************************/
//#if 0
//- (void)connectionStatus {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
//                                                 name:kReachabilityChangedNotification object:nil];
//    
//    //  -- 商城
//    hostReach_mall = [Reachability reachabilityWithHostname:kHostUrl_boqiiMall];
//    [hostReach_mall startNotifier];
//    
//    //  -- 生活馆
//    hostReach_life = [Reachability reachabilityWithHostname:kHostUrl_boqiiLife];
//    [hostReach_life startNotifier];
//}
//
//- (void)reachabilityChanged:(NSNotification *)note {
//    Reachability *  curReach = [note object];
//    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
//    [self updateInterfaceWithReachability:curReach];
//}
//
//- (void)updateInterfaceWithReachability:(Reachability *)curReach {
//    if (curReach == hostReach_mall || curReach == hostReach_life) {
//        // 網絡已連接
//        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable)
//        {
//            NetworkStatus netStatus = [curReach currentReachabilityStatus];
//            // 網絡连接类型
//            switch (netStatus) {
//                case NotReachable:      HEAD_VALUE_WANTYPE = @"NotReachable";
//                    break;
//                case ReachableViaWWAN:  HEAD_VALUE_WANTYPE = @"WWAN";   // 窩蜂連接
//                    break;
//                case ReachableViaWiFi:  HEAD_VALUE_WANTYPE = @"WiFi";   // wifi連接
//                    break;
//            }
//        }
//        else {
//            // 未连接网络
//            HEAD_VALUE_WANTYPE = @"NotReachable";
//        }
//        
//        [MemoryData setCommonParam:HEAD_KEY_WANTYPE value:HEAD_VALUE_WANTYPE];
//        
//        if ([HEAD_VALUE_WANTYPE isEqualToString:@"NotReachable"]) {
//            
//            [PMGlobal shared].isHttp = NO;          //无网络
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetWork" object:nil];
//            
//            EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"温馨提示"
//                                                                                  message:@"似乎已断开网络连接"
//                                                                        cancelButtonTitle:nil
//                                                                            okButtonTitle:@"确定"];
//            alertView.delegate1 = self;
//            [alertView setTag:2392];
//            [alertView show];
//
//        }
//        else{
////            NSLog(@"---已切换至：%@",HEAD_VALUE_WANTYPE);
//            [PMGlobal shared].isHttp = YES;
//        }
//    }
//}
//#endif

- (void)connectionStatus
{
   __block AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                HEAD_VALUE_WANTYPE = @"NotReachable";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                HEAD_VALUE_WANTYPE = @"WWAN";   // 窩蜂連接
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                HEAD_VALUE_WANTYPE = @"WiFi";   // wifi連接
                break;
  
            default:
                break;
        }
        
        [MemoryData setCommonParam:HEAD_KEY_WANTYPE value:HEAD_VALUE_WANTYPE];
        
        if ([HEAD_VALUE_WANTYPE isEqualToString:@"NotReachable"]) {
            
            [PMGlobal shared].isHttp = NO;          //无网络
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetWork" object:nil];
            
            NZAlertView *alert = [[NZAlertView alloc]initWithStyle:NZAlertStyleInfo title:@"温馨提示" message:@"似乎已断开网络连接" delegate:self];
            
            [alert showWithCompletion:^{
                [alert removeFromSuperview];
            }];
            
            
        }
        else{
            [PMGlobal shared].isHttp = YES;
        }
    }];
}


/************************************************************
 *                         发送错误日志
 ************************************************************/
void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *exUserInfo = [NSString stringWithFormat:@"<br/>USERID:%@; APP-VERSION:%@<br/>",[UserUnit userId],APP_VERSION];
    NSString *exReason = [exception reason];
    NSString *exname = [exception name];
    
    NSString *urlStr = [NSString stringWithFormat:@"mailto:yswboqii@163.com?subject=BUG报告--BOQIIMALL&body=感谢您的配合!<br><br><br>错误详情:%@<br/>%@<br/>--------------------------<br/>%@<br/>---------------------<br/>%@", exUserInfo,exname,exReason,[arr componentsJoinedByString:@"<br>"]];
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

/************************************************************
 *                         更 新 缓 存 时 间 : 对于每次启动需更新的接口，请在这里设置下
 ************************************************************/
- (void) reSetCacheTime{
    //  --  保存本次更新时间
    NSString *pathUpdateTime = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent: MemoryFileName];
    NSMutableDictionary *pdic = [[[NSMutableDictionary alloc]initWithContentsOfFile:pathUpdateTime] mutableCopy];
    
    if (pdic==nil) {
        pdic = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    for (NSString * skey in [[PMGlobal shared] ApiKeyForMemoryResponseJson].allKeys) {
        [pdic setObject:[NSDate date] forKey:[NSString stringWithFormat:@"updateTime%@",skey]];
        [pdic setValue:@"PleaseApiRequest" forKey:[NSString stringWithFormat:@"Launch%@",skey]];
    }
    
    [pdic writeToFile:pathUpdateTime atomically:YES];
}
/************************************************************
 *                         定 位 : 取 经 纬 度
 ************************************************************/
- (void) LoadLocation{
    self.locationManage = [[CLLocationManager alloc]init];
    self.locationManage.delegate = self;
    self.locationManage.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManage.distanceFilter = 10;
//    if(IOS8_OR_LATER) {
//        [self.locationManage requestAlwaysAuthorization];
//    }
    [self.locationManage startUpdatingLocation];
}

- (void) locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    // 获取当前的地理坐标
    CLLocationDistance  l = newLocation.coordinate.latitude;    //获取经度
    CLLocationDistance  v = newLocation.coordinate.longitude;   //获取纬度
    
    _lat = l;
    _lon = v;

    [self.locationManage stopUpdatingLocation];
}

/************************************************************
 *                         版 本 检 测
 ************************************************************/
- (void) checkVersion{
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] init];
    [dicParams setObject:kApiMethod_GetVersionInfo forKey:APP_ACTIONNAME];
    [dicParams setObject:APP_VERSIONNUM forKey:@"Version"];
    if (!APPVERSIONTYPE) {
        //--不传type表示商城版app，传1表示独立生活馆app
        [dicParams setObject:@"1" forKey:@"Type"];
    }
    InterfaceAPIExcute *inter = [[InterfaceAPIExcute alloc] initWithAPI:api_BOQIILIFE
                                                                apiPath:kApiUrl(api_BOQIILIFE)
                                                               retClass:@"resMod_CallBack_LastVersion"
                                                                 Params:dicParams setDelegate:self];
    [inter beginRequest];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    if ([ApiName isEqualToString:kApiMethod_GetVersionInfo]) {
        resMod_CallBack_LastVersion * backObj = [[resMod_CallBack_LastVersion alloc] initWithDic:retObj];//retObj;
        versionInfo = backObj.ResponseData;
        
        if ([versionInfo isKindOfClass:[resMod_LastVersionInfo class]]) {
            if (versionInfo.VersionStatus == 1) {
                EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"有新版本可用"
                                                                                      message:versionInfo.UpdateMsg
                                                                            cancelButtonTitle:@"现在更新"
                                                                                okButtonTitle:nil];
                alertView.delegate1 = self;
                [alertView show];
            }
            else if(versionInfo.VersionStatus == 2) {
                EC_UICustomAlertView  *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"有新版本可用"
                                                                                      message:versionInfo.UpdateMsg
                                                                            cancelButtonTitle:@"以后再说"
                                                                                okButtonTitle:@"现在更新"];
                alertView.delegate1 = self;
                [alertView show];
            }
        }
    }
}

//-- 请求出错时
-(void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName {
    if ([ApiName isEqualToString:kApiMethod_GetVersionInfo]) {
        
    }
}

/************************************************************
 *                         友 盟 : 数 据 监 测
 ************************************************************/
- (void) initUmengTrack {
//    [MobClick setCrashReportEnabled:NO];  // 如果不需要捕捉异常，注释掉此行
//    [MobClick setLogEnabled:YES];         // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:APP_VERSION];   //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy)REALTIME channelId:nil];
    
//    [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
//    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
//    1.6.8之前的初始化方法
//    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:)
                                                 name:UMOnlineConfigDidFinishedNotification object:nil];
}

- (void)onlineConfigCallBack:(NSNotification *)note {
//    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

/************************************************************
 *                         推 送 : 极 光 推 送
 ************************************************************/
- (void) initJpush:(NSDictionary *) launchOptions{
    
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
    
    [APService setupWithOption:launchOptions];
    [APService setTags:[NSSet setWithObjects:APP_VERSION,nil] alias:@"boqiimall"
      callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidReceiveMessageFromJPush:)
//                                                 name:kAPNetworkDidReceiveMessageNotification object:nil];
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
//    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

//  -- 收到 jpush msg : 代表推送成功
//- (void)DidReceiveMessageFromJPush:(NSNotification *)notification {
//    NSDictionary * userInfo = [notification userInfo];
//    NSString *title = [userInfo valueForKey:@"title"];
//    NSString *content = [userInfo valueForKey:@"content"];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    
//    NSLog(@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content);
//#if ! __has_feature(objc_arc)
//    [dateFormatter release];
//#endif
//}

//  -- 点击通知中心 msg 进入    :   代表推送成功并点击进入了
- (void) comingFromNotification:(NSDictionary *) userInfo{
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [APService handleRemoteNotification:userInfo];
    
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得自定义字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    NSLog(@"content =[%@], badge=[%d], sound=[%@], customize field =[%@]",content,badge,sound,customizeField1);
}


/************************************************************
 *                         分 享 : 数 据 
 ************************************************************/

- (void)initializeShareSDKPlat
{
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     **/
    [ShareSDK connectSinaWeiboWithAppKey:sinaAppKey appSecret:sinaAppSecret redirectUri:sinaRedirectUrl];
    
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
    [ShareSDK connectTencentWeiboWithAppKey:tencentAppid
                                  appSecret:tencentAPPKEY
                                redirectUri:tencentRedirectUrl
                                   wbApiCls:[WeiboApi class]];
    
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
    [ShareSDK connectQZoneWithAppKey:tencentAppid
                           appSecret:tencentAPPKEY
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:tencentWXAppID wechatCls:[WXApi class]];
    
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
//    [ShareSDK connectQQWithAppId:@"QQ41a73e5c" qqApiCls:[QQApi class]];
    [ShareSDK connectQQWithQZoneAppKey:tencentAppid
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    /**
     连接人人网应用以使用相关功能，此应用需要引用RenRenConnection.framework
     http://dev.renren.com上注册人人网开放平台应用，并将相关信息填写到以下字段
     **/

/*
    [ShareSDK connectRenRenWithAppId:@"226427"
                              appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                           appSecret:@"f29df781abdd4f49beca5a2194676ca4"
                   renrenClientClass:[RennClient class]];
*/    
    /**
     连接易信应用以使用相关功能，此应用需要引用YiXinConnection.framework
     http://open.yixin.im/上注册易信开放平台应用，并将相关信息填写到以下字段
     **/
//    [ShareSDK connectYiXinWithAppId:@"yx0d9a9f9088ea44d78680f3274da1765f" yixinCls:[YXApi class]];
    
    //连接邮件
    [ShareSDK connectMail];
    //连接短信分享
    [ShareSDK connectSMS];
    
    /**
     连接网易微博应用以使用相关功能，此应用需要引用T163WeiboConnection.framework
     http://open.t.163.com上注册网易微博开放平台应用，并将相关信息填写到以下字段
     **/
//    [ShareSDK connect163WeiboWithAppKey:@"T5EI7BXe13vfyDuy"
//                              appSecret:@"gZxwyNOvjFYpxwwlnuizHRRtBRZ2lV1j"
//                            redirectUri:@"http://www.boqii.com"];
    
    /**
     连接豆瓣应用以使用相关功能，此应用需要引用DouBanConnection.framework
     http://developers.douban.com上注册豆瓣社区应用，并将相关信息填写到以下字段
     **/
//    [ShareSDK connectDoubanWithAppKey:@"02e2cbe5ca06de5908a863b15e149b0b"
//                            appSecret:@"9f1e7b4f71304f2f"
//                          redirectUri:@"http://www.boqii.com"];
}

//  ------      弹框确认
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([alertView.title isEqualToString:@"有新版本可用"]) {
        if(versionInfo.VersionStatus == 1) {
            if(buttonIndex == 0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_APPSTOREURL]];
            }
        }
        else {
            if(buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_APPSTOREURL]];
                exit(0);
            }else if (buttonIndex == 0){
            
//                [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithBool:YES] forKey:@"CHECK_VERSION_SHOW_DISMISS"];
            }
            
        }
    }
}


#pragma mark - 加载欢迎页

CALayer *dogLayer = nil;
UIImageView *dogImages = nil;

- (void)loadWelcomePage{
    
    
    UIScrollView *welcomeScrollView = [[UIScrollView alloc]initWithFrame:self.window.bounds];
    welcomeScrollView.backgroundColor = [UIColor convertHexToRGB:@"fbf5e9"];
    welcomeScrollView.tag = 8888;
    welcomeScrollView.contentSize = CGSizeMake(__MainScreen_Width*4, self.window.bounds.size.height);
    welcomeScrollView.pagingEnabled = YES;
    welcomeScrollView.showsVerticalScrollIndicator = NO;
    welcomeScrollView.showsHorizontalScrollIndicator = NO;
    welcomeScrollView.bounces = NO;
    
    welcomeScrollView.delegate = self;
    
    [self.window addSubview:welcomeScrollView];
    CGRect frame = CGRectMake(90, 210, 140, 140);
    NSArray *dogArray = nil;
    if (Iphone5_OrLater) {
        dogArray = @[[UIImage imageNamed:@"action_1_hover.png"],
                     [UIImage imageNamed:@"action_2_hover.png"],
                     [UIImage imageNamed:@"action_3_hover.png"],
                     [UIImage imageNamed:@"action_4_hover.png"]];
    }
    else{
        dogArray = @[[UIImage imageNamed:@"action_1.png"],
                     [UIImage imageNamed:@"action_2.png"],
                     [UIImage imageNamed:@"action_3.png"],
                     [UIImage imageNamed:@"action_4.png"]];
    }
    
    dogImages = [[UIImageView alloc]initWithFrame:frame];
    dogImages.image = [UIImage imageNamed:@"action_1.png"];
    [self.window addSubview:dogImages];
    
    dogImages.animationImages = dogArray;
    dogImages.animationDuration = 0.5;
    
    NSArray *imgArrayForIphone5OrLater = @[@"help_1_hover.png",@"help_2_hover.png",@"help_3_hover.png",@"help_4_hover.png"];
    NSArray *imgArray = @[@"help_1.png",@"help_2.png",@"help_3.png",@"help_4.png"];
    
    
    if (Iphone5_OrLater) {
        for (int i = 0; i < 4; i++) {
            
            BQImageview *imgView = [[BQImageview alloc]initWithFrame:CGRectMake(__MainScreen_Width*i, 0, __MainScreen_Width, __MainScreenFrame.size.height)];
            
            imgView.image = [UIImage imageNamed:[imgArrayForIphone5OrLater objectAtIndex:i]];
            
            [welcomeScrollView addSubview:imgView];
            
            if (i == 3) {
                imgView.delegate = self;
                imgView.selector = @selector(imgViewClick:);
                imgView.object = welcomeScrollView;
                
                CALayer *experienceLayer = [CALayer layer];
                experienceLayer.bounds = CGRectMake(0, 0, 143, 40);
                experienceLayer.position = CGPointMake(160, 500);
                experienceLayer.contents = (id)[UIImage imageNamed:@"start_btn_hover.png"].CGImage;
                [imgView.layer addSublayer:experienceLayer];
                
                
                CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
                animation.keyPath = @"position.x";
                animation.values = @[@0,@5,@(-5),@5,@0];
                animation.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
                animation.duration = 0.5;
                animation.additive = YES;
                animation.repeatCount = CGFLOAT_MAX;
                [experienceLayer addAnimation:animation forKey:@"keypath"];
            }
            
        }
    }
    else{
        for (int i = 0; i < 4; i++) {
            
            BQImageview *imgView = [[BQImageview alloc]initWithFrame:CGRectMake(__MainScreen_Width*i, 0, __MainScreen_Width, __MainScreenFrame.size.height)];
            
            imgView.image = [UIImage imageNamed:[imgArray objectAtIndex:i]];
            imgView.tag = IMG_TAG_BASE +i;
            [welcomeScrollView addSubview:imgView];
            
            if (i == 3) {
                
                imgView.delegate = self;
                imgView.selector = @selector(imgViewClick:);
                imgView.object = welcomeScrollView;
                
                
                CALayer *experienceLayer = [CALayer layer];
                experienceLayer.bounds = CGRectMake(0, 0, 143, 40);
                experienceLayer.position = CGPointMake(160, 430);
                experienceLayer.contents = (id)[UIImage imageNamed:@"start_btn_hover.png"].CGImage;
                [imgView.layer addSublayer:experienceLayer];
                
                
                
                CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
                animation.keyPath = @"position.x";
                animation.values = @[@0,@5,@(-5),@5,@0];
                animation.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
                animation.duration = 0.5;
                animation.additive = YES;
                animation.repeatCount = CGFLOAT_MAX;
                [experienceLayer addAnimation:animation forKey:@"keypath"];
            }
        }
    }
    
}


- (void)imgViewClick:(id)sender{
    UIScrollView *scrollView = (UIScrollView*)sender;
    
    scrollView.alpha = 1;
    dogImages.alpha=1;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        scrollView.alpha = 0;
        dogImages.alpha =0 ;
        
        
    } completion:^(BOOL finished) {
        
        [self writeAppNeedShowPage];
        
        [scrollView removeFromSuperview];
        
        [dogImages removeFromSuperview];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"firstOpenApp_selectClass" object:nil];
        
    }];
    
}


- (void)writeAppNeedShowPage{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:APP_NEED_SHOW_WELCOMEPAGE forKey:APP_SHOW_WELCOME_PAGE_KEY];
    [defaults synchronize];
}

- (void)writeHasRun
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:APP_HAS_ALREADY_LANUCH_KEY];
    [defaults synchronize];
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [dogImages startAnimating];
    
    
    //    UIDevice
    
    UIImageView *imageView2 = (UIImageView*)[self.window viewWithTag:IMG_TAG_BASE+1];
    UIImageView *imageView3 = (UIImageView*)[self.window viewWithTag:IMG_TAG_BASE+2];
    //      UIImageView *imageView4 = (UIImageView*)[self.window viewWithTag:IMG_TAG_BASE+3];
    CGPoint p = scrollView.contentOffset;
    
    if (p.x >=320 && p.x <480) {
        
        CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
        animation1.keyPath = @"position.x";
        animation1.values = @[@0,@100,@(-100),@100,@0];
        animation1.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
        animation1.duration = 0.5;
        animation1.additive = YES;
        animation1.repeatCount = 1;
        animation1.removedOnCompletion = YES;
        [imageView2.layer addAnimation:animation1 forKey:@"keypath"];
        
        
        CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animation];
        animation2.keyPath = @"position.x";
        animation2.values = @[@0,@10,@(-10),@10,@0];
        animation2.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
        animation2.duration = 0.5;
        animation2.additive = YES;
        animation2.removedOnCompletion = YES;
        animation2.repeatCount = 1;
        [imageView2.layer addAnimation:animation2 forKey:@"keypath"];
        
        
        CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animation];
        animation3.keyPath = @"position.x";
        animation3.values = @[@0,@5,@(-5),@5,@0];
        animation3.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
        animation3.duration = 0.5;
        animation3.additive = YES;
        animation3.removedOnCompletion = YES;
        animation3.repeatCount = 1;
        [imageView2.layer addAnimation:animation3 forKey:@"keypath"];
    }
    else if (p.x >=480 && p.x <900){
        
        CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
        animation1.keyPath = @"position.x";
        animation1.values = @[@0,@100,@(-100),@100,@0];
        animation1.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
        animation1.duration = 0.5;
        animation1.additive = YES;
        animation1.repeatCount = 1;
        animation1.removedOnCompletion = YES;
        [imageView3.layer addAnimation:animation1 forKey:@"keypath"];
        
        
        CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animation];
        animation2.keyPath = @"position.x";
        animation2.values = @[@0,@10,@(-10),@10,@0];
        animation2.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
        animation2.duration = 0.5;
        animation2.additive = YES;
        animation2.removedOnCompletion = YES;
        animation2.repeatCount = 1;
        [imageView3.layer addAnimation:animation2 forKey:@"keypath"];
        
        
        CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animation];
        animation3.keyPath = @"position.x";
        animation3.values = @[@0,@5,@(-5),@5,@0];
        animation3.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
        animation3.duration = 0.5;
        animation3.additive = YES;
        animation3.removedOnCompletion = YES;
        animation3.repeatCount = 1;
        [imageView3.layer addAnimation:animation3 forKey:@"keypath"];
        
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

@end
