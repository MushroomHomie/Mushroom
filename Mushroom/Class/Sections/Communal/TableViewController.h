//
//  TableViewController.h
//  Mushroom
//
//  Created by 中原管家 on 2017/9/15.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseViewController.h"
@class TableViewModel;

@interface TableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong,readonly) UITableView *tableView;
@property (nonatomic,assign,readonly) BOOL isRefresh;

@property (nonatomic,assign) BOOL hideFooterLoadingMore;

- (void)endHeaderRefresh;
- (void)endFooterRefresh;

/// 子类实现，进行数据的请求  binding
- (void)pullTableViewRequestData:(BOOL)isRefresh;

- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
