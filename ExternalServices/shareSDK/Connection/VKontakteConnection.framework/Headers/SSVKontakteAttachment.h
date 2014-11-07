//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>

/**
 *	@brief	附件信息
 */
@interface SSVKontakteAttachment : NSObject
{
@private
    NSString *_type;
    NSString *_ownerId;
    NSString *_mediaId;
}

/**
 *	@brief	附件类型
 */
@property (nonatomic,copy) NSString *type;

/**
 *	@brief	媒体标识
 */
@property (nonatomic,copy) NSString *mediaId;

/**
 *	@brief	媒体所属用户标识
 */
@property (nonatomic,copy) NSString *ownerId;

/**
 *	@brief	创建附件信息
 *
 *	@param 	type 	附件类型
 *	@param 	mediaId 	媒体标识
 *	@param 	ownerId 	媒体所属用户标识
 *
 *	@return	附件信息
 */
+ (SSVKontakteAttachment *)attachmentWithType:(NSString *)type
                                      mediaId:(NSString *)mediaId
                                      ownerId:(NSString *)ownerId;


@end
