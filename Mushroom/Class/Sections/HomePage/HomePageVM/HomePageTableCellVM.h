//
//  HomePageTableCellVM.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/23.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseTableViewCellVM.h"

@interface HomePageTableCellVM : BaseTableViewCellVM

@property (nonatomic, strong) RACSubject *cellClickSubject;


- (instancetype)initWithEntity:(nullable id)model cellClickSubject:(RACSubject *)cellClickSubject;

- (NSArray *)getDataArray;
- (NSString *)getBannerStr;
@end
