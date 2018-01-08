//
//  HomePageSearchListVC.h
//  Mushroom
//
//  Created by 王雅琦 on 2018/1/8.
//  Copyright © 2018年 iOSfghj. All rights reserved.
//

#import "BaseTableViewController.h"

@protocol SearchResultListDelegate <NSObject>

- (void)changeKeyWord:(NSString *)keyWord;

@end

@interface HomePageSearchResultListVC : BaseTableViewController

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, copy) NSString *keyWord;
@property (nonatomic, assign) id<SearchResultListDelegate> delegate;

@end
