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
        [self initView];

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
    
}

- (void)initLoopPlayView:(NSArray *)photoNameArray
{
    if (!_loopPlayView)
    {
        _loopPlayView = [[LoopPlaybackView alloc]initWithFrame:_loopPlayViewFrame array:photoNameArray];
        [self.contentView addSubview:_loopPlayView];
    }
}

- (void)initData
{
    _loopPlayViewFrame = CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_WIDTH * 0.55);

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
