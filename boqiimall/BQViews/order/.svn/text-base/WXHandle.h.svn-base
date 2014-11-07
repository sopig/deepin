//
//  WXHandle.h
//  boqiimall
//
//  Created by 张正超 on 14-8-27.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
/*
 需要在 appdelegate 两个方法中如下方式调用
 - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
 {
 return  [WXApi handleOpenURL:url delegate:[WXPayBusiness shareWXHandle]];
 }
 
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 {
 return  [WXApi handleOpenURL:url delegate:[WXPayBusiness shareWXHandle]];
 }
 
 */

@protocol WXHandleDelegate <NSObject>

- (void)responseFromPayHandle:(id)object;
- (void)requestFromPayHandle:(id)object;

@end


@interface WXHandle : NSObject<WXApiDelegate>


@property (nonatomic,readwrite,assign)id<WXHandleDelegate>delegate;

+ (instancetype)shareWXHandle;

- (void)sendPayWithParamDict:(NSMutableDictionary*)params;//调起微信支付
- (void)sendAuthRequest;//调起微信授权
@end
