//
//  HomePageHeaderTableCell.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/23.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "LoopPlaybackView.h" // 轮播图

@interface HomePageHeaderTableCell : BaseTableViewCell

@property (nonatomic, assign) CGRect loopPlayViewFrame;

- (void)initLoopPlayView:(NSArray *)photoNameArray;

@end
