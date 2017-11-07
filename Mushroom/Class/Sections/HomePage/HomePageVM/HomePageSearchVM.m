//
//  HomePageSearchVM.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageSearchVM.h"
#import "HomePageDefaultSearchModel.h"
#import "HotSearchModel.h"
#import "SearchListModel.h"

#import "HomePageSearchCellVM.h"

@interface HomePageSearchVM ()

@property (nonatomic, strong) HomePageDefaultSearchModel *homePageDefaultSearchModel;
@property (nonatomic, strong) HotSearchModel *hotSearchModel;
@property (nonatomic, strong) HomePageSearchCellVM *hotSearchCellVM;
@property (nonatomic, strong) SearchListModel *searchResultModel;
@property (nonatomic, strong) NSMutableArray *searchResultModelCells;
@property (nonatomic, strong) SearchListApi *searchListApi;
@end

@implementation HomePageSearchVM

- (void)initData
{
    _homePageDefaultSearchModel = [HomePageDefaultSearchModel new];
    _hotSearchModel = [HotSearchModel new];
    _searchResultModel = [SearchListModel new];
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSections
{
    // 有搜索操作
    if (_searchListApi.keyWord.length > 0)
    {
        return 1;
    }
    
    return 2;
}

- (NSInteger)numberOfRowInSection:(NSInteger)section
{
    // 有搜索操作
    if (_searchListApi.keyWord.length > 0)
    {
        return _searchResultModelCells.count;
    }
    
    if (_homePageDefaultSearchModel.data.count <= 0 || _hotSearchModel.data.count <= 0)
    {
        return 0;
    }
   
    if (section == 0)
    {
        return 3;
    }
    
    return 1;
}

- (NSInteger)heightForRowWithIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightForRow = 44;
    if (indexPath.section == 1)
    {
        heightForRow = 190;
    }
    
    return heightForRow;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    
    return 30;
}

- (NSString *)titleForHeader:(NSInteger)section
{
    if (!_hotSearchCellVM)
    {
        return @"";
    }
    
    if (section == 1)
    {
        return @"热搜";
    }
    
    if (section == 2)
    {
        return @"搜索历史";
    }
    
    return nil;
}

/// CellVM
- (BaseTableViewCellVM *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_searchListApi.keyWord.length <= 0)
    {
        if (indexPath.section == 0)
        {
            return self.cellViewModels[indexPath.row];
        }
        else
        {
            return _hotSearchCellVM;
        }
    }
    else
    {
        return _searchResultModelCells[indexPath.row];
    }
}

#pragma mark - RequestData

- (void)getTopThreeDefaultData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock
{
    [[_homePageDefaultSearchModel requestHomePageTopDefaultSearch] subscribeNext:^(id data) {
        
        NSMutableArray *modelArray = [NSMutableArray array];
        if (data)
        {
            _homePageDefaultSearchModel = [DataConvert convertDic:data toEntity:HomePageDefaultSearchModel.class];
            modelArray = (NSMutableArray *)[self handlePagingEntities:_homePageDefaultSearchModel.data cellViewModelClass:HomePageSearchCellVM.class];
        }
        
        !succeedBlock ? : succeedBlock(modelArray);
    }];
}

- (void)getHotSearchData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock
{
    [[_hotSearchModel requestHotSearchData] subscribeNext:^(id data) {
        
        if (data)
        {
            _hotSearchModel = [DataConvert convertDic:data toEntity:HotSearchModel.class];
            _hotSearchCellVM = [HomePageSearchCellVM new];
            _hotSearchCellVM.hotSearchData = _hotSearchModel.data;
        }
        
        !succeedBlock ? : succeedBlock(_hotSearchModel);
    }];
}

/// 模糊搜索结果
- (void)getSearchResultListWithApi:(SearchListApi *)api
                           succeed:(RequestSucceed)succeedBlock
                           failure:(RequestFailure)failBlock
{
    _searchListApi = api;
    
    [[_searchResultModel getSearchResultList:api] subscribeNext:^(id data) {
        
        if (data)
        {
            _searchResultModel = [DataConvert convertDic:data toEntity:SearchListModel.class];
            [self handleSearchListEntites:_searchResultModel.data.suggest];
        }
         !succeedBlock ? : succeedBlock(_searchResultModel);
    }];
}

- (NSArray *)handlePagingEntities:(NSArray *)entities cellViewModelClass:(Class)cellViewModelClass
{
    NSInteger  randomNumberCount = 3;
    NSMutableArray *mutableEntities = [NSMutableArray arrayWithArray:entities];
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (int i = 0; i < randomNumberCount; i++)
    {
        int t = arc4random() % mutableEntities.count;
        resultArray[i] = mutableEntities[t];
        [mutableEntities removeObject:mutableEntities[t]];
    }
    
    [self handleMutableArrayEntites:resultArray cellViewModelClass:cellViewModelClass];
    return resultArray;
}

- (void)handleSearchListEntites:(NSArray *)entities
{
    NSMutableArray *cellViewModes = [NSMutableArray array];
    if (self.searchResultModelCells.count > 0)
    {
        [self.searchResultModelCells removeAllObjects];
    }
    
    [entities enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [cellViewModes addObject:[[HomePageSearchCellVM new] initWithSearchListModel:obj]];
    }];
    [self.searchResultModelCells addObjectsFromArray:cellViewModes];
}

#pragma mark - Lazy load
- (NSMutableArray *)searchResultModelCells
{
    if (!_searchResultModelCells)
    {
        _searchResultModelCells = [NSMutableArray array];
    }
    return _searchResultModelCells;
}

@end
