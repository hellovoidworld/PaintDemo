//
//  ColorSelectionView.m
//  PaintDemo
//
//  Created by hellovoidworld on 15/1/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "ColorSelectionView.h"

@implementation ColorSelectionView

- (void)awakeFromNib {
    // 给UIView设置点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorClicked)];
    [self addGestureRecognizer:tapGesture];
}

/** “色块”点击事件 */
- (void) colorClicked {
    [self.delegate selectColor:self.backgroundColor];
}

@end
