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
 *	@brief	用户信息读取器
 */
@interface SSDouBanUserReader : NSObject
{
@private
    NSDictionary *_sourceData;
}

/**
 *	@brief	源数据
 */
@property (nonatomic,readonly) NSDictionary *sourceData;

/**
 *	@brief	用户ID
 */
@property (nonatomic,readonly) NSString *Id;

/**
 *	@brief	用户ID
 */
@property (nonatomic,readonly) NSString *uid;

/**
 *	@brief	用户昵称
 */
@property (nonatomic,readonly) NSString *name;

/**
 *	@brief	头像小图
 */
@property (nonatomic,readonly) NSString *avatar;

/**
 *	@brief	暂无
 */
@property (nonatomic,readonly) NSString *alt;

/**
 *	@brief	注册时间
 */
@property (nonatomic,readonly) NSString *created;

/**
 *	@brief	城市id
 */
@property (nonatomic,readonly) NSString *locId;

/**
 *	@brief	所在地全称
 */
@property (nonatomic,readonly) NSString *locName;

/**
 *	@brief	描述
 */
@property (nonatomic,readonly) NSString *desc;

/**
 *	@brief	大头像
 */
@property (nonatomic,readonly) NSString *largeAvatar;

/**
 *	@brief	小头像
 */
@property (nonatomic,readonly) NSString *smallAvatar;

/**
 *	@brief	用户名号
 */
@property (nonatomic,readonly) NSString *screenName;

/**
 *	@brief	类型
 */
@property (nonatomic,readonly) NSString *type;

/**
 *	@brief	暂无
 */
@property (nonatomic,readonly) NSString *signature;

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
+ (SSDouBanUserReader *)readerWithSourceData:(NSDictionary *)sourceData;

@end
