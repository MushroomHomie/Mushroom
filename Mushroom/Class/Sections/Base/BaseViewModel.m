//
//  BaseViewModel.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/14.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseViewModel.h"

@interface BaseViewModel ()

@property (nonatomic, copy) NSString *title;

@end

@implementation BaseViewModel

- (void)sendRequest:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock
{
    // 子类自己实现数据请求
}

@end
