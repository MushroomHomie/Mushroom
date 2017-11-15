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

@interface HomePageHeaderTableCell ()<LoopPlaybackDelegate>

@property (nonatomic, strong) HomePageTableCellVM *viewModel;
@property (nonatomic, strong) LoopPlaybackView *loopPlayView;
@property (nonatomic, strong) NSMutableArray *photoNameArray;
@property (nonatomic, strong) UILabel *pageNumberLabel;
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
    _loopPlayViewFrame = CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_WIDTH * 0.58);
    _gradientShadowView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   (_loopPlayViewFrame.size.height / 3) * 2,
                                                                   APP_SCREEN_WIDTH,
                                                                   _loopPlayViewFrame.size.height / 3)];

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _gradientShadowView.bounds;
    [_gradientShadowView.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor blackColor].CGColor];
    gradientLayer.locations = @[@0.1];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, APP_SCREEN_WIDTH * 0.58 - 50, APP_SCREEN_WIDTH - 50, 20)];
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    _titleLabel.textColor = [UIColor whiteColor];
    
    _authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _titleLabel.bottom, APP_SCREEN_WIDTH, 20)];
    _authorLabel.font = [UIFont systemFontOfSize:12];
    _authorLabel.textColor = [UIColor whiteColor];
    
    _pageNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 50, _loopPlayViewFrame.size.height - 30, 50, 30)];
    _pageNumberLabel.font = [UIFont systemFontOfSize:11];
    _pageNumberLabel.textAlignment = NSTextAlignmentCenter;
    _pageNumberLabel.textColor = [UIColor whiteColor];
}

- (void)initLoopPlayView:(NSArray *)photoNameArray
{
    if (!_loopPlayView)
    {
        _loopPlayView = [[LoopPlaybackView alloc] initWithFrame:_loopPlayViewFrame array:photoNameArray];
        _loopPlayView.delegate = self;
        [self.contentView addSubview:_loopPlayView];
        [self.contentView addSubview:_gradientShadowView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_authorLabel];
        [self.contentView addSubview:_pageNumberLabel];
        
        _pageNumberLabel.text = [NSString stringWithFormat:@"1/%ld",photoNameArray.count];
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

#pragma mark - LoopPlaybackDelegate

- (void)slippingPageNumber:(NSInteger)pageNumber
{
    NSArray *dataArray = [self.viewModel getDataArray];
    HomePageSubDataModel *subModel = dataArray[pageNumber - 1];
    NSString *authors = @"";
    for (HomePageArtistsModel *authorModel in subModel.artists)
    {
        if (authors.length > 0)
        {
            authors = [authors stringByAppendingString:[NSString stringWithFormat:@"&%@",authorModel.artistName]];
        }
        else
        {
            authors = authorModel.artistName;
        }
    }
    
    _titleLabel.text = subModel.title;
    _authorLabel.text = authors;
    _pageNumberLabel.text = [NSString stringWithFormat:@"%ld/%ld",pageNumber,dataArray.count];
}

@end
