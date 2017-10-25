//
//  HomePageSubDataModel.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageSubDataModel.h"

@implementation HomePageSubDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"artists" : [HomePageArtistsModel class]};
}

@end
