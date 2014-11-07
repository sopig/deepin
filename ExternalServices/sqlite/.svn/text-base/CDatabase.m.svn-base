//
//  CDatabase.m
//
//  Created on 11/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
//

#import "CDatabase.h"

////////////////////////////////////////////////////////////////////
@implementation ColumnDesc

@synthesize bIsKey;
@synthesize nColumType;
@synthesize nsColumName;

#if ! __has_feature(objc_arc)

- (void)dealloc  {
	[nsColumName release];
    [super dealloc];
}
#endif

@end

////////////////////////////////////////////////////
@implementation TabelDesc

@synthesize columnArray;
@synthesize nsTableName;

- (id) init
{
	if(self=[super init])
	{
		NSMutableArray *array=[[NSMutableArray alloc] init];
		self.columnArray=array;
#if ! __has_feature(objc_arc)
		[array release];
#endif
	}
	return self;
}

//添加列
- (void) AddColumn:(int) nType colName:(NSString *) nsColName primary:(BOOL) bKey
{
	ColumnDesc * colDesc=[[ColumnDesc alloc] init];
	colDesc.nColumType=nType;
	colDesc.nsColumName=nsColName;
	colDesc.bIsKey=bKey;
	[self.columnArray addObject:colDesc];
#if ! __has_feature(objc_arc)
    [colDesc release];
#endif
}

#if ! __has_feature(objc_arc)
- (void)dealloc
{
	[columnArray release];
	[nsTableName release];
    [super dealloc];
}
#endif

@end


///////////////////////////////////////////////////

@implementation ParamInfo

@synthesize paramType;
@synthesize nValue64;
@synthesize dbValue;
@synthesize szValue;

- (id) init
{
	if(self=[super init])
	{
		paramType=0;
		nValue64=0;
		dbValue=0.0f;
		szValue=NULL;		
	}
	return self;
}

#if ! __has_feature(objc_arc)
- (void)dealloc 
{
	if(szValue!=NULL)
		free(szValue);
	
    [super dealloc];
}
#endif

@end

///////////////////////////////////////////////////////
@implementation DataBaseParam

@synthesize paramArray;
@synthesize nsSqlText;

- (id) init
{
	if(self=[super init])
	{
		NSMutableArray *array=[[NSMutableArray alloc] init];
		self.paramArray=array;
        
#if ! __has_feature(objc_arc)
		[array release];
#endif
	}
	return self;
}

- (void) AddParamText:(NSString *) nsParam
{	
	const char * pValue=[nsParam UTF8String];
	[self AddParamString:pValue];
}

- (void) AddParamString:(const char *) szParam
{
	ParamInfo * param=[[ParamInfo alloc] init];	
	int nLen=(int)strlen(szParam);
	char * pNew=(char*)malloc(nLen+1);
	memcpy(pNew,szParam,nLen);
	pNew[nLen]=0;
	param.szValue=pNew;
	param.nValue64=nLen;
	param.paramType=DT_TEXT;
	[paramArray addObject:param];
    
#if ! __has_feature(objc_arc)
    [param release];
#endif
}

- (void) AddParamInt:(int) nParam
{
	ParamInfo * param=[[ParamInfo alloc] init];	
	
	param.nValue64=nParam;
	param.paramType=DT_INT;
	[paramArray addObject:param];
    
#if ! __has_feature(objc_arc)
    [param release];
#endif
}

- (void) AddParamDouble:(double) dbParam
{
	ParamInfo * param=[[ParamInfo alloc] init];		
	param.dbValue=dbParam;
	param.paramType=DT_DOUBLE;
	[paramArray addObject:param];
#if ! __has_feature(objc_arc)
    [param release];
#endif
}

- (void) AddParamInt64:(sqlite_int64) n64Param
{
	ParamInfo * param=[[ParamInfo alloc] init];		
	param.nValue64=n64Param;
	param.paramType=DT_INT64;
	[paramArray addObject:param];
#if ! __has_feature(objc_arc)
    [param release];
#endif
}

