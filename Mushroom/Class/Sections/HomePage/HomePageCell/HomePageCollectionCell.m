//
//  HomePageCollectionCell.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/17.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageCollectionCell.h"

@interface HomePageCollectionCell ()

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation HomePageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    
    return self;
}

- (void)initView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _photoImageView = [UIImageView new];
    [self.contentView addSubview:_photoImageView];
    
    _photoImageView.backgroundColor = [UIColor blackColor];
    @weakify(self)
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(5, 3, 20, 5));
    }];
    
    _textLabel = [UILabel new];
    [self.contentView addSubview:_textLabel];

    _textLabel.text = @"官方版";
    _textLabel.font = [UIFont systemFontOfSize:14];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.contentView);
        make.top.equalTo(_photoImageView.mas_bottom);
        make.left.equalTo(_photoImageView.mas_left);
        make.right.equalTo(_photoImageView.mas_right);
    }];
}

- (void)setSubDataModel:(HomePageSubDataModel *)subDataModel
{
    if (_subDataModel != subDataModel)
    {
        _subDataModel = subDataModel;
    }
 
    _textLabel.text = subDataModel.title;
    
    NSURL *url = [NSURL URLWithString:subDataModel.posterPic];
    [_photoImageView sd_setImageWithURL:url];
}

@end
