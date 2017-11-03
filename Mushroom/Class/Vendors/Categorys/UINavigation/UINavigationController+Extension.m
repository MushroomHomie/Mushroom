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
    if (buttonTitle)
    {
        target.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:buttonTitle style:UIBarButtonItemStyleDone target:target action:action];
        [target.navigationItem.rightBarButtonItem setTintColor:[UIColor lightGrayColor]];
        [target.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
    }
    
    if (imageName)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *btuImage = [UIImage imageNamed:imageName];
        btuImage = [btuImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        // 设置图片
        [btn setBackgroundImage:btuImage forState:UIControlStateNormal];
        [btn setBackgroundImage:btuImage forState:UIControlStateHighlighted];
        // 设置尺寸
        btn.size = btn.currentBackgroundImage.size;
        
        target.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
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
    searchBarBg.layer.cornerRadius = 15;
    
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
