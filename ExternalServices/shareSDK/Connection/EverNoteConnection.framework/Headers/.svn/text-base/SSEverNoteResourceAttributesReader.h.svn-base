//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SSEverNoteLazyMapReader.h"

/**
 *	@brief	资源属性集合读取器
 */
@interface SSEverNoteResourceAttributesReader : NSObject
{
@private
    NSDictionary *_sourceData;
}

/**
 *	@brief	源数据
 */
@property (nonatomic,readonly) NSDictionary *sourceData;

/**
 *	@brief	the original location where the resource was hosted
 */
@property (nonatomic,readonly) NSString *sourceURL;

/**
 *	@brief	the date and time that is associated with this resource (e.g. the time embedded in an image from a digital camera with a clock)
 */
@property (nonatomic,readonly) long long timestamp;

/**
 *	@brief	the latitude where the resource was captured
 */
@property (nonatomic,readonly) double latitude;

/**
 *	@brief	the longitude where the resource was captured
 */
@property (nonatomic,readonly) double longitude;

/**
 *	@brief	the altitude where the resource was captured
 */
@property (nonatomic,readonly) double altitude;

/**
 *	@brief	information about an image's camera, e.g. as embedded in the image's EXIF data
 */
@property (nonatomic,readonly) NSString *cameraMake;

/**
 *	@brief	information about an image's camera, e.g. as embedded in the image's EXIF data
 */
@property (nonatomic,readonly) NSString *cameraModel;

/**
 *	@brief	if true, then the original client that submitted the resource plans to submit the recognition index for this resource at a later time.
 */
@property (nonatomic,readonly) BOOL clientWillIndex;

/**
 *	@brief	DEPRECATED - this field is no longer set by the service, so should be ignored.
 */
@property (nonatomic,readonly) NSString *recoType;

/**
 *	@brief	if the resource came from a source that provided an explicit file name,
 *          the original name will be stored here. Many resources come from unnamed sources, so this will not always be set.
 */
@property (nonatomic,readonly) NSString *fileName;

/**
 *	@brief	this will be true if the resource should be displayed as an attachment,
 *          or false if the resource should be displayed inline (if possible).
 */
@property (nonatomic,readonly) BOOL attachment;

/**
 *	@brief	Provides a location for applications to store a relatively small (4kb) blob of data associated
 *          with a Resource that is not visible to the user and that is opaque to the Evernote service.
 *          A single application may use at most one entry in this map, using its API consumer key as the map key.
 *          See the documentation for LazyMap for a description of when the actual map values are returned by the service.
 *          To safely add or modify your application's entry in the map, use NoteStore.setResourceApplicationDataEntry.
 *          To safely remove your application's entry from the map, use NoteStore.unsetResourceApplicationDataEntry.
 */
@property (nonatomic,readonly) SSEverNoteLazyMapReader *applicationData;

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
+ (SSEverNoteResourceAttributesReader *)readerWithSourceData:(NSDictionary *)sourceData;

@end
