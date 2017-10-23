//
//  HomePageTableCellVM.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/23.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageTableCellVM.h"
#import "HomaPageTypeModel.h"
#import "HomePageSubDataModel.h"

@interface  HomePageTableCellVM ()

@property (nonatomic, strong, nullable) HomaPageTypeModel *model;

@end

@implementation HomePageTableCellVM

- (NSArray *)getDataArray
{
    return self.model.data;
}

- (NSString *)getBannerStr
{
    return @"https://img1.c.yinyuetai.com/others/admin/170930/0/1506780963015_1050x244.jpg";
}

@end
