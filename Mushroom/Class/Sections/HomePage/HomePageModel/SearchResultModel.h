//
//  SearchResultModel.h
//  Mushroom
//
//  Created by 王雅琦 on 2018/1/8.
//  Copyright © 2018年 iOSfghj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultModel : NSObject

@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *posterPic;
@property (nonatomic, copy) NSString *albumImg;
@property (nonatomic, strong) NSArray *artists;
@property (nonatomic, copy) NSString *regdate;

@end
