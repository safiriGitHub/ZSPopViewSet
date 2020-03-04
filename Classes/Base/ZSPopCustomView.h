//
//  ZSPopCustomView.h
//  CheFu365
//
//  Created by safiri on 2018/3/9.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSPopBaseView.h"

@interface ZSPopCustomView : ZSPopBaseView

///整体背景颜色，也为梯度开始颜色 默认白色
@property (nonatomic ,strong) UIColor *tintColor;
///内容容器View
@property (nonatomic ,strong) UIView *contentView;
///圆角
@property (nonatomic ,assign) CGFloat cornerRadius;
///动画时间
@property (nonatomic ,assign) CGFloat animationDuration;

///是否展示箭头 默认不展示
@property (nonatomic ,assign) BOOL showArrow;
///箭头大小 默认10
@property (nonatomic ,assign) CGFloat kArrowSize;
///自定义View
@property (nonatomic ,strong) UIView *customView;

///梯度结束颜色
@property (nonatomic ,strong) UIColor *gradientEndColor;
///是否使用梯度颜色
@property (nonatomic ,assign) BOOL useGradientColor;
///调整x方向位置 正数右移
@property (nonatomic, assign) CGFloat adjsutXPosition;
///调整y方向位置 正数下移
@property (nonatomic, assign) CGFloat adjsutYPosition;

///用在有箭头的情况 showArrow = YES
- (void)showCustomViewInView:(UIView *)view
                    fromRect:(CGRect)rect
                  completion:(void (^)(void))block;
///用在无箭头的情况 point指定位置
- (void)showCustomViewInView:(UIView *)view
                 andPosition:(CGPoint)point
                  completion:(void (^)(void))block;
///用在无箭头的情况 展示在中心位置
- (void)showCustomViewCenterInView:(UIView *)view
                        completion:(void (^)(void))block;
@end
