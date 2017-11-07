//
//  HomePageSearchCellVM.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/31.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageSearchCellVM.h"
#import "SubDefaultSearchModel.h"

@interface  HomePageSearchCellVM ()

@property (nonatomic, strong, nullable) SubDefaultSearchModel *model;

@end

@implementation HomePageSearchCellVM

- (instancetype)initWithSearchListModel:(nullable id)model
{
    self = [super init];
    if (self)
    {
        _searchResultModel = model;
    }
    return self;
}

- (NSString *)getHomePageSearchText
{
    if (_searchResultModel)
    {
        return self.searchResultModel.word;
    }
    return self.model.title;
}

- (NSArray *)getHotSearchTag
{
    return self.hotSearchData;
}

- (NSString *)getSearchHistoryTitle
{
    return self.searchHistoryTitle;
}

@end
