//
//  Database.m
//  boqiimall
//
//  Created by iXiaobo on 14-9-22.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "Database.h"

#define kDatabaseName @"offLineShopingCartV2.sqlite"


@implementation Database
+(sqlite3 *)openDatabase
{
    static sqlite3 *shopCartDB;//表示与studentDb的连接
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:kDatabaseName];
    
    if (sqlite3_open([database_path UTF8String], &shopCartDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS GOODSINFO(ID INTEGER PRIMARY KEY , goodsId INTEGER, goodsSpecID INTEGER,goodsType INTEGER, goodsNum INTEGER,addedTime TEXT,selected INTEGER,changeBuyId INTEGER,actionId INTEGER)";
        if (sqlite3_exec(shopCartDB, sql_stmt, NULL, NULL, &errMsg) !=SQLITE_OK)
        {
            sqlite3_close(shopCartDB);
            return nil;
        }
        else
        {
            return shopCartDB;
        }
    }
    else
    {
        return nil;
    }
}


@end
