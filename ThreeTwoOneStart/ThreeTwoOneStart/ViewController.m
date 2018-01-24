//
//  ViewController.m
//  ThreeTwoOneStart
//
//  Created by 杨磊 on 2018/1/23.
//  Copyright © 2018年 csda_Chinadance. All rights reserved.
//

#import "ViewController.h"
#import "CountdownAnimationView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton                  *onceMore;
@property (nonatomic, strong) CountdownAnimationView    *animationView;
@property (nonatomic, strong) NSArray                   *countArr;
@property (nonatomic, strong) NSArray                   *soundArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backSublayer];
    
#pragma mark - 声音数组的个数必须和标题数组个数相同
#pragma mark - 动画view
    self.animationView = [[CountdownAnimationView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.animationView];
    
    self.animationView
    .YlFromValue(2.f)
    .YlToValue(0.2f)
    .YlDurationTime(0.9f)
    .YlTitleArr(self.countArr)
    .YlSoundArr(self.soundArr)
    .YlStart()
    .YlClick = ^{
    };
    
    self.onceMore.titleLabel.font = [UIFont systemFontOfSize:14.f];
}

#pragma mark - 再次播放
- (void)onceClick
{
    [self.animationView startAni];
}

- (UIButton *)onceMore
{
    if (!_onceMore) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 40, 100, 50);
        button.backgroundColor = [UIColor purpleColor];
        [button setTitle:@"再来一次" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onceClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        _onceMore = button;
    }
    return _onceMore;
}

- (NSArray *)soundArr
{
    if (!_soundArr) {
        NSArray *soundArr = @[@"num_6.mp3",
                              @"num_5.mp3",
                              @"num_4.mp3",
                              @"num_3.mp3",
                              @"num_2.mp3",
                              @"num_1.mp3",
                              @"orun_start.mp3"];
        _soundArr = soundArr;
    }
    return _soundArr;
}

- (NSArray *)countArr
{
    if (!_countArr) {
        NSArray *countArr = @[@"6",
                              @"5",
                              @"4",
                              @"3",
                              @"2",
                              @"1",
                              @"GO"];
        _countArr = countArr;
    }
    return _countArr;
}
#pragma mark - 渐变背景
- (void)backSublayer
{
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.colors = @[(__bridge id)[self getColor:@"FA508C"].CGColor, (__bridge id)[self getColor:@"FFC86E"].CGColor];
    gradientLayer1.locations = @[@0.0, @1.0];
    gradientLayer1.startPoint = CGPointMake(0, 1);
    gradientLayer1.endPoint = CGPointMake(1, 0);
    gradientLayer1.frame =self.view.bounds;
    [self.view.layer addSublayer:gradientLayer1];
}
#pragma mark - 16进制颜色
- (UIColor *)getColor:(NSString*)hexColor {
    if([hexColor hasPrefix:@"#"]) {
        hexColor = [hexColor substringFromIndex:1];
    }
    
    NSScanner*scanner = [NSScanner scannerWithString:hexColor];
    unsigned hexNum;
    if(![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    return [self colorWithRGBHex:hexNum];
}

- (UIColor *)colorWithRGBHex:(UInt32)hex{
    int r = (hex >>16) &0xFF;
    int g = (hex >>8) &0xFF;
    int b = (hex) &0xFF;
    return[UIColor colorWithRed:r /255.0f
                          green:g /255.0f
                           blue:b /255.0f
                          alpha:1.0f];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
