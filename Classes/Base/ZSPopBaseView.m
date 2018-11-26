//
//  ZSPopBaseView.m
//  ZSPopViewSet-master
//
//  Created by safiri on 2018/7/10.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSPopBaseView.h"

#define GrayBGViewTag 201
#define EffectBGViewTag 202

@interface ZSPopBaseView ()<CAAnimationDelegate>

@property (nonatomic ,copy) void (^animationCompletion)(void);
@property (nonatomic ,assign) CGFloat animationDuration;
@property (nonatomic ,assign) CGSize originSize;

@end

@implementation ZSPopBaseView

- (instancetype)initWithSize:(CGSize)size{
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    return [self initWithFrame:frame];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _originSize = frame.size;
        _adjustFrame = frame;
        _tapBgViewAutoHide = YES;
        _grayBackgroundAlpha = 0.35f;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
#pragma mark - show

- (void)showInView:(UIView *)containerView
          duration:(CGFloat)waitDuration
        completion:(void (^)(void))block {
    
    if (self.bgShadowType == ShadowTypeGray ||
        self.bgShadowType == ShadowTypeClear) {
        _grayBackgroundView = [[UIView alloc] initWithFrame:containerView.bounds];
        _grayBackgroundView.tag = GrayBGViewTag;
        _grayBackgroundView.backgroundColor = [UIColor lightGrayColor];
        _grayBackgroundView.alpha = self.grayBackgroundAlpha;
        if (self.bgShadowType == ShadowTypeClear) {
            _grayBackgroundView.backgroundColor = [UIColor clearColor];
            _grayBackgroundView.alpha = 1;
        }
        [containerView addSubview:_grayBackgroundView];
        if (self.tapBgViewAutoHide) {
            _grayBackgroundView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGrayBgView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBgView)];
            [_grayBackgroundView addGestureRecognizer:tapGrayBgView];
        }
    } else if (self.bgShadowType == ShadowTypeEffect) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        if (@available(iOS 10.0, *)) {
            effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
        }
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = containerView.bounds;
        effectView.tag = EffectBGViewTag;
        [containerView addSubview:effectView];
        if (self.tapBgViewAutoHide) {
            effectView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapEffectBgView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBgView)];
            [effectView addGestureRecognizer:tapEffectBgView];
        }
        self.effectBackgroundView = effectView;
    }
    [containerView addSubview:self];
    [containerView bringSubviewToFront:self];
    
    //animation
    self.animationCompletion = block;
    self.animationDuration = waitDuration;
    if (self.showAnimationType == ShowTypeTransformScale) {
        CABasicAnimation *forwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        forwardAnimation.duration = self.animationDuration;
        forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.7f :0.6f :0.85f];
        forwardAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        forwardAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.animations = [NSArray arrayWithObjects:forwardAnimation, nil];
        animationGroup.delegate = self;
        animationGroup.duration = forwardAnimation.duration;
        animationGroup.removedOnCompletion = NO;
        animationGroup.fillMode = kCAFillModeForwards;
        [UIView animateWithDuration:animationGroup.duration
                              delay:0.0
                            options:0
                         animations:^{
                             [self.layer addAnimation:animationGroup forKey:@"AnimationKeyPop"];
                         }
                         completion:^(BOOL finished) {
                             if (self.animationCompletion) {
                                 self.animationCompletion();
                             }
                         }];
    }else if (self.showAnimationType == ShowTypeHeightGrow) {
        CGRect toFrame = self.adjustFrame;
        self.frame = CGRectMake(toFrame.origin.x, toFrame.origin.y, toFrame.size.width, 0);
        [UIView animateWithDuration:self.animationDuration
                              delay:0.0
                            options:0
                         animations:^{
                             self.frame = toFrame;
                         }
                         completion:^(BOOL finished) {
                             if (self.animationCompletion) {
                                 self.animationCompletion();
                             }
                         }];
    }
}
- (void)showInView:(UIView *)containerView
     centerAtPoint:(CGPoint)centerPosition
          duration:(CGFloat)waitDuration
        completion:(void (^)(void))block {
    self.center = centerPosition; //指定中心位置
    [self showInView:containerView duration:waitDuration completion:block];
}
- (void)showInView:(UIView *)containerView
          position:(CGPoint)position
          duration:(CGFloat)waitDuration
        completion:(void (^)(void))block {
    CGRect frame = self.adjustFrame;
    frame.origin.x = position.x;
    frame.origin.y = position.y;
    self.frame = frame;
    self.adjustFrame = frame;
    [self showInView:containerView duration:waitDuration completion:block];
}

#pragma mark - actions gestures

- (void)tapSelfView {
    if (self.canResponseTapSelfView) {
        if ([self.delegate respondsToSelector:@selector(tapPopView)]) {
            [self.delegate tapPopView];
        }
        if (self.canRemoveSelfByTapSelfView) {
            [self removeSelfAndBgViewFromSuperview];
        }
    }
}

- (void)tapBgView {
    if ([self.delegate respondsToSelector:@selector(tapPopBgView)]) {
        [self.delegate tapPopBgView];
    }
    [self removeSelfAndBgViewFromSuperview];
}


- (void)removeSelfAndBgViewFromSuperview {
    
    if (_grayBackgroundView) [_grayBackgroundView removeFromSuperview];
    if (self.effectBackgroundView) [self.effectBackgroundView removeFromSuperview];
    if (self.showAnimationType == ShowTypeHeightGrow) {
        if ([self.delegate respondsToSelector:@selector(removePopViewAndBgViewBegin)]) {
            [self.delegate removePopViewAndBgViewBegin];
        }
        CGRect oriFrame = self.frame;
        [UIView animateWithDuration:self.animationDuration
                              delay:0.0
                            options:0
                         animations:^{
                             self.frame = CGRectMake(oriFrame.origin.x, oriFrame.origin.y, oriFrame.size.width, 0);
                         }
                         completion:^(BOOL finished) {
                             [self removeFromSuperview];
                             if ([self.delegate respondsToSelector:@selector(removePopViewAndBgViewFinish)]) {
                                 [self.delegate removePopViewAndBgViewFinish];
                             }
                         }];
    }else {
        if ([self.delegate respondsToSelector:@selector(removePopViewAndBgViewBegin)]) {
            [self.delegate removePopViewAndBgViewBegin];
        }
        [self removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(removePopViewAndBgViewFinish)]) {
            [self.delegate removePopViewAndBgViewFinish];
        }
    }
}

#pragma mark - getters and setters

- (void)setCanResponseTapSelfView:(BOOL)canResponseTapSelfView {
    _canResponseTapSelfView = canResponseTapSelfView;
    self.userInteractionEnabled = canResponseTapSelfView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelfView)];
        [self addGestureRecognizer:tap];
    });
}
- (void)setGrayBackgroundAlpha:(CGFloat)grayBackgroundAlpha {
    _grayBackgroundAlpha = grayBackgroundAlpha;
    self.grayBackgroundView.alpha = self.grayBackgroundAlpha;
}
@end
