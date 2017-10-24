//
//  HomePageHeaderTableCell.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/23.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageHeaderTableCell.h"
#import "HomePageTableCellVM.h"
#import "HomePageSubDataModel.h"

@interface HomePageHeaderTableCell ()

@property (nonatomic, strong) HomePageTableCellVM *viewModel;
@property (nonatomic, strong) LoopPlaybackView *loopPlayView;


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
    self.viewModel = (HomePageTableCellVM *)viewModel;
    [self initData];
    
    return self;
}

- (void)initView:(NSIndexPath *)indexPath
{
    _loopPlayViewFrame = CGRectMake(0, 0, APP_SCREEN_WIDTH, 170);
}

- (void)initLoopPlayView:(NSArray *)photoNameArray
{
    if (!_loopPlayView)
    {
        _loopPlayView = [[LoopPlaybackView alloc]initWithFrame:_loopPlayViewFrame array:photoNameArray];
        [self.contentView addSubview:_loopPlayView];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        @weakify(self);
        [RACObserve(self, viewModel) subscribeNext:^(HomePageTableCellVM *viewModel) {
            @strongify(self);
            
        }];
    }
    return self;
}

- (void)initData
{
    NSArray *dataArray = [self.viewModel getDataArray];
    NSMutableArray *photoNameArray = [NSMutableArray array];
    
    for (HomePageSubDataModel *subModel in dataArray)
    {
        if (subModel.posterPic)
        {
            [photoNameArray addObject:subModel.posterPic];
        }
    }
    
    [self initLoopPlayView:photoNameArray];
}

@end
