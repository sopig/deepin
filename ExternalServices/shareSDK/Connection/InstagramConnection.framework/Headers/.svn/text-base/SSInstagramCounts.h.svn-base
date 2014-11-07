//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ShareSDKCoreService/SSCDataObject.h>

/**
 *	@brief	数量
 */
@interface SSInstagramCounts : SSCDataObject

/**
 *	@brief	媒体数量
 */
@property (nonatomic,readonly) NSInteger media;

/**
 *	@brief	关注数量
 */
@property (nonatomic,readonly) NSInteger follows;

/**
 *	@brief	粉丝数量
 */
@property (nonatomic,readonly) NSInteger followedBy;

/**
 *	@brief	创建数量对象实例
 *
 *	@param 	data 	回复数据
 *
 *	@return	数量对象
 */
+ (SSInstagramCounts *)countsWithResponse:(NSDictionary *)data;


@end
