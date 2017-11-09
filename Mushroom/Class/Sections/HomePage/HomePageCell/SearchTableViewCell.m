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
@property (nonatomic, strong) UILabel *searchHistoryTextLabel;

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
    else if (indexPath.section == 2)
    {
        UIView *searchHistoryView = [UIView new];
        [self.contentView addSubview:searchHistoryView];
        
        @weakify(self)
        [searchHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        // 绘制时钟
        CGPoint center = CGPointMake(10, 10);
        
        UIBezierPath *path = [UIBezierPath new];
        [path addArcWithCenter:center radius:6 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        [path moveToPoint:center];
        [path addLineToPoint:CGPointMake(center.x, center.y - 3.5)];
        [path moveToPoint:center];
        [path addLineToPoint:CGPointMake(center.x + 3.5, center.y)];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.strokeColor = [UIColor grayColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 1;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineJoinRound;
        shapeLayer.path = path.CGPath;
        
        [searchHistoryView.layer addSublayer:shapeLayer];
        
        // historyLabel
        _searchHistoryTextLabel = [UILabel new];
        _searchHistoryTextLabel.textColor = [UIColor lightGrayColor];
        _searchHistoryTextLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_searchHistoryTextLabel];
        
        [_searchHistoryTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(searchHistoryView.mas_right).with.offset(5);
            make.right.equalTo(self.contentView).with.offset(20);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        _searchHistoryTextLabel.text = @"历史记录";
    }
}

- (void)initData:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        self.searchTextLabel.text = [self.viewModel getHomePageSearchText];
    }
    else if (indexPath.section == 1)
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
    else
    {
        _searchHistoryTextLabel.text = [self.viewModel getSearchHistoryTitle];
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
        tagButton.tag = ButtonsTag + i;
        [tagButton addTarget:self action:@selector(selectedTagButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:tagButton];
        
        width = width + labWidth;
        j++;
        
        if (width > APP_SCREEN_WIDTH - 20)
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
            tagButton.mj_y = (row - 1) * 31 + 5;
        }
    }
}

- (UIButton *)createTagButton:(NSString *)text
{
    UIFont *font = [UIFont systemFontOfSize:13];
    
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:text forState:UIControlStateNormal];
    [tagButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    tagButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    tagButton.titleLabel.font = font;
    tagButton.layer.cornerRadius = 5.0;
    tagButton.layer.borderWidth = 1.0;
    tagButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    return tagButton;
}

- (void)selectedTagButton:(UIButton *)tagButton
{
    if (tagButton.selected)
    {
        [tagButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        tagButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tagButton.selected = NO;
    }
    else
    {
        [tagButton setTitleColor:RGBColor(28, 185, 112) forState:UIControlStateNormal];
        tagButton.layer.borderColor = RGBColor(28, 185, 112).CGColor;
        tagButton.selected = YES;
        
        [[DataBaseOperation sharedataBaseOperation] insertSearchHistoricalRecordWithSearchTitle:tagButton.titleLabel.text];
    }
}

/// 计算文字长度
- (CGFloat )widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    return size.width;
}

@end
