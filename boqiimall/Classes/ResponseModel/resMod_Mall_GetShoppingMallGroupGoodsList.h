//
//  resMod_Mall_GetShoppingMallGroupGoodsList.h
//  boqiimall
//
//  Created by iXiaobo on 14-9-24.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_Mall_GetShoppingMallGroupGoods : NSObject
{
    NSInteger goodsId;
    NSString *goodsImgUrl;
    NSString *goodsTitle;
    float goodsPrice;
    float goodsOriPrice;
    NSInteger goodsSaledNum;
    NSString *goodsScale;
    NSInteger remainTime;
}
-(instancetype)initWithDic:(NSDictionary*)dic;
@property(nonatomic,assign)NSInteger goodsId;
@property(retain,nonatomic)NSString *goodsImgUrl;
@property(retain,nonatomic)NSString *goodsTitle;
@property(nonatomic,assign)float goodsPrice;
@property(nonatomic,assign)float goodsOriPrice;
@property(nonatomic,assign)NSInteger goodsSaledNum;
@property(retain,nonatomic)NSString *goodsScale;
@property(nonatomic,assign)NSInteger remainTime;

@end

@interface resMod_CallbackMall_GetShoppingMallGroupGoodsList : NSObject
{
    
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
    
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;


@end