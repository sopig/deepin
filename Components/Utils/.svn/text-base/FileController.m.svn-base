//
//  FileController.m
//  Hotel
//
//  Created by YSW on 5/12/11.
//  Copyright 2011 danal. All rights reserved.
//

 
#import "FileController.h"


@implementation FileController

//获得document
+(NSString *)documentsPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

//读取工程文件
+(NSString *) ProductPath:(NSString*)filename{

    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    return  path;
}

//获得document文件路径，名字方便记忆
+(NSString *) DocumentPath:(NSString *)filename {
	NSString *documentsPath = [self documentsPath];
    // NSLog(@"documentsPath=%@",documentsPath);
	return [documentsPath stringByAppendingPathComponent:filename];
}

 
//获得document文件路径
+(NSString *)fullpathOfFilename:(NSString *)filename {
	NSString *documentsPath = [self documentsPath];
   // NSLog(@"documentsPath=%@",documentsPath);
	return [documentsPath stringByAppendingPathComponent:filename];
}

 
//写入文件沙盒位置NSDictionary
+(void)saveNSDictionaryForDocument:(NSDictionary *)list  FileUrl:(NSString*) FileUrl  {
	
    NSString *f = [self fullpathOfFilename:FileUrl];
    
	[list writeToFile:f atomically:YES];
}

//写入文件存放到工程位置NSDictionary
+(void)saveNSDictionaryForProduct:(NSDictionary *)list  FileUrl:(NSString*) FileUrl  {
	
    NSString *ProductPath =[[NSBundle mainBundle]  resourcePath];
    NSString *f=[ProductPath stringByAppendingPathComponent:FileUrl];
    
	[list writeToFile:f atomically:YES];
}

//写入文件 Array 工程
+(void)saveOrderArrayListProduct:(NSMutableArray *)list  FileUrl :(NSString*) FileUrl {

    NSString *ProductPath =[[NSBundle mainBundle]  resourcePath];
    NSString *f=[ProductPath stringByAppendingPathComponent:FileUrl];
    
	[list writeToFile:f atomically:YES];
}
//写入文件 Array 沙盒
+(void)saveOrderArrayList:(NSMutableArray *)list  FileUrl :(NSString*) FileUrl {
	NSString *f = [self fullpathOfFilename:FileUrl];
    
	[list writeToFile:f atomically:YES];
}


//加载文件沙盒NSDictionary
+(NSDictionary *)loadNSDictionaryForDocument  : (NSString*) FileUrl {

	NSString *f = [self fullpathOfFilename:FileUrl];
	NSDictionary *list = [ [NSDictionary alloc] initWithContentsOfFile:f];
	 
#if ! __has_feature(objc_arc)
	return [list autorelease];
#else
    return list;
#endif
}

//加载文件工程位置NSDictionary
+(NSDictionary *)loadNSDictionaryForProduct   : (NSString*) FileUrl {
   
	NSString *f = [self ProductPath:FileUrl];
    NSDictionary *list =[NSDictionary dictionaryWithContentsOfFile:f];
    
	return list;
}


//加载文件沙盒NSArray
+(NSArray *)loadArrayList   : (NSString*) FileUrl {
    
	NSString *f = [self fullpathOfFilename:FileUrl];
    
	NSArray *list = [NSArray  arrayWithContentsOfFile:f];
    
	return list;
}

//加载文件工程位置NSArray
+(NSArray *)loadArrayListProduct   : (NSString*) FileUrl {
    
	NSString *f = [self ProductPath:FileUrl];
    
    NSArray *list = [NSArray  arrayWithContentsOfFile:f];
    
	return list;
}

//拷贝文件到沙盒
+(int) CopyFileToDocument:(NSString*)FileName{
    

    NSString *appFileName =[self fullpathOfFilename:FileName];

    
    NSFileManager *fm = [NSFileManager defaultManager];  
    
    //判断沙盒下是否存在 
    BOOL isExist = [fm fileExistsAtPath:appFileName];  
    
    if (!isExist)   //不存在，把工程的文件复制document目录下
    {  
        
        //获取工程中文件
        NSString *backupDbPath = [[NSBundle mainBundle]  
                                  pathForResource:FileName  
                                  ofType:@""];  
    
        
        //这一步实现数据库的添加，  
        // 通过NSFileManager 对象的复制属性，把工程中数据库的路径复制到应用程序的路径上  
        BOOL cp = [fm copyItemAtPath:backupDbPath toPath:appFileName error:nil];  
      
    
        return cp;
        
    } else {
        
        return  -1; //已经存在
    } 
    
}

//判断文件是否存在
+(BOOL) FileIsExists:(NSString*) checkFile{
     
    if([[NSFileManager defaultManager]fileExistsAtPath:checkFile])
    {
        return true;
    }
    return  false;

}

#if ! __has_feature(objc_arc)
- (void)dealloc {
    [super dealloc];
}
#endif

@end
