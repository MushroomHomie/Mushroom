//
//  HomePageVM.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageVM.h"
#import "HomePageModel.h"

@interface HomePageVM ()
{
    NSMutableArray *_cellViewModels;
    HomePageModel *_homePageModel;
}

@end

@implementation HomePageVM

- (void)initData
{
    _homePageModel = [HomePageModel new];
}

// 默认是一个section
- (NSInteger)numberOfSections
{
    return _homePageModel.data.count;
}

///  子类必须实现（每个section多少rows）
- (NSInteger)numberOfRowInSection:(NSInteger)section
{
    HomaPageTypeModel *typeModel = _homePageModel.data[section];
    return typeModel.data.count;
}

/// headerView的默认是没有的
- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


- (void)sendRequest:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock
{
    [[_homePageModel requestHomePageData] subscribeNext:^(id data) {
        
        if (data)
        {
            _homePageModel = [DataConvert convertDic:data toEntity:HomePageModel.class];
        }
        
        !succeedBlock ? : succeedBlock(_homePageModel);
        
    }];
}




@end
