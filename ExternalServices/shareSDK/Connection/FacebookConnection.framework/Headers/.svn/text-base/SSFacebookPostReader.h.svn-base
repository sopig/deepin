//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>

@class SSFacebookUserReader;

/**
 *	@brief	文章信息读取器
 */
@interface SSFacebookPostReader : NSObject
{
@private
    NSDictionary *_sourceData;
}

/**
 *	@brief	源数据
 */
@property (nonatomic,readonly) NSDictionary *sourceData;

/**
 *	@brief	ID
 */
@property (nonatomic,readonly) NSString *Id;

/**
 *	@brief	文章ID
 */
@property (nonatomic,readonly) NSString *postId;

/**
 *	@brief	发送用户
 */
@property (nonatomic,readonly) SSFacebookUserReader *from;

/**
 *	@brief	消息
 */
@property (nonatomic,readonly) NSString *message;

/**
 *	@brief	更新时间
 */
@property (nonatomic,readonly) NSString *updatedTime;

/**
 *	@brief	创建时间
 */
@property (nonatomic,readonly) NSString *createdTime;

/**
 *	@brief	图标
 */
@property (nonatomic,readonly) NSString *icon;

/**
 *	@brief	链接
 */
@property (nonatomic,readonly) NSString *link;

/**
 *	@brief	照片名称
 */
@property (nonatomic,readonly) NSString *name;

/**
 *	@brief	缩略图路径
 */
@property (nonatomic,readonly) NSString *picture;

/**
 *	@brief	源图路径
 */
@property (nonatomic,readonly) NSString *source;

/**
 *	@brief	高度
 */
@property (nonatomic,readonly) NSInteger height;

/**
 *	@brief	宽度
 */
@property (nonatomic,readonly) NSInteger width;

/**
 *	@brief	图片信息
 */
@property (nonatomic,readonly) NSArray *images;

/**
 *	@brief	初始化读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
- (id)initWithSourceData:(NSDictionary *)sourceData;

/**
 *	@brief	创建文章信息读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
+ (SSFacebookPostReader *)readerWithSourceData:(NSDictionary *)sourceData;

@end
