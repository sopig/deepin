//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ShareSDKCoreService/ShareSDKCoreService.h>
#import "SSInstagramUser.h"
#import "SSInstagramErrorInfo.h"
#import "SSInstagramCredential.h"
#import <ShareSDK/ShareSDKPlugin.h>

/**
 *	@brief	Instagram请求方式
 */
typedef enum
{
	SSInstagramRequestMethodGet = 0, /**< GET方式 */
	SSInstagramRequestMethodPost = 1, /**< POST方式 */
	SSInstagramRequestMethodMultipartPost = 2 /**< Multipart POST方式，用于上传文件的api接口 */
}
SSInstagramRequestMethod;

/**
 *	@brief	Instagram应用协议
 */
@protocol ISSInstagramApp <ISSPlatformApp>

/**
 *	@brief	获取应用Key
 *
 *	@return	应用Key
 */
- (NSString *)clientId;

/**
 *	@brief	获取应用密钥
 *
 *	@return	应用密钥
 */
- (NSString *)clientSecret;

/**
 *	@brief	获取应用回调地址
 *
 *	@return	应用回调地址
 */
- (NSString *)redirectUri;

/**
 *	@brief	调用开放平台API
 *
 *	@param 	path 	路径
 *	@param 	params 	请求参数
 *  @param  user    授权用户,如果传入nil则表示默认的授权用户
 *  @param  result  返回回调
 *  @param  fault   失败回调
 */
- (void)api:(NSString *)path
     method:(SSInstagramRequestMethod)method
     params:(id<ISSCParameters>)params
       user:(id<ISSPlatformUser>)user
     result:(void(^)(id responder))result
      fault:(void(^)(CMErrorInfo *error))fault;

/**
 *	@brief 打开Instagram的拍照功能
 *
 *  @return YES 表示
 */
- (BOOL)openInstagramWithCamera;

/**
 *	@brief	分享内容
 *
 *	@param 	image 	图片
 *	@param 	title 	标题
 *  @param  containerController     容器控制器
 *  @param  result  返回回调
 */
- (void)shareWithImage:(id<ISSCAttachment>)image
                 title:(NSString *)title
   containerController:(UIViewController *)containerController
                result:(SSShareResultEvent)result;


@end
