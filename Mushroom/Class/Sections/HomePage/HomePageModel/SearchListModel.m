//
//  SearchListModel.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/2.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "SearchListModel.h"
#import "SearchListApi.h"

@implementation SearchListModel

- (RACSignal *)getSearchResultList:(SearchListApi *)api
{
    RACSignal *successSignal = [self getRequestWithApi:api];
    return successSignal;
}

@end
