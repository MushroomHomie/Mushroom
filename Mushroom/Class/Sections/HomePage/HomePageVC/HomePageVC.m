//
//  HomePageVC.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/13.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageVC.h"
#import "HomePageCollectionCell.h"

@interface HomePageVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
    
    UIView *_firstSectionHeaderView;
    NSArray *_sectionNameArray;
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


+ (UIView *)initOtherSectionHeaderView:(NSInteger)sectionNo
{
    UIView *sectionHeaderView = [UIView new];
    sectionHeaderView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, 50);
    
    UILabel *sectionTitleLable = [UILabel new];
    sectionTitleLable.text = _sectionNameArray[sectionNo];
    [sectionHeaderView addSubview:sectionTitleLable];
    [sectionTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sectionHeaderView).with.insets(UIEdgeInsetsMake(0, 20, 0, 0));
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
        return  headerView;
    }
    
    return nil;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {APP_SCREEN_WIDTH, 170};
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

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionCell *homePageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    
    return homePageCell;
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
