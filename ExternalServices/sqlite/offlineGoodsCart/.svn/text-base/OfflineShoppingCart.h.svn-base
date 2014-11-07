//
//  OfflineShoppingCart.h
//  boqiimall
//
//  Created by iXiaobo on 14-9-22.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfflineGoods.h"
#import "Database.h"

@interface OfflineShoppingCart : NSObject

+(NSMutableArray *)queryAll;
+(OfflineGoods *)findByGoodsId:(NSInteger )goodsId specialId:(NSString *)specialId;
+(BOOL)updateGoods:(OfflineGoods *)item;
+(BOOL)insertGoods:(OfflineGoods *)item;
+(BOOL)deleteGoods:(OfflineGoods *)item;
+(BOOL)deleteAll;


@end
