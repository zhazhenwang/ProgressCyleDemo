//
//  GJCycleProgressView.m
//  GJB4iPhone
//
//  Created by 查震旺 on 15-9-16.
//  Copyright (c) 2015年 zhenWang. All rights reserved.
//

#import "GJCycleProgressView.h"

#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degrees) ((pi * degrees) / 180)
//颜色RGB配置
#define rgba(r,g,b,a) ([UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:(a)])

@interface GJCycleProgressView ()
{
    CAShapeLayer * _trackLayer;
    CAShapeLayer * _progressLayer;
}
@property (nonatomic, assign) float progress;
@end

@implementation GJCycleProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        CGFloat w = self.bounds.size.width;
        CGFloat h = self.bounds.size.height;
        
        CGFloat radius = MIN(w, h) / 2;
        
        UIBezierPath * cyclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(w / 2, h / 2)
                                                                  radius:radius
                                                              startAngle:DEGREES_TO_RADIANS(-90)
                                                                endAngle:DEGREES_TO_RADIANS(270)
                                                               clockwise:YES];
        //轨迹
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.frame           = self.bounds;
        _trackLayer.fillColor       = nil;
        _trackLayer.path            = cyclePath.CGPath;
        _trackLayer.strokeColor     = rgba(241, 241, 241, 1).CGColor;
        _trackLayer.lineWidth       = 2.0f;
        _trackLayer.strokeStart     = 0;
        _trackLayer.strokeEnd       = 1;
        _trackLayer.backgroundColor = [UIColor clearColor].CGColor;
        
        //进度
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame        = self.bounds;
        _progressLayer.fillColor    = nil;
        _progressLayer.path         = cyclePath.CGPath;
        _progressLayer.strokeColor  = rgba(45, 155, 248, 1).CGColor;
        _progressLayer.lineWidth    = 2.0f;
        _progressLayer.strokeStart  = 0;
        _progressLayer.strokeEnd    = 0;
        
        //文案
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.frame = self.bounds;
        _progressLabel.textColor = [UIColor orangeColor];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = [UIFont systemFontOfSize:20.0f];
        
        [self.layer addSublayer:_trackLayer];
        [self.layer addSublayer:_progressLayer];
        [self addSubview:_progressLabel];

        _animateDuration = 1.0f;
        
        [self resetCyleProgress];
    }
    return self;
}

- (void)resetCyleProgress
{
    _progress = 0;
    _progressLabel.text = @"";
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
}

- (void)setCycleProgress:(NSInteger)progress animated:(BOOL)animated
{
    [_progressLayer removeAllAnimations];
    
    if (progress < 0)
    {
        progress = 0;
    }
    if (progress > 100)
    {
        progress = 100;
    }
    _progress = progress;
    if (animated)
    {
        if (!_customText.length && _isTextAnimatable)
        {
            [[NSTimer scheduledTimerWithTimeInterval:0.015f
                                              target:self
                                            selector:@selector(updateProgress:)
                                            userInfo:nil
                                             repeats:YES] fire];
        }
        else if (_customText.length)
        {
            _progressLabel.text = _customText;
        }
        else
        {
            _progressLabel.attributedText = [self getFormattedProgressStr:_progress];
        }
        CABasicAnimation * animation  = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration            = _animateDuration;
        animation.fromValue           = 0;
        animation.toValue             = [NSNumber numberWithFloat:(_progress / 100.0f)];
        animation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.fillMode            = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        
        [_progressLayer addAnimation:animation forKey:@"KCycleAnimation"];
    }
    else
    {
        if (!_customText.length)
        {
            _progressLabel.attributedText = [self getFormattedProgressStr:_progress];
        }
        else
        {
            _progressLabel.text = _customText;
        }
        _progressLayer.strokeEnd = progress / 100.0f;
    }
}

- (NSAttributedString *)getFormattedProgressStr:(NSInteger)progress
{
    NSMutableAttributedString * progressStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld%%", (long)progress]];
    [progressStr setAttributes:@{NSFontAttributeName:_perSymbolFont ? _perSymbolFont : _progressLabel.font}
                         range:NSMakeRange(progressStr.string.length - 1, 1)];
    return progressStr;
}

- (void)updateProgress:(NSTimer *)timer
{
    static NSInteger count = 0;
    _progressLabel.attributedText = [self getFormattedProgressStr:count++];
    if (count > _progress)
    {
        count = 0;
        [timer invalidate], timer = nil;
    }
}

-(void)setStrokenColor:(UIColor *)strokenColor
{
    _strokenColor = strokenColor;
    _progressLayer.strokeColor = strokenColor.CGColor;
}

- (void)setStrokenWidth:(CGFloat)strokenWidth
{
    _strokenWidth = strokenWidth;
    _trackLayer.lineWidth    = strokenWidth;
    _progressLayer.lineWidth = strokenWidth;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    _trackTintColor = trackTintColor;
    _trackLayer.strokeColor = trackTintColor.CGColor;
}

- (void)setCycleBackgroundColor:(UIColor *)cycleBackgroundColor
{
    _cycleBackgroundColor = cycleBackgroundColor;
    _trackLayer.backgroundColor = cycleBackgroundColor.CGColor;
}

- (void)setCustomText:(NSString *)customText
{
    _customText = customText;
}

@end
