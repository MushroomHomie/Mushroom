//
//  HomePageVM.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseViewModel.h"
#import "BaseTableViewModel.h"

@interface HomePageVM : BaseTableViewModel

@property (nonatomic, strong) RACSubject *cellClickSubject;

- (void)getHomePageListData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock;
- (void)getHomePageTopSearchData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock;

@end
