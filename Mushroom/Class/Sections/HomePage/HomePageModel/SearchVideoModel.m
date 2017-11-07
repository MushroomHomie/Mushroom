//
//  SearchVideoModel.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/6.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "SearchVideoModel.h"

@implementation SearchVideoModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"artists" : [HomePageArtistsModel class]};
}

@end
