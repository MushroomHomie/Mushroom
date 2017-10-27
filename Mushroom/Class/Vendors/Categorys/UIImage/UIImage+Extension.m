//
//  UIImage+Extension.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/27.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

/// 通过图片名获得图片
+ (UIImage *)imageWithName:(NSString *)imageName imageFormat:(NSString *)imageFormat
{
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:imageFormat];
    return [UIImage imageWithContentsOfFile:path];;
}

@end
