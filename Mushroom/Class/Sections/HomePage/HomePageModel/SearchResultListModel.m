//
//  SearchResultListModel.m
//  Mushroom
//
//  Created by 王雅琦 on 2018/1/8.
//  Copyright © 2018年 iOSfghj. All rights reserved.
//

#import "SearchResultListModel.h"
#import "SearchVideoListApi.h"

@implementation SearchResultListModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [SearchResultModel class]};
}

- (RACSignal *)requestSearchResultList:(NSString *)keyWord offset:(NSInteger)offset
{
    SearchVideoListApi *api = [SearchVideoListApi new];
    api.keyword = keyWord;
    api.offset = [NSString stringWithFormat:@"%ld",offset];
    return [self getRequestWithApi:api];
}

@end
