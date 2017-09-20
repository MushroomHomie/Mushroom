//
//  UtilsMacro.h
//  Mushroom
//
//  Created by 中原管家 on 2017/9/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h


#define APP_SCREEN_WIDTH                [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height
#define APP_NAVTOPBAR_HEIGHT            64

#define showMessage(MESSAGE,QUVC) UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:MESSAGE preferredStyle:UIAlertControllerStyleAlert];\
[alertController addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:nil]];\
[QUVC presentViewController:alertController animated:YES completion:nil];


#endif /* UtilsMacro_h */
