//
//  InterfaceAPIDelegate.h
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-2.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InterfaceAPIDelegate <NSObject>

@optional
-(void) interfaceExcuteError:(NSError*)error apiName:(NSString*)ApiName;     //[APIMethodHandle shareAPIMethodHandle]请求错误回调
-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName;    //[APIMethodHandle shareAPIMethodHandle]请求成功回调
-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName apiFlag:(NSString*) ApiFlag;  //[APIMethodHandle shareAPIMethodHandle]请求成功回调

@end
