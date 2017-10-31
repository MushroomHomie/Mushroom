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
    else
    {
        
    }
}

- (void)initData
{
    self.searchTextLabel.text = [self.viewModel getHomePageSearchText];
}

- (void)createTagsWithArray:(NSArray *)tagsArray
{
    NSMutableArray *groupTagArray = [[NSMutableArray alloc] init];
    NSMutableArray<NSNumber *> *widthArray = [[NSMutableArray alloc] init];
    CGFloat labelSpace = 10;
    CGFloat lastWidth = 0;
    int lastIndex = 0;
    
    NSMutableArray *smallTagsArray = [[NSMutableArray alloc] init];
    UIFont *font = [UIFont systemFontOfSize:16];
    for (int tagIndex = 0; tagIndex < tagsArray.count; tagIndex ++ )
    {
        NSString *tagString =tagsArray[tagIndex];
        CGFloat tagWidth = [tagString sizeWithAttributes:@{NSFontAttributeName: font}].width + 15;
        if (tagWidth + lastIndex * labelSpace + lastWidth >= APP_SCREEN_WIDTH - 60) {
            [widthArray addObject:[NSNumber numberWithFloat:lastWidth]];
            lastWidth = tagWidth;
            [groupTagArray addObject:smallTagsArray];
            smallTagsArray = [[NSMutableArray alloc] init];
            [smallTagsArray addObject:tagString];
            if (tagIndex == tagsArray.count - 1) {
                [groupTagArray addObject:smallTagsArray];
                [widthArray addObject:[NSNumber numberWithFloat:lastWidth]];
            }
            lastIndex = 1;
            
        } else {
            lastWidth = lastWidth + tagWidth;
            [smallTagsArray addObject:tagString];
            if (tagIndex == tagsArray.count - 1) {
                [groupTagArray addObject:smallTagsArray];
                [widthArray addObject:[NSNumber numberWithFloat:lastWidth]];
            }
            lastIndex ++;
        }
    }
    
    for (int arrayIndex = 0; arrayIndex < groupTagArray.count; arrayIndex ++)
    {
        NSArray *smallTagArray = groupTagArray[arrayIndex];
        CGFloat width = [widthArray[arrayIndex] floatValue];
        CGFloat lastTagWidth = (APP_SCREEN_WIDTH -  width - (smallTagArray.count - 1) * 10) / 2.0;
        for (int index = 0; index < smallTagArray.count; index ++) {
            NSString *tagString = smallTagArray[index];
            CGFloat tagWidth = [tagString sizeWithAttributes:@{NSFontAttributeName: font}].width + 15;
            UILabel *label = [self createTagLabel:tagString];
            label.frame = CGRectMake(lastTagWidth + index * 10, arrayIndex * (font.lineHeight + 10 + 15) + 80, tagWidth, font.lineHeight + 10);
            [self.contentView addSubview:label];
            lastTagWidth = lastTagWidth + tagWidth;
        }
    }
}

- (UILabel *)createTagLabel:(NSString *)text {
    UIFont *font = [UIFont systemFontOfSize:16];
    UILabel *tagLabel = [[UILabel alloc] init];
    tagLabel.textColor = [UIColor whiteColor];
    tagLabel.font = font;
    tagLabel.layer.cornerRadius = 5.0;
    tagLabel.layer.borderWidth = 1.0;
    tagLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.text = text;
    return tagLabel;
}


@end
