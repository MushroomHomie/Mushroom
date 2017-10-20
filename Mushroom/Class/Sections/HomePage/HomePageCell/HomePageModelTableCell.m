//
//  HomePageModelTableCell.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/20.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageModelTableCell.h"
#import "HomePageCollectionCell.h"

@interface HomePageModelTableCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
}

@end

@implementation HomePageModelTableCell

+ (instancetype)cellWithTable:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify = NSStringFromClass([self class]);
    NSString *cellName = [NSString stringWithFormat:@"%@%ld%ld",identify,indexPath.section,indexPath.row];
    HomePageModelTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell = [[HomePageModelTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName andindexPath:indexPath];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andindexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initView:indexPath];
    }
    return self;
}

- (void)initView:(NSIndexPath *)indexPath
{
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
    _collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:flowLayout];
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
    
    [self.contentView addSubview:_collectionView];
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
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionCell *homePageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    
    return homePageCell;
}



@end
