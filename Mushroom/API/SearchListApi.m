//
//  SearchListApi.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/2.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "SearchListApi.h"
#import "SearchListModel.h"

@implementation SearchListApi

//请求体参数
- (NSDictionary *)getBody
{
    if (!_keyWord)
    {
        _keyWord = @"";
    }
    
    return @{
             @"keyword":_keyWord,
             @"type":@"Mv"
             };
}

- (NSString *)getPath
{
    return @"search/suggest.json";
}

- (Class)getRespClass
{
    return SearchListModel.class;
}

- (int)getRequestMethod
{
    return RequestMethodGET;
}

@end
