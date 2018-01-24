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

@property (nonatomic,copy,readonly) YLdurationTime YldurationTime;
@property (nonatomic,copy,readonly) YLfromValue    YlfromValue;
@property (nonatomic,copy,readonly) YLtoValue      YltoValue;
@property (nonatomic,copy,readonly) YLfontSize     YlfontSize;
@property (nonatomic,copy,readonly) YLstart        Ylstart;
@property (nonatomic,copy,readonly) YLtitleArr     YltitleArr;
@property (nonatomic,copy,readonly) YLsoundArr     YlsoundArr;
@property (nonatomic,copy         ) YLclick        Ylclick;

- (void)startAni;

@end
