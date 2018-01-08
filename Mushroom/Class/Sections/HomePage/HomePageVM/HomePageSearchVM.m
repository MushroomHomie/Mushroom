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
@property (nonatomic, strong) NSMutableArray *searchHistoryModelCells;
@property (nonatomic, strong) NSMutableArray *searchHistoryTitles;
@property (nonatomic, strong) SearchListApi *searchListApi;
@end

@implementation HomePageSearchVM

- (void)initData
{
    _homePageDefaultSearchModel = [HomePageDefaultSearchModel new];
    _hotSearchModel = [HotSearchModel new];
    _searchResultModel = [SearchListModel new];
    [self getHistoryListTitle];
}

- (void)getHistoryListTitle
{
    self.searchHistoryTitles = (NSMutableArray *)[[DataBaseOperation sharedataBaseOperation] selectSearchHistoricalRecordList];
    [self handleSearchHistoryTitle:self.searchHistoryTitles];
}

#pragma mark - PrivateMethod

/// 是否含有历史记录
- (BOOL)haveHistoryList
{
    return self.searchHistoryTitles.count > 0;
}

/// 获得热搜cell的高度
- (CGFloat)getHotSearchSectionHeight
{
    int width = 15;
    int j = 0;
    int row = 1;
    
    for (int i = 0 ; i < _hotSearchCellVM.hotSearchData.count; i++)
    {
        NSString *buttonTitle = _hotSearchCellVM.hotSearchData[i];
        int labWidth = [self widthForLabel:buttonTitle fontSize:16] + 7;
        
        width = width + labWidth;
        j++;
        
        if (width > APP_SCREEN_WIDTH - 20)
        {
            j = 0;
            width = 15;
            row++;
            width = width + labWidth;
            j++;
        }
    }
   
    return row * (22 + 10);
}

/// 计算文字长度
- (CGFloat )widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    return size.width;
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSections
{
    // 有搜索操作
    if (_searchListApi.keyWord.length > 0)
    {
        return 1;
    }
    
    // 有历史记录
    if (self.searchHistoryTitles.count > 0)
    {
        return 3;
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
    
    if (_homePageDefaultSearchModel.data.count <= 0 && _hotSearchModel.data.count <= 0)
    {
        return 0;
    }
   
    if (section == 0)
    {
        return 3;
    }
    
    if (section == 2)
    {
        return self.searchHistoryTitles.count;
    }
    
    return 1;
}

- (NSInteger)heightForRowWithIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightForRow = 44;
    if (indexPath.section == 1)
    {
        heightForRow = [self getHotSearchSectionHeight];
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
    
    if (!_searchHistoryTitles)
    {
        return @"";
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
        else if (indexPath.section == 1)
        {
            return _hotSearchCellVM;
        }
        else
        {
            return self.searchHistoryModelCells[indexPath.row];
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

#pragma mark - createCellVM

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

/// 历史记录
- (void)handleSearchHistoryTitle:(NSArray *)historyTitleArray
{
    [self.searchHistoryModelCells removeAllObjects];
    NSMutableArray *cellViewModes = [NSMutableArray array];

    [historyTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HomePageSearchCellVM *cellVM = [HomePageSearchCellVM new];
        cellVM.searchHistoryTitle = (NSString *)obj;
        
        [cellViewModes addObject:cellVM];
    }];
    
    [self.searchHistoryModelCells addObjectsFromArray:cellViewModes];
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

- (NSMutableArray *)searchHistoryModelCells
{
    if (!_searchHistoryModelCells)
    {
        _searchHistoryModelCells = [NSMutableArray array];
    }
    
    return _searchHistoryModelCells;
}

@end
