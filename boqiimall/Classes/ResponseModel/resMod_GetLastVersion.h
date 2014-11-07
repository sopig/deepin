//
//  resMod_GetLastVersion.h
//  BoqiiLife
//
//  Created by YSW on 14-5-5.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_LastVersionInfo : NSObject{
    int VersionStatus;
    NSString * UpdateMsg;
}

@property (assign,nonatomic) int VersionStatus;
@property (retain,nonatomic) NSString * UpdateMsg;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end





@interface resMod_CallBack_LastVersion : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_LastVersionInfo * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_LastVersionInfo * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end