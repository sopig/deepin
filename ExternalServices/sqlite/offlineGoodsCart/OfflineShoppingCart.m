//
//  OfflineShoppingCart.m
//  boqiimall
//
//  Created by iXiaobo on 14-9-22.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "OfflineShoppingCart.h"

#define kTableName @"GOODSINFO"
#define kGoodsId @"goodsId"
#define kGoodsSpecId @"goodsSpecId"
#define kGoodsType @"goodsType"
#define kGoodsNum @"goodsNum"
#define kAddedTime @"addedTime"
#define kGoodsSelected @"selected"
#define kChangeBuyId @"changeBuyId"
#define kActionId @"actionId"




@implementation OfflineShoppingCart
+(NSMutableArray *)queryAll
{
    
    @synchronized(self)
    {
        sqlite3_stmt *stmt = NULL;
        NSMutableArray *itemsArray ;
        
        sqlite3 *mySQLite = [Database openDatabase];
        if (mySQLite == nil)
        {
            return nil;
        }
        NSString *sql = [NSString stringWithFormat:@"select * from %@",kTableName];
        int flag = sqlite3_prepare_v2(mySQLite, [sql UTF8String], -1, &stmt, nil);
        if (flag == SQLITE_OK)
        {
            itemsArray = [[NSMutableArray alloc] init];
            while (sqlite3_step(stmt) == SQLITE_ROW)
            {
                OfflineGoods *item = [[OfflineGoods alloc] init];
                item.goodsID = sqlite3_column_int(stmt, 1);
                item.goodsSpecId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                item.goodsType = sqlite3_column_int(stmt,3);
                item.totalNum =  sqlite3_column_int(stmt, 4);
                double dateValue = sqlite3_column_double(stmt, 5);
                item.addedDate = [NSDate dateWithTimeIntervalSince1970:dateValue];
                item.selected = sqlite3_column_int(stmt,6);
                item.changeBuyId = sqlite3_column_int(stmt,7);
                item.actionId = sqlite3_column_int(stmt,8);
                [itemsArray addObject:item];
            }
            sqlite3_finalize(stmt);
            return itemsArray;
        }
        else
        {
            return nil;
        }
    }
    
}




+(OfflineGoods *)findByGoodsId:(NSInteger )goodsId specialId:(NSString *)specialId
{
    @synchronized(self)
    {
        OfflineGoods *item = nil;
        sqlite3_stmt *stmt = NULL;
        
        sqlite3 *mySQLite=[Database openDatabase];
        if (mySQLite == nil)
        {
            return NO;
        }
        
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@=? and %@=?",kTableName,kGoodsId,kGoodsSpecId];
        int flag=sqlite3_prepare_v2(mySQLite, [sql UTF8String], -1, &stmt, nil);
        if (flag==SQLITE_OK)
        {
            sqlite3_bind_int(stmt, 1, goodsId);
            
            if (specialId)
            {
                sqlite3_bind_text(stmt, 2, [specialId UTF8String], -1, nil);
            }
           
           if(sqlite3_step(stmt) ==SQLITE_ROW)
            {
                item = [[OfflineGoods alloc] init];
                item.goodsID = sqlite3_column_int(stmt, 1);
                item.goodsSpecId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                item.goodsType = sqlite3_column_int(stmt, 3);
                item.totalNum =  sqlite3_column_int(stmt, 4);
                double dateValue = sqlite3_column_double(stmt, 5);
                item.addedDate = [NSDate dateWithTimeIntervalSince1970:dateValue];
                item.selected = sqlite3_column_int(stmt,6);
                item.changeBuyId = sqlite3_column_int(stmt,7);
                item.actionId = sqlite3_column_int(stmt,8);
            }
        }
        
        sqlite3_finalize(stmt);
        sqlite3_close(mySQLite);
        return item;
    }
    
}

