//
//  HomePageBannerTableCell.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/23.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageBannerTableCell.h"
#import "HomePageTableCellVM.h"

@interface HomePageBannerTableCell ()

@property (nonatomic, strong) HomePageTableCellVM *viewModel;

@end

@implementation HomePageBannerTableCell

+ (instancetype)cellWithTable:(UITableView *)tableView
                 andIndexPath:(NSIndexPath *)indexPath
                 andViewModel:(BaseTableViewCellVM *)viewModel
{
    NSString *identify = NSStringFromClass([self class]);
    NSString *cellName = [NSString stringWithFormat:@"%@%ld%ld",identify,indexPath.section,indexPath.row];
    
    HomePageBannerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell = [[HomePageBannerTableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:cellName
                                                 andindexPath:indexPath
                                                 andViewModel:viewModel];
    }
    
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
    }
    
    self.viewModel = viewModel;
    [self initData];
    return self;
}

- (void)initView:(NSIndexPath *)indexPath
{
    _bannerView = [UIImageView new];
    [self.contentView addSubview:_bannerView];
    
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.equalTo(self.contentView);
    }];
}

- (void)initData
{
    NSString *bannerStr = [self.viewModel getBannerStr];
    NSURL *url = [NSURL URLWithString:bannerStr];
    [_bannerView sd_setImageWithURL:url];
}

@end
