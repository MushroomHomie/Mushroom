//
//  HomePageCollectionCell.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/17.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "HomePageCollectionCell.h"

@interface HomePageCollectionCell ()

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UIView *gradientShadowView;


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
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(5, 3, 25, 5));
    }];
    
    NSInteger shadowHeight = 40;
    _gradientShadowView = [UIView new];
    [_photoImageView addSubview:_gradientShadowView];
    
    [_gradientShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(_photoImageView).with.insets(UIEdgeInsetsMake(self.contentView.height - shadowHeight - 25, 0, 0, 0 ));
    }];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.contentView.width - 8, shadowHeight - 5);
    [_gradientShadowView.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor blackColor].CGColor];
    gradientLayer.locations = @[@0.4];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    _authorLabel = [UILabel new];
    _authorLabel.font = [UIFont systemFontOfSize:11];
    _authorLabel.textColor = [UIColor whiteColor];
    [_gradientShadowView addSubview:_authorLabel];
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(_gradientShadowView.mas_bottom);
        make.left.equalTo(_gradientShadowView.mas_left);
        make.height.mas_equalTo(@20);
        make.right.equalTo(_gradientShadowView.mas_right);
    }];
    
    _textLabel = [UILabel new];
    [self.contentView addSubview:_textLabel];
    _textLabel.text = @"官方版";
    _textLabel.font = [UIFont systemFontOfSize:13];
    
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
 
    NSString *authors = @"";
    for (HomePageArtistsModel *authorModel in _subDataModel.artists)
    {
        if (authors.length > 0) {
            authors = [authors stringByAppendingString:[NSString stringWithFormat:@"&%@",authorModel.artistName]];
        }
        else
        {
            authors = authorModel.artistName;
        }
    }
    
    _textLabel.text = subDataModel.title;
    _authorLabel.text = authors;
    
    NSURL *url = [NSURL URLWithString:subDataModel.posterPic];
    [_photoImageView sd_setImageWithURL:url];
}

@end
