//
//  HomePageApi.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageApi.h"
#import "HomePageModel.h"

@implementation HomePageApi

//请求体参数
- (NSDictionary *)getBody
{
    return @{
             @"type":@"1",
             };
}

- (NSString *)getPath
{
    return @"component/prefecture.json";
}

- (Class)getRespClass
{
    return HomePageModel.class;
}

- (int)getRequestMethod
{
    return RequestMethodGET;
}

@end
