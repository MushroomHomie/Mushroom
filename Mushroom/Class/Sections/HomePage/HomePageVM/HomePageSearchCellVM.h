//
//  HomePageSearchCellVM.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/31.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewCellVM.h"

@interface HomePageSearchCellVM : BaseTableViewCellVM

@property (nonatomic, strong) NSArray *hotSearchData;

- (NSString *)getHomePageSearchText;

@end
