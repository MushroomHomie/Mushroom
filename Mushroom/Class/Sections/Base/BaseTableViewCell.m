//
//  BaseTableViewCell.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseTableViewCellViewModel.h"

@interface BaseTableViewCell ()

@property (nonatomic, strong) BaseTableViewCellViewModel *viewModel;

@end

@implementation BaseTableViewCell

+ (instancetype)cellForTableView:(UITableView *)tableView viewModel:(BaseTableViewCellViewModel *)viewModel
{
    NSString *identify = NSStringFromClass([self class]);
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell initView];
        [cell initBinding];
    }
    cell.viewModel = viewModel;
    [cell initData];
    return cell;
}

// cell里面实现，通过viewModel去存储数据，高度由这个Block返回给ViewModel保存起来
+ (NSNumber *)calculateRowHeightWithViewModel:(BaseTableViewCellViewModel *)viewModel
{
    return nil;
}

- (void)initView
{
}

- (void)initBinding
{
}

- (void)initData
{
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
