//
//  HomePageSearchVM.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewModel.h"

@interface HomePageSearchVM : BaseTableViewModel


- (void)getTopThreeDefaultData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock;
- (void)getHotSearchData:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock;

@end
