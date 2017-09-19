//
//  TableViewCellViewModel.h
//  Mushroom
//
//  Created by 中原管家 on 2017/9/15.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseViewModel.h"
typedef NSNumber * _Nonnull (^TableCellViewModelCalculateBlock)();


@interface BaseTableViewCellViewModel : BaseViewModel

// cellViewModel会绑定一个entity实例对象
@property (nonatomic,strong,readonly,nullable) id entity;

// 每个cellViewModel里面有一个实体，然后还有一个字段计算高度，缓存
@property (nonatomic,strong,nullable) NSNumber *rowHeight;

///  cell点击的信号量监听
@property (nonatomic,strong,nullable) RACSubject *cellSelectedSignal;

/// cellViewModel的初始化
- (nullable instancetype)initWithEntity:(nullable id)entity;

- (NSNumber *_Nonnull)cacheCellHeightWithCalculateBlock:(_Nonnull TableCellViewModelCalculateBlock)calculateHeightBlock;


@end
