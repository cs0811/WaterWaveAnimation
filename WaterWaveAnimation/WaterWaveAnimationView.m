//
//  WaterWaveAnimationView.m
//  WaterWaveAnimation
//
//  Created by tongxuan on 17/1/24.
//  Copyright © 2017年 tongxuan. All rights reserved.
//

#import "WaterWaveAnimationView.h"

@interface WaterWaveAnimationView ()

@property (nonatomic, strong) CADisplayLink * waveDisplaylink;
@property (nonatomic, strong) CAShapeLayer * firstWaveLayer;
@property (nonatomic, strong) CAShapeLayer * secondWaveLayer;

@property (nonatomic, strong) UIColor * firstWaveColor;
// 水纹振幅
@property (nonatomic, assign) CGFloat waveA;
// 水纹周期
@property (nonatomic, assign) CGFloat waveW;
// 位移
@property (nonatomic, assign) CGFloat offsetX;
// 当前波浪高度Y
@property (nonatomic, assign) CGFloat currentK;
// 水纹速度
@property (nonatomic, assign) CGFloat waveSpeed;
// 水纹路宽度
@property (nonatomic, assign) CGFloat waterWaveWidth;

@end

@implementation WaterWaveAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    self.waveA = 10.;
    self.waveW = 1/30.0;
    // 波浪宽
    self.waterWaveWidth = self.bounds.size.width;
    // 波浪颜色
    self.firstWaveColor = [UIColor greenColor];
    // 波浪速度
    self.waveSpeed = 0.4 / M_PI;
    // 设置闭环的颜色
    self.firstWaveLayer.fillColor = [UIColor colorWithRed:73/255.0 green:142/255.0 blue:178/255.0 alpha:0.5].CGColor;
    // 设置边缘线的颜色
    //        firstWaveLayer.strokeColor = UIColor.blue.cgColor
    self.firstWaveLayer.strokeStart = 0.0;
    self.firstWaveLayer.strokeEnd = 0.8;
    // 设置闭环的颜色
    self.secondWaveLayer.fillColor = [UIColor colorWithRed:73/255.0 green:142/255.0 blue:178/255.0 alpha:0.5].CGColor;
    // 设置边缘线的颜色
    //        secondWaveLayer.strokeColor = UIColor.blue.cgColor
    self.secondWaveLayer.strokeStart = 0.0;
    self.secondWaveLayer.strokeEnd = 0.8;
    [self.layer addSublayer:self.firstWaveLayer];
    [self.layer addSublayer:self.secondWaveLayer];
    
    // 设置波浪流动速度
    self.waveSpeed = 0.05;
    // 设置振幅
    self.waveA = 8;
    // 设置周期
    self.waveW = 2 * M_PI / self.bounds.size.width;
    // 设置波浪纵向位置
    self.currentK = self.bounds.size.height / 2; //屏幕居中
    
    self.waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    [self.waveDisplaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

}

- (void)dealloc {
    [self.waveDisplaylink invalidate];
}

- (void)setCurrentFirstWaveLayerPath {
    // 创建一个路径
    UIBezierPath * path = [UIBezierPath bezierPath];
    CGFloat y = self.currentK;
    [path moveToPoint:CGPointMake(0, y)];

    for (int i=0; i<self.waterWaveWidth; i++) {
        y = self.waveA * sin(self.waveW * i + self.offsetX) + self.currentK;
        [path addLineToPoint:CGPointMake(i, y)];
    }
    
    [path addLineToPoint:CGPointMake(self.waterWaveWidth, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [path closePath];
    self.firstWaveLayer.path = path.CGPath;
    
    // 创建一个路径
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    CGFloat y2 = self.currentK;
    [path2 moveToPoint:CGPointMake(0, y2)];
    
    for (int i=0; i<self.waterWaveWidth; i++) {
        y2 = self.waveA * sin(self.waveW * i + self.offsetX - self.waterWaveWidth/2) + self.currentK;
        [path2 addLineToPoint:CGPointMake(i, y2)];
    }
    
    [path2 addLineToPoint:CGPointMake(self.waterWaveWidth, self.bounds.size.height)];
    [path2 addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [path2 closePath];
    self.secondWaveLayer.path = path2.CGPath;
}

#pragma mark - Action
- (void)getCurrentWave {
    // 实时位移
    self.offsetX += self.waveSpeed;
    [self setCurrentFirstWaveLayerPath];
}


#pragma mark - Getter
- (CADisplayLink *)waveDisplaylink {
    if (!_waveDisplaylink) {
        _waveDisplaylink = [CADisplayLink new];
    }
    return _waveDisplaylink;
}
- (CAShapeLayer *)firstWaveLayer {
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
    }
    return _firstWaveLayer;
}
- (CAShapeLayer *)secondWaveLayer {
    if (!_secondWaveLayer) {
        _secondWaveLayer = [CAShapeLayer layer];
    }
    return _secondWaveLayer;
}

@end
