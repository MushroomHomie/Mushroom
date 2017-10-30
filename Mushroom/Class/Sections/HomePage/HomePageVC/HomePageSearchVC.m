//
//  HomePageSearchVC.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageSearchVC.h"
#import "HomePageSearchVM.h"
#import "SearchTableViewCell.h"

@interface HomePageSearchVC ()

@property (nonatomic, strong) HomePageSearchVM *viewModel;
@property (nonatomic, strong) UILabel *topSearchLabel;
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
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    // 顶部搜索条
    [self createTopSearchTextField];
    
    [self.navigationController createTextfieldWithTarget:self Textfield:_topSearchLabel];
    [self.navigationController setRightBarButtonItemWithTitle:nil
                                                        Image:@"StarTV_Live_Back_40x40_"
                                                       Target:self
                                                       Action:@selector(cancelSearch)];
}

- (void)initData
{
    self.viewModel = [HomePageSearchVM new];
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

#pragma mark - CommonMethod

- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SearchTableViewCell.class;
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
