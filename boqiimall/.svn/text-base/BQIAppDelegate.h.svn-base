//
//  BQIAppDelegate.h
//  BoqiiLife
//
//  Created by YSW on 14-4-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UITabBarExController.h"
#import "MemoryData.h"
#import "SDWebImageManager.h"
#import "EC_UICustomAlertView.h"
#import "InterfaceAPIExcute.h"

#import "resMod_GetLastVersion.h"

#import <AFNetworkReachabilityManager.h>

#import "InterfaceAPIDelegate.h"

@interface BQIAppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,SDWebImageManagerDelegate,EC_UICustomAlertViewDelegate,InterfaceAPIDelegate,UIScrollViewDelegate>{
    
    NSUncaughtExceptionHandler *  _uncaughtExceptionHandler;
    UITabBarExController *tabbarController;
    resMod_LastVersionInfo * versionInfo;
}

@property (strong, nonatomic) CLLocationManager    *locationManage;
@property (strong, nonatomic) UITabBarExController *tabbarController;
@property (strong, nonatomic) UIWindow *window;

//@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
//- (NSURL *)applicationDocumentsDirectory;

@end
