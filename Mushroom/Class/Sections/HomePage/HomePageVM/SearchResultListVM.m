//
//  SearchResultListVM.m
//  Mushroom
//
//  Created by 王雅琦 on 2018/1/8.
//  Copyright © 2018年 iOSfghj. All rights reserved.
//

#import "SearchResultListVM.h"
#import "SearchResultListModel.h"
#import "SearchResultCellVM.h"

@interface SearchResultListVM ()

@property (nonatomic, strong) SearchResultListModel *searchResultListModel;

@end

@implementation SearchResultListVM

- (void)initData
{
    _searchResultListModel = [SearchResultListModel new];
    _offset = 0;
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfRowInSection:(NSInteger)section
{
    return _searchResultListModel.data.count;
}

- (NSInteger)heightForRowWithIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightForRow = 101;
    return heightForRow;
}

/// CellVM
- (BaseTableViewCellVM *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellViewModels[indexPath.row];
}

#pragma mark - RequestData

- (void)getSearchResultListData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock
{
    [[_searchResultListModel requestSearchResultList:_keyWord offset:_offset] subscribeNext:^(id data) {
        
        if (data)
        {
            _searchResultListModel = [DataConvert convertDic:data toEntity:SearchResultListModel.class];
            [self handleMutableArrayEntites:_searchResultListModel.data cellViewModelClass:SearchResultCellVM.class];
        }
        
        !succeedBlock ? : succeedBlock(_searchResultListModel);
    }];
}

@end
