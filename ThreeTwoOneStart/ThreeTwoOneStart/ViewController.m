//
//  ViewController.m
//  ThreeTwoOneStart
//
//  Created by 杨磊 on 2018/1/23.
//  Copyright © 2018年 csda_Chinadance. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<CAAnimationDelegate,AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) CABasicAnimation *scaleAnim;
@property (nonatomic, strong) UILabel *aniLabel;
@property (nonatomic, strong) UIButton*onceMore;
@property (nonatomic,   copy) NSArray *countArr;
@property (nonatomic,   copy) NSArray *soundArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countArr = @[@"3",@"2",@"1",@"GO"];
    self.soundArr = @[@"num_3.mp3",@"num_2.mp3",@"num_1.mp3",@"orun_start.mp3"];
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.colors = @[(__bridge id)[self getColor:@"FA508C"].CGColor, (__bridge id)[self getColor:@"FFC86E"].CGColor];
    gradientLayer1.locations = @[@0.0, @1.0];
    gradientLayer1.startPoint = CGPointMake(0, 1);
    gradientLayer1.endPoint = CGPointMake(1, 0);
    gradientLayer1.frame =self.view.bounds;
    [self.view.layer addSublayer:gradientLayer1];
    
    self.onceMore.titleLabel.font = [UIFont systemFontOfSize:14.f];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.aniLabel.layer addAnimation:self.scaleAnim forKey:@"scaleAnim"];
        NSURL *url = [[NSBundle mainBundle] URLForResource:self.soundArr[self.aniLabel.tag] withExtension:nil];
        [self playerUrl:url];
    });
}
#pragma mark - 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [self.aniLabel.layer animationForKey:@"scaleAnim"])
    {//加分
        if (self.aniLabel.tag == 3)
        {//动画播放结束do something

        }else
        {//播放动画
            self.aniLabel.tag ++;
            self.aniLabel.text = self.countArr[self.aniLabel.tag];
            [self.aniLabel.layer addAnimation:self.scaleAnim forKey:@"scaleAnim"];
            NSURL *url = [[NSBundle mainBundle] URLForResource:self.soundArr[self.aniLabel.tag] withExtension:nil];
            [self playerUrl:url];
        }
    }
    
}

- (CABasicAnimation *)scaleAnim{
    if (!_scaleAnim) {
        // 缩放动画
        CABasicAnimation * scaleAnim = [CABasicAnimation animation];
        scaleAnim.keyPath = @"transform.scale";
        scaleAnim.fromValue = @1.5f;
        scaleAnim.toValue = @0.25f;
        scaleAnim.duration = 1.0f;
        scaleAnim.removedOnCompletion = NO;
        scaleAnim.fillMode = kCAFillModeForwards;
        scaleAnim.delegate = self;
        scaleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//时间函数
        scaleAnim.repeatCount = 1;
        _scaleAnim = scaleAnim;
    }
    return _scaleAnim;
}

- (UILabel *)aniLabel
{
    if (!_aniLabel) {
        UILabel *label = [UILabel new];
        label.frame = [UIScreen mainScreen].bounds;
        label.tag = 0;
        label.backgroundColor=[UIColor clearColor];
        label.text = self.countArr[label.tag];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:200.f];
        [self.view addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        _aniLabel = label;
    }
    return _aniLabel;
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
#pragma mark - 再次播放
- (void)onceClick{
    self.aniLabel.tag = 0;
    self.aniLabel.text = self.countArr[self.aniLabel.tag];
    [self.aniLabel.layer addAnimation:self.scaleAnim forKey:@"scaleAnim"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.soundArr[self.aniLabel.tag] withExtension:nil];
    [self playerUrl:url];
}
#pragma mark - 音频播放器
-(void)playerUrl:(NSURL *)url{
    //.设置静音模式依然播放
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //初始音量大小
    self.player.volume = 1;
    ///循环次数
    self.player.numberOfLoops = 0;
    // 准备播放
    if([self.player prepareToPlay]) {
        [self.player play];
    }
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
