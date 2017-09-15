//
//  TableViewController.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/15.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

// 调用父类的方法进行初始化ViewModel的传递
- (instancetype)initWithViewModel:(BaseViewModel *)viewModel
{
    return [super initWithViewModel:viewModel];
}

- (void)initView
{
//    [super initView];
//    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:[self.viewModel tableViewStyle]];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.rowHeight = 80;
//    _tableView.showsHorizontalScrollIndicator = NO;
//    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_tableView];
//    @weakify(self);
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.edges.equalTo(self.view);
//    }];
//    
//    
//    // 添加头部刷新控件
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        @strongify(self);
//        self.isRefresh = YES;
//        [self pullTableViewRequestData:self.isRefresh];
//    }];
//    
//    
//    // 添加尾部刷新控件
//    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
//        @strongify(self);
//        self.isRefresh = NO;
//        [self pullTableViewRequestData:self.isRefresh];
//    }];
//    
//    self.tableView.mj_header.hidden = NO;
//    self.tableView.mj_footer.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
