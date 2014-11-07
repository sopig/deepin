//
//  CDatabase.h
//
//  Created on 11/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

//////////////////////////////////////////////////////////////
#define DT_INT			0x01					//32位整型
#define DT_INT64		0x02					//64位整型
#define DT_DOUBLE		0x03					//double型
#define DT_TEXT			0x04					//字符串型
#define DT_BLOB			0x05					//二进制型

//////////////////////////////////////////////////////////////
@interface ColumnDesc : NSObject
{
	BOOL			bIsKey;
	int				nColumType;
	NSString		*nsColumName;	
}

@property (nonatomic) BOOL bIsKey;
@property (nonatomic) int nColumType;
@property (nonatomic,retain) NSString *nsColumName;

@end
//////////////////////////////////////////////////////////////

@interface TabelDesc : NSObject
{
	NSMutableArray		*columnArray;
	NSString			*nsTableName;
}

@property(nonatomic,retain) NSMutableArray *columnArray;
@property(nonatomic,retain) NSString *nsTableName;

//添加列
- (void) AddColumn:(int) nType colName:(NSString *) nsColName primary:(BOOL) bKey;

@end
//////////////////////////////////////////////////////////////

@interface ParamInfo : NSObject
{
@private
	int					paramType;
	sqlite_int64		nValue64;
	double				dbValue;
	char				*szValue;
}

@property (nonatomic) int paramType;
@property (nonatomic) sqlite_int64 nValue64;
@property (nonatomic) double dbValue;
@property (nonatomic) char * szValue;

@end


@interface DataBaseParam : NSObject
{
	NSMutableArray		*paramArray;
	
@private
	NSString			*nsSqlText;

}

@property (nonatomic,retain) NSString *nsSqlText;
@property (nonatomic,retain) NSMutableArray *paramArray;

- (void) AddParamText:(NSString *) nsParam;
- (void) AddParamString:(const char *) szParam;
- (void) AddParamInt:(int) nParam;
- (void) AddParamDouble:(double) dbParam;
- (void) AddParamInt64:(sqlite_int64) n64Param;
- (void) AddBlobParameter:(void *) pData datalen:(int) nDataLenght;

@end

typedef struct tagStatement 
{
	void	*statement;
	int		nColIndex;
}STATEMENT;

//////////////////////////////////////////////////////////////
@interface CDatabase : NSObject 
{
@private
	NSString				*nsDBName;
	sqlite3					*database;
}

@property (nonatomic,retain) NSString *nsDBName;

- (BOOL) OpenCoreDatabase:(NSString *) dbName;
- (BOOL) OpenUserDatabase:(NSString *) dbName;
- (void) CloseDataBase;

- (BOOL) ExecCmd:(NSString *) nsSql;
- (BOOL) ExecCmdByParam:(DataBaseParam *) params;

- (BOOL) CreateTable:(TabelDesc *) tableDesc;

- (STATEMENT *) PrepareSQL:(NSString *) sqlText;
- (STATEMENT *) PrepareSQLByParam:(DataBaseParam *) params;

- (BOOL) GetNextColumn:(STATEMENT *) statement;
- (int) GetColumnInt:(STATEMENT *) statement;
- (sqlite_int64) GetColumnInt64:(STATEMENT *) statement;
- (char *) GetColumnString:(STATEMENT *) statement;
- (NSString *) GetColumnText:(STATEMENT *) statement;
- (double) GetColumnDouble:(STATEMENT *) statement;
- (int) GetColumnBlod:(STATEMENT *) statement blobBuffer:(void *)dataBuffer bufLen:(int) buffLen;
- (int) GetColumnBlod:(STATEMENT *) statement blobBuffer:(void **)dataBuffer;
- (void) FinishColumn:(STATEMENT *) statement;

- (sqlite_int64) GetLastInsertID;

@end
