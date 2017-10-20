//
//  HomePageVC.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/13.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageVC.h"
#import "HomePageCollectionCell.h"
#import "HomePageModelTableCell.h"
#import "LoopPlaybackView.h" // 轮播图
#import "HomePageVM.h"

@interface HomePageVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView *_firstSectionHeaderView;
    NSArray *_sectionNameArray;
    
    HomePageVM *_homePageVM;
}

@end

@implementation HomePageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self initView];
    [self headerRefreshMethod];
}

#pragma mark - Init

- (void)initData
{
    _sectionNameArray = @[@"首播",@"娱乐",@"热播推荐",@"音乐现场",@"主打星:GOT7",@"自制节目",@"官方合作专区",@"猜你喜欢"];
    _homePageVM = [HomePageVM new];
}

- (void)initView
{
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self initCollection];
}

+ (UIView *)initFirstSectionHeaderview:(NSString *)sectionTitleName
{
    CGRect loopPlayViewFrame = CGRectMake(0, 0, APP_SCREEN_WIDTH, 140);
    NSArray *photoName = @[@"https://b-ssl.duitang.com/uploads/item/201509/26/20150926234325_KuCnP.jpeg",
                           @"https://b-ssl.duitang.com/uploads/item/201506/02/20150602182550_myGsS.jpeg",
                           @"https://b-ssl.duitang.com/uploads/item/201509/26/20150926234325_KuCnP.jpeg",
                           @"https://b-ssl.duitang.com/uploads/item/201506/02/20150602182550_myGsS.jpeg"];
    
    UIView *firstSectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 190)];

    LoopPlaybackView *loopPlayView = [[LoopPlaybackView alloc]initWithFrame:loopPlayViewFrame array:photoName];
    [firstSectionHeaderView addSubview:loopPlayView];
    
    UIView *sectionTitleView = [UIView new];
    [firstSectionHeaderView addSubview:sectionTitleView];
    [sectionTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(firstSectionHeaderView).with.insets(UIEdgeInsetsMake(140, 0, 0, 0));
    }];
    
    UIImageView *imageView = [UIImageView new];
    [sectionTitleView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"help_setting_40x40_"];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionTitleView).with.offset(7);
        make.top.equalTo(sectionTitleView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *sectionTitleLable = [UILabel new];
    sectionTitleLable.text = sectionTitleName;
    sectionTitleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [sectionTitleView addSubview:sectionTitleLable];
    
    [sectionTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sectionTitleView).with.insets(UIEdgeInsetsMake(0, 40, 0, 0));
    }];

    return firstSectionHeaderView;
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
    return [HomePageModelTableCell class];
}

#pragma mark - RequestData

- (void)headerRefreshMethod
{
    @weakify(self)
    [self.viewModel sendRequest:^(id entity) {
        @strongify(self);
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
