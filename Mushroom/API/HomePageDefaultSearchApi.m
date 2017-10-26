//
//  HomePageDefaultSearchApi.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/26.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageDefaultSearchApi.h"
#import "HomePageDefaultSearchModel.h"

@implementation HomePageDefaultSearchApi

- (NSString *)getPath
{
    return @"search/search_rec.json";
}

- (Class)getRespClass
{
    return HomePageDefaultSearchModel.class;
}

- (int)getRequestMethod
{
    return RequestMethodGET;
}

@end
