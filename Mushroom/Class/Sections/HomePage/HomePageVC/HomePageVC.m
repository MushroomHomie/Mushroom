//
//  HomePageVC.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/13.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageVC.h"
#import "HomePageCollectionCell.h"
#import "LoopPlaybackView.h" // 轮播图
#import "HomePageVM.h"

@interface HomePageVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
    
    UIView *_firstSectionHeaderView;
    NSArray *_sectionNameArray;
    
    HomePageVM *_homePageVM;
}

@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initData];
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
    
    [self initCollection];
}

- (void)initCollection
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置item大小
    flowLayout.itemSize = CGSizeMake(APP_SCREEN_WIDTH / 2 - 10, APP_SCREEN_HEIGHT / 4 - 10);
    // section距离边界的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 3  , 0 , 0);
    // 头部视图区域大小
//     flowLayout.headerReferenceSize = CGSizeMake(APP_SCREEN_WIDTH, 170);
    // 底部视图区域大小
    // flowLayout.footerReferenceSize = CGSizeMake(self.frame.size.width, 130 );
    
    // 集合视图
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    // 注册item
    [_collectionView registerClass:[HomePageCollectionCell class] forCellWithReuseIdentifier:@"reuse"];
    // 注册头部
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReuse"];
    
    // 垂直:各小方格之间的列间距
    flowLayout.minimumInteritemSpacing = 5 ;
    // 行间距
    flowLayout.minimumLineSpacing = 10 ;
    
    [self.view addSubview:_collectionView];
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

#pragma mark - <UICollectionViewDelegate/UICollectionViewDataSource>

// 设置头部和底部区域内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerReuse" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.userInteractionEnabled = YES;
        
        if (indexPath.section == 0)
        {
            if (!_firstSectionHeaderView)
            {
                _firstSectionHeaderView = [HomePageVC initFirstSectionHeaderview:_sectionNameArray[0]];
            }
            
            [headerView addSubview:_firstSectionHeaderView];
        }
        
        if (indexPath.section > 0)
        {
            for (UIView *subv in [headerView subviews])
            {
                [subv removeFromSuperview];
            }
            NSString *titleName = _sectionNameArray[indexPath.section];
            [headerView addSubview:[HomePageVC initOtherSectionHeaderView:titleName]];
        }
        
        return  headerView;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {APP_SCREEN_WIDTH, 190};
        return size;
    }
    else
    {
        CGSize size = {APP_SCREEN_WIDTH, 50};
        return size;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 8;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionCell *homePageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    
    return homePageCell;
}


#pragma mark - RequestData

- (void)headerRefreshMethod
{
    [_homePageVM sendRequest:^(id entity) {
        
        
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
