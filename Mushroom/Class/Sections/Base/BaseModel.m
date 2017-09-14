//
//  BaseModel.m
//  Mushroom
//
//  Created by 中原管家 on 2017/9/14.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseModel.h"
#import "BaseApi.h"
#import "RequestManager.h"

@interface BaseModel ()

@property (nonatomic, strong) RequestManager *manager; // 网络请求对象，每个Model有拥有一个

@end

@implementation BaseModel

- (RACSignal *)getRequestWithApi:(BaseApi *)api
{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
       
        self.manager
        
        return nil;
    }];

}

@end
