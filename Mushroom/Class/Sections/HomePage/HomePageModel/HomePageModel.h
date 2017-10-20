//
//  HomePageModel.h
//  Mushroom
//
//  Created by 中原管家 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseModel.h"
#import "HomaPageTypeModel.h"

@interface HomePageModel : BaseModel

@property (nonatomic, strong) NSMutableArray *data;

- (RACSignal *)requestHomePageData;
@end
