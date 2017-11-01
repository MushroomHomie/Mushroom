//
//  HomePageHeaderTableCell.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/23.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageHeaderTableCell.h"
#import "HomePageTableCellVM.h"
#import "HomePageSubDataModel.h"

@interface HomePageHeaderTableCell ()

@property (nonatomic, strong) HomePageTableCellVM *viewModel;
@property (nonatomic, strong) LoopPlaybackView *loopPlayView;
@property (nonatomic, strong) NSMutableArray *photoNameArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UIView *gradientShadowView;
@end

@implementation HomePageHeaderTableCell

+ (instancetype)cellWithTable:(UITableView *)tableView
                 andIndexPath:(NSIndexPath *)indexPath
                 andViewModel:(BaseTableViewCellVM *)viewModel
{
    NSString *identify = NSStringFromClass([self class]);
    NSString *cellName = [NSString stringWithFormat:@"%@%ld%ld",identify,indexPath.section,indexPath.row];
    
    HomePageHeaderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell = [[HomePageHeaderTableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:cellName
                                                 andindexPath:indexPath
                                                 andViewModel:viewModel];
    }
    cell.viewModel = (HomePageTableCellVM *)viewModel;

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
        [RACObserve(self, viewModel) subscribeNext:^(id x) {
            @strongify(self);
            [self initData];
        }];
    }
    
    return self;
}

- (void)initView:(NSIndexPath *)indexPath
{
    _loopPlayViewFrame = CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_WIDTH * 0.55);
    
    _gradientShadowView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   (_loopPlayViewFrame.size.height / 3) * 2,
                                                                   APP_SCREEN_WIDTH,
                                                                   _loopPlayViewFrame.size.height / 3)];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _gradientShadowView.bounds;
    [_gradientShadowView.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor blackColor].CGColor];
    gradientLayer.locations = @[@0.2];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);

    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, APP_SCREEN_WIDTH * 0.55 - 50, APP_SCREEN_WIDTH, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"美人谷";
    
    _authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _titleLabel.bottom, APP_SCREEN_WIDTH, 20)];
    _authorLabel.font = [UIFont systemFontOfSize:13];
    _authorLabel.textColor = [UIColor whiteColor];
    _authorLabel.text = @"Alan";
}

- (void)initLoopPlayView:(NSArray *)photoNameArray
{
    if (!_loopPlayView)
    {
        _loopPlayView = [[LoopPlaybackView alloc] initWithFrame:_loopPlayViewFrame array:photoNameArray];
        [self.contentView addSubview:_loopPlayView];
        [self.contentView addSubview:_gradientShadowView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_authorLabel];
    }
}

- (void)initData
{
    NSArray *dataArray = [self.viewModel getDataArray];
    
    if (_photoNameArray)
    {
        [_photoNameArray removeAllObjects];
    }
    else
    {
        _photoNameArray = [NSMutableArray array];
    }
    
    for (HomePageSubDataModel *subModel in dataArray)
    {
        if (subModel.posterPic)
        {
            [_photoNameArray addObject:subModel.posterPic];
        }
    }
    
    if (_photoNameArray.count > 0)
    {
        [self initLoopPlayView:_photoNameArray];
    }
}

@end
