//
//  VideoPlaySubModel.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/15.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoPlaySubModel : NSObject

@property (nonatomic, copy) NSString *specialType;
@property (nonatomic, copy) NSString *bhdUrl;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *hdUrl;
@property (nonatomic, copy) NSString *videoSize;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray *videoTypes;
@property (nonatomic, copy) NSString *uhdUrl;
@property (nonatomic, copy) NSString *shdUrl;
@property (nonatomic, assign) CGFloat shdVideoSize;
@property (nonatomic, assign) CGFloat bhdVideoSize;
@property (nonatomic, assign) CGFloat hdVideoSize;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat videoId;
@property (nonatomic, assign) BOOL ad;
@property (nonatomic, assign) CGFloat uhdVideoSize;

@end
