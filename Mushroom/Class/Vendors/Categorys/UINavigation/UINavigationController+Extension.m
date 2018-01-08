//
//  UINavigationController+Extension.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/26.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)


- (void)setRightBarButtonItemWithTitle:(NSString *)buttonTitle
                                 Image:(NSString *)imageName
                                Target:(UIViewController *)target
                                Action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (buttonTitle) {
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:buttonTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentRight;
        btn.size = CGSizeMake(33, 30);
    }
    
    if (imageName) {
        UIImage *btuImage = [UIImage imageNamed:imageName];
        btuImage = [btuImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 设置图片
        [btn setBackgroundImage:btuImage forState:UIControlStateNormal];
        [btn setBackgroundImage:btuImage forState:UIControlStateHighlighted];
        // 设置尺寸
        btn.size = btn.currentBackgroundImage.size;
    }
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    target.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

- (void)setLeftBarButtonItemWithTitle:(NSString *)buttonTitle
                                Image:(NSString *)imageName
                               Target:(UIViewController *)target
                               Action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (buttonTitle) {
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn setTitle:buttonTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.size = CGSizeMake(33, 30);
    }
    
    if (imageName) {
        UIImage *btuImage = [UIImage imageNamed:imageName];
        btuImage = [btuImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 设置图片
        [btn setBackgroundImage:btuImage forState:UIControlStateNormal];
        [btn setBackgroundImage:btuImage forState:UIControlStateHighlighted];
        // 设置尺寸
        btn.size = btn.currentBackgroundImage.size;
    }
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    target.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}


/// 导航栏上的textfield
- (void)createTextfieldWithTarget:(UIViewController *)target
                             Textfield:(UIView *)textField
             clearTextfieldButton:(UIButton *)clearButton

{
    UIView *topSearchView = [[UIView alloc] init];
    [topSearchView setFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH-100, 30)];
    
    //  搜索框背景图片imageView
    UIView *searchBarBg = [UIView new];
    [topSearchView addSubview:searchBarBg];
    searchBarBg.backgroundColor = [UIColor whiteColor];
    searchBarBg.layer.cornerRadius = 13; //因为下面 你设置了 UIEdgeInsetsMake(2, 0, 2, 0)  所以不是十五  是 (30 - 2 - 2) / 2
    
    [searchBarBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(topSearchView).with.insets(UIEdgeInsetsMake(2, 0, 2, 0));
    }];
    
    // 放大镜imageView
    UIImageView *searchIconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_fangdajing_18x18_"]];
    [searchBarBg addSubview:searchIconImage];
    
    [searchIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.left.equalTo(searchBarBg.mas_left).with.offset(10);
        make.centerY.mas_equalTo(searchBarBg.mas_centerY);
    }];
    
    // clearButton
    [searchBarBg addSubview:clearButton];
    [clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.right.equalTo(searchBarBg.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(searchBarBg.mas_centerY);
    }];
    
    // textfield
    [searchBarBg addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchIconImage.mas_right).with.offset(5);
        make.right.equalTo(searchBarBg.mas_right).with.offset(-10);
        make.top.equalTo(searchBarBg);
        make.bottom.equalTo(searchBarBg);
    }];
    
    if (clearButton)
    {
        [textField mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(searchBarBg.mas_right).with.offset(-30);;
        }];
    }
    
    target.navigationItem.titleView = topSearchView;
}


@end
