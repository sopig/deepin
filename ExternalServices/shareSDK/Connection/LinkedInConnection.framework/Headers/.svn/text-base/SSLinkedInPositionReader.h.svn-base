//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SSLinkedInCompanyReader.h"

/**
 *	@brief	职位信息读取器
 */
@interface SSLinkedInPositionReader : NSObject
{
@private
    NSDictionary *_sourceData;
}

/**
 *	@brief	源数据
 */
@property (nonatomic,readonly) NSDictionary *sourceData;

/**
 *	@brief	公司信息
 */
@property (nonatomic,readonly) SSLinkedInCompanyReader *company;

/**
 *	@brief	标识
 */
@property (nonatomic,readonly) long long Id;

/**
 *	@brief	是否在职
 */
@property (nonatomic,readonly) BOOL isCurrent;

/**
 *	@brief	头衔
 */
@property (nonatomic,readonly) NSString *title;

/**
 *	@brief	初始化读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
- (id)initWithSourceData:(NSDictionary *)sourceData;

/**
 *	@brief	创建职位信息读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
+ (SSLinkedInPositionReader *)readerWithSourceData:(NSDictionary *)sourceData;

@end
