//
//  ProgressView.m
//  WaterViewPractice
//
//  Created by Gguomingyue on 2017/5/15.
//  Copyright © 2017年 Gguomingyue. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()

@end

@implementation ProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - setup UI
-(void)setupUI
{
    [self addSubview:self.backImageView];
    [self addSubview:self.waterView];
    [self addSubview:self.numberLabel];
    [self addSubview:self.unitLabel];
    [self addSubview:self.explainLabel];
}

#pragma mark - getters and setters
-(UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
    }
    return _backImageView;
}

-(WaveView *)waterView
{
    if (!_waterView) {
        _waterView = [[WaveView alloc] init];
    }
    return _waterView;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
    }
    return _numberLabel;
}

-(UILabel *)unitLabel
{
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
    }
    return _unitLabel;
}

-(UILabel *)explainLabel
{
    if (!_explainLabel) {
        _explainLabel = [[UILabel alloc] init];
    }
    return _explainLabel;
}

#pragma mark - protect method implementtion
-(void)stopWave
{
    [self.waterView stopWave];
}

-(void)startWave
{
    if (self.numberLabel.text) {
        if (self.percent >= 0) {
            self.waterView.percent = self.percent;
            [self.waterView startWave];
        } else {
            [self resetWave];
        }
    }
}

-(void)resetWave
{
    [self.waterView resetWave];
}

#pragma mark - layout subviews
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewHeight = CGRectGetHeight(self.frame);
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    
    self.backImageView.frame = self.bounds;
    self.waterView.frame = CGRectMake(self.waveViewMargin.left, self.waveViewMargin.top, viewWidth - self.waveViewMargin.left - self.waveViewMargin.right, viewHeight - self.waveViewMargin.top - self.waveViewMargin.bottom);
    self.waterView.layer.cornerRadius = MIN(CGRectGetHeight(self.waterView.frame)/2, CGRectGetWidth(self.waterView.frame)/2);
    
    CGFloat numberLabelWidth = viewWidth * 2 / 3;
    CGFloat numberLabelHeight = self.numberLabel.font.pointSize + 2;
    
    CGFloat explainLabelWidth = viewWidth * 3 / 4;
    CGFloat expainlabelHeight = self.explainLabel.font.pointSize;
    
    self.numberLabel.frame = CGRectMake((viewWidth - numberLabelWidth) / 2, (viewHeight - numberLabelHeight - expainlabelHeight)/2, numberLabelWidth, numberLabelHeight);
    if (_unitLabel.text.length > 0) {
        _unitLabel.frame = CGRectMake(viewWidth * 0.7, CGRectGetMinY(_numberLabel.frame)*1.2, _unitLabel.font.pointSize*3, _unitLabel.font.pointSize);
    } else{
        _unitLabel.frame = CGRectZero;
    }
    
    _explainLabel.frame = CGRectMake((viewWidth - explainLabelWidth)/2, CGRectGetMaxY(_numberLabel.frame)-numberLabelHeight/30, explainLabelWidth, expainlabelHeight);
}

-(void)dealloc
{
    [self stopWave];
}



@end
