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
 *	@brief	文件信息读取器
 */
@interface SSDropboxFileReader : NSObject
{
@private
    NSDictionary *_sourceData;
}

/**
 *	@brief	源数据
 */
@property (nonatomic,readonly) NSDictionary *sourceData;

@property (nonatomic,readonly) long long bytes;

@property (nonatomic,readonly) NSString *clientMtime;

@property (nonatomic,readonly) NSString *icon;

@property (nonatomic,readonly) BOOL isDir;

@property (nonatomic,readonly) NSString *mimeType;

@property (nonatomic,readonly) NSString *modified;

@property (nonatomic,readonly) NSString *path;

@property (nonatomic,readonly) long long rev;

@property (nonatomic,readonly) NSInteger revision;

@property (nonatomic,readonly) NSString *root;

@property (nonatomic,readonly) NSString *size;

@property (nonatomic,readonly) BOOL thumbExists;

/**
 *	@brief	初始化读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
- (id)initWithSourceData:(NSDictionary *)sourceData;

/**
 *	@brief	创建读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
+ (SSDropboxFileReader *)readerWithSourceData:(NSDictionary *)sourceData;

@end
