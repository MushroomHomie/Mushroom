//
//  HomePageDefaultSearchModel.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/26.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseModel.h"
#import "SubDefaultSearchModel.h"

@interface HomePageDefaultSearchModel : BaseModel

@property (nonatomic, strong) NSArray *data;

- (RACSignal *)requestHomePageTopDefaultSearch;

@end
