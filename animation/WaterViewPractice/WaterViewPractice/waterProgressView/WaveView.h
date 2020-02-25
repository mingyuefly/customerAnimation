//
//  WaveView.h
//  WaterViewPractice
//
//  Created by Gguomingyue on 2017/5/15.
//  Copyright © 2017年 Gguomingyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveView : UIView

@property (nonatomic, strong) UIColor *firstWaveColor;
@property (nonatomic, strong) UIColor *secondWaveColor;
@property (nonatomic, assign) CGFloat percent;

-(void)startWave;
-(void)stopWave;
-(void)resetWave;

@end
