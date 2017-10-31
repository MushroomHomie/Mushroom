//
//  DataConvert.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "DataConvert.h"

@implementation DataConvert

/// 将Dic转成model
+ (id)convertDic:(NSDictionary *)dic toEntity:(Class)cls
{
    return [cls modelWithDictionary:dic] ;
}


/// 将Model转成dic
+ (id)convertModeltToDic:(id)model
{
    return [NSJSONSerialization JSONObjectWithData:[model modelToJSONObject]
                                           options:NSJSONReadingAllowFragments
                                             error:nil];
}

@end
