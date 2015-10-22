//
//  ViewController.m
//  ProgressCycleDemo
//
//  Created by Zhenwang Zha on 15/10/22.
//  Copyright © 2015年 zhenwang. All rights reserved.
//

#import "ViewController.h"
#import "GJCycleProgressView.h"

@interface ViewController ()
{
    GJCycleProgressView * _cycle;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cycle = [[GJCycleProgressView alloc] initWithFrame:CGRectMake(50, 100, 70, 70)];
    _cycle.isTextAnimatable = YES;
    [self.view addSubview:_cycle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_cycle setCycleProgress:70 animated:YES];
}

@end
