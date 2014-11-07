//
//  WXHandle.m
//  boqiimall
//
//  Created by 张正超 on 14-8-27.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "WXHandle.h"

#import "resMod_QueryGoodsOrder.h" //商城商品微信支付结果查询
#import "resMod_QueryOrder.h"   //生活馆微信支付结果查询

#import <NZAlertView/NZAlertView.h>
#import "WXErrorUtil.h"

@interface WXHandle ()
@end

static WXHandle *handle = nil;
static NSString *stateDomain = @"com.boqii.boqiiMall.tolly.oauth2.0";
@implementation WXHandle

+ (instancetype)shareWXHandle
{
    if (handle == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            handle = [[[self class]alloc]init];
        });
    }
    return handle ;
}

///*
// 调起微信支付
// */
- (void)sendPayWithParamDict:(NSMutableDictionary*)params
{
   
    if ( params != nil) {
        
        NSMutableString *stamp  = [params objectForKey:@"TimeStamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = tencentWXAppID;
        req.partnerId           = tencentWXPartnerID;
        req.prepayId            = [params objectForKey:@"PrepayId"];
        req.nonceStr            = [params objectForKey:@"NonceStr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [params objectForKey:@"Package"];
        req.sign                = [params objectForKey:@"AppSignature"];
        [WXApi safeSendReq:req];

        //如需要对调起支付进行统计，则请在此处添加  将各参数统计上传
        NSLog(@"");
    }
    else
    {
        [self alert:@"提示信息" msg:@"参数错误"];
    }
    
}


//调起微信授权
- (void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ] ;
    req.scope = @"snsapi_userinfo" ;
    req.state = stateDomain ;
    
    [WXApi sendReq:req];
}


//
//提示消息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    
    NZAlertView *alert = [[NZAlertView alloc]initWithStyle:NZAlertStyleInfo title:title message:msg delegate:self];
    
    [alert showWithCompletion:^{
        [alert removeFromSuperview];
    }];
    
    
}

#pragma mark - WXApiDelegate

-(void) onReq:(BaseReq*)req
{
    if (_delegate && [_delegate respondsToSelector:@selector(requestFromPayHandle:)]){
        [_delegate requestFromPayHandle:nil];
    }
}


-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        PayResp *response = (PayResp*)resp;
        switch (response.errCode) {
            case WXSuccess:
                
                if (_delegate && [_delegate respondsToSelector:@selector(responseFromPayHandle:)]) {
                    [_delegate responseFromPayHandle:nil];
                }
                 break;
                
            case WXErrCodeUserCancel:
               
                [self alert:@"取消支付" msg:@"您的订单取消支付"];
                
                break;
            default:
                
                [self alert:@"微信支付错误" msg: [NSString stringWithFormat:@"errno = %d",response.errCode]];
                
                break;
        }
    }
    
    else if ([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *response = (SendAuthResp*)resp;
        
    switch (response.errCode) {
            case ERR_OK:
            if (![response.state isEqualToString:stateDomain])
            {
                [self alert:@"微信授权登录" msg:@"您获得的授权信息被篡改，请进行安全检查！"];
                return;
            }
        
            if (self.delegate && [self.delegate respondsToSelector:@selector(responseFromPayHandle:)]) {
                [_delegate responseFromPayHandle:response];
            }
            
                break;
                
            case ERR_AUTH_DENIED:
                [self alert:@"微信授权登录" msg:@"您已拒绝使用微信登录！"];

                break;
                
            case ERR_USER_CANCEL:
                [self alert:@"微信授权登录" msg:@"您已取消使用微信登录！"];

                break;
                
            default:
                break;
        }
        

        
    }
}

@end
