//
//  VideoPlayVM.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/15.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "VideoPlayVM.h"
#import "VideoPlayCellVM.h"

@implementation VideoPlayVM

#pragma mark - TableViewDelegate

- (NSInteger)numberOfRowInSection:(NSInteger)section
{
    return 1;
}

/// CellVM
- (BaseTableViewCellVM *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellViewModels.count > 0 ? self.cellViewModels[indexPath.row] : nil;
}

@end
