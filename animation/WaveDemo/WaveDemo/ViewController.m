//
//  ViewController.m
//  WaveDemo
//
//  Created by Gguomingyue on 2019/11/8.
//  Copyright © 2019 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (strong, nonatomic) UIBezierPath *path;
@property (strong, nonatomic) CAShapeLayer *shapeLayer2;
@property (strong, nonatomic) UIBezierPath *path2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(0, 100, 375, 150);
    [self.view.layer addSublayer:self.shapeLayer];
    
    self.shapeLayer2 = [CAShapeLayer layer];
    self.shapeLayer2.frame = CGRectMake(0, 100, 375, 150);
    [self.view.layer addSublayer:self.shapeLayer2];
    
    self.shapeLayer.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3].CGColor;
    self.shapeLayer2.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.3].CGColor;
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawPath)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)drawPath {
    static double phaseStarti = 0;
    CGFloat A = 10.f;//A振幅
    CGFloat k = 0;//y轴偏移
    CGFloat ω = 0.03;
    //角速度ω变大，则波形在X轴上收缩（波形变紧密）；角速度ω变小，则波形在X轴上延展（波形变稀疏）。不等于0
    CGFloat φ = 0 + phaseStarti;//初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
    
    //y=Asin(ωx+φ)+k
    
    self.path = [UIBezierPath bezierPath];
    self.path2 = [UIBezierPath bezierPath];
    
    /******从起点CGPointZero开始path和path2的边框线 *****/
    [self.path moveToPoint:CGPointZero];
    [self.path2 moveToPoint:CGPointZero];
    
    // 将375条极短的直线连接起来成为波浪线
    for (int i = 0; i < 376; i ++) {
        CGFloat x = i;
        CGFloat y = A * sin(ω*x+φ)+k;
        CGFloat y2 = A * cos(ω*x+φ)+k;
        [self.path addLineToPoint:CGPointMake(x, y)];
        [self.path2 addLineToPoint:CGPointMake(x, y2)];
    }
    
    [self.path addLineToPoint:CGPointMake(375, -100)];
    [self.path addLineToPoint:CGPointMake(0, -100)];
    self.path.lineWidth = 1;
    self.shapeLayer.path = self.path.CGPath;
    
    [self.path2 addLineToPoint:CGPointMake(375, -100)];
    [self.path2 addLineToPoint:CGPointMake(0, -100)];
    self.path2.lineWidth = 1;
    self.shapeLayer2.path = self.path2.CGPath;
    /*********边框线结束(CAShapeLayer不一定要闭合)，并设置其线宽，并根据之前设置的颜色显示***************/

    phaseStarti += 0.1;
    if (phaseStarti > M_PI * 2) {
        phaseStarti = 0;//防止i越界
    }
}


@end
