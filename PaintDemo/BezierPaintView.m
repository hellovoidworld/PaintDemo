//
//  BezierPaintView.m
//  PaintDemo
//
//  Created by hellovoidworld on 15/1/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "BezierPaintView.h"
#import "UIImage+Extension.h"
#import "HVWBezierPath.h"

@interface BezierPaintView()

@end

@implementation BezierPaintView

- (NSMutableArray *)lines {
    if (nil == _lines) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}

#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint startLocation = [touch locationInView:touch.view];
    
    // 新建一条Bezier线
    HVWBezierPath *path = [[HVWBezierPath alloc] init];
    
    // 配置线粗
    if (self.lineWidth) {
        [path setLineWidth:self.lineWidth];
    }
    
    // 配置线色
    if (self.lineColor) {
        path.color = self.lineColor;
    }
    
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    
    // 移动到始点
    [path moveToPoint:startLocation];
    // 添加Bezier线到数组
    [self.lines addObject:path];
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    // 获得正在画的线
    HVWBezierPath *path = [self.lines lastObject];
    // 画线-添加点信息
    [path addLineToPoint:location];
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // 停止拖曳的逻辑其实和拖曳中是一样的
    [self touchesMoved:touches withEvent:event];
}

#pragma mark - 绘图方法
/** 绘图 */
- (void)drawRect:(CGRect)rect {
    
    // 画出所有的线
    for (HVWBezierPath *path in self.lines) {

        // 设置颜色
        if (path.color) {
            [path.color set];
        }
        
        // 渲染
        [path stroke];
    }
    
}

#pragma mark - view操作方法
/** 回退 */
- (void)rollback {
    [self.lines removeLastObject];
    [self setNeedsDisplay];
}

/** 清屏 */
- (void)clearScreen {
    [self.lines removeAllObjects];
    [self setNeedsDisplay];
}

/** 保存 */
- (void)save {
    // 1.获取图片
    UIImage *image = [UIImage imageOfView:self];
    
    // 2.保存图片到相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/** 保存图片后激发事件
 * 这是文档推荐的方法
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存失败");
    } else {
        NSLog(@"保存成功");
    }
}


@end
