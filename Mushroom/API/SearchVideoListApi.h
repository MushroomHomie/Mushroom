//
//  SearchVideoListApi.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/6.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "MushroomBaseApi.h"

@interface SearchVideoListApi : MushroomBaseApi

@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *offset;
@property (nonatomic, copy) NSString *size;

@end
