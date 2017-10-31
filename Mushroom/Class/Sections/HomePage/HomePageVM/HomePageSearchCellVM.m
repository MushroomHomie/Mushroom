//
//  HomePageSearchCellVM.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/31.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageSearchCellVM.h"
#import "SubDefaultSearchModel.h"

@interface  HomePageSearchCellVM ()

@property (nonatomic, strong, nullable) SubDefaultSearchModel *model;

@end

@implementation HomePageSearchCellVM

- (NSString *)getHomePageSearchText
{
    return self.model.title;
}

@end
