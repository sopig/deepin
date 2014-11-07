//
//  InterfaceAPIExcute.m
//
//
//  Created by ysw on 13-2-23.
//  Copyright (c) 2013年 boqii. All rights reserved.
//

#import "InterfaceAPIExcute.h"

@implementation InterfaceAPIExcute
@synthesize delegate;
@synthesize flagCommonApi;

- (id)initWithAPI:(EnvApiHost) _EnvApiHost apiPath:(NSString*)apiName retClass:(NSString*)retClass
           Params:(NSMutableDictionary *)params setDelegate:(id)thedelegate
{
    self = [super init];
    if (self) {
        m_envApiHost = _EnvApiHost;
        m_apiName = apiName;
        m_retClass = retClass;
        m_params =  [params retain];
        m_apiMethod = [m_params objectForKey:APP_ACTIONNAME];
        
        self.delegate = thedelegate;
        _originalClass = object_getClass(thedelegate);
    }
    
    return self;
}

-(void)excuteSuccess:(id)retObj {
    Class currentClass = object_getClass(self.delegate);
    if (currentClass == _originalClass) {
        
        if (flagCommonApi.length>0) {   // -- 有标记
            if ([delegate respondsToSelector:@selector(interfaceExcuteSuccess: apiName:)])
                [delegate interfaceExcuteSuccess:retObj apiName:m_apiMethod apiFlag:self.flagCommonApi];
        }
        else{                           // -- 无标记
            if ([delegate respondsToSelector:@selector(interfaceExcuteSuccess: apiName:)])
                [delegate interfaceExcuteSuccess:retObj apiName:m_apiMethod];
        }
    }
}

- (void)failWithError:(NSError *)error {
    Class currentClass = object_getClass(self.delegate);
    if (currentClass == _originalClass) {
        
        if ([delegate respondsToSelector:@selector(interfaceExcuteError: apiName:)])            
            [delegate interfaceExcuteError:error apiName:m_apiMethod];
    }
}

- (void)failWithErrorText:(NSString *)text {
    NSError *   error = [NSError errorWithDomain:@"errormessage" code:0 userInfo:[NSDictionary dictionaryWithObject:text forKey:NSLocalizedDescriptionKey]];
    
    [self failWithError:error];
}

- (void)backCall:(id)jsonObject {
    
    if (jsonObject) {

        ResponseBase* retObj = [[ResponseBase alloc] initWithDic:jsonObject];
        if (retObj == nil) {
            [self failWithErrorText:@""];
            return;
        }
        if (retObj.ResponseStatus != SUCCESS_CODE) {
            [self failWithErrorText:retObj.ResponseMsg];
        }
        else{
            [self  excuteSuccess:jsonObject];
        }
        
        [retObj release];
    }
    else{
        [self failWithErrorText:@"系统错误"];
    }
}

// 不带returncode的网络回调处理
- (void)backCallNotReturnCode:(id)jsonObject {
    ResponseBase* retObj = [[ResponseBase alloc] initWithDic:jsonObject];
    if (retObj == nil) {
        [self failWithErrorText:@""];
        return;
    }
    [self  excuteSuccess:jsonObject];
    [retObj release];
}


//api请求.
-(void)beginRequest {
    
    [self showNetworkError];
    
    if ([PMGlobal shared].isHttp) {
        
        [HttpRequest httpRequest:m_envApiHost apiPath:m_apiName extraParams:m_params
                       className:m_retClass object:self action:@selector(backCall:)];
    }
}

//直接URL请求
-(void)beginRequestWithUrl {
    
    [self showNetworkError];
    
    if ([PMGlobal shared].isHttp)
    {
        [HttpRequest httpRequest:m_apiName className:m_retClass object:self
                          action:@selector(backCallNotReturnCode:)];
    }
}

- (void)dealloc {
    if (m_params != nil ) {
        [m_params release];
    }
    
    [super dealloc];
}


- (void)showNetworkError{

    if (![PMGlobal shared].isHttp) {
        
        NZAlertView *alert = [[NZAlertView alloc]initWithStyle:NZAlertStyleInfo title:@"温馨提示" message:@"似乎已断开网络连接" delegate:nil];
        
        [alert showWithCompletion:^{
            [alert removeFromSuperview];
        }];
        
        return;
    }

}

@end
