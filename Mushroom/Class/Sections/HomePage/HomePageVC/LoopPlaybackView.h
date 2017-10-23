//
//  LoopPlaybackView.h
//  Mushroom
//
//  Created by 中原管家 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

/// 轮播图View
@interface LoopPlaybackView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *pageNameArray;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, strong) NSString *placeholderImage;

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array;

@end
