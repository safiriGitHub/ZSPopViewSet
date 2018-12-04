//
//  ZSPopCustomView.m
//  CheFu365
//
//  Created by safiri on 2018/3/9.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSPopCustomView.h"

typedef enum {
    
    KxMenuViewArrowDirectionNone,
    KxMenuViewArrowDirectionUp,
    KxMenuViewArrowDirectionDown,
    KxMenuViewArrowDirectionLeft,
    KxMenuViewArrowDirectionRight,
    
} KxMenuViewArrowDirection;

@implementation ZSPopCustomView {
    KxMenuViewArrowDirection    _arrowDirection;
    CGFloat                     _arrowPosition;
}

- (instancetype)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        _tintColor = [UIColor whiteColor];
        _kArrowSize = 10.f;
        _animationDuration = 0.5;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - show
- (void)showCustomViewInView:(UIView *)view
                    fromRect:(CGRect)rect
                  completion:(void (^)(void))block {
    [self setupFrameInView:view fromRect:rect];
    [self showInView:view duration:self.animationDuration completion:block];
}
- (void)showCustomViewInView:(UIView *)view
                 andPosition:(CGPoint)point
                  completion:(void (^)(void))block {
    
    [self showInView:view position:point duration:self.animationDuration completion:block];
}
- (void)showCustomViewCenterInView:(UIView *)view
                        completion:(void (^)(void))block {
    
    [self showInView:view centerAtPoint:view.center duration:self.animationDuration completion:block];
}

