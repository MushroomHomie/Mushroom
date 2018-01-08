//
//  SearchResultListModel.h
//  Mushroom
//
//  Created by 王雅琦 on 2018/1/8.
//  Copyright © 2018年 iOSfghj. All rights reserved.
//

#import "BaseModel.h"
#import "SearchResultModel.h"

@interface SearchResultListModel : BaseModel

@property (nonatomic, strong) NSArray *data;

- (RACSignal *)requestSearchResultList:(NSString *)keyWord offset:(NSInteger)offset;

@end
