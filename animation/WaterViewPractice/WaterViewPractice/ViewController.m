//
//  ViewController.m
//  WaterViewPractice
//
//  Created by Gguomingyue on 2017/5/15.
//  Copyright © 2017年 Gguomingyue. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"

@interface ViewController ()

@property (nonatomic, strong) ProgressView *upProgressView;
@property (nonatomic, strong) ProgressView *downProgressView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *middleButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"self.view.frame = %@", [NSValue valueWithCGRect:self.view.frame]);
    // init UI
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)initUI
{
    [self.view addSubview:self.upProgressView];
    [self.view addSubview:self.downProgressView];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.middleButton];
    [self.view addSubview:self.rightButton];
    
    [self.upProgressView startWave];
    [self.downProgressView startWave];
}

#pragma mark - getters and setters
-(ProgressView *)upProgressView
{
    if (!_upProgressView) {
        _upProgressView = [[ProgressView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 180)/2, 44, 180, 180)];
        _upProgressView.waveViewMargin = UIEdgeInsetsMake(15, 15, 20, 20);
        _upProgressView.backImageView.image = [UIImage imageNamed:@"backImage"];
        _upProgressView.numberLabel.text = @"80";
        _upProgressView.numberLabel.font = [UIFont boldSystemFontOfSize:70];
        _upProgressView.numberLabel.textColor = [UIColor whiteColor];
        _upProgressView.unitLabel.text = @"%";
        _upProgressView.unitLabel.font = [UIFont boldSystemFontOfSize:20];
        _upProgressView.unitLabel.textColor = [UIColor whiteColor];
        _upProgressView.explainLabel.text = @"电量";
        _upProgressView.explainLabel.font = [UIFont systemFontOfSize:20];
        _upProgressView.explainLabel.textColor = [UIColor whiteColor];
        _upProgressView.percent = 0.76;
    }
    return _upProgressView;
}

-(ProgressView *)downProgressView
{
    if (!_downProgressView) {
        _downProgressView = [[ProgressView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 180)/2, 300, 180, 180)];
        _downProgressView.waveViewMargin = UIEdgeInsetsMake(15, 15, 20, 20);
        _downProgressView.backImageView.image = [UIImage imageNamed:@"backImage"];
        _downProgressView.numberLabel.text = @"68";
        _downProgressView.numberLabel.font = [UIFont boldSystemFontOfSize:70];
        _downProgressView.numberLabel.textColor = [UIColor whiteColor];
        _downProgressView.explainLabel.text = @"评分";
        _downProgressView.explainLabel.font = [UIFont systemFontOfSize:20];
        _downProgressView.explainLabel.textColor = [UIColor whiteColor];
        _downProgressView.percent = 0.68;
    }
    return _downProgressView;
}

-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(24, 600, 78, 30);
        [_leftButton setTitle:@"下降" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

-(UIButton *)middleButton
{
    if (!_middleButton) {
        _middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_middleButton setTitle:@"重新开始" forState:UIControlStateNormal];
        _middleButton.frame = CGRectMake(137.5, 600, 100, 30);
        [_middleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_middleButton addTarget:self action:@selector(middleAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _middleButton;
}

-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(273, 600, 78, 30);
        [_rightButton setTitle:@"上升" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

#pragma mark - events handle
-(void)leftAction
{
    NSLog(@"leftAction");
    self.upProgressView.percent = 0.36;
    self.downProgressView.percent = 0.28;
    [self.upProgressView startWave];
    [self.downProgressView startWave];
}

-(void)middleAction
{
    NSLog(@"middleAction");
    [self.upProgressView resetWave];
    [self.downProgressView resetWave];
    [self.upProgressView startWave];
    [self.downProgressView startWave];
}

-(void)rightAction
{
    NSLog(@"rightAction");
    self.upProgressView.percent = 0.9;
    self.downProgressView.percent = 0.8;
    [self.upProgressView startWave];
    [self.downProgressView startWave];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
