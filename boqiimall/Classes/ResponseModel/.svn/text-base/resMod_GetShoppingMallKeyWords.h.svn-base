//
//  resMod_GetShoppingMallKeyWords.h
//  boqiimall
//
//  Created by 波奇-xiaobo on 14-8-28.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_GetShoppingMallKeyWords : NSObject
{
    NSString *TypeId;
    NSMutableArray *keyWordsArray;
}

@property(retain,nonatomic)NSString *TypeId;
@property (retain,nonatomic) NSMutableArray *keyWordsArray;


-(instancetype)initWithDic:(NSDictionary*)dic;

@end


/******************************************************
 ---------        return  : call back
 ******************************************************
 */
@interface resMod_CallBackMall_SearchKeyWordsList: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end