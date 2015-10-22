//
//  GJCycleProgressView.h
//  GJB4iPhone
//
//  Created by 查震旺 on 15-9-16.
//  Copyright (c) 2015年 zhenWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJCycleProgressView : UIView

/**
 *  设置圆形进度
 *
 *  @param progress 当前进度, 0 ~ 100
 *  @param animated 是否加载动画
 */
- (void)setCycleProgress:(NSInteger)progress animated:(BOOL)animated;

/**
 *  动画时间
 */
@property (nonatomic, assign) CGFloat animateDuration;

/**
 *  文案是否动画
 */
@property (nonatomic, assign) BOOL isTextAnimatable;

/**
 *  圆弧颜色
 */
@property (nonatomic, retain) UIColor * strokenColor;

/**
 *  轨迹颜色
 */
@property (nonatomic, retain) UIColor * trackTintColor;

/**
 *  圆形背景颜色
 */
@property (nonatomic, retain) UIColor * cycleBackgroundColor;

/**
 *  圆弧宽度
 */
@property (nonatomic, assign) CGFloat strokenWidth;

/**
 *  进度信息显示视图
 */
@property (nonatomic, retain, readonly) UILabel * progressLabel;

/**
 *  自定义文字
 */
@property (nonatomic, copy) NSString * customText;

/**
 *  百分号的字体
 */
@property (nonatomic, retain) UIFont * perSymbolFont;

@end
