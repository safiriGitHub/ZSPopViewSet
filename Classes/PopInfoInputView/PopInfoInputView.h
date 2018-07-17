//
//  PopInfoInputView.h
//  Weschool
//  弹出填写信息的View
//  Created by safiri on 15/6/30.
//  Copyright (c) 2015年 soullon. All rights reserved.
//


#import "ZSPopBaseView.h"

@protocol PopInfoInputViewDelegate <NSObject>

@required

/**
 点击确定按钮回调输入的内容并隐藏

 @param contentString 输入的内容
 */
- (void)popInfoInputViewConfirmWithContent:(NSString *)contentString;

/**
 点击取消按钮回调并隐藏
 */
- (void)popInfoInputViewCancel;

@end

@interface PopInfoInputView : ZSPopBaseView


/**
 标题label
 */
@property (nonatomic ,strong) UILabel *titleLabel;
/**
 标题string
 */
@property (nonatomic ,strong) NSString *titleString;


/**
 输入框textField
 */
@property (nonatomic ,strong) UITextField *textField;
/**
 输入框textView
 */
@property (nonatomic ,strong) UITextView *textView;
/**
 是否强制文本框输入内容,默认NO不强制输入
 */
@property (nonatomic, assign) BOOL isMustInputText;
/**
 textField or textView's placeHolder
 */
@property (nonatomic ,strong) NSString *placeholder;
/**
 textField or textView's keyboardType
 */
@property (nonatomic ,assign) UIKeyboardType keyboardType;
/**
 textField or textView's 内容
 */
@property (nonatomic, strong) NSString *contentText;
/**
 内容显示行数
 默认1->单行textField
 0->不限行textView
 其他->多行textView 未实现
 */
@property(nonatomic) NSInteger numberOfLines;

/**
 确认按钮
 */
@property (nonatomic ,strong) UIButton *confirmButton;
/**
 取消按钮
 */
@property (nonatomic ,strong) UIButton *cancelButton;

/**
 delegate
 */
@property (nonatomic ,weak) id <PopInfoInputViewDelegate>infoInputViewDelegate;


/**
 自定义初始化方法

 @param Size 大小size
 @param title 标题
 @param placeholderString textField or textView's placeHolder
 @return self
 */
- (instancetype)initWithSize:(CGSize)Size title:(NSString *)title placeholderString:(NSString *)placeholderString;

@end

