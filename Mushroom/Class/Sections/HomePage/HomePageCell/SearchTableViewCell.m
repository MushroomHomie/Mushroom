//
//  SearchTableViewCell.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "HomePageSearchCellVM.h"

@interface SearchTableViewCell ()

@property (nonatomic, strong) UILabel *searchTextLabel;
@property (nonatomic, strong) HomePageSearchCellVM *viewModel;

@end

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
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.viewModel = (HomePageSearchCellVM *)viewModel;
    
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
        [self initView:indexPath];
        
        @weakify(self);
        [RACObserve(self, viewModel) subscribeNext:^(BaseTableViewCellVM *viewModel) {
            @strongify(self);
            [self initData];
        }];
    }
    
    return self;
}

- (void)initView:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        self.searchTextLabel = [UILabel new];
        self.searchTextLabel.font = [UIFont systemFontOfSize:13];
        self.searchTextLabel.textColor = [UIColor lightGrayColor];
        //    self.searchTextLabel.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, 44);
        [self.contentView addSubview:self.searchTextLabel];
        
        @weakify(self)
        [self.searchTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 20, 0, 0));
        }];
    }
}

- (void)initData
{
    self.searchTextLabel.text = [self.viewModel getHomePageSearchText];
}

@end
