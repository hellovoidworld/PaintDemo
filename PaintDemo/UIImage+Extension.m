//
//  UIImage+Extension.m
//  PaintDemo
//
//  Created by hellovoidworld on 15/1/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage(Extension)

+ (UIImage *) imageOfView:(UIView *) view {
    // 1.开启图片上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    // 2.将view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.获取上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭图片上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
