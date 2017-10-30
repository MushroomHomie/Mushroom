//
//  SearchTableViewCell.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

+ (instancetype)cellWithTable:(UITableView *)tableView
                 andIndexPath:(NSIndexPath *)indexPath
                 andViewModel:(BaseTableViewCellVM *)viewModel
{
    NSString *identify = NSStringFromClass([self class]);
    NSString *cellName = [NSString stringWithFormat:@"%@%ld%ld",identify,indexPath.section,indexPath.row];
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:cellName
                                                 andindexPath:indexPath
                                                 andViewModel:viewModel];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    
//    cell.viewModel = (HomePageTableCellVM *)viewModel;
    
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                 andindexPath:(NSIndexPath *)indexPath
                 andViewModel:(BaseTableViewCellVM *)viewModel
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        [self initView:indexPath];
        
        @weakify(self);
        [RACObserve(self, viewModel) subscribeNext:^(BaseTableViewCellVM *viewModel) {
            @strongify(self);
            [self initData];
        }];
    }
    
    return self;
}


@end
