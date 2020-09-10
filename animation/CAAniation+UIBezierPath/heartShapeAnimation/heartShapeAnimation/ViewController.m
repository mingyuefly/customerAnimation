//
//  ViewController.m
//  heartShapeAnimation
//
//  Created by mingyue on 2020/9/9.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "HeartView.h"

@interface ViewController ()

@property (nonatomic, strong) HeartView *heartView;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) UIView *animationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.heartView];
    //[self.view addSubview:self.animationView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //[self startAnimation];
}

-(void)startAnimation
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.width - 20 + 100);
    [path moveToPoint:startPoint];
    CGPoint endPoint = CGPointMake(self.view.bounds.size.width / 2, 120 + 100);
    CGPoint controlPoint1 = CGPointMake(60, self.view.bounds.size.width - 20 + 100);
    CGPoint controlPoint2 = CGPointMake(0, 0 + 100);
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    [path moveToPoint:endPoint];
    CGPoint controlPoint3 = CGPointMake(self.view.bounds.size.width, 0 + 100);
    CGPoint controlPoint4 = CGPointMake(self.view.bounds.size.width - 60, self.view.bounds.size.width - 20 + 100);
    [path addCurveToPoint:startPoint controlPoint1:controlPoint3 controlPoint2:controlPoint4];
    path.lineWidth = 3;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [[UIColor redColor] set];
    [path stroke];
    self.path = path;
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = path.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = self.path.CGPath;
    keyFrameAnimation.duration = 3.0f;
    keyFrameAnimation.repeatCount = FLT_MAX;
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    [self.animationView.layer addAnimation:keyFrameAnimation forKey:nil];
}

-(HeartView *)heartView
{
    if (!_heartView) {
        _heartView = [[HeartView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.width)];
    }
    return _heartView;
}

-(UIView *)animationView
{
    if (!_animationView) {
        _animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _animationView.backgroundColor = [UIColor redColor];
        _animationView.layer.cornerRadius = 10;
    }
    return _animationView;
}

@end
