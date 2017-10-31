//
//  BaseTableViewCell.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/9/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()

@property (nonatomic,strong) BaseTableViewCellVM *viewModel;

@end

@implementation BaseTableViewCell

+ (instancetype)cellWithTable:(UITableView *)tableView
                 andIndexPath:(NSIndexPath *)indexPath
                 andViewModel:(BaseTableViewCellVM *)viewModel
{
    NSString *identify = NSStringFromClass([self class]);
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell initView];
    }
    
    cell.viewModel = viewModel;
    [cell initData];
    return cell;
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