- (void) AddBlobParameter:(void *) pData datalen:(int) nDataLenght
{
	ParamInfo * param=[[ParamInfo alloc] init];	
	
	char * pNew=(char *)malloc(nDataLenght);
	memcpy(pNew,pData,nDataLenght);	
	param.szValue=pNew;
	param.nValue64=nDataLenght;
	param.paramType=DT_BLOB;
	[paramArray addObject:param];
#if ! __has_feature(objc_arc)
    [param release];
#endif
}

#if ! __has_feature(objc_arc)
- (void) dealloc
{
	[paramArray release];
	[nsSqlText release];
    [super dealloc];
}
#endif

@end

///////////////////////////////////////////////////////////////////
@implementation CDatabase

@synthesize nsDBName;


- (BOOL) OpenCoreDatabase:(NSString *) dbName
{

//	NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//	NSString * documentDirectory=[paths objectAtIndex:0];
    
	NSString * documentDirectory= [[NSBundle mainBundle] bundlePath];
	NSString * name=[documentDirectory stringByAppendingPathComponent:dbName];
	self.nsDBName=name;
	
	if(sqlite3_open([self.nsDBName UTF8String],&database)!=SQLITE_OK)
	{
		sqlite3_close(database);
		NSAssert(0,@"Failed to open database");
		return NO;
	}
	return YES;	
}

- (BOOL) OpenUserDatabase:(NSString *) dbName
{
    
    NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * documentDirectory=[paths objectAtIndex:0];
	NSString * name=[documentDirectory stringByAppendingPathComponent:dbName];
	self.nsDBName=name;
	
	if(sqlite3_open([self.nsDBName UTF8String],&database)!=SQLITE_OK)
	{
		sqlite3_close(database);
		NSAssert(0,@"Failed to open database");
		return NO;
	}
	return YES;	
}

- (void) CloseDataBase
{
	sqlite3_close(database);
}

//执行命令脚本
- (BOOL) ExecCmd:(NSString *) nsSql
{
	char * errorMsg;	
	if(sqlite3_exec(database, [nsSql UTF8String],NULL,NULL,&errorMsg)!=SQLITE_OK)
	{		
		NSAssert1(0,@"Error creating table:%s",errorMsg);
		return NO;
	}
	return YES;	
}

//执行带参数命令脚本
- (BOOL) ExecCmdByParam:(DataBaseParam *) params
{
	sqlite3_stmt * stmt;
	 
	if(sqlite3_prepare_v2(database,[params.nsSqlText UTF8String],-1,&stmt,nil)!=SQLITE_OK)
		return NO;
		
	NSMutableArray *array=params.paramArray;
	NSInteger nCount=[array count];
	for(NSInteger i=0;i<nCount;i++)
	{
		ParamInfo * pInfo =[array objectAtIndex:i];
		switch (pInfo.paramType) {
		case DT_INT:
			{
				int nValue=(int)pInfo.nValue64;
				sqlite3_bind_int(stmt,i+1,nValue);
			}
			break;
		case DT_INT64:
			sqlite3_bind_int64(stmt,i+1,pInfo.nValue64);
			break;
		case DT_TEXT:
			sqlite3_bind_text(stmt,i+1,pInfo.szValue,-1,NULL);
			break;
		case DT_DOUBLE:
			sqlite3_bind_double(stmt,i+1,pInfo.dbValue);
			break;
		case DT_BLOB:
			{
				int nLen=(int)pInfo.nValue64;
				sqlite3_bind_blob(stmt,i+1,pInfo.szValue, nLen,NULL);
			}
			break;
		default:
			break;
		}
	}
	
	//char * errorMsg;
	BOOL bSuccess=YES;
	if(sqlite3_step(stmt) !=SQLITE_DONE)
	{
		bSuccess=NO;
		NSAssert1(0,@"Error:%@",params.nsSqlText);
	}
	sqlite3_finalize(stmt);
	
	return bSuccess;
}

