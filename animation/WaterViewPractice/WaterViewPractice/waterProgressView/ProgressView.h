//
//  ProgressView.h
//  WaterViewPractice
//
//  Created by Gguomingyue on 2017/5/15.
//  Copyright © 2017年 Gguomingyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaveView.h"

@interface ProgressView : UIView

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) WaveView *waterView;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) UILabel *explainLabel;
@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, assign) UIEdgeInsets waveViewMargin;

-(void)startWave;
-(void)stopWave;
-(void)resetWave;

@end
