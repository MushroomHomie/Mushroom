//
//  BaseViewModel.h
//  Mushroom
//
//  Created by 中原管家 on 2017/9/14.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSucceed)(id entity);
typedef void(^RequestFailure)(NSUInteger errCode,NSString *errorMsg);

@interface BaseViewModel : NSObject

/// 请求回调的公共属性
@property (nonatomic,assign,readonly) BOOL isSucceed;
@property (nonatomic,copy,readonly) NSString *messgae;
@property (nonatomic,copy,readonly) NSString *resultCode;

@property (nonatomic, copy, readonly) NSString *title;

/// 请求数据
- (void)sendRequest:(RequestSucceed)succeedBlock failure:(RequestFailure)failBlock;

@end
