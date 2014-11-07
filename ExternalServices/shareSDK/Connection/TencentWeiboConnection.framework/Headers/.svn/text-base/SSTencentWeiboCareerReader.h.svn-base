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
 *	@brief	职业信息读取器
 */
@interface SSTencentWeiboCareerReader : NSObject
{
@private
    NSDictionary *_sourceData;
}

/**
 *	@brief	源数据
 */
@property (nonatomic,readonly) NSDictionary *sourceData;

/**
 *	@brief	开始年
 */
@property (nonatomic,readonly) NSInteger beginYear;

/**
 *	@brief	公司名称
 */
@property (nonatomic,readonly) NSString *companyName;

/**
 *	@brief	部门名称
 */
@property (nonatomic,readonly) NSString *departmentName;

/**
 *	@brief	结束年
 */
@property (nonatomic,readonly) NSInteger endYear;

/**
 *	@brief	公司id
 */
@property (nonatomic,readonly) NSInteger Id;

/**
 *	@brief	初始化读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
- (id)initWithSourceData:(NSDictionary *)sourceData;

/**
 *	@brief	创建职业信息读取器
 *
 *	@param 	sourceData 	原数据
 *
 *	@return	读取器实例对象
 */
+ (SSTencentWeiboCareerReader *)readerWithSourceData:(NSDictionary *)sourceData;

@end
