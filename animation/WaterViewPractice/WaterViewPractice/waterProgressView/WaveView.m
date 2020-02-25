//
//  WaveView.m
//  WaterViewPractice
//
//  Created by Gguomingyue on 2017/5/15.
//  Copyright © 2017年 Gguomingyue. All rights reserved.
//

#import "WaveView.h"

@interface WaveView ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer *secondWaveLayer;

@end

@implementation WaveView

{
    CGFloat waveAmplitude;     //波纹振幅
    CGFloat waveCycle;         //波纹周期
    CGFloat waveSpeed;         //波速
    CGFloat waveGrowth;        //波纹上升速度
    CGFloat waterWaveHeight;   //
    CGFloat waterWaveWidth;
    CGFloat offsetX;           //波浪x位移
    CGFloat currentWavePointY; //当前波浪上市高度
    float variable;            //可变参数 更加真实 模拟波纹
    BOOL increase;             //增减变化
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        [self setupUI];
    }
    return self;
}

#pragma mark - setup UI
-(void)setupUI
{
    waterWaveHeight = self.frame.size.height/2;
    waterWaveWidth = self.frame.size.width;
    self.firstWaveColor = [UIColor colorWithRed:223/255.0 green:83/255.0 blue:64/255.0 alpha:1];
    self.secondWaveColor = [UIColor colorWithRed:236/255.0f green:90/255.0f blue:66/255.0f alpha:1];
    waveGrowth = 0.85;
    waveSpeed = 0.4/M_PI;
    [self resetProperty];
}

-(void)resetProperty
{
    currentWavePointY = self.frame.size.height;
    
    variable = 1.6;
    increase = NO;
    
    offsetX = 0;
}

#pragma mark - getters and setters
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    waterWaveHeight = self.frame.size.height/2;
    waterWaveWidth = self.frame.size.width;
    if (waterWaveWidth > 0) {
        waveCycle = 1.29 * M_PI / waterWaveWidth;
    }
    if (currentWavePointY <= 0) {
        currentWavePointY = self.frame.size.height;
    }
}

-(void)setFirstWaveColor:(UIColor *)firstWaveColor
{
    _firstWaveColor = firstWaveColor;
    _firstWaveLayer.fillColor = firstWaveColor.CGColor;
}

-(void)setSecondWaveColor:(UIColor *)secondWaveColor
{
    _secondWaveColor = secondWaveColor;
    _secondWaveLayer.fillColor = secondWaveColor.CGColor;
}

-(void)setPercent:(CGFloat)percent
{
    if (percent < _percent) {
        //下降
        waveGrowth = waveGrowth > 0 ? -waveGrowth : waveGrowth;
    } else if (percent > _percent) {
        //上升
        waveGrowth = waveGrowth > 0 ? waveGrowth : -waveGrowth;
    }
    _percent = percent;
}

#pragma mark - protected method implemention
-(void)startWave
{
    if (_firstWaveLayer == nil) {
        //创建第一个波浪
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
        [self.layer addSublayer:_firstWaveLayer];
    }
    if (_secondWaveLayer == nil) {
        //创建第二个波浪
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.fillColor = _secondWaveColor.CGColor;
        [self.layer addSublayer:_secondWaveLayer];
    }
    if (_displayLink == nil) {
        //启动定时调用
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

-(void)stopWave
{
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

-(void)resetWave
{
    [self stopWave];
    [self resetProperty];
    
    if (_firstWaveLayer) {
        [_firstWaveLayer removeFromSuperlayer];
        _firstWaveLayer = nil;
    }
    
    if (_secondWaveLayer) {
        [_secondWaveLayer removeFromSuperlayer];
        _secondWaveLayer = nil;
    }
}

-(void)animateWave
{
    if (increase) {
        variable += 0.01;
    } else {
        variable -= 0.01;
    }
    
    if (variable <= 1) {
        increase = YES;
    }
    if (variable >= 1.6) {
        increase = NO;
    }
    
    waveAmplitude = variable * 5;
}

#pragma mark - events handle
-(void)getCurrentWave:(CADisplayLink *)displayLink
{
    [self animateWave];
    
    if (waveGrowth > 0 && currentWavePointY > 2 * waterWaveHeight * (1 - _percent)) {
        //波浪高度未达到指定高度 继续上涨
        currentWavePointY -= waveGrowth;
    } else if (waveGrowth < 0 && currentWavePointY < 2 * waterWaveHeight * (1 -  _percent)) {
        currentWavePointY -= waveGrowth;
    }
    
    //波浪位移
    offsetX += waveSpeed;
    
    [self setCurrentFirstWaveLayerPath];
    [self setSecondWaveLayerPath];
}

-(void)setCurrentFirstWaveLayerPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <= waterWaveWidth; x++) {
        //正弦波浪公式
        y = waveAmplitude * sin(waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    _firstWaveLayer.path = path;
    CGPathRelease(path);
}

-(void)setSecondWaveLayerPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentWavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <= waterWaveWidth; x++) {
        //余弦波浪公式
        y = waveAmplitude * cos(waveCycle * x + offsetX) + currentWavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    _secondWaveLayer.path = path;
    CGPathRelease(path);
}

-(void)dealloc
{
    [self resetWave];
}

@end
