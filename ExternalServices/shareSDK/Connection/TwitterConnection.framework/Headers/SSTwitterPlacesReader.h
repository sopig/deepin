//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SSTwitterBoundingBoxReader.h"

/**
 *	@brief	地方信息读取器
 */
@interface SSTwitterPlacesReader : NSObject
{
@private
    NSDictionary *_sourceData;
}

/**
 *	@brief	源数据
 */
@property (nonatomic,readonly) NSDictionary *sourceData;

/**
 *	@brief	一个哈希表结构地方信息
 */
@property (nonatomic,readonly) id attributes;

/**
 *	@brief	地方的边界坐标
 */
@property (nonatomic,readonly) SSTwitterBoundingBoxReader *boundingBox;

/**
 *	@brief	所在国家
 */
@property (nonatomic,readonly) NSString *country;

/**
 *	@brief	所在国家编码
 */
@property (nonatomic,readonly) NSString *countryCode;

/**
 *	@brief	完整的地方名称
 */
@property (nonatomic,readonly) NSString *fullName;

/**
 *	@brief	ID
 */
@property (nonatomic,readonly) NSString *Id;

/**
 *	@brief	地名
 */
@property (nonatomic,readonly) NSString *name;

/**
 *	@brief	类型
 */
@property (nonatomic,readonly) NSString *placeType;

/**
 *	@brief	URL
 */
@property (nonatomic,readonly) NSString *url;

/**
 *	@brief	初始化读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
- (id)initWithSourceData:(NSDictionary *)sourceData;

/**
 *	@brief	创建地点信息读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
+ (SSTwitterPlacesReader *)readerWithSourceData:(NSDictionary *)sourceData;

@end
