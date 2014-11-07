//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AGCommon/CMErrorInfo.h>
#import "ISSEverNoteDataOutput.h"

/**
 *	@brief	错误信息类，用于描述印象笔记中产生的错误信息（包括：错误码、错误描述）
 */
@interface SSEverNoteErrorInfo : CMErrorInfo
{
@private
    NSString *_identifier;
    NSString *_key;
}

/**
 *	@brief	错误标识
 */
@property (nonatomic,copy) NSString *identifier;

/**
 *	@brief	错误的key标识
 */
@property (nonatomic,copy) NSString *key;

/**
 *	@brief	创建应用错误信息
 *
 *	@param 	reader 	数据读取器
 *
 *	@return	错误信息
 */
+ (SSEverNoteErrorInfo *)applicationErrorWithReader:(id<ISSEverNoteDataOutput>)reader;

/**
 *	@brief	创建用户错误信息
 *
 *	@param 	reader 	数据读取器
 *
 *	@return	错误信息
 */
+ (SSEverNoteErrorInfo *)userErrorWithReader:(id<ISSEverNoteDataOutput>)reader;

/**
 *	@brief	创建系统错误信息
 *
 *	@param 	reader 	数据读取器
 *
 *	@return	错误信息
 */
+ (SSEverNoteErrorInfo *)systemErrorWithReader:(id<ISSEverNoteDataOutput>)reader;

/**
 *	@brief	创建未找到错误信息
 *
 *	@param 	reader 	数据读取器
 *
 *	@return	错误信息
 */
+ (SSEverNoteErrorInfo *)notFoundErrorWithReader:(id<ISSEverNoteDataOutput>)reader;

@end
