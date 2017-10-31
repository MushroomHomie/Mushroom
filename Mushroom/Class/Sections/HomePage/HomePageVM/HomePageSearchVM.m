//
//  HomePageSearchVM.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageSearchVM.h"
#import "HomePageDefaultSearchModel.h"
#import "HomePageSearchCellVM.h"

@interface HomePageSearchVM ()

@property(nonatomic, strong) HomePageDefaultSearchModel *homePageDefaultSearchModel;

@end

@implementation HomePageSearchVM

- (void)initData
{
    _homePageDefaultSearchModel = [HomePageDefaultSearchModel new];
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSections
{
    return 1;
}

- (NSInteger)numberOfRowInSection:(NSInteger)section
{
    if (_homePageDefaultSearchModel.data.count > 0)
    {
        return 3;
    }
    return 0;
}

/// CellVM
- (BaseTableViewCellVM *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellViewModels[indexPath.row];
}

#pragma mark - RequestData

- (void)getTopThreeDefaultData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock
{
    [[_homePageDefaultSearchModel requestHomePageTopDefaultSearch] subscribeNext:^(id data) {
        
        if (data)
        {
            _homePageDefaultSearchModel = [DataConvert convertDic:data toEntity:HomePageDefaultSearchModel.class];
            [self handlePagingEntities:_homePageDefaultSearchModel.data cellViewModelClass:HomePageSearchCellVM.class];
        }
        
        !succeedBlock ? : succeedBlock(_homePageDefaultSearchModel);
    }];
}

- (void)handlePagingEntities:(NSArray *)entities cellViewModelClass:(Class)cellViewModelClass
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
}

@end
