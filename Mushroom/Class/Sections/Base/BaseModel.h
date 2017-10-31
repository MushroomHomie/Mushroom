//
//  BaseModel.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/9/14.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseApi;

@interface BaseModel : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *now;

- (RACSignal *)getRequestWithApi:(BaseApi *)api;

@end
