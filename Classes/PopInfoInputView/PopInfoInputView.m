//
//  PopInfoInputView.m
//  Weschool
//
//  Created by safiri on 15/6/30.
//  Copyright (c) 2015年 soullon. All rights reserved.
//

#define BtnConfirmTag            104
#define BtnCancelTag             105
#import "PopInfoInputView.h"
#import "Masonry.h"

@interface PopInfoInputView ()

@property (nonatomic ,strong) UIView *contentContainerView;

@end

@implementation PopInfoInputView
{
    //键盘
    BOOL isKeyBoardHide;
    CGRect originRect;
    CGFloat moveHeightSum;
    
}
- (instancetype)initWithSize:(CGSize)Size title:(NSString *)title placeholderString:(NSString *)placeholderString {
    self = [super initWithSize:Size];
    if (self) {
        _titleString = title;
        _placeholder = placeholderString;
        _keyboardType = UIKeyboardTypeDefault;
        _numberOfLines = 1;
        _isMustInputText = NO;
        moveHeightSum = 0;
        [self commonInit];
    }
    return self;
}

- (void)dealloc {
    [self removeKeyBoardObserver];
}

- (void)commonInit {
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentContainerView];
    [self addSubview:self.confirmButton];
    [self addSubview:self.cancelButton];
    
    //设置不同的UI元素及属性 以及约束
    UIView *superView = self;
    CGFloat padding = 15;
    CGFloat space = 5;
    CGFloat buttonHeight = 45;

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(space);
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.bottom.equalTo(self.contentContainerView.mas_top).offset(-space);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(self.titleLabel.mas_bottom).offset(space);
        make.bottom.equalTo(self.confirmButton.mas_top).offset(-padding);
        make.bottom.equalTo(self.cancelButton.mas_top).offset(-padding);
        make.left.equalTo(superView.mas_left).offset(padding);
        make.right.equalTo(superView.mas_right).offset(-padding);
    }];
    
    if (self.numberOfLines == 1) {
        [self.contentContainerView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentContainerView.mas_top).offset(space);
            make.leading.equalTo(self.contentContainerView.mas_leading).offset(padding);
            make.trailing.equalTo(self.contentContainerView.mas_trailing).offset(-padding);
            make.height.mas_equalTo(buttonHeight);
        }];
    }else {
        [self.contentContainerView addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentContainerView.mas_top).offset(space);
            make.leading.equalTo(self.contentContainerView.mas_leading).offset(padding);
            make.trailing.equalTo(self.contentContainerView.mas_trailing).offset(-padding);
            make.bottom.equalTo(self.contentContainerView.mas_bottom).offset(-space);
        }];
    }

    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentContainerView.mas_bottom).with.offset(padding);
        make.left.equalTo(superView.mas_left).with.offset(padding);
        make.right.greaterThanOrEqualTo(self.cancelButton.mas_left).with.offset(-30);
        make.bottom.equalTo(superView.mas_bottom).offset(-space);
        make.width.equalTo(self.cancelButton);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentContainerView.mas_bottom).offset(padding);
        make.left.greaterThanOrEqualTo(self.confirmButton.mas_right).offset(30);
        make.right.equalTo(superView.mas_right).offset(-padding);
        make.bottom.equalTo(superView.mas_bottom).offset(-space);
        make.width.equalTo(self.confirmButton);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    originRect = self.frame;
    [self addKeyBoardObserver];
}

#pragma mark - setters and getters
- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    self.titleLabel.text = titleString;
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    if (self.textView) {
        //self.textView
    }
    if (self.textField) {
        self.textField.placeholder = placeholder;
    }
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    _keyboardType = keyboardType;
    if (self.textView) {
        self.textView.keyboardType = keyboardType;
    }
    if (self.textField) {
        self.textField.keyboardType = keyboardType;
    }
}

- (void)setContentText:(NSString *)contentText {
    _contentText = contentText;
    if (self.textView) {
        self.textView.text = contentText;
    }
    if (self.textField) {
        self.textField.text = contentText;
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = self.titleString;
        _titleLabel.font = [UIFont systemFontOfSize:22];
    }
    return _titleLabel;
}

- (UIView *)contentContainerView {
    if (!_contentContainerView) {
        _contentContainerView = [[UIView alloc] init];
    }
    return _contentContainerView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = self.placeholder;
        _textField.keyboardType = self.keyboardType;
        _textField.text = self.contentText;
        _textField.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.textAlignment = NSTextAlignmentLeft;
    }
    return _textField;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        //_textView.placeholder = self.placeholder;
        _textView.text = self.contentText;
        _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textView.layer.borderWidth = 0.5f;
        _textView.layer.cornerRadius = 3.0f;
    }
    return _textView;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

#pragma mark - 键盘操作
- (void)addKeyBoardObserver {
    isKeyBoardHide = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleKeyboardWillShows:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleKeyboardWillHides:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)removeKeyBoardObserver {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)handleKeyboardWillShows:(NSNotification *)paramNotification {
    NSDictionary *userInfo = [paramNotification userInfo];
    NSNumber *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSNumber *animationDurationObject = [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *keyboardEndRectObject = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    NSUInteger animationCurve = [animationCurveObject integerValue];
    double animationDuration = [animationDurationObject doubleValue];
    CGRect keyboardEndRect = [keyboardEndRectObject CGRectValue];
    
    
    //开始一个动画,修改popView的位置
    [UIView beginAnimations:@"changePopViewFrame" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    //获得两个frame之间的交集
    CGRect intersectionOfKeyboardRectAndPopViewRect = CGRectIntersection(self.frame, keyboardEndRect);
    CGFloat intersectionHeight = intersectionOfKeyboardRectAndPopViewRect.size.height;
    //NSLog(@"%f",intersectionHeight);
    //只移动intersectionHeight只是让view与键盘之间没有缝隙
    CGFloat moveHeight = 30;
    self.frame = CGRectMake(originRect.origin.x, originRect.origin.y - intersectionHeight - moveHeight, originRect.size.width, originRect.size.height);
    [UIView commitAnimations];
}
- (void)handleKeyboardWillHides:(NSNotification *)paramNotification {
    NSDictionary *userInfo = [paramNotification userInfo];
    NSUInteger animationCurve  = [[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey]integerValue];
    double animationDuration = [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView beginAnimations:@"changeTableViewContentInset" context:nil];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    [UIView setAnimationDuration:animationDuration];
    self.frame = originRect;
    [UIView commitAnimations];
    isKeyBoardHide = YES;
}
#pragma mark - 按钮点击事件 手势点击事件 时间选择事件
- (void)confirmButtonClick {
    NSString *content = @"";
    if (self.numberOfLines == 1) {
        content = self.textField.text;
        [self.textField resignFirstResponder];
    }else {
        content = self.textView.text;
        [self.textView resignFirstResponder];
    }
    if ([self.infoInputViewDelegate respondsToSelector:@selector(popInfoInputViewConfirmWithContent:)]) {
        [self.infoInputViewDelegate popInfoInputViewConfirmWithContent:content];
    }
    
    [self removeSelfAndBgViewFromSuperview];
}
- (void)cancelButtonClick {
    if ([self.infoInputViewDelegate respondsToSelector:@selector(popInfoInputViewCancel)]) {
        [self.infoInputViewDelegate popInfoInputViewCancel];
    }
    [self removeSelfAndBgViewFromSuperview];
}

@end
