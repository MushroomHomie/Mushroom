//
//  SearchResultListVM.h
//  Mushroom
//
//  Created by 王雅琦 on 2018/1/8.
//  Copyright © 2018年 iOSfghj. All rights reserved.
//

#import "BaseTableViewModel.h"

@interface SearchResultListVM : BaseTableViewModel

@property (nonatomic, copy) NSString *keyWord;
@property (nonatomic, assign) NSInteger offset;

- (void)getSearchResultListData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock;

@end
