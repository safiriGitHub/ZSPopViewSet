//
//  ZSPopBaseView.h
//  ZSPopViewSet-master
//
//  Created by safiri on 2018/7/10.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 弹出视图背景样式
 
 - ShadowTypeNone: 无背景
 - ShadowTypeGray: 灰色背景
 - ShadowTypeEffect: 毛玻璃背景
 - ShadowTypeClear: 透明背景
 */
typedef NS_ENUM(NSUInteger, BgShadowType) {
    ShadowTypeNone,
    ShadowTypeGray,
    ShadowTypeEffect,
    ShadowTypeClear
};


/**
 视图弹出动画样式
 
 - ShowTypeTransformScale: 放大浮现
 - ShowTypeHeightGrow: 高度增加，类似从上到下移动
 */
typedef NS_ENUM(NSUInteger, ShowAnimationType) {
    ShowTypeTransformScale,
    ShowTypeHeightGrow
};


@protocol ZSPopBaseViewDelegate <NSObject>

@optional;

/**
 开始移除弹出视图和背景AOP
 */
- (void)removePopViewAndBgViewBegin;

/**
 完成移除弹出视图和背景AOP
 */
- (void)removePopViewAndBgViewFinish;

/**
 手势点击背景回调
 */
- (void)tapPopBgView;

/**
 手势点击弹出视图回调
 */
- (void)tapPopView;

@end

@interface ZSPopBaseView : UIView

/**
 delegate
 */
@property (nonatomic ,weak) id <ZSPopBaseViewDelegate>delegate;
/**
 视图弹出动画样式 默认：ShowTypeTransformScale
 */
@property (nonatomic ,assign) ShowAnimationType showAnimationType;
/**
 是否可以响应点击自己(ZSPopDetailView)的手势 默认NO
 */
@property (nonatomic ,assign) BOOL canResponseTapSelfView;
/**
 是否点击自己(ZSPopDetailView)后隐藏消失 默认NO
 相当于调用 - (void)removeSelfAndBgViewFromSuperview
 */
@property (nonatomic ,assign) BOOL canRemoveSelfByTapSelfView;

/**
 调整自己的Frame字段
 */
@property (nonatomic ,assign) CGRect adjustFrame;

/**
 弹出视图背景样式
 */
@property (nonatomic ,assign) BgShadowType bgShadowType;

/**
 ShadowTypeGray 和 ShadowTypeClear 模式下背景View
 */
@property (nonatomic ,strong) UIView *grayBackgroundView;
/**
 ShadowTypeGray 模式下 grayBackgroundView 的透明度 ,默认0.35f
 */
@property (nonatomic ,assign) CGFloat grayBackgroundAlpha;
/**
 ShadowTypeEffect 模式下毛玻璃背景View
 */
@property (nonatomic ,strong) UIVisualEffectView *effectBackgroundView;
/**
 点击bgView是否自动隐藏，默认YES
 */
@property (nonatomic ,assign) BOOL tapBgViewAutoHide;


// MARK: Show


/**
 调用弹出展示
 
 @param containerView 容器View，指明展示到这个View
 @param waitDuration 弹出动画时间
 @param block 弹出完成回调
 */
- (void)showInView:(UIView *)containerView
          duration:(CGFloat)waitDuration
        completion:(void (^)(void))block;

- (void)showInView:(UIView *)containerView
     centerAtPoint:(CGPoint)centerPosition
          duration:(CGFloat)waitDuration
        completion:(void (^)(void))block;

- (void)showInView:(UIView *)containerView
          position:(CGPoint)position
          duration:(CGFloat)waitDuration
        completion:(void (^)(void))block;

// MARK: init
- (instancetype)initWithSize:(CGSize)size;

// MARK: remove
- (void)removeSelfAndBgViewFromSuperview;


@end
