//
//  UIImage+Extension.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/// 通过图片名获得图片
+ (UIImage *)imageWithName:(NSString *)imageName imageFormat:(NSString *)imageFormat;

@end
