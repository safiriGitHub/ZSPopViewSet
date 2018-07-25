//
//  PopFSCalendarView.m
//  CheFu365
//
//  Created by safiri on 2018/2/8.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "PopFSCalendarView.h"


@implementation PopFSCalendarView

- (instancetype)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4.0f;
        self.layer.masksToBounds = YES;
        [self createUI];
    }
    return self;
}
- (void)createUI {
    
    self.calendar.delegate = self;
    self.calendar.dataSource = self;
    [self addSubview:self.calendar];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    self.confirmButton = confirmBtn;
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    self.cancelButton = cancelBtn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat buttonWidth = self.frame.size.width/2;
    CGFloat buttonHeight = 55;
    CGFloat buttonY = self.frame.size.height - buttonHeight;
    self.confirmButton.frame = CGRectMake(buttonWidth, buttonY, buttonWidth, buttonHeight);
    self.cancelButton.frame = CGRectMake(0, buttonY, buttonWidth, buttonHeight);
    self.calendar.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - buttonHeight);
}

- (void)confirmButtonClick {
    if ([self.popCalendarDelegate respondsToSelector:@selector(confirmCanlendarSelectDate:)]) {
        [self.popCalendarDelegate confirmCanlendarSelectDate:self.selectedDate];
    }
}
- (void)cancelButtonClick {
    [self removeSelfAndBgViewFromSuperview];
}
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    self.selectedDate = date;
}
- (FSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] init];
    }
    return _calendar;
}

#pragma mark - <FSCalendarDataSource>

- (NSDate *)minimumDate {
    if (!_minimumDate) {
        _minimumDate = [NSDate date];
    }
    return _minimumDate;
}
- (NSDate *)maximumDate {
    if (!_maximumDate) {
        //最多预约30天
        _maximumDate = [NSDate dateWithTimeIntervalSinceNow:30*24*3600];
    }
    return _maximumDate;
}
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    return self.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return self.maximumDate;
}
@end