+(BOOL)updateGoods:(OfflineGoods *)item
{
    @synchronized(self)
    {
        NSDate *nowDate = nil;
        NSDate *localeDate = nil;
        sqlite3_stmt *stmt = NULL;
        
        sqlite3 *mySQLite=[Database openDatabase];
        if (mySQLite == nil)
        {
            return NO;
        }
        nowDate = item.addedDate;
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: nowDate];
        localeDate = [nowDate  dateByAddingTimeInterval: interval];

        
        NSString *sql = [NSString stringWithFormat:@"update %@ set %@='%d',%@='%d',%@='%f',%@='%d',%@='%d',%@='%d' where %@='%d' and %@='%s' ",kTableName,kGoodsType,item.goodsType,kGoodsNum,item.totalNum,kAddedTime,[localeDate timeIntervalSince1970],kGoodsSelected,item.selected,kChangeBuyId,item.changeBuyId,kActionId,item.actionId,kGoodsId,item.goodsID,kGoodsSpecId,(item.goodsSpecId != nil ? [item.goodsSpecId UTF8String]:"")];
        int flag=sqlite3_prepare_v2(mySQLite, [sql UTF8String], -1, &stmt, nil);
        if (flag==SQLITE_OK)
        {
            
//            sqlite3_bind_int(stmt, 1, item.goodsID);
//            sqlite3_bind_text(stmt, 2, [item.goodsSpecId UTF8String], -1, nil);
//            sqlite3_bind_int(stmt, 3, item.goodsType);
//            sqlite3_bind_int(stmt, 4, item.totalNum);
//            nowDate = item.addedDate;
//            NSTimeZone *zone = [NSTimeZone systemTimeZone];
//            NSInteger interval = [zone secondsFromGMTForDate: nowDate];
//            localeDate = [nowDate  dateByAddingTimeInterval: interval];
//            sqlite3_bind_double(stmt, 5,[localeDate timeIntervalSince1970]);
            
           //int flag = sqlite3_step(stmt);
            
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                sqlite3_finalize(stmt);
                sqlite3_close(mySQLite);
                return NO;
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(mySQLite);
        return YES;
    }
}


+(BOOL)insertGoods:(OfflineGoods *)item
{
    @synchronized(self)
    {
        NSDate *nowDate = nil;
        NSDate *localeDate = nil;
        sqlite3_stmt *stmt = NULL;
        
        sqlite3 *mySQLite = [Database openDatabase];
        if (mySQLite == nil)
        {
            return NO;
        }
        NSString *sql = [NSString stringWithFormat:
                         @"INSERT INTO '%@' ('%@','%@', '%@','%@','%@','%@','%@','%@') VALUES (?,?,?,?,?,?,?,?)",
                         kTableName,kGoodsId, kGoodsSpecId,kGoodsType, kGoodsNum, kAddedTime,kGoodsSelected,kChangeBuyId,kActionId];
        int flag = sqlite3_prepare_v2(mySQLite, [sql UTF8String], -1, &stmt, nil);
        if (flag == SQLITE_OK)
        {
    
            
            sqlite3_bind_int(stmt, 1, item.goodsID);
            if (item.goodsSpecId)
            {
                sqlite3_bind_text(stmt, 2, [item.goodsSpecId UTF8String], -1, nil);
            }
            sqlite3_bind_int(stmt, 3, item.goodsType);
            sqlite3_bind_int(stmt, 4, item.totalNum);
            nowDate = item.addedDate;
            NSTimeZone *zone = [NSTimeZone systemTimeZone];
            NSInteger interval = [zone secondsFromGMTForDate: nowDate];
            localeDate = [nowDate  dateByAddingTimeInterval: interval];
            sqlite3_bind_double(stmt, 5,[localeDate timeIntervalSince1970]);
            sqlite3_bind_int(stmt, 6, 1);
            sqlite3_bind_int(stmt, 7, 0);
            sqlite3_bind_int(stmt, 8, 0);
            
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                sqlite3_finalize(stmt);
                sqlite3_close(mySQLite);
                return NO;
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(mySQLite);
        return YES;
    }
}


+(BOOL)deleteGoods:(OfflineGoods *)item
{
    @synchronized(self)
    {
        sqlite3_stmt *stmt = NULL;
        
        sqlite3 *mySQLite  = [Database openDatabase];
        if (mySQLite == nil)
        {
            return NO;
        }
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@='%d' and %@='%s'",kTableName,kGoodsId,item.goodsID,kGoodsSpecId,[item.goodsSpecId UTF8String]];
        int flag = sqlite3_prepare_v2(mySQLite, [sql UTF8String], -1, &stmt, nil);
        if (flag == SQLITE_OK)
        {
         if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                sqlite3_finalize(stmt);
                sqlite3_close(mySQLite);
                return NO;
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(mySQLite);
        return YES;
    }
    
}
+(BOOL)deleteAll
{
    @synchronized(self)
    {
        sqlite3_stmt *stmt = NULL;
        
        sqlite3 *mySQLite  = [Database openDatabase];
        if (mySQLite == nil)
        {
            return NO;
        }
        NSString *sql = [NSString stringWithFormat:@"delete from %@",kTableName];
        int flag = sqlite3_prepare_v2(mySQLite, [sql UTF8String], -1, &stmt, nil);
        if (flag == SQLITE_OK)
        {
            if (sqlite3_step(stmt) != SQLITE_DONE)
            {
                sqlite3_finalize(stmt);
                sqlite3_close(mySQLite);
                return NO;
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(mySQLite);
        return YES;
        
    }
    return YES;
}

@end
