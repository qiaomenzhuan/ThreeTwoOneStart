//
//  CountdownAnimationView.m
//  ThreeTwoOneStart
//
//  Created by 杨磊 on 2018/1/24.
//  Copyright © 2018年 csda_Chinadance. All rights reserved.
//

#import "CountdownAnimationView.h"
#import <AVFoundation/AVFoundation.h>

@interface CountdownAnimationView()<CAAnimationDelegate,AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer    *player;
@property (nonatomic, strong) CABasicAnimation *scaleAnim;
@property (nonatomic, strong) UILabel          *aniLabel;
@property (nonatomic,   copy) NSArray          *mtitleArr;
@property (nonatomic,   copy) NSArray          *msoundArr;

@end

@implementation CountdownAnimationView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self loadSubViews];
    }
    return self;
}

-(void)loadSubViews
{
    self.mtitleArr              = @[@"3",@"2",@"1",@"GO"];
    self.msoundArr              = @[@"num_3.mp3",@"num_2.mp3",@"num_1.mp3",@"orun_start.mp3"];
    
    self.aniLabel.font          = [UIFont boldSystemFontOfSize:180.f];
    self.scaleAnim.fromValue    = [NSNumber numberWithFloat:1.5f];
    self.scaleAnim.toValue      = [NSNumber numberWithFloat:0.25f];
    self.scaleAnim.duration     = 1.0f;
}

#pragma mark - 开始动画
- (void)startAni
{
    self.aniLabel.tag = 0;
    self.aniLabel.text = self.mtitleArr[self.aniLabel.tag];
    [self.aniLabel.layer addAnimation:self.scaleAnim forKey:@"scaleAnim"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.msoundArr[self.aniLabel.tag] withExtension:nil];
    [self playerUrl:url];
}
#pragma mark - 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [self.aniLabel.layer animationForKey:@"scaleAnim"])
    {//加分
        if (self.aniLabel.tag == self.mtitleArr.count - 1)
        {//动画播放结束do something
            self.aniLabel.text = @"";
            if (self.YlClick) {
                self.YlClick();
            }
        }else
        {//播放动画
            self.aniLabel.tag ++;
            self.aniLabel.text = self.mtitleArr[self.aniLabel.tag];
            [self.aniLabel.layer addAnimation:self.scaleAnim forKey:@"scaleAnim"];
            NSURL *url = [[NSBundle mainBundle] URLForResource:self.msoundArr[self.aniLabel.tag] withExtension:nil];
            [self playerUrl:url];
        }
    }
    
}
#pragma mark - block
- (YLdurationTime)YlDurationTime
{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value)
    {
        weakSelf.scaleAnim.duration = value;
        return weakSelf;
    };
}

- (YLfromValue)YlFromValue
{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value)
    {
        weakSelf.scaleAnim.fromValue = [NSNumber numberWithFloat:value];
        return weakSelf;
    };
}

- (YLtoValue)YlToValue
{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value)
    {
        weakSelf.scaleAnim.toValue = [NSNumber numberWithFloat:value];
        return weakSelf;
    };
}

- (YLfontSize)YlFontSize
{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value)
    {
        weakSelf.aniLabel.font = [UIFont boldSystemFontOfSize:value];
        return weakSelf;
    };
}

- (YLsoundArr)YlSoundArr
{
    __weak typeof(self) weakSelf = self;
    return ^(NSArray<NSString*> *array)
    {
        weakSelf.msoundArr = array;
        if (weakSelf.mtitleArr.count != weakSelf.msoundArr.count) {
            NSAssert(NO, @"文字数组和声音数组的个数必须相同");
        }
        return weakSelf;
    };
}

- (YLtitleArr)YlTitleArr
{
    __weak typeof(self) weakSelf = self;
    return ^(NSArray<NSString*> *array)
    {
        weakSelf.mtitleArr = array;
        return weakSelf;
    };
}

- (YLstart)YlStart
{
    __weak typeof(self) weakSelf = self;
    return ^(void)
    {
        [weakSelf startAni];
        return weakSelf;
    };
}
#pragma mark - lazyload
- (CABasicAnimation *)scaleAnim{
    if (!_scaleAnim) {
        // 缩放动画
        CABasicAnimation * scaleAnim  = [CABasicAnimation animation];
        scaleAnim.keyPath             = @"transform.scale";
        scaleAnim.removedOnCompletion = NO;
        scaleAnim.fillMode            = kCAFillModeForwards;
        scaleAnim.delegate            = self;
        scaleAnim.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        scaleAnim.repeatCount         = 1;
        _scaleAnim                    = scaleAnim;
    }
    return _scaleAnim;
}

- (UILabel *)aniLabel
{
    if (!_aniLabel) {
        UILabel *label          = [UILabel new];
        label.frame             = self.bounds;
        label.tag               = 0;
        label.backgroundColor   = [UIColor clearColor];
        label.text              = self.mtitleArr[label.tag];
        label.textColor         = [UIColor whiteColor];
        label.textAlignment     = NSTextAlignmentCenter;
        _aniLabel               = label;
        [self addSubview:label];
    }
    return _aniLabel;
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
@end
