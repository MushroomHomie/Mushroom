//
//  TableViewCellViewModel.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/15.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewCellViewModel.h"

@implementation BaseTableViewCellViewModel

- (instancetype)initWithEntity:(nullable id)entity
{
    self = [super init];
    if (self)
    {
        _entity = entity;
        _cellSelectedSignal = [RACSubject subject];
    }
    return self;
}

/// cellViewModel来计算高度，通过带返回值的Block，从上层数据拿高度
- (NSNumber *)cacheCellHeightWithCalculateBlock:(TableCellViewModelCalculateBlock)calculateHeightBlock
{
    if (!self.rowHeight)
    {
        self.rowHeight = calculateHeightBlock();
    }
    return self.rowHeight;
}


@end
