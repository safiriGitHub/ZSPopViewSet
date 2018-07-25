//
//  PopFSCalendarView.h
//  CheFu365
//
//  Created by safiri on 2018/2/8.
//  Copyright © 2018年 safiri. All rights reserved.
//

#import "ZSPopBaseView.h"
#import "FSCalendar.h"

@protocol PopFSCalendarViewDelegate <NSObject>

/**
 点击确认按钮回调

 @param selectDate 回调返回已选日期
 */
- (void)confirmCanlendarSelectDate:(NSDate *)selectDate;

@end

/**
 自定义弹出日历控件 FSCalendar
 */
@interface PopFSCalendarView : ZSPopBaseView <FSCalendarDataSource,FSCalendarDelegate>

/**
 日历控件
 配置举例：
 _calendar.appearance.todayColor = [UIColor appDesignRedColor];
 _calendar.appearance.todaySelectionColor = [UIColor appMainColor];
 _calendar.appearance.titleSelectionColor = [UIColor appMainColor];
 _calendar.appearance.weekdayTextColor = [UIColor appMainColor];
 _calendar.appearance.headerTitleColor = [UIColor appMainColor];
 _calendar.appearance.titleSelectionColor = [UIColor whiteColor];
 _calendar.appearance.subtitleDefaultColor = [UIColor brownColor];
 _calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
 */
@property (nonatomic ,strong) FSCalendar *calendar;
@property (nonatomic ,strong) UIButton *confirmButton;
@property (nonatomic ,strong) UIButton *cancelButton;
@property (nonatomic ,weak) id <PopFSCalendarViewDelegate> popCalendarDelegate;

/// minimumDate
@property (nonatomic ,strong) NSDate *minimumDate;
/// maximumDate
@property (nonatomic ,strong) NSDate *maximumDate;

/**
 已选择的Date
 */
@property (nonatomic ,strong) NSDate *selectedDate;

@end
