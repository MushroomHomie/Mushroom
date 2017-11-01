//
//  UtilsMacro.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/9/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

#define MODEL_VERSION                   [[[UIDevice currentDevice] systemVersion] floatValue]

#define APP_SCREEN_WIDTH                [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height
#define APP_NAVTOPBAR_HEIGHT            64

/// alert弹框
#define showMessage(MESSAGE,QUVC) UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:MESSAGE preferredStyle:UIAlertControllerStyleAlert];\
[alertController addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:nil]];\
[QUVC presentViewController:alertController animated:YES completion:nil];

/// RGB颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#endif /* UtilsMacro_h */
