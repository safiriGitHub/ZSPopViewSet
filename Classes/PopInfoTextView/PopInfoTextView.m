//
//  PopInfoTextView.m
//  CheFu365
//
//  Created by safiri on 2018/3/22.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "PopInfoTextView.h"

@implementation PopInfoTextView

- (instancetype)initWithSize:(CGSize)size andContent:(NSString *)contentString {
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _contentString = contentString;
        self.bgShadowType = ShadowTypeClear;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat edgeTop = self.contentEdge.top;
    CGFloat edgeBottom = self.contentEdge.bottom;
    CGFloat edgeLeft = self.contentEdge.left;
    CGFloat edgeRight = self.contentEdge.right;
    self.contentLabel.frame = CGRectMake(edgeLeft, edgeTop, self.frame.size.width-edgeLeft-edgeRight, self.frame.size.height-edgeTop-edgeBottom);
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.text = self.contentString;
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}
@end