#pragma mark - getters setters
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.autoresizingMask = UIViewAutoresizingNone;
        _contentView.backgroundColor = self.tintColor;
        _contentView.opaque = NO;
        [self addSubview:_contentView];
    }
    return _contentView;
}
- (void)setCustomView:(UIView *)customView {
    _customView = customView;
    self.contentView.frame = customView.frame;
    [self.contentView addSubview:_customView];
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

#pragma mark - arrow
- (void)setupFrameInView:(UIView *)view
                fromRect:(CGRect)fromRect {
    const CGSize contentSize = self.frame.size;
    
    const CGFloat outerWidth = view.bounds.size.width;
    const CGFloat outerHeight = view.bounds.size.height;
    
    const CGFloat rectX0 = fromRect.origin.x;
    const CGFloat rectX1 = fromRect.origin.x + fromRect.size.width;
    const CGFloat rectXM = fromRect.origin.x + fromRect.size.width * 0.5f;
    const CGFloat rectY0 = fromRect.origin.y;
    const CGFloat rectY1 = fromRect.origin.y + fromRect.size.height;
    const CGFloat rectYM = fromRect.origin.y + fromRect.size.height * 0.5f;
    
    const CGFloat widthPlusArrow = contentSize.width + self.kArrowSize;
    const CGFloat heightPlusArrow = contentSize.height + self.kArrowSize;
    const CGFloat widthHalf = contentSize.width * 0.5f;
    const CGFloat heightHalf = contentSize.height * 0.5f;
    
    const CGFloat kMargin = 5.f;
    
    if (heightPlusArrow < (outerHeight - rectY1)) {
        
        _arrowDirection = KxMenuViewArrowDirectionUp;
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY1
        };
        
        if (point.x < kMargin)
            point.x = kMargin;
        
        if ((point.x + contentSize.width + kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - kMargin;
        
        _arrowPosition = rectXM - point.x;
        //_arrowPosition = MAX(16, MIN(_arrowPosition, contentSize.width - 16));
        _contentView.frame = (CGRect){0, self.kArrowSize, contentSize};
        
        self.frame = (CGRect) {
            
            point,
            contentSize.width,
            contentSize.height + self.kArrowSize
        };
        
    } else if (heightPlusArrow < rectY0) {
        
        _arrowDirection = KxMenuViewArrowDirectionDown;
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY0 - heightPlusArrow
        };
        
        if (point.x < kMargin)
            point.x = kMargin;
        
        if ((point.x + contentSize.width + kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - kMargin;
        
        _arrowPosition = rectXM - point.x;
        _contentView.frame = (CGRect){CGPointZero, contentSize};
        
        self.frame = (CGRect) {
            
            point,
            contentSize.width,
            contentSize.height + self.kArrowSize
        };
        
    } else if (widthPlusArrow < (outerWidth - rectX1)) {
        
        _arrowDirection = KxMenuViewArrowDirectionLeft;
        CGPoint point = (CGPoint){
            rectX1,
            rectYM - heightHalf
        };
        
        if (point.y < kMargin)
            point.y = kMargin;
        
        if ((point.y + contentSize.height + kMargin) > outerHeight)
            point.y = outerHeight - contentSize.height - kMargin;
        
        _arrowPosition = rectYM - point.y;
        _contentView.frame = (CGRect){self.kArrowSize, 0, contentSize};
        
        self.frame = (CGRect) {
            
            point,
            contentSize.width + self.kArrowSize,
            contentSize.height
        };
        
    } else if (widthPlusArrow < rectX0) {
        
        _arrowDirection = KxMenuViewArrowDirectionRight;
        CGPoint point = (CGPoint){
            rectX0 - widthPlusArrow,
            rectYM - heightHalf
        };
        
        if (point.y < kMargin)
            point.y = kMargin;
        
        if ((point.y + contentSize.height + 5) > outerHeight)
            point.y = outerHeight - contentSize.height - kMargin;
        
        _arrowPosition = rectYM - point.y;
        _contentView.frame = (CGRect){CGPointZero, contentSize};
        
        self.frame = (CGRect) {
            
            point,
            contentSize.width  + self.kArrowSize,
            contentSize.height
        };
        
    } else {
        
        _arrowDirection = KxMenuViewArrowDirectionNone;
        
        self.frame = (CGRect) {
            
            (outerWidth - contentSize.width)   * 0.5f,
            (outerHeight - contentSize.height) * 0.5f,
            contentSize,
        };
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.showArrow) {
        [self drawBackground:self.bounds
                   inContext:UIGraphicsGetCurrentContext()];
    }
}
- (void)drawBackground:(CGRect)frame
             inContext:(CGContextRef) context {
    CGFloat R0 = 0.267, G0 = 0.303, B0 = 0.335;
    CGFloat R1 = 0.040, G1 = 0.040, B1 = 0.040;
    
    UIColor *tintColor = self.tintColor;
    if (tintColor) {
        CGFloat a;
        [tintColor getRed:&R0 green:&G0 blue:&B0 alpha:&a];
    }
    if (self.gradientEndColor) {
        CGFloat a;
        [self.gradientEndColor getRed:&R1 green:&G1 blue:&B1 alpha:&a];
    }
    
    CGFloat X0 = frame.origin.x;
    CGFloat X1 = frame.origin.x + frame.size.width;
    CGFloat Y0 = frame.origin.y;
    CGFloat Y1 = frame.origin.y + frame.size.height;
    
    // render arrow
    
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    
    // fix the issue with gap of arrow's base if on the edge
    const CGFloat kEmbedFix = 3.f;
    
    if (_arrowDirection == KxMenuViewArrowDirectionUp) {
        
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - self.kArrowSize;
        const CGFloat arrowX1 = arrowXM + self.kArrowSize;
        const CGFloat arrowY0 = Y0;
        const CGFloat arrowY1 = Y0 + self.kArrowSize + kEmbedFix;
        
        [arrowPath moveToPoint:    (CGPoint){arrowXM, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY0}];
        
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:1] set];
        Y0 += self.kArrowSize;
        
    } else if (_arrowDirection == KxMenuViewArrowDirectionDown) {
        
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - self.kArrowSize;
        const CGFloat arrowX1 = arrowXM + self.kArrowSize;
        const CGFloat arrowY0 = Y1 - self.kArrowSize - kEmbedFix;
        const CGFloat arrowY1 = Y1;
        
        [arrowPath moveToPoint:    (CGPoint){arrowXM, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY1}];
        
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:1] set];
        [[UIColor redColor] set];
        Y1 -= self.kArrowSize;
        
    } else if (_arrowDirection == KxMenuViewArrowDirectionLeft) {
        
        const CGFloat arrowYM = _arrowPosition;
        const CGFloat arrowX0 = X0;
        const CGFloat arrowX1 = X0 + self.kArrowSize + kEmbedFix;
        const CGFloat arrowY0 = arrowYM - self.kArrowSize;;
        const CGFloat arrowY1 = arrowYM + self.kArrowSize;
        
        [arrowPath moveToPoint:    (CGPoint){arrowX0, arrowYM}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowYM}];
        
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:1] set];
        X0 += self.kArrowSize;
        
    } else if (_arrowDirection == KxMenuViewArrowDirectionRight) {
        
        const CGFloat arrowYM = _arrowPosition;
        const CGFloat arrowX0 = X1;
        const CGFloat arrowX1 = X1 - self.kArrowSize - kEmbedFix;
        const CGFloat arrowY0 = arrowYM - self.kArrowSize;;
        const CGFloat arrowY1 = arrowYM + self.kArrowSize;
        
        [arrowPath moveToPoint:    (CGPoint){arrowX0, arrowYM}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowYM}];
        
        [[UIColor colorWithRed:R0 green:G0 blue:B0 alpha:1] set];
        X1 -= self.kArrowSize;
    }
    
    [arrowPath fill];
    
    if (self.useGradientColor) {
        // render body
        
        const CGRect bodyFrame = {X0, Y0, X1 - X0, Y1 - Y0};
        
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:bodyFrame
                                                              cornerRadius:8];
        
        const CGFloat locations[] = {0, 1};
        const CGFloat components[] = {
            R0, G0, B0, 1,
            R1, G1, B1, 1,
        };
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace,
                                                                     components,
                                                                     locations,
                                                                     sizeof(locations)/sizeof(locations[0]));
        CGColorSpaceRelease(colorSpace);
        
        
        [borderPath addClip];
        
        CGPoint start, end;
        
        if (_arrowDirection == KxMenuViewArrowDirectionLeft ||
            _arrowDirection == KxMenuViewArrowDirectionRight) {
            
            start = (CGPoint){X0, Y0};
            end = (CGPoint){X1, Y0};
            
        } else {
            
            start = (CGPoint){X0, Y0};
            end = (CGPoint){X0, Y1};
        }
        
        CGContextDrawLinearGradient(context, gradient, start, end, 0);
        
        CGGradientRelease(gradient);
    }
}
@end
