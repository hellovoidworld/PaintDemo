//
//  PaintView.h
//  PaintDemo
//
//  Created by hellovoidworld on 15/1/10.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintView : UIView

/** 线组(所有线) */
@property(nonatomic, strong) NSMutableArray *lines;

/** 回退 */
- (void)rollback;

/** 清屏 */
- (void)clearScreen;

/** 保存 */
- (void)save;

@end
