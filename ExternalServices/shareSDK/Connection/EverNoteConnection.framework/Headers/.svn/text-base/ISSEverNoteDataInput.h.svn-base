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
 *	@brief	数据写入协议
 */
@protocol ISSEverNoteDataInput <NSObject>

/**
 *	@brief	写入字节数组
 *
 *	@param 	buf 	缓存区
 *	@param 	offset 	偏移位置，从缓存区的指定位置开始读取位置
 *	@param 	len 	读入长度
 */
- (void)writeBytes:(const uint8_t *)buf
            offset:(NSInteger)offset
               len:(NSInteger)len;

/**
 *	@brief	开始写入消息
 *
 *	@param 	name 	消息名称
 *	@param 	messageType 	消息类型
 *	@param 	sequenceID 	序列ID
 */
- (void)beginWriteMessage:(NSString *)name
                     type:(int)messageType
               sequenceID:(int)sequenceID;

/**
 *	@brief	结束写入消息
 */
- (void)endWriteMessage;

/**
 *	@brief	开始写入结构
 *
 *	@param 	name 	结构名称
 */
- (void)beginWriteStruct:(NSString *)name;

/**
 *	@brief	结束写入结构
 */
- (void)endWriteStruct;

/**
 *	@brief	开始写入字段
 *
 *	@param 	name 	字段名称
 *	@param 	type 	字段类型
 *	@param 	fieldID 	字段ID
 */
- (void)beginWriteField:(NSString *)name
                   type:(int)type
                fieldID:(int)fieldID;

/**
 *	@brief	写入字段结束标识
 */
- (void)writeFieldStop;

/**
 *	@brief	结束写入字段
 */
- (void)endWriteField;

/**
 *	@brief	写入一个整型值
 *
 *	@param 	value 	整型值
 */
- (void)writeInt32:(int32_t)value;

/**
 *	@brief	写入一个长整型值
 *
 *	@param 	value   长整型值
 */
- (void)writeInt64:(int64_t)value;

/**
 *	@brief	写入一个短整型指
 *
 *	@param 	value 	短整型值
 */
- (void)writeShort:(short)value;

/**
 *	@brief	写入一个字节
 *
 *	@param 	value 	字节
 */
- (void)writeByte:(uint8_t)value;

/**
 *	@brief	写入一个字符串
 *
 *	@param 	value 	字符串
 */
- (void)writeString:(NSString *)value;

/**
 *	@brief	写入一个双精度浮点型
 *
 *	@param 	value 	浮点型数值
 */
- (void)writeDouble:(double)value;

/**
 *	@brief	写入一个布尔值
 *
 *	@param 	value 	布尔值
 */
- (void)writeBool:(BOOL)value;

/**
 *	@brief	写入一个字节流
 *
 *	@param 	data 	二进制流
 */
- (void)writeBinary:(NSData *)data;

/**
 *	@brief	开始写入图
 *
 *	@param 	keyType 	Key类型
 *	@param 	valueType 	Value类型
 *	@param 	size 	长度
 */
- (void)beginWriteMap:(int)keyType
            valueType:(int)valueType
                 size:(int)size;
				 
/**
 *	@brief	结束写入图
 */
- (void)endWriteMap;

/**
 *	@brief	开始写入集合
 *
 *	@param 	elementType 	元素类型
 *	@param 	size 	长度
 */
- (void)beginWriteSet:(int)elementType
                 size:(int)size;

/**
 *	@brief	结束写入集合
 */
- (void)endWriteSet;

/**
 *	@brief	开始写入列表
 *
 *	@param 	elementType 	元素类型
 *	@param 	size 	长度
 */
- (void)beginWriteList:(int)elementType size:(int)size;

/**
 *	@brief	结束写入列表
 */
- (void)endWriteList;

@end
