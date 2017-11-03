//
//  SubSearchListModel.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/2.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "SubSearchListModel.h"
#import "SubSearchModel.h"

@implementation SubSearchListModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"suggest" : [SubSearchModel class]};
}

@end
