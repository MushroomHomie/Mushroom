//
//  HomaPageTypeModel.h
//  Mushroom
//
//  Created by 中原管家 on 2017/10/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageMoreDataModel.h"

@interface HomaPageTypeModel : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *enTitle;
@property (nonatomic, copy) NSString *showTitle;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, strong) HomePageMoreDataModel *moreData;
@property (nonatomic, strong) NSMutableArray *data;



@end
