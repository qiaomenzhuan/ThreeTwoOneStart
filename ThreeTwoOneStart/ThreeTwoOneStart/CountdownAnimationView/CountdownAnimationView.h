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

@property (nonatomic,copy,readonly) YLdurationTime durationTime;
@property (nonatomic,copy,readonly) YLfromValue    fromValue;
@property (nonatomic,copy,readonly) YLtoValue      toValue;
@property (nonatomic,copy,readonly) YLfontSize     fontSize;
@property (nonatomic,copy,readonly) YLstart        start;
@property (nonatomic,copy,readonly) YLtitleArr     titleArr;
@property (nonatomic,copy,readonly) YLsoundArr     soundArr;
@property (nonatomic,copy         ) YLclick        click;

- (void)startAni;

@end
