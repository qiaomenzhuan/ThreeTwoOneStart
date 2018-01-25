//
//  CountdownAnimationView.h
//  ThreeTwoOneStart
//
//  Created by 杨磊 on 2018/1/24.
//  Copyright © 2018年 csda_Chinadance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CountdownAnimationView;

typedef void(^YLclick)(void);

typedef CountdownAnimationView *(^YLdurationTime)(CGFloat value);
typedef CountdownAnimationView *(^YLfromValue   )(CGFloat value);
typedef CountdownAnimationView *(^YLtoValue     )(CGFloat value);
typedef CountdownAnimationView *(^YLfontSize    )(CGFloat value);

typedef CountdownAnimationView *(^YLstart       )(void);

typedef CountdownAnimationView *(^YLtitleArr)(NSArray<NSString*> *array);
typedef CountdownAnimationView *(^YLsoundArr)(NSArray<NSString*> *array);


@interface CountdownAnimationView : UIView

/** 设置 每个数字动画的时长 -> 格式: .YlDurationTime(1.5f) */
@property (nonatomic,copy,readonly) YLdurationTime YlDurationTime;
/** 设置 每个数字开始动画时数字的大小是原始大小的倍数 -> 格式: .YlFromValue(1.5f) */
@property (nonatomic,copy,readonly) YLfromValue    YlFromValue;
/** 设置 每个数字结束动画时数字的大小是原始大小的倍数 -> 格式: .YlToValue(1.5f) */
@property (nonatomic,copy,readonly) YLtoValue      YlToValue;
/** 设置 每个数字的文字大小 -> 格式: .YlFontSize(200.f) */
@property (nonatomic,copy,readonly) YLfontSize     YlFontSize;
/** 设置 开始动画 -> 格式: .YlStart() */
@property (nonatomic,copy,readonly) YLstart        YlStart;
/** 设置 动画显示的文字 和声音数组的个数必须一致 -> 格式: .YlTitleArr(@[@"3",@"2",@"1",@"GO"]) */
@property (nonatomic,copy,readonly) YLtitleArr     YlTitleArr;
/** 设置 动画时的声音数组 -> 格式: .YlSoundArr(@[@"num_3.mp3",@"num_2.mp3",@"num_1.mp3",@"orun_start.mp3"]) */
@property (nonatomic,copy,readonly) YLsoundArr     YlSoundArr;
/** 设置 动画结束触发事件 */
@property (nonatomic,copy         ) YLclick        YlClick;

- (void)startAni;

@end
