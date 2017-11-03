//
//  TableViewModel.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/9/15.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewModel.h"


@interface BaseTableViewModel ()

@property (nonatomic,strong) NSMutableArray *cellViewModels;

@end


@implementation BaseTableViewModel


- (UITableViewStyle)tableViewStyle
{
    return UITableViewStylePlain;
}

- (UITableViewCellSelectionStyle)tableViewCellSelectionStyle
{
    // 无点击效果
    return UITableViewCellSelectionStyleNone;
}

- (void)handleMutableArrayEntites:(NSArray *)entities cellViewModelClass:(Class)cellViewModelClass
{
    NSMutableArray *cellViewModes = [NSMutableArray array];
    [entities enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [cellViewModes addObject:[[cellViewModelClass alloc] initWithEntity:obj]];
        
    }];
    [self.cellViewModels addObjectsFromArray:cellViewModes];
}

#pragma mark - tableView的代理方法实现

/// 子类必须实现（返回数据请求回来之后放在cellViewModels数组里面的每个cell对应的cellViewModel）
- (BaseTableViewCellVM *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @throw [NSException exceptionWithName:@"抽象方法未实现"
                                   reason:[NSString stringWithFormat:@"%@ 必须实现抽象方法 %@",[self class],NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

// 默认是一个section
- (NSInteger)numberOfSections
{
    return 1;
}

///  子类必须实现（每个section多少rows）
- (NSInteger)numberOfRowInSection:(NSInteger)section
{
    @throw [NSException exceptionWithName:@"抽象方法未实现"
                                   reason:[NSString stringWithFormat:@"%@ 必须实现抽象方法 %@",[self class],NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSString *)titleForHeader:(NSInteger)section
{
    return @"";
}

/// headerView的默认是没有的
- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)heightForRowWithIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSMutableArray *)cellViewModels
{
    if (!_cellViewModels)
    {
        _cellViewModels = [NSMutableArray array];
    }
    return _cellViewModels;
}



@end
