//
//  DataConvert.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit/YYKit.h>

@interface DataConvert : NSObject

/// 将Dic转成model
+ (id)convertDic:(NSDictionary *)dic toEntity:(Class)cls;

/// 将Model转成dic
+ (id)convertModeltToDic:(id)model;
@end
