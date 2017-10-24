//
//  HomePageVM.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageVM.h"
#import "HomePageModel.h"
#import "HomePageTypeEnum.h"
#import "HomePageTableCellVM.h"

@interface HomePageVM ()

@property(nonatomic, strong) HomePageModel *homePageModel;

@end

@implementation HomePageVM

- (void)initData
{
    _homePageModel = [HomePageModel new];
}

- (UITableViewStyle)tableViewStyle
{
    return UITableViewStylePlain;
}

// 默认是一个section
- (NSInteger)numberOfSections
{
    return _homePageModel.data.count;
}

///  子类必须实现（每个section多少rows）
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

/// headerView的默认是没有的
- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    HomaPageTypeModel *typeModel = _homePageModel.data[section];
    CGFloat heightForHeader = 0;
    
    if (typeModel.type == CollectionView)
    {
        heightForHeader = 30;
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
            heightForRow = (APP_SCREEN_HEIGHT / 4 - 20) * typeModel.data.count / 2 + 20;
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

- (void)sendRequest:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock
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

- (void)handlePagingEntities:(NSArray *)entities cellViewModelClass:(Class)cellViewModelClass
{
    [self handleMutableArrayEntites:entities cellViewModelClass:cellViewModelClass];
}


@end
