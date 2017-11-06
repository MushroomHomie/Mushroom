//
//  LoopPlaybackView.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "LoopPlaybackView.h"

@implementation LoopPlaybackView

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createSubviews:array andFrame:frame];
    }
    return self;
}

#pragma mark - PrivateMethod

- (void)createSubviews:(NSArray *)photoNameArray andFrame:(CGRect)frame
{
    if (photoNameArray.count <= 0)
    {
        return;
    }
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:frame];
    [self addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    
    NSString *firstPhotoUrl = [photoNameArray firstObject];
    NSString *lastPhotoUrl = [photoNameArray lastObject];

    NSMutableArray *loopPlayArray = [NSMutableArray arrayWithArray:photoNameArray];
    [loopPlayArray addObject:firstPhotoUrl];
    [loopPlayArray insertObject:lastPhotoUrl atIndex:0];

    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * loopPlayArray.count, 0);
    
    int i = 0;
    
    for (NSString *name in loopPlayArray)
    {
        UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        im.backgroundColor = [UIColor clearColor];
        im.tag = 10000 + i;
        NSURL *url = [NSURL URLWithString:name];
        [im sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:_placeholderImage]];
        
        [self.scrollView addSubview:im];
        self.scrollView.pagingEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [im addGestureRecognizer: tap];
        im.userInteractionEnabled = YES;
        
        i++;
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    [self createTimer];
}

- (void)createTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAciton:) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    if (self.myTimer)
    {
        if (self.myTimer.isValid)
        {
            // 如果是开启状态
            [self.myTimer invalidate];
            self.myTimer = nil;
        }
    }
}

- (void)timerAciton:(NSTimer *)timer
{
    // 当正常滚动的时候
    self.page ++;
    
    // 将要到达偏移量的宽度
    CGFloat offWith = self.scrollView.frame.size.width * self.page;
    [self.scrollView setContentOffset:CGPointMake(offWith, 0) animated:YES];
    
    // 当不是正常滚动,滚动到边缘就取消动画
    NSInteger number = self.scrollView.contentSize.width / self.scrollView.frame.size.width;
    // number是当前图片个数
    if (offWith == self.scrollView.frame.size.width * (number - 1))
    {
        self.page = 1;
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    }
    
    [self.delegate slippingPageNumber:self.page];
}

- (void)setPageNameArray:(NSMutableArray *)pageNameArray
{
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 手指将要拖拽
    [self stopTimer];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    // 将要结束拖拽
    [self createTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 加速结束时
    CGSize  size = scrollView.contentSize;
    CGFloat with = scrollView.frame.size.width;
    self.page = scrollView.contentOffset.x / with;
    
    // 往左划,如果是滑到最后一张图
    if (scrollView.contentOffset.x == (size.width - with))
    {
        self.page = 1;
        [scrollView setContentOffset:CGPointMake(with, 0)];
    }
    
    // 往右滑,如果滑到第一张图
    if (scrollView.contentOffset.x == 0)
    {
        self.page = scrollView.contentSize.width / scrollView.frame.size.width - 2 ;
        [scrollView setContentOffset:CGPointMake(size.width - with * 2, 0)];
    }
    
    [self.delegate slippingPageNumber:self.page];
}

#pragma mark - tapAction

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    // 获得点击的视图
    UIImageView *image = (UIImageView *)tap.view;
    NSLog(@"image = %ld",image.tag);
    NSInteger number = image.tag - 10000;
    
    return;
}

@end
