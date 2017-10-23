//
//  BaseTableViewCellVM.h
//  Mushroom
//
//  Created by 中原管家 on 2017/10/23.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseViewModel.h"

@interface BaseTableViewCellVM : BaseViewModel

@property (nonatomic, strong, readonly, nullable) id model; // cellViewModel会绑定一个entity实例对象

- (instancetype)initWithEntity:(nullable id)model;

@end
