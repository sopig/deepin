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
#import "SSPinterestErrorInfo.h"
#import <ShareSDK/ShareSDKPlugin.h>

/**
 *	@brief	Pinterest应用协议
 */
@protocol ISSPinterestApp <ISSPlatformApp>

/**
 *	@brief	获取应用ID
 *
 *	@return	应用ID
 */
- (NSString *)clientId;

/**
 *	@brief	分享内容
 *
 *	@param 	image 	图片，只允许网络图片路径
 *	@param 	url 	网址
 *	@param 	description 	描述
 *  @param  result  回调方法
 */
- (void)createPinWithImage:(id<ISSCAttachment>)image
                       url:(NSString *)url
               description:(NSString *)description
                    result:(SSShareResultEvent)result;


@end
