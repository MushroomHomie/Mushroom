//
//  HomePageVM.h
//  Mushroom
//
//  Created by 中原管家 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseViewModel.h"
#import "BaseTableViewModel.h"

@interface HomePageVM : BaseTableViewModel

- (void)getHomePageTopSearchData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock;

@end
