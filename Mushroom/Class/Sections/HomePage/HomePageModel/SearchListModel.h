//
//  SearchListModel.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/2.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseModel.h"
#import "SubSearchListModel.h"
@class SearchListApi;

@interface SearchListModel : BaseModel

@property (nonatomic, strong) SubSearchListModel *data;

- (RACSignal *)getSearchResultList:(SearchListApi *)api;

@end
