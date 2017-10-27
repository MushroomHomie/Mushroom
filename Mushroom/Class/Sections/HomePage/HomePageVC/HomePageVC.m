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
#import "HomePageDefaultSearchModel.h"

#import "HomePageTypeEnum.h"


@interface HomePageVC ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    HomePageModel *_homePageModel;
    HomePageDefaultSearchModel *_homePageDefaultSearchModel;
    
    UILabel *_topSearchLabel;
    BOOL _hasTouched;                       // 是否已点击搜索
}

@end

@implementation HomePageVC

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _hasTouched = NO;
}

#pragma mark - Init

- (void)initView
{
    [super initView];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 顶部搜索条
    [self createTopSearchTextField];

    [self.navigationController createTextfieldWithTarget:self Textfield:_topSearchLabel];
}

- (void)initData
{
    self.viewModel = [HomePageVM new];
    
    [self headerRefreshMethod];
}

#pragma mark - ClickEvents

/// 搜索
- (void)searchAction
{
    
}

#pragma mark - PrivateMethod

// 顶部搜索条
- (void)createTopSearchTextField
{
    _topSearchLabel = [UILabel new];
    _topSearchLabel.userInteractionEnabled = YES;
    _topSearchLabel.font = [UIFont systemFontOfSize:12];
    _topSearchLabel.textColor = [UIColor lightGrayColor];
    
    UITapGestureRecognizer *topSearchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [_topSearchLabel addGestureRecognizer:topSearchTap];

    [[topSearchTap rac_gestureSignal] subscribeNext:^(id x) {
        NSLog(@"x=======234");
    }];
}

- (UIView *)createOtherSectionHeaderView:(NSString *)sectionTitleName andIconImage:(NSString *)imageStr
{
    UIView *sectionHeaderView = [UIView new];
    sectionHeaderView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, 50);
    
    UIImageView *imageView = [UIImageView new];
    [sectionHeaderView addSubview:imageView];
    if (imageStr)
    {
        NSURL *url = [NSURL URLWithString:imageStr];
        [imageView sd_setImageWithURL:url];
    }
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionHeaderView).with.offset(7);
        make.centerY.mas_equalTo(sectionHeaderView.mas_centerY);
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

#pragma mark - CommonMethod

/// 上下拉刷新的回调， YES是下拉刷新  NO上拉加载更多
- (void)pullTableViewRequestData:(BOOL)isRefresh
{
    // 下拉刷新的额时候重新刷新pagecount为0
    if (isRefresh)
    {
        [self headerRefreshMethod];
    }
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

- (UIView *)viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:self.tableView titleForHeaderInSection:section];
    if (sectionTitle == nil)
    {
        return  nil;
    }
    
    HomaPageTypeModel *typeModel = _homePageModel.data[section];
    return [self createOtherSectionHeaderView:sectionTitle andIconImage:typeModel.icon];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y >= sectionHeaderHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark - RequestData

- (void)headerRefreshMethod
{
    [self requestHomePageListData];
    [self requestTopSearchData];
}

- (void)requestHomePageListData
{
    [self.viewModel sendRequest:^(id entity) {
        
        _homePageModel = (HomePageModel *)entity;
        [self.tableView reloadData];
        [self endHeaderRefresh];
        
    } failure:^(NSUInteger errCode, NSString *errorMsg) {
    }];
}

/// 顶部搜索框
- (void)requestTopSearchData
{
    [self.viewModel getHomePageTopSearchData:^(id entity)
    {
        _homePageDefaultSearchModel = (HomePageDefaultSearchModel *)entity;
        
        int x = arc4random() % (_homePageDefaultSearchModel.data.count - 1);
        SubDefaultSearchModel *subModel = _homePageDefaultSearchModel.data[x];
        _topSearchLabel.text = subModel.title;
        
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
