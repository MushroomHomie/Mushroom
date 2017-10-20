//
//  BaseTableViewCell.h
//  Mushroom
//
//  Created by 中原管家 on 2017/9/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseTableViewCell : UITableViewCell

+ (instancetype)cellWithTable:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

- (void)initView;
- (void)initBinding;
- (void)initData;


@end
