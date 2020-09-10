//
//  HeartView.m
//  heartShapeAnimation
//
//  Created by mingyue on 2020/9/9.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "HeartView.h"

@interface HeartView ()

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) UIView *animationView;

@end

@implementation HeartView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.animationView];
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint startPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.width - 20);
        [path moveToPoint:startPoint];
        CGPoint endPoint = CGPointMake(self.frame.size.width / 2, 120);
        CGPoint controlPoint1 = CGPointMake(60, self.frame.size.width - 20);
        CGPoint controlPoint2 = CGPointMake(0, 0);
        [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
        [path moveToPoint:endPoint];
        CGPoint controlPoint3 = CGPointMake(self.frame.size.width, 0);
        CGPoint controlPoint4 = CGPointMake(self.frame.size.width - 60, self.frame.size.width - 20);
        [path addCurveToPoint:startPoint controlPoint1:controlPoint3 controlPoint2:controlPoint4];
        path.lineWidth = 3;
        path.lineCapStyle = kCGLineCapRound;
        path.lineJoinStyle = kCGLineJoinRound;
        [[UIColor greenColor] set];
        [path stroke];
        
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.path = path.CGPath;
        pathLayer.fillColor = [UIColor clearColor].CGColor;
        pathLayer.strokeColor = [UIColor greenColor].CGColor;
        pathLayer.lineWidth = 3.0f;
        [self.layer addSublayer:pathLayer];
        
        self.path = path;
        CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        keyFrameAnimation.path = self.path.CGPath;
        keyFrameAnimation.duration = 3.0f;
        keyFrameAnimation.repeatCount = FLT_MAX;
        keyFrameAnimation.removedOnCompletion = NO;
        keyFrameAnimation.fillMode = kCAFillModeForwards;
        [self.animationView.layer addAnimation:keyFrameAnimation forKey:nil];
    }
    return self;
}

-(UIView *)animationView
{
    if (!_animationView) {
        _animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _animationView.backgroundColor = [UIColor greenColor];
        _animationView.layer.cornerRadius = 10;
    }
    return _animationView;
}


@end
