//
//  HomePageSearchVM.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewModel.h"
#import "SearchListApi.h"

@interface HomePageSearchVM : BaseTableViewModel

- (void)getHistoryListTitle;

/// 默认三条搜索
- (void)getTopThreeDefaultData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock;

/// 热门搜索
- (void)getHotSearchData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock;

/// 模糊搜索结果
- (void)getSearchResultListWithApi:(SearchListApi *)api succeed:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock;

@end
