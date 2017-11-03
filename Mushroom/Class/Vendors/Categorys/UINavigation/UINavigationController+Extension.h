//
//  UINavigationController+Extension.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/26.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Extension)

@property (nonatomic, strong) UIButton *clearTextfieldButton;

- (void)setRightBarButtonItemWithTitle:(NSString *)buttonTitle
                                 Image:(NSString *)imageName
                                Target:(UIViewController *)target
                                Action:(SEL)action;

/// 导航栏上的textfield
-  (void)createTextfieldWithTarget:(UIViewController *)target
                         Textfield:(UIView *)textField
              clearTextfieldButton:(UIButton *)clearButton;

@end
