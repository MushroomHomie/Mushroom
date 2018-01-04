//
//  HomePageHotSearchApi.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/31.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageHotSearchApi.h"
#import "HotSearchModel.h"

@implementation HomePageHotSearchApi

- (NSString *)getPath
{
    return @"search/top_keyword.json";
}

- (Class)getRespClass
{
    return HotSearchModel.class;
}

- (int)getRequestMethod
{
    return RequestMethodGET;
}
@end
