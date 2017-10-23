//
//  HomePageVC.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/13.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageVC.h"

#import "HomePageVM.h"
#import "HomePageModelTableCell.h"
#import "HomePageHeaderTableCell.h"
#import "HomePageBannerTableCell.h"

#import "HomePageModel.h"
#import "HomePageTypeEnum.h"


@interface HomePageVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView *_firstSectionHeaderView;
    NSArray *_sectionNameArray;
    
    HomePageModel *_homePageModel;
}

@end

@implementation HomePageVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self headerRefreshMethod];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self headerRefreshMethod];
}

#pragma mark - Init

- (void)initData
{
    _sectionNameArray = @[@"首播",@"娱乐",@"热播推荐",@"音乐现场",@"主打星:GOT7",@"自制节目",@"官方合作专区",@"猜你喜欢"];
    self.viewModel = [HomePageVM new];
}

- (void)initView
{
    [super initView];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
}

/// 上下拉刷新的回调， YES是下拉刷新  NO上拉加载更多
- (void)pullTableViewRequestData:(BOOL)isRefresh
{
    // 下拉刷新的额时候重新刷新pagecount为0
    if (isRefresh)
    {
        [self headerRefreshMethod];
    }
}

+ (UIView *)initOtherSectionHeaderView:(NSString *)sectionTitleName
{
    UIView *sectionHeaderView = [UIView new];
    sectionHeaderView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, 50);
    
    UIImageView *imageView = [UIImageView new];
    [sectionHeaderView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"help_setting_40x40_"];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionHeaderView).with.offset(7);
        make.top.equalTo(sectionHeaderView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *sectionTitleLable = [UILabel new];
    sectionTitleLable.text = sectionTitleName;
    sectionTitleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [sectionHeaderView addSubview:sectionTitleLable];
    
    [sectionTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sectionHeaderView).with.insets(UIEdgeInsetsMake(0, 40, 0, 0));
    }];
    
    return sectionHeaderView;
}

- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomaPageTypeModel *typeModel = _homePageModel.data[indexPath.section];
    Class cellClass;
    
    switch (typeModel.type) {
        case LoopPlayView:
        {
            cellClass = HomePageHeaderTableCell.class;
        }
            break;
            
        case CollectionView:
        {
            cellClass = HomePageModelTableCell.class;
        }
            break;
            
        case BannerView:
        {
            cellClass = HomePageBannerTableCell.class;
        }
            break;
            
        default:
            break;
    }
    
    return cellClass;
}

#pragma mark - RequestData

- (void)headerRefreshMethod
{
    [self.viewModel sendRequest:^(id entity) {
        
        _homePageModel = (HomePageModel *)entity;
        [self.tableView reloadData];
        [self endHeaderRefresh];
        
    } failure:^(NSUInteger errCode, NSString *errorMsg) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
