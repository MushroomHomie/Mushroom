//
//  HomePageVM.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageVM.h"
#import "HomePageModel.h"
#import "HomePageTypeEnum.h"
#import "HomePageTableCellVM.h"
#import "HomePageDefaultSearchModel.h"

@interface HomePageVM ()

@property(nonatomic, strong) HomePageModel *homePageModel;
@property(nonatomic, strong) HomePageDefaultSearchModel *homePageDefaultSearchModel;

@end

@implementation HomePageVM

- (void)initData
{
    _homePageModel = [HomePageModel new];
    _homePageDefaultSearchModel = [HomePageDefaultSearchModel new];
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSections
{
    return _homePageModel.data.count;
}

- (NSInteger)numberOfRowInSection:(NSInteger)section
{
    return 1;
}

/// CellVM
- (BaseTableViewCellVM *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellViewModels[indexPath.section];
}

- (NSString *)titleForHeader:(NSInteger)section
{
    HomaPageTypeModel *typeModel = _homePageModel.data[section];
    return typeModel.title;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    HomaPageTypeModel *typeModel = _homePageModel.data[section];
    CGFloat heightForHeader = 0;
    
    if (typeModel.type == CollectionView)
    {
        heightForHeader = 35;
    }
    return heightForHeader;
}

- (NSInteger)heightForRowWithIndexPath:(NSIndexPath *)indexPath
{
    HomaPageTypeModel *typeModel = _homePageModel.data[indexPath.section];
    CGFloat heightForRow = 0;
    
    switch (typeModel.type) {
        case CollectionView:
        {
            heightForRow = (APP_SCREEN_HEIGHT / 4 - 20) * typeModel.data.count / 2 ;
        }
            break;
            
        case LoopPlayView:
        {
            heightForRow = 170;
        }
            break;
            
        case BannerView:
        {
            heightForRow = 90;
        }
            break;
            
        default:
            break;
    }
    
    return heightForRow;
}

#pragma mark - RequestData

- (void)getHomePageListData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock
{
    [[_homePageModel requestHomePageData] subscribeNext:^(id data) {
        
        if (data)
        {
            _homePageModel = [DataConvert convertDic:data toEntity:HomePageModel.class];
            [self handlePagingEntities:_homePageModel.data cellViewModelClass:HomePageTableCellVM.class];
        }
        
        !succeedBlock ? : succeedBlock(_homePageModel);
    }];
    
}

- (void)getHomePageTopSearchData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock
{
    [[_homePageDefaultSearchModel requestHomePageTopDefaultSearch] subscribeNext:^(id data) {
        
        if (data)
        {
            _homePageDefaultSearchModel = [DataConvert convertDic:data toEntity:HomePageDefaultSearchModel.class];
        }
        
        !succeedBlock ? : succeedBlock(_homePageDefaultSearchModel);
    }];
}

- (void)handlePagingEntities:(NSArray *)entities cellViewModelClass:(Class)cellViewModelClass
{
    [self handleMutableArrayEntites:entities cellViewModelClass:cellViewModelClass];
}

@end
