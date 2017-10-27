//
//  HomePageSearchVM.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageSearchVM.h"
#import "HomePageDefaultSearchModel.h"

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
//    return _homePageDefaultSearchModel.data.count;
    return 1;
}

- (NSInteger)numberOfRowInSection:(NSInteger)section
{
    return 6;
}

/// CellVM
- (BaseTableViewCellVM *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return self.cellViewModels[indexPath.section];
    return nil;
}

@end
