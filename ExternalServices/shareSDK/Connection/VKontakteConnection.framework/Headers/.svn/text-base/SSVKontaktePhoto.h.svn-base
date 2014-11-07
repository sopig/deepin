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
 *	@brief	照片信息
 */
@interface SSVKontaktePhoto : SSCDataObject

/**
 *	@brief	相册ID
 */
@property (nonatomic,readonly) NSInteger aid;

/**
 *	@brief	创建时间
 */
@property (nonatomic,readonly) long long created;

/**
 *	@brief	高度
 */
@property (nonatomic,readonly) NSInteger height;

/**
 *	@brief	标识
 */
@property (nonatomic,readonly) NSString *Id;

/**
 *	@brief	所属用户ID
 */
@property (nonatomic,readonly) NSInteger ownerId;

/**
 *	@brief	照片标识
 */
@property (nonatomic,readonly) NSInteger pid;

/**
 *	@brief	路径
 */
@property (nonatomic,readonly) NSString *src;

/**
 *	@brief	大图路径
 */
@property (nonatomic,readonly) NSString *srcBig;

/**
 *	@brief	小图路径
 */
@property (nonatomic,readonly) NSString *srcSmall;

/**
 *	@brief	描述
 */
@property (nonatomic,readonly) NSString *text;

/**
 *	@brief	宽度
 */
@property (nonatomic,readonly) NSInteger width;

/**
 *	@brief	创建照片信息
 *
 *	@param 	response 	回复数据
 *
 *	@return	照片信息实例
 */
+ (SSVKontaktePhoto *)photoWithResponse:(NSDictionary *)response;


@end
