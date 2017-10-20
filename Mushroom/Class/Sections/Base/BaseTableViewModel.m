//
//  TableViewModel.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/15.
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



#pragma mark - tableView的代理方法实现

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
        _cellViewModels = [[NSMutableArray alloc] init];
    }
    return _cellViewModels;
}



@end
