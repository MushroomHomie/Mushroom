//
//  HomaPageTypeModel.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomaPageTypeModel.h"
#import "HomePageSubDataModel.h"

@implementation HomaPageTypeModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [HomePageSubDataModel class]};
}

@end
