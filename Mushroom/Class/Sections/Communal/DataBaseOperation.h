//
//  DataBaseOperation.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/6.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DataBaseOperation : NSObject
{
   FMDatabase *_dataBase;
}

+ (DataBaseOperation *)sharedataBaseOperation;
/// 创建数据库
- (void)createDataBaseMethod;
// 检查表是否存在
- (BOOL)isTableExist:(NSString *)tableName;

/// 插入搜索历史记录
- (void)insertSearchHistoricalRecordWithSearchTitle:(NSString *)searchTitle;

/// 获得搜索历史记录
- (NSArray *)selectSearchHistoricalRecordList;

/// 删除搜索历史记录
- (void)deleteSearchHistoricalRecordList;


@end
