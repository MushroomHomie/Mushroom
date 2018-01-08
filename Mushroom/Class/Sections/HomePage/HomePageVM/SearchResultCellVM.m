//
//  SearchResultCellVM.m
//  Mushroom
//
//  Created by 王雅琦 on 2018/1/8.
//  Copyright © 2018年 iOSfghj. All rights reserved.
//

#import "SearchResultCellVM.h"
#import "SearchResultModel.h"

@interface SearchResultCellVM ()

@property (nonatomic, strong, nullable) SearchResultModel *model;

@end

@implementation SearchResultCellVM

- (SearchResultModel *)getData
{
    return self.model;
}

@end
