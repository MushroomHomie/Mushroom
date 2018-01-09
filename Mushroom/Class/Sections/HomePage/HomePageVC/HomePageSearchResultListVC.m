//
//  HomePageSearchListVC.m
//  Mushroom
//
//  Created by 王雅琦 on 2018/1/8.
//  Copyright © 2018年 iOSfghj. All rights reserved.
//

#import "HomePageSearchResultListVC.h"
#import "SearchResultListVM.h"
#import "SearchResultListModel.h"
#import "SearchVideoCell.h"

@interface HomePageSearchResultListVC ()

@property (nonatomic, strong) UITextField *topSearchTextField;
@property (nonatomic, strong) UIButton *clearTextFieldButton;
@property (nonatomic, strong) UIImageView *backGroundImageView;

@property (nonatomic, strong) SearchResultListVM *viewModel;
@property (nonatomic, assign) BOOL isChange;
@end

@implementation HomePageSearchResultListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData
{
    _isChange = NO;
    [self getListData];
}

- (void)initBinding
{
    self.viewModel = [SearchResultListVM new];
    self.viewModel.keyWord = _keyWord;
    self.viewModel.offset = 0;
}

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
    self.tableView.mj_header = nil;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    // 顶部搜索条
    [self createTopSearchTextField];
    [self createClearSearchButton];
    [self.navigationController createTextfieldWithTarget:self
                                               Textfield:self.topSearchTextField
                                    clearTextfieldButton:_clearTextFieldButton];
    [self.navigationController setRightBarButtonItemWithTitle:@"取消"
                                                        Image:nil
                                                       Target:self
                                                       Action:@selector(cancelSearch)];
}

#pragma mark - ClickEvents

- (void)cancelSearch
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - PrivateMethod

/// 顶部搜索条
- (void)createTopSearchTextField
{
    _topSearchTextField = [UITextField new];
    _topSearchTextField.font = [UIFont systemFontOfSize:12];
    _topSearchTextField.textColor = [UIColor lightGrayColor];
    [_topSearchTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_topSearchTextField setValue:[UIFont boldSystemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    _topSearchTextField.text = _keyWord;
    _clearTextFieldButton.hidden = NO;

    // 设置placeholder的大小后，如果不是系统默认大小，会出现垂直不居中的情况，解决如下
    NSMutableParagraphStyle *style = [_topSearchTextField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = _topSearchTextField.font.lineHeight - (_topSearchTextField.font.lineHeight - [UIFont systemFontOfSize:13.0f].lineHeight) / 2.0;
    
    // 监听textfield
    @weakify(self);
    [[_topSearchTextField.rac_textSignal filter:^BOOL(NSString *value) {
        
        @strongify(self);
        NSString *newValue = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (newValue.length > 0)
        {
            return YES;
        }
        else
        {
            _clearTextFieldButton.hidden = YES;
            return NO;
        }
    }] subscribeNext:^(NSString *x) {
        
        @strongify(self);
        _clearTextFieldButton.hidden = NO;

        if (_clearTextFieldButton)
        {
            [self.navigationController popViewControllerAnimated:NO];
            
            if ([self.delegate respondsToSelector:@selector(changeKeyWord:)]) {
                [self.delegate changeKeyWord:_keyWord];
            }
        }
    }];
}

/// 创建清空搜索框Button
- (void)createClearSearchButton
{
    _clearTextFieldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearTextFieldButton setBackgroundImage:[UIImage imageNamed:@"AD_RSS_CloseBtn_8x8_"] forState:UIControlStateNormal];
    
    // 监听button
    @weakify(self);
    [[_clearTextFieldButton rac_signalForControlEvents:UIControlEventTouchUpInside]  subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:NO];

        if ([self.delegate respondsToSelector:@selector(changeKeyWord:)]) {
            [self.delegate changeKeyWord:@""];
        }
    }];
}

#pragma mark - CommonMethod

/// 上下拉刷新的回调， YES是下拉刷新  NO上拉加载更多
- (void)pullTableViewRequestData:(BOOL)isRefresh
{
    // 下拉刷新的额时候重新刷新pagecount为0
    if (isRefresh)
    {
        [self getListData];
    }
}

- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SearchVideoCell.class;
}

#pragma mark - RequestData

- (void)getListData
{
    [self.viewModel getSearchResultListData:^(id entity) {
        
        SearchResultListModel *listModel = (SearchResultListModel *)entity;
        [self.tableView reloadData];
        
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
