//
//  ResponseBase.h
//  ule_specSale
//
//  Created by ysw.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseBase : NSObject
{
    int ResponseStatus;
    NSString * ResponseMsg;
    NSString * ResponseData;
    
    //  --  测试环境下注册验证码用到
    NSString * code;
}

@property(nonatomic,assign) int ResponseStatus;
@property(nonatomic,retain) NSString *ResponseMsg;
@property(nonatomic,retain) NSString *ResponseData;
@property(nonatomic,retain) NSString *code;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
