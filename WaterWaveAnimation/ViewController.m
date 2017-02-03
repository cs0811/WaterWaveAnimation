//
//  ViewController.m
//  WaterWaveAnimation
//
//  Created by tongxuan on 17/1/24.
//  Copyright © 2017年 tongxuan. All rights reserved.
//

#import "ViewController.h"
#import "WaterWaveAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WaterWaveAnimationView * waterWave = [[WaterWaveAnimationView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 300)];
    [self.view addSubview:waterWave];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
