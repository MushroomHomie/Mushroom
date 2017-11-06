//
//  LoopPlaybackView.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

@protocol LoopPlaybackDelegate <NSObject>

- (void)slippingPageNumber:(NSInteger)pageNumber;

@end

/// 轮播图View
@interface LoopPlaybackView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *pageNameArray;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, strong) NSString *placeholderImage;
@property (nonatomic, assign) id<LoopPlaybackDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array;

@end
