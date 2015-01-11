//
//  PaintView.m
//  PaintDemo
//
//  Created by hellovoidworld on 15/1/10.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "PaintView.h"
#import "UIImage+Extension.h"

@interface PaintView()

@end

@implementation PaintView

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
    
    // 开启一条新的线
    NSMutableArray *points = [NSMutableArray array];
    // 存储点信息到线上
    [points addObject:[NSValue valueWithCGPoint:startLocation]];
    // 存储到线组上
    [self.lines addObject:points];
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    // 拿到正在画的线
    NSMutableArray *points = [self.lines lastObject];
    // 添加点信息
    [points addObject:[NSValue valueWithCGPoint:location]];
    
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
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 遍历线组，把所有线画出来
    for (NSArray *line in self.lines) {
        for (int i=0; i<line.count; i++) {
            NSValue *pointValue = line[i];
            CGPoint point = [pointValue CGPointValue];
            
            // 如果是线的第一个点，要先移动画笔到那个点
            if (0 == i) {
                CGContextMoveToPoint(ctx, point.x, point.y);
            } else {
                CGContextAddLineToPoint(ctx, point.x, point.y);
            }
        }
    }
    
    // 设置线宽、线头样式、线转折样式
    CGContextSetLineWidth(ctx, 5);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    // 渲染
    CGContextStrokePath(ctx);
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