//创建表
- (BOOL) CreateTable:(TabelDesc *) tableDesc
{
	if(tableDesc==nil)
		return NO;
	if(tableDesc.nsTableName==nil)
		return NO;
	
	NSMutableArray *colArray=tableDesc.columnArray;
	NSInteger nColCount=[colArray count];
	if(nColCount==0)
		return NO;
	
	NSMutableString * createSql=[[NSMutableString alloc] initWithFormat:@"CREATE TABLE IF NOT EXISTS %@(",tableDesc.nsTableName];
	for(NSInteger i=0;i<nColCount;i++)
	{
		ColumnDesc * col=[colArray objectAtIndex:i];
		[createSql appendString:col.nsColumName];		
		switch (col.nColumType) {
			case DT_INT:
				[createSql appendString:@" INTEGER"];
				break;
			case DT_INT64:
				[createSql appendString:@" NUMERIC"];
				break;
			case DT_TEXT:
				[createSql appendString:@" TEXT"];
				break;
			case DT_DOUBLE:
				[createSql appendString:@" REAL"];
				break;
			case DT_BLOB:
				[createSql appendString:@" NONE"];
				break;
			default:
				break;
		}
		if(col.bIsKey)
		{
			[createSql appendString:@" PRIMARY KEY"];
		}
		if(i<nColCount-1)
		{
			[createSql appendString:@","];
		}
	}	
	[createSql appendString:@");"];
	
	//NSLog(createSql);
	char * errorMsg;	 
	if(sqlite3_exec(database, [createSql UTF8String],NULL,NULL,&errorMsg)!=SQLITE_OK)
	{		 
		NSAssert1(0,@"Error creating table:%s",errorMsg);
		return NO;
	}
#if ! __has_feature(objc_arc)
	[createSql release];
#endif
    return YES;
}

//准备语句
- (STATEMENT *) PrepareSQL:(NSString *) sqlText
{
	STATEMENT * pstateInfo=NULL;
	sqlite3_stmt * statement;
	if(sqlite3_prepare_v2(database, [sqlText UTF8String], -1, &statement, nil)==SQLITE_OK)
	{
		pstateInfo=malloc(sizeof(STATEMENT));
		if(pstateInfo==NULL)
		{
			sqlite3_finalize(statement);
			return NO;
		}
		pstateInfo->statement=statement;
		pstateInfo->nColIndex=0;		
	}
	return pstateInfo;		
}

//准备语句
- (STATEMENT *) PrepareSQLByParam:(DataBaseParam *) params
{		
	if(params==nil)
		return NULL;
			
	STATEMENT * pstateInfo=NULL;
	sqlite3_stmt * statement;
	if(sqlite3_prepare_v2(database, [params.nsSqlText UTF8String], -1, &statement, nil)!=SQLITE_OK)
	{
		return NO;		
	}
	
	NSMutableArray *array=params.paramArray;
	NSInteger nCount=[array count];
	for(NSInteger i=0;i<nCount;i++)
	{
		ParamInfo * pInfo =[array objectAtIndex:i];
		switch (pInfo.paramType) {
			case DT_INT:
				{
					int nValue=(int)pInfo.nValue64;
					sqlite3_bind_int(statement,i+1,nValue);
				}
				break;
			case DT_INT64:
				sqlite3_bind_int64(statement,i+1,pInfo.nValue64);
				break;
			case DT_TEXT:
				sqlite3_bind_text(statement,i+1,pInfo.szValue,-1,NULL);
				break;
			case DT_DOUBLE:
				sqlite3_bind_double(statement,i+1,pInfo.dbValue);
				break;
			case DT_BLOB:
				{
					int nLen=(int)pInfo.nValue64;
					sqlite3_bind_blob(statement,i+1,pInfo.szValue, nLen,NULL);
				}
				break;
			default:
				break;
		}
	}
	
	pstateInfo=malloc(sizeof(STATEMENT));
	if(pstateInfo==NULL)
	{
		sqlite3_finalize(statement);
		return NO;
	}
	pstateInfo->statement=statement;
	pstateInfo->nColIndex=0;
	
	return pstateInfo;			
}

