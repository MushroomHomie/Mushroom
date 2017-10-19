//
//  BaseTableViewCell.h
//  Mushroom
//
//  Created by 中原管家 on 2017/9/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseTableViewCellViewModel;


@interface BaseTableViewCell : UITableViewCell

+ (instancetype)cellForTableView:(UITableView *)tableView viewModel:(BaseTableViewCellViewModel *)viewModel;

- (void)initView;
- (void)initBinding;
- (void)initData;

// cell里面实现，通过viewModel去存储数据，高度由这个Block返回给ViewModel保存起来
+ (NSNumber *)calculateRowHeightWithViewModel:(BaseTableViewCellViewModel *)viewModel;

@end
