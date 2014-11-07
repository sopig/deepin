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
 *	@brief	资源数据读取器
 */
@interface SSEverNoteResourceDataReader : NSObject
{
@private
    NSDictionary *_sourceData;
}

/**
 *	@brief	源数据
 */
@property (nonatomic,readonly) NSDictionary *sourceData;

/**
 *	@brief	This field carries a one-way hash of the contents of the data body, in binary form. The hash function is MD5
 */
@property (nonatomic,readonly) NSData *bodyHash;

/**
 *	@brief	The length, in bytes, of the data body.
 */
@property (nonatomic,readonly) NSInteger size;

/**
 *	@brief	This field is set to contain the binary contents of the data whenever the resource is being transferred.
 *          If only metadata is being exchanged, this field will be empty.
 *          For example, a client could notify the service about the change to an attribute for
 *          a resource without transmitting the binary resource contents.
 */
@property (nonatomic,readonly) NSData *body;

/**
 *	@brief	初始化读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
- (id)initWithSourceData:(NSDictionary *)sourceData;

/**
 *	@brief	创建资源信息读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
+ (SSEverNoteResourceDataReader *)readerWithSourceData:(NSDictionary *)sourceData;

@end
