//
//  BezierPaintView.h
//  PaintDemo
//
//  Created by hellovoidworld on 15/1/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BezierPaintView : UIView
/** 线组(所有线) */
@property(nonatomic, strong) NSMutableArray *lines;

/** 线粗 */
@property(nonatomic, assign) CGFloat lineWidth;

/** 线颜色 */
@property(nonatomic, strong) UIColor *lineColor;

/** 回退 */
- (void)rollback;

/** 清屏 */
- (void)clearScreen;

/** 保存 */
- (void)save;

@end
