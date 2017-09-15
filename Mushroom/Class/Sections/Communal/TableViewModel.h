//
//  TableViewModel.h
//  Mushroom
//
//  Created by 中原管家 on 2017/9/15.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseViewModel.h"
#import "TableViewCellViewModel.h"

@interface TableViewModel : BaseViewModel

/// 通过实体组装成cellViewModel
@property (nonatomic,strong,readonly) NSMutableArray *cellViewModels;

/// 外部通过监听该字段来判断是否需要刷新tableView
@property (nonatomic,assign) BOOL isNeedRefresh;

#pragma mark - tableView的代理通过ViewModel来实现

/// UITableView的属性 plain or group
- (UITableViewStyle)tableViewStyle;

/// tableViewCell的点击状态
- (UITableViewCellSelectionStyle)tableViewCellSelectionStyle;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowInSection:(NSInteger)section;

///  对应section的header高度
- (CGFloat)heightForHeaderInSection:(NSInteger)section;

/// 返回对应section的头部View
- (UIView *)viewForHeaderInSection:(NSInteger)section;

/// 返回对应的cellViewModel给对应的cell初始化
- (TableViewCellViewModel *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath;


/**
 给每个ViewModel里面的cellViewModel数组装载通过实体对象初始化的cellViewModel
 这个方法是默认给一个Section的时候进行调用的，如果是分页的话需要在封装一层，外部进行代码的分离，然后根据currentPage进行数组的清空还是继续加载
 */
- (void)handleMutableArrayEntites:(NSArray *)entities cellViewModelClass:(Class)cellViewModelClass;


@end
