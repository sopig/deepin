//
//  FileController.h
//  Hotel
//
//  Created by YSW on 5/12/11.
//  Copyright 2011 danal. All rights reserved.
//

 


#import <UIKit/UIKit.h>


@interface FileController : NSObject {

}



+(NSString *)documentsPath;

+(NSString *)fullpathOfFilename:(NSString *)filename;

//读取工程文件
+(NSString *) ProductPath:(NSString*)filename;
 
 
//获得document文件路径，名字方便记忆
+(NSString *) DocumentPath:(NSString *)filename;

 

//写入文件 Array 沙盒
+(void)saveOrderArrayList:(NSMutableArray *)list  FileUrl :(NSString*) FileUrl;
 
//写入文件 Array 工程
+(void)saveOrderArrayListProduct:(NSMutableArray *)list  FileUrl :(NSString*) FileUrl;

 
//写入文件存放到工程位置NSDictionary
+(void)saveNSDictionaryForProduct:(NSDictionary *)list  FileUrl:(NSString*) FileUrl;
//写入文件沙盒位置NSDictionary
+(void)saveNSDictionaryForDocument:(NSDictionary *)list  FileUrl:(NSString*) FileUrl;


//加载文件沙盒NSDictionary
+(NSDictionary *)loadNSDictionaryForDocument  : (NSString*) FileUrl;

//加载文件工程位置NSDictionary
+(NSDictionary *)loadNSDictionaryForProduct   : (NSString*) FileUrl;

//加载文件沙盒NSArray
+(NSArray *)loadArrayList   : (NSString*) FileUrl;

//加载文件工程位置NSArray
+(NSArray *)loadArrayListProduct   : (NSString*) FileUrl;

//判断文件是否存在
+(BOOL) FileIsExists:(NSString*) checkFile;

//拷贝文件到沙盒
+(int) CopyFileToDocument:(NSString*)FileName;
@end
