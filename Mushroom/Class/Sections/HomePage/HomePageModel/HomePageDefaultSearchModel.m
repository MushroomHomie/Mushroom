//
//  HomePageDefaultSearchModel.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/26.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageDefaultSearchModel.h"
#import "HomePageDefaultSearchApi.h"

@implementation HomePageDefaultSearchModel

- (RACSignal *)requestHomePageData
{
    return [self getRequestWithApi:[HomePageDefaultSearchApi new]];
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [SubDefaultSearchModel class]};
}

@end
