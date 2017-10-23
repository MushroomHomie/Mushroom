//
//  TableViewController.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/15.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewModel.h"

@interface BaseTableViewController ()

@property (nonatomic,strong) UITableView *tableView; // 实例化的tableView
@property (nonatomic,assign) BOOL isRefresh;

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 调用父类的方法进行初始化ViewModel的传递
- (instancetype)initWithViewModel:(BaseViewModel *)viewModel
{
    return [super initWithViewModel:viewModel];
}

- (void)initView
{
    [super initView];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:[self.viewModel tableViewStyle]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view);
    }];
    
    // 添加头部刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.isRefresh = YES;
        [self pullTableViewRequestData:self.isRefresh];
    }];
    
    // 添加尾部刷新控件
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.isRefresh = NO;
        [self pullTableViewRequestData:self.isRefresh];
    }];
    
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = YES;
}

/// 刷新的时候调用该方法，子类实现，进行重写
/// 上下拉刷新的回调， YES是下拉刷新  NO上拉加载更多
- (void)pullTableViewRequestData:(BOOL)isRefresh
{
    
}

- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @throw [NSException exceptionWithName:@"必须实现的方法"
                                   reason:[NSString stringWithFormat:@"%@ 必须实现的方法 %@",[self class],NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}


#pragma mark - tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.viewModel heightForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [[self cellClassForRowAtIndexPath:indexPath] cellWithTable:tableView
                                                                            andIndexPath:indexPath
                                                                            andViewModel:[self.viewModel cellViewModelForRowAtIndexPath:indexPath]];
    cell.selectionStyle = [self.viewModel tableViewCellSelectionStyle];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.viewModel heightForRowWithIndexPath:indexPath];
}

- (void)setHideFooterLoadingMore:(BOOL)hideFooterLoadingMore
{
    _hideFooterLoadingMore = hideFooterLoadingMore;
    self.tableView.mj_footer.hidden = hideFooterLoadingMore;
}

- (void)endFooterRefresh
{
    [self.tableView.mj_footer endRefreshing];
}

- (void)endHeaderRefresh
{
    [self.tableView.mj_header endRefreshing];
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
