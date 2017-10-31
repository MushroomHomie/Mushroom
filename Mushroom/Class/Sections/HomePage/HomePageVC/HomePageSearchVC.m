//
//  HomePageSearchVC.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageSearchVC.h"
#import "HomePageSearchVM.h"
#import "SearchTableViewCell.h"

@interface HomePageSearchVC ()

@property (nonatomic, strong) HomePageSearchVM *viewModel;
@property (nonatomic, strong) UITextField *topSearchTextField;
@property (nonatomic, strong) UIImageView *backGroundImageView;

@end

@implementation HomePageSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Init

- (void)initView
{
    _backGroundImageView = [UIImageView new];
    _backGroundImageView.image = _backgroundImage;
    _backGroundImageView.frame = self.view.bounds;
    [self.view addSubview:_backGroundImageView];
    
    // 毛玻璃
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, _backGroundImageView.frame.size.width, _backGroundImageView.frame.size.height);
    [_backGroundImageView addSubview:effectView];
    
    [super initView];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.mj_header = nil;
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    // 顶部搜索条
    [self createTopSearchTextField];
    
    [self.navigationController createTextfieldWithTarget:self Textfield:self.topSearchTextField];
    [self.navigationController setRightBarButtonItemWithTitle:nil
                                                        Image:@"StarTV_Live_Back_40x40_"
                                                       Target:self
                                                       Action:@selector(cancelSearch)];
}

- (void)initData
{
    self.viewModel = [HomePageSearchVM new];
    [self requestData];
}

#pragma mark - ClickEvents

- (void)cancelSearch
{
    [self back];
}

#pragma mark - PrivateMethod

// 顶部搜索条
- (void)createTopSearchTextField
{
    _topSearchTextField = [UITextField new];
    _topSearchTextField.font = [UIFont systemFontOfSize:12];
    _topSearchTextField.textColor = [UIColor lightGrayColor];
    _topSearchTextField.placeholder = _defultSearchText;
    [_topSearchTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_topSearchTextField setValue:[UIFont boldSystemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    
    // 设置placeholder的大小后，如果不是系统默认大小，会出现垂直不居中的情况，解决如下
    NSMutableParagraphStyle *style = [_topSearchTextField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    // [UIFont systemFontOfSize:13.0f]是设置的placeholder的字体
    style.minimumLineHeight = _topSearchTextField.font.lineHeight - (_topSearchTextField.font.lineHeight - [UIFont systemFontOfSize:13.0f].lineHeight) / 2.0;
    _topSearchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_defultSearchText attributes:@{NSParagraphStyleAttributeName : style}];
}

#pragma mark - CommonMethod

- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SearchTableViewCell.class;
}

#pragma mark - RequestData

- (void)requestData
{
    [self requestTopSearchDefultData];
    [self requestHotSearchData];
} 

/// 默认三条
- (void)requestTopSearchDefultData
{
    [self.viewModel getTopThreeDefaultData:^(id entity) {
        
        [self.tableView reloadData];
        
    } failure:^(NSUInteger errCode, NSString *errorMsg) {
    }];
}

/// 热搜歌手
- (void)requestHotSearchData
{
    [self.viewModel getHotSearchData:^(id entity) {
        
        
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
