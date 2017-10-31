//
//  HotSearchModel.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/31.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseModel.h"

@interface HotSearchModel : BaseModel

@property (nonatomic, strong) NSArray *data;

- (RACSignal *)requestHotSearchData;
@end
