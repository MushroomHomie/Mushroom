//
//  HomePageSearchCellVM.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/31.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewCellVM.h"
#import "SubSearchModel.h"

@interface HomePageSearchCellVM : BaseTableViewCellVM

@property (nonatomic, strong) NSArray *hotSearchData;
@property (nonatomic, strong) SubSearchModel *searchResultModel;

- (NSString *)getHomePageSearchText;
- (NSArray *)getHotSearchTag;
- (instancetype)initWithSearchListModel:(nullable id)model;

@end
