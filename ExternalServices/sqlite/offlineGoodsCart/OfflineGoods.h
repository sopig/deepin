//
//  OfflineGoods.h
//  boqiimall
//
//  Created by iXiaobo on 14-9-22.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfflineGoods : NSObject
{
    NSInteger goodsID;
    NSString *goodsSpecId;
    NSInteger goodsType;
    NSInteger totalNum;
    NSDate *addedDate;
    NSInteger selected;  // 0 为未选中，1为选中
    NSInteger changeBuyId;
    NSInteger actionId;
}

@property(assign,nonatomic)NSInteger goodsID;
@property(strong,nonatomic)NSString *goodsSpecId;
@property(assign,nonatomic)NSInteger totalNum;
@property(strong,nonatomic)NSDate *addedDate;
@property(assign,nonatomic)NSInteger goodsType;
@property(assign,nonatomic)NSInteger selected;
@property(assign,nonatomic)NSInteger changeBuyId;
@property(assign,nonatomic)NSInteger actionId;


@end
