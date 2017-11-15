//
//  VideoPlayApi.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/15.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "VideoPlayApi.h"
#import "VideoPlayModel.h"

@implementation VideoPlayApi

// 请求体参数
- (NSDictionary *)getBody
{
    return @{
             @"id":_vedioId?_vedioId:@"",
             @"type":_vedioType?_vedioType:@""
             };
}

- (NSString *)getPath
{
    return @"search/top_keyword.json";
}

- (Class)getRespClass
{
    return VideoPlayModel.class;
}

- (int)getRequestMethod
{
    return RequestMethodGET;
}


@end
