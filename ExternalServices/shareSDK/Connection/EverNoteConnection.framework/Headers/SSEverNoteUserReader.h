//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SSEverNoteTypeDef.h"
#import "SSEverNoteUserAttributesReader.h"
#import "SSEverNoteAccountingReader.h"
#import "SSEverNotePremiumInfoReader.h"

/**
 *	@brief	用户信息读取器
 */
@interface SSEverNoteUserReader : NSObject
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
@property (nonatomic,readonly) NSInteger Id;

/**
 *	@brief	用户名称
 */
@property (nonatomic,readonly) NSString *username;

/**
 *	@brief	电子邮箱
 */
@property (nonatomic,readonly) NSString *email;

/**
 *	@brief	名称
 */
@property (nonatomic,readonly) NSString *name;

/**
 *	@brief	时区
 *
 */
@property (nonatomic,readonly) NSString *timezone;

/**
 *	@brief	权限
 */
@property (nonatomic,readonly) SSEverNotePrivilegeLevel privilege;

/**
 *	@brief	创建时间
 */
@property (nonatomic,readonly) long long created;

/**
 *	@brief	最近一次修改时间
 */
@property (nonatomic,readonly) long long updated;

/**
 *	@brief	删除时间
 */
@property (nonatomic,readonly) long long deleted;

/**
 *	@brief	是否有效
 */
@property (nonatomic,readonly) BOOL active;

/**
 *	@brief	此字段已过时
 */
@property (nonatomic,readonly) NSString *shardId;

/**
 *	@brief	用户属性对象
 */
@property (nonatomic,readonly) SSEverNoteUserAttributesReader *attributes;

/**
 *	@brief	簿记用户的订阅信息
 */
@property (nonatomic,readonly) SSEverNoteAccountingReader *accounting;

/**
 *	@brief	地价信息
 */
@property (nonatomic,readonly) SSEverNotePremiumInfoReader *premiumInfo;

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
+ (SSEverNoteUserReader *)readerWithSourceData:(NSDictionary *)sourceData;

@end
