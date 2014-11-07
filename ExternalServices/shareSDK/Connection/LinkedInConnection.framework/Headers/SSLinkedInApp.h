//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ISSLinkedInApp.h"
#import "SSLinkedInUserManager.h"
#import "SSLinkedInAuthSession.h"
#import <ShareSDK/ShareSDKPlugin.h>

/**
 *	@brief	LinkedIn应用对象
 */
@interface SSLinkedInApp : NSObject <ISSLinkedInApp,
                                     SSLinkedInAuthSessionDelegate>
{
@private
    id<ISSPlatform> _platform;
    NSString *_apiKey;
    NSString *_secretKey;
    NSString *_redirectUri;
    id<ISSCAccount> _account;
    
    SSLinkedInUserManager *_userManager;
    NSMutableArray *_authSessions;

    BOOL _convertUrlEnabled;
}

/**
 *	@brief	应用Key
 */
@property (nonatomic,readonly) NSString *apiKey;

/**
 *	@brief	应用密钥
 */
@property (nonatomic,readonly) NSString *secretKey;

/**
 *	@brief	回调地址
 */
@property (nonatomic,readonly) NSString *redirectUri;

/**
 *	@brief	登录帐号
 */
@property (nonatomic,retain) id<ISSCAccount> account;

/**
 *	@brief	所属平台
 */
@property (nonatomic,readonly) id<ISSPlatform> platform;

/**
 *	@brief	转换URL标识
 */
@property (nonatomic) BOOL convertUrlEnabled;

/**
 *	@brief	默认注册用户
 */
@property (nonatomic,retain) id<ISSPlatformUser> currentUser;

/**
 *	@brief	初始化应用
 *
 *  @param  platform    平台
 *  @param  account 帐号
 *	@param 	appKey 	应用Key
 *	@param 	appSecret 	应用密钥
 *	@param 	redirectUri 	回调地址
 *
 *	@return	应用对象
 */
- (id)initWithPlatform:(id<ISSPlatform>)platform
               account:(id<ISSCAccount>)account
                apiKey:(NSString *)apiKey
             secretKey:(NSString *)secretKey
           redirectUri:(NSString *)redirectUri;

@end
