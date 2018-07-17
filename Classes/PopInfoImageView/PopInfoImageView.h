//
//  PopInfoImageView.h
//  Weschool
//
//  Created by safiri on 15/8/18.
//  Copyright (c) 2015年 soullon. All rights reserved.
//

#import "ZSPopBaseView.h"

@protocol PopShowImageViewDelegate <NSObject>

@optional
/// 长按手势开始回调
- (void)longPressGestureBegan;

@end

@interface PopInfoImageView : ZSPopBaseView

/**
 图片弹出前初始frame
 */
@property (nonatomic, assign) CGRect originFrame;

/**
 需要弹出展示的image
 */
@property (nonatomic ,strong) UIImage *showImage;

/**
 imageView
 */
@property (nonatomic ,strong) UIImageView *showImageView;


/**
 是否开启长按手势
 */
@property (nonatomic ,assign) BOOL canLongPressGesture;

//todo:可添加长按保存图片等功能

/**
 delegate
 */
@property (nonatomic ,weak) id <PopShowImageViewDelegate>showImageViewDelegate;


/**
 关闭ImageView时是否有回到原始frame的动画
 */
@property (nonatomic ,assign) BOOL isCloseImageViewToOriginFrame;

/**
 初始化

 @param size 大小
 @param showImage 展示图片
 @return self
 */
- (instancetype)initWithSize:(CGSize)size andShowImage:(UIImage *)showImage;

@end
