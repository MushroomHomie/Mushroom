//
//  DataBaseOperation.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/6.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "DataBaseOperation.h"

@implementation DataBaseOperation

static DataBaseOperation* dataBaseOperation = nil;

+ (DataBaseOperation *)sharedataBaseOperation
{
    @synchronized (self) {
        if (dataBaseOperation== nil)
        {
            dataBaseOperation= [[self alloc] init];
        }
    }
    
    return dataBaseOperation;
}

// 创建数据库
- (void)createDataBaseMethod
{
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbpath = [docsdir stringByAppendingPathComponent:@"Mushroom.sqlite"];
    
    NSLog(@"dbpath = %@",dbpath);
    
    _dataBase = [FMDatabase databaseWithPath:dbpath];
    
    if (![_dataBase open])
    {
        return;
    }
    
    [_dataBase close];
}

// 检查表是否存在
- (BOOL)isTableExist:(NSString *)tableName
{
    FMResultSet *rs = [_dataBase executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"count"];
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}

/// 插入搜索历史记录
- (void)insertSearchHistoricalRecordWithSearchTitle:(NSString *)searchTitle
{
    if (![_dataBase open]) {
        
        return;
    }
    
    if (![self isTableExist:@"SearchHistoricalRecordList"])
    {
        [_dataBase executeUpdate:@"CREATE TABLE SearchHistoricalRecordList (searchTitle TEXT)"];
    }
    
    // 删除之前保存过的搜索内容
    [_dataBase executeUpdate:@"delete from SearchHistoricalRecordList where searchTitle = ?", searchTitle];
    
    FMResultSet *sysParamResultSet = [_dataBase executeQuery:@"SELECT searchTitle FROM SearchHistoricalRecordList"];
    NSMutableArray *searchHistoricalRecordList = [NSMutableArray array];
    
    while ([sysParamResultSet next]){
        NSString *searchTitle = [NSString stringWithFormat:@"%@",[sysParamResultSet stringForColumn:@"searchTitle"]];
        [searchHistoricalRecordList addObject:searchTitle];
    }

    if (searchHistoricalRecordList.count > 4)
    {
        NSString *searchTitle = [searchHistoricalRecordList firstObject];
        [_dataBase executeUpdate:@"delete from SearchHistoricalRecordList where searchTitle = ?", searchTitle];
    }
    
    [_dataBase executeUpdate:@"INSERT INTO SearchHistoricalRecordList(searchTitle) VALUES (?)",searchTitle];
    [_dataBase close];
}

/// 获得搜索历史记录
- (NSArray *)selectSearchHistoricalRecordList
{
    if (![_dataBase open] || ![self isTableExist:@"SearchHistoricalRecordList"]) {
        return nil;
    }
    
    FMResultSet *sysParamResultSet = [_dataBase executeQuery:@"SELECT searchTitle FROM SearchHistoricalRecordList"];
    NSMutableArray *searchHistoricalRecordList = [NSMutableArray array];
    
    while ([sysParamResultSet next]){
        NSString *searchTitle = [NSString stringWithFormat:@"%@",[sysParamResultSet stringForColumn:@"searchTitle"]];
        [searchHistoricalRecordList addObject:searchTitle];
    }
    
    [_dataBase close];
    
    // 倒叙输出
    NSArray *reverseArray = [[searchHistoricalRecordList reverseObjectEnumerator] allObjects];
    
    return reverseArray;
}

/// 删除搜索历史记录
- (void)deleteSearchHistoricalRecordList
{
    if (![_dataBase open] && [self isTableExist:@"SearchHistoricalRecordList"])
    {
        return;
    }

    [_dataBase executeUpdate:@" DROP TABLE IF EXISTS SearchHistoricalRecordList"];
    [_dataBase close];
}

@end