//获下一行
- (BOOL) GetNextColumn:(STATEMENT *) statement
{
	sqlite3_stmt * stmt=(sqlite3_stmt *)statement->statement;
	if(sqlite3_step(stmt)==SQLITE_ROW)
	{
		statement->nColIndex=0;
		return YES;
	}
		
	return NO;
}

//获取数据
- (int) GetColumnInt:(STATEMENT *) statement
{
	sqlite3_stmt * stmt=(sqlite3_stmt *)statement->statement;
	int nValue=sqlite3_column_int(stmt, statement->nColIndex++);
	return nValue;
}

- (sqlite_int64) GetColumnInt64:(STATEMENT *) statement
{
	sqlite3_stmt * stmt=(sqlite3_stmt *)statement->statement;
	sqlite_int64 nValue=sqlite3_column_int64(stmt, statement->nColIndex++);
	return nValue;
}

- (char *) GetColumnString:(STATEMENT *) statement
{
	sqlite3_stmt * stmt=(sqlite3_stmt *)statement->statement;
	char * rowData=(char*)sqlite3_column_text(stmt,statement->nColIndex++);
	return rowData;
}

- (NSString *) GetColumnText:(STATEMENT *) statement
{
	sqlite3_stmt * stmt=(sqlite3_stmt *)statement->statement;
	char * rowData=(char*)sqlite3_column_text(stmt,statement->nColIndex++);
	if(rowData==NULL)
		return nil;
	NSString * fieldValue=[[NSString alloc] initWithUTF8String:rowData];
#if ! __has_feature(objc_arc)
    [fieldValue autorelease];
#endif
	return fieldValue;
}

- (double) GetColumnDouble:(STATEMENT *) statement
{
	sqlite3_stmt * stmt=(sqlite3_stmt *)statement->statement;
	double nValue=sqlite3_column_double(stmt, statement->nColIndex++);
	return nValue;
	
}

- (int) GetColumnBlod:(STATEMENT *) statement blobBuffer:(void *)dataBuffer bufLen:(int) buffLen
{
	sqlite3_stmt * stmt=(sqlite3_stmt *)statement->statement;
	int nDataLen=sqlite3_column_bytes(stmt,statement->nColIndex);
	const void * colData=sqlite3_column_blob(stmt, statement->nColIndex++);
	if(buffLen>nDataLen)
		buffLen=nDataLen;
	memcpy(dataBuffer, colData, buffLen);
	return nDataLen;
}

- (int) GetColumnBlod:(STATEMENT *) statement blobBuffer:(void **)dataBuffer
{
	assert(*dataBuffer==NULL);
	sqlite3_stmt * stmt=(sqlite3_stmt *)statement->statement;
	int nDataLen=sqlite3_column_bytes(stmt,statement->nColIndex);
	*dataBuffer=malloc(nDataLen);
	if(*dataBuffer==NULL)
		return 0;
	const void * colData=sqlite3_column_blob(stmt, statement->nColIndex++);
	memcpy(*dataBuffer, colData, nDataLen);
	return nDataLen;
}

- (void) FinishColumn:(STATEMENT *) statement
{
	sqlite3_stmt * stmt=(sqlite3_stmt *)statement->statement;
	sqlite3_finalize(stmt);	
	free(statement);
}

- (sqlite_int64) GetLastInsertID
{
	return sqlite3_last_insert_rowid(database);
}

#if ! __has_feature(objc_arc)
- (void)dealloc 
{
	[nsDBName release];	
    [super dealloc];
}
#endif

@end
