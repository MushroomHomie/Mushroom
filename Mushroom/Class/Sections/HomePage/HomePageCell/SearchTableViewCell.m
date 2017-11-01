//
//  SearchTableViewCell.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "HomePageSearchCellVM.h"

#define  ButtonsTag  1000

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
            [self initData:indexPath];
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
        [self.contentView addSubview:self.searchTextLabel];
        
        @weakify(self)
        [self.searchTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 15, 0, 0));
        }];
        
        UIView *line = [UIView new];
        [self.contentView addSubview:line];
        line.backgroundColor = [UIColor grayColor];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(self.contentView.height - 0.5, 0, 0, 0));
        }];
    }
}

- (void)initData:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        self.searchTextLabel.text = [self.viewModel getHomePageSearchText];
    }
    else
    {
        NSArray *hotSearchTag = [self.viewModel getHotSearchTag];
        if (hotSearchTag.count > 0)
        {
            NSArray *views = [self.contentView subviews];
            for(UIView *view in views)
            {
                [view removeFromSuperview];
            }
            
            [self createTagsWithArray:hotSearchTag];
        }
    }
}

- (void)createTagsWithArray:(NSArray *)tagsArray
{
    int width = 15;
    int j = 0;
    int row = 1;
    int widthSpacing = 7;
    int heightSpacing = 31;

    for (int i = 0 ; i < tagsArray.count; i++)
    {
        NSString *buttonTitle = tagsArray[i];
        int labWidth = [self widthForLabel:buttonTitle fontSize:16] + 7;

        UIButton *tagButton = [self createTagButton:buttonTitle];
        tagButton.frame = CGRectMake(widthSpacing * j + width, row * heightSpacing, labWidth, 22);
        [self.contentView addSubview:tagButton];
        
        width = width + labWidth;
        j++;
        
        if (width > APP_SCREEN_WIDTH - 30)
        {
            j = 0;
            width = 15;
            row++;
            tagButton.frame = CGRectMake(widthSpacing * j + width, row * heightSpacing, labWidth, 22);
            width = width + labWidth;
            j++;
        }
        
        if (row == 1)
        {
            tagButton.mj_y = 5;
        }
        else
        {
            tagButton.mj_y = row * (tagButton.mj_h + 10);
        }
    }
}

- (UIButton *)createTagButton:(NSString *)text
{
    UIFont *font = [UIFont systemFontOfSize:13];
    
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:text forState:UIControlStateNormal];
    [tagButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [tagButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    tagButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    tagButton.titleLabel.font = font;
    tagButton.layer.cornerRadius = 5.0;
    tagButton.layer.borderWidth = 1.0;
    tagButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    return tagButton;
}

/// 计算文字长度
- (CGFloat )widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    return size.width;
}

@end
