//
//  SearchVideoModel.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/6.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseModel.h"
#import "HomePageArtistsModel.h"

@interface SearchVideoModel : BaseModel

@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *posterPic;
@property (nonatomic, copy) NSString *albumImg;
@property (nonatomic, strong) NSArray *artists;
@property (nonatomic, copy) NSString *totalView;
@property (nonatomic, copy) NSString *regdate;
@property (nonatomic, copy) NSString *isVchart;
@property (nonatomic, copy) NSString *ad;

@end
