//
//  BaseModel.h
//  Mushroom
//
//  Created by 中原管家 on 2017/9/14.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseApi;

@interface BaseModel : NSObject

- (RACSignal *)getRequestWithApi:(BaseApi *)api;

@end
