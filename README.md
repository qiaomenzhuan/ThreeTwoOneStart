# ThreeTwoOneStart
ThreeTwoOneStart1
##项目是运动类，有一个321倒计时进入运动界面的功能，实现用了简单的基础动画CABasicAnimation，大致效果如下
![gif5新文件.gif](http://upload-images.jianshu.io/upload_images/6206716-26d06012dc762138.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###下面我们看一下实现部分
####创建了一个CABasicAnimation 使用了其中的缩放transform.scale路径
```
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
```

####创建了一个显示内容的label
```
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
```
####在每次动画结束animationDidStop代理方法里处理一下label上显示的内容
```
#pragma mark - 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [self.aniLabel.layer animationForKey:@"scaleAnim"])
    {//加分
        if (self.aniLabel.tag == self.mtitleArr.count - 1)
        {//动画播放结束do something
            if (self.click) {
                self.click();
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
```

以上。
