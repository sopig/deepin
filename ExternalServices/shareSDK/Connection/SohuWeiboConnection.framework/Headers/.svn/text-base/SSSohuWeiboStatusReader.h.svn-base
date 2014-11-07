//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SSSohuWeiboUserReader.h"

/**
 *	@brief	微博信息读取器
 */
@interface SSSohuWeiboStatusReader : NSObject
{
@private
    NSDictionary *_sourceData;
}

/**
 *	@brief	源数据
 */
@property (nonatomic,readonly) NSDictionary *sourceData;

/**
 *	@brief	创建时间
 */
@property (nonatomic,readonly) NSString *createAt;

/**
 *	@brief	微博id
 */
@property (nonatomic,readonly) NSString *Id;

/**
 *	@brief	内容
 */
@property (nonatomic,readonly) NSString *text;

/**
 *	@brief	来源
 */
@property (nonatomic,readonly) NSString *source;

/**
 *	@brief	是否收藏
 */
@property (nonatomic,readonly) BOOL favorited;

/**
 *	@brief	暂无
 */
@property (nonatomic,readonly) BOOL truncated;

/**
 *	@brief	转发微博id
 */
@property (nonatomic,readonly) NSString *inReplyToStatusId;

/**
 *	@brief	转发微博作者id
 */
@property (nonatomic,readonly) NSString *inReplyToUserId;

/**
 *	@brief	转发微博作者昵称
 */
@property (nonatomic,readonly) NSString *inReplyToScreenName;

/**
 *	@brief	转发微博内容
 */
@property (nonatomic,readonly) NSString *inReplyToStatusText;

/**
 *	@brief	小图
 */
@property (nonatomic,readonly) NSString *smallPic;

/**
 *	@brief	中图
 */
@property (nonatomic,readonly) NSString *middlePic;

/**
 *	@brief	原图
 */
@property (nonatomic,readonly) NSString *originalPic;

/**
 *	@brief	用户信息
 */
@property (nonatomic,readonly) SSSohuWeiboUserReader *userInfo;

/**
 *	@brief	初始化读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
- (id)initWithSourceData:(NSDictionary *)sourceData;

/**
 *	@brief	创建用户信息读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
+ (SSSohuWeiboStatusReader *)readerWithSourceData:(NSDictionary *)sourceData;

@end
