//
//  HotSearchModel.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/31.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HotSearchModel.h"
#import "HomePageHotSearchApi.h"

@implementation HotSearchModel

- (RACSignal *)requestHotSearchData
{
    return [self getRequestWithApi:[HomePageHotSearchApi new]];
}

@end
