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

@property (nonatomic,copy,readonly) YLdurationTime YlDurationTime;
@property (nonatomic,copy,readonly) YLfromValue    YlFromValue;
@property (nonatomic,copy,readonly) YLtoValue      YlToValue;
@property (nonatomic,copy,readonly) YLfontSize     YlFontSize;
@property (nonatomic,copy,readonly) YLstart        YlStart;
@property (nonatomic,copy,readonly) YLtitleArr     YlTitleArr;
@property (nonatomic,copy,readonly) YLsoundArr     YlSoundArr;
@property (nonatomic,copy         ) YLclick        YlClick;

- (void)startAni;

@end
