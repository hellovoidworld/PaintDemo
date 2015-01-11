//
//  ColorSelectionView.h
//  PaintDemo
//
//  Created by hellovoidworld on 15/1/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorSelectionViewDelegate <NSObject>

/** “色块”点击代理方法 */
@optional
- (void) selectColor:(UIColor *) selectedColor;

@end

@interface ColorSelectionView : UIView

/** 代理 */
@property(nonatomic, strong) id<ColorSelectionViewDelegate> delegate;

@end
