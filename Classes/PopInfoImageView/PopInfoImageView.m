//
//  PopInfoImageView.m
//  Weschool
//
//  Created by safiri on 15/8/18.
//  Copyright (c) 2015年 soullon. All rights reserved.
//

#import "PopInfoImageView.h"

@interface PopInfoImageView () <UIActionSheetDelegate>

@end

@implementation PopInfoImageView
{
    UIView *grayBgBiew;
}
- (instancetype)initWithSize:(CGSize)size andShowImage:(UIImage *)showImage{
    self = [super initWithSize:size];
    if (self) {
        _showImage = showImage;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.showImageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  
}

- (UIImageView *)showImageView {
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] init];
        [_showImageView setContentMode:UIViewContentModeScaleToFill];
        [_showImageView setImage:self.showImage];
        [_showImageView setUserInteractionEnabled:YES];
        [self addSubview:_showImageView];
    }
    return _showImageView;
}

- (void)setCanLongPressGesture:(BOOL)canLongPressGesture {
    _canLongPressGesture = canLongPressGesture;
    self.showImageView.userInteractionEnabled = canLongPressGesture;
    if (canLongPressGesture) {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressImageView:)];
        [self.showImageView addGestureRecognizer:longPress];
    }
}

- (void)removeSelfAndBgViewFromSuperview {
    
    if (self.isCloseImageViewToOriginFrame) {
        [UIView animateWithDuration:0.35 animations:^{
            self.frame = self.originFrame;
            self.grayBackgroundAlpha = 0.1;
            self.effectBackgroundView.alpha = 0.1;
            self.showImageView.alpha = 0.25;
        } completion:^(BOOL finished) {
            self.showImageView.hidden = YES;
            [super removeSelfAndBgViewFromSuperview];
        }];
    }else {
        [super removeSelfAndBgViewFromSuperview];
    }
}

- (void)longPressImageView:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if ([self.showImageViewDelegate respondsToSelector:@selector(longPressGestureBegan)]) {
            [self.showImageViewDelegate longPressGestureBegan];
        }
    }
}


@end
