//
//  ViewController.m
//  PaintDemo
//
//  Created by hellovoidworld on 15/1/10.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "ViewController.h"
#import "BezierPaintView.h"
#import "ColorSelectionView.h"

@interface ViewController () <ColorSelectionViewDelegate>

@property (weak, nonatomic) IBOutlet BezierPaintView *paintView;

/** 颜色选择集合 */
@property (strong, nonatomic) IBOutletCollection(ColorSelectionView) NSArray *colorSelection;

- (IBAction)rollback;
- (IBAction)clearScreen;
- (IBAction)save;
- (IBAction)lineWidthChange:(UISlider *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 设置颜色选择器的代理
    for (ColorSelectionView *colorView in self.colorSelection) {
        colorView.delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 回退 */
- (IBAction)rollback {
    [self.paintView rollback];
}

/** 清屏 */
- (IBAction)clearScreen {
    [self.paintView clearScreen];
}

/** 保存 */
- (IBAction)save {
    [self.paintView save];
}

/** 改变线粗 */
- (IBAction)lineWidthChange:(UISlider *)sender {
    self.paintView.lineWidth = sender.value;
}

#pragma mark - ColorSelectionViewDelegate 代理方法
- (void) selectColor:(UIColor *) selectedColor {
    self.paintView.lineColor = selectedColor;
}

@end
