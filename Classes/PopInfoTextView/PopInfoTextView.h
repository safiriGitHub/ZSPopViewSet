//
//  PopInfoTextView.h
//  CheFu365
//
//  Created by safiri on 2018/3/22.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSPopBaseView.h"

@interface PopInfoTextView : ZSPopBaseView


/**
 内容label
 */
@property (nonatomic ,strong) UILabel *contentLabel;

/**
 内容edge
 */
@property (nonatomic ,assign) UIEdgeInsets contentEdge;

/**
 内容string
 */
@property (nonatomic ,copy) NSString *contentString;


/**
 初始化

 @param size 大小
 @param contentString 内容
 @return self
 */
- (instancetype)initWithSize:(CGSize)size andContent:(NSString *)contentString;

@end
