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
#import "HotSearchModel.h"
#import "SearchListModel.h"
#import "HomePageDefaultSearchModel.h"

#import "SearchListApi.h"

@interface HomePageSearchVC ()

@property (nonatomic, strong) HomePageSearchVM *viewModel;
@property (nonatomic, strong) UITextField *topSearchTextField;
@property (nonatomic, strong) UIButton *clearTextFieldButton;
@property (nonatomic, strong) UIImageView *backGroundImageView;
@property (nonatomic, strong) HotSearchModel *hotSearchModel;
@property (nonatomic, strong) NSMutableArray *defaultSearchModelArray;

@property (nonatomic, strong) SearchListModel *searchResultModel;
@property (nonatomic, strong) SearchListApi *searchListApi;

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

- (void)initData
{
    _searchListApi = [SearchListApi new];
    self.viewModel = [HomePageSearchVM new];
    [self requestData];
    [[DataBaseOperation sharedataBaseOperation] deleteSearchHistoricalRecordList];
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
    style.minimumLineHeight = _topSearchTextField.font.lineHeight - (_topSearchTextField.font.lineHeight - [UIFont systemFontOfSize:13.0f].lineHeight) / 2.0;
    if (_defultSearchText)
    {
        _topSearchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_defultSearchText attributes:@{NSParagraphStyleAttributeName : style}];
    }
    
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
            _searchListApi.keyWord = @"";
            _clearTextFieldButton.hidden = YES;
            [self.viewModel getHistoryListTitle];
            [self.tableView reloadData];
            return NO;
        }
    }] subscribeNext:^(NSString *x) {
        
        @strongify(self);
        _clearTextFieldButton.hidden = NO;
        _searchListApi.keyWord = [x stringByReplacingOccurrencesOfString:@" " withString:@""];
        [self requestSearchResultList];
    }];
}

/// 创建清空搜索框Button
- (void)createClearSearchButton
{
    _clearTextFieldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearTextFieldButton setBackgroundImage:[UIImage imageNamed:@"AD_RSS_CloseBtn_8x8_"] forState:UIControlStateNormal];
    _clearTextFieldButton.hidden = YES;
    
    // 监听button
    @weakify(self);
    [[_clearTextFieldButton rac_signalForControlEvents:UIControlEventTouchUpInside]  subscribeNext:^(id x) {
        @strongify(self);
        _topSearchTextField.text = @"";
        _searchListApi.keyWord = @"";
        _clearTextFieldButton.hidden = YES;
        [self.tableView reloadData];
    }];
}

- (UIView *)createSectionHeaderView:(NSString *)sectionTitleName
{
    UIView *sectionHeaderView = [UIView new];
    sectionHeaderView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, 35);
    
    UILabel *sectionTitleLable = [UILabel new];
    sectionTitleLable.text = sectionTitleName;
    sectionTitleLable.textColor = [UIColor grayColor];
    sectionTitleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [sectionHeaderView addSubview:sectionTitleLable];
    
    [sectionTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sectionHeaderView).with.insets(UIEdgeInsetsMake(0, 15, 0, 0));
    }];
    
    return sectionHeaderView;
}

#pragma mark - CommonMethod

- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SearchTableViewCell.class;
}

- (UIView *)viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:self.tableView titleForHeaderInSection:section];
    if (sectionTitle == nil)
    {
        return  nil;
    }
    
    return [self createSectionHeaderView:sectionTitle];
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubDefaultSearchModel *subModel = _defaultSearchModelArray[indexPath.row];
    [[DataBaseOperation sharedataBaseOperation] insertSearchHistoricalRecordWithSearchTitle:subModel.title];
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
    [self.viewModel getTopThreeDefaultData:^(id array) {
        
        _defaultSearchModelArray = (NSMutableArray *)array;
        [self.tableView reloadData];
        
    } failure:^(NSUInteger errCode, NSString *errorMsg) {
    }];
}

/// 热搜歌手
- (void)requestHotSearchData
{
    [self.viewModel getHotSearchData:^(id entity) {
        
        _hotSearchModel = (HotSearchModel *)entity;
        
    } failure:^(NSUInteger errCode, NSString *errorMsg) {
    }];
}

/// 模糊搜索MV/歌手
- (void)requestSearchResultList
{
    [self.viewModel getSearchResultListWithApi:_searchListApi succeed:^(id entity) {
        
        _searchResultModel = (SearchListModel *)entity;
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
