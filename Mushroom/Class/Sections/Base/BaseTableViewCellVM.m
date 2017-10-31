//
//  BaseTableViewCellVM.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/23.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewCellVM.h"

@interface BaseTableViewCellVM ()

@property (nonatomic,strong,nullable) id model;

@end


@implementation BaseTableViewCellVM

- (instancetype)initWithEntity:(nullable id)model
{
    self = [super init];
    if (self)
    {
        _model = model;
    }
    return self;
}

@end
