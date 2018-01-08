//
//  SearchResultModel.m
//  Mushroom
//
//  Created by 王雅琦 on 2018/1/8.
//  Copyright © 2018年 iOSfghj. All rights reserved.
//

#import "SearchResultModel.h"
#import "HomePageArtistsModel.h"

@implementation SearchResultModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"artists" : [HomePageArtistsModel class]};
}


@end
