//
//  HomePageModel.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageModel.h"
#import "HomePageApi.h"

@implementation HomePageModel

- (RACSignal *)requestHomePageData
{
    return [self getRequestWithApi:[HomePageApi new]];
}


+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [HomaPageTypeModel class]};
}

@end
