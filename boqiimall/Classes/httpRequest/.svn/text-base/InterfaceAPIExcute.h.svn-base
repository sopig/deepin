//
//  InterfaceAPIExcute.h
//  Ule
//
//  Created by ysw on 13-2-23.
//  Copyright (c) 2013年 Ule. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResponseBase.h"
#import "HttpRequest.h"
#import "BqiAPI.h"
#define SUCCESS_CODE    0

Class object_getClass(id object);

@protocol InterfaceAPIDelegate;

@interface InterfaceAPIExcute : NSObject
{
    EnvApiHost m_envApiHost;
    NSString*  m_apiName;
    NSString*  m_apiMethod;
    NSString*  m_retClass;
    NSMutableDictionary* m_params;
    Class _originalClass;
}

@property   (nonatomic,retain)  NSString * flagCommonApi;   //用于一个页面请求相同API时标记

@property   (nonatomic,assign)  id<InterfaceAPIDelegate> delegate;


- (id)initWithAPI:(EnvApiHost) _EnvApiHost
          apiPath:(NSString*)apiName
         retClass:(NSString*)retClass
           Params:(NSMutableDictionary *)params
      setDelegate:(id<InterfaceAPIDelegate>)thedelegate;

-(void)beginRequest;
-(void)beginRequestWithUrl;

- (void)failWithErrorText:(NSString *)text;
@end

