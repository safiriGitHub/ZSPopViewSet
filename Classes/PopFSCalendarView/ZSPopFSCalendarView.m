////
////  ZSPopFSCalendarView.m
////  CheFu365
////
////  Created by safiri on 2018/2/8.
////  Copyright © 2018年 safiri. All rights reserved.
////
//
//#import "ZSPopFSCalendarView.h"
//
//
//@implementation ZSPopFSCalendarView
//
//- (instancetype)initWithSize:(CGSize)size {
//    self = [super initWithSize:size];
//    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
//        self.layer.cornerRadius = 4.0f;
//        self.layer.masksToBounds = YES;
//        [self createUI];
//    }
//    return self;
//}
//- (void)createUI {
//    UIView *grayBgBiew = self.grayBgView;
//    grayBgBiew.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//    grayBgBiew.alpha = 1;
//    
//    self.calendar.delegate = self;
//    self.calendar.dataSource = self;
//    
//    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [confirmBtn setTitle:@"确 定" forState:UIControlStateNormal];
//    [confirmBtn setTitleColor:[UIColor appMainColor] forState:UIControlStateNormal];
//    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:confirmBtn];
//    
//    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
//    [cancelBtn setTitleColor:[UIColor appMainColor] forState:UIControlStateNormal];
//    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:cancelBtn];
//    
//    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(cancelBtn.mas_right);
//        make.trailing.equalTo(self.mas_trailing);
//        make.bottom.equalTo(self.mas_bottom);
//        make.height.mas_equalTo(45);
//        make.width.equalTo(cancelBtn.mas_width);
//    }];
//    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.mas_leading);
//        make.right.equalTo(confirmBtn.mas_left);
//        make.bottom.equalTo(self.mas_bottom);
//        make.height.mas_equalTo(45);
//        make.width.equalTo(confirmBtn.mas_width);
//    }];
//}
//- (void)confirm {
//    if (self.confirmSubject) {
//        [self.confirmSubject sendNext:RACTuplePack(self.showDate,self.paramDate)];
//    }
//}
//- (void)cancel {
//    [self removeSelfAndBgViewFromSuperview];
//}
//- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
//    self.paramDate = [date stringWithFormat:@"yyyy-MM-dd"];
//    self.showDate = [date stringWithFormat:@"MM-dd"];
//    
//}
//- (FSCalendar *)calendar {
//    if (!_calendar) {
//        _calendar = [[FSCalendar alloc] init];
//        [self addSubview:_calendar];
//        [_calendar mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
//        }];
//        
//        _calendar.appearance.todayColor = [UIColor appDesignRedColor];
//        _calendar.appearance.todaySelectionColor = [UIColor appMainColor];
//        _calendar.appearance.titleSelectionColor = [UIColor appMainColor];
//        _calendar.appearance.weekdayTextColor = [UIColor appMainColor];
//        _calendar.appearance.headerTitleColor = [UIColor appMainColor];
//        _calendar.appearance.titleSelectionColor = [UIColor whiteColor];
//        _calendar.appearance.subtitleDefaultColor = [UIColor brownColor];
//        _calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
//    }
//    return _calendar;
//}
//
//#pragma mark - <FSCalendarDataSource>
//
//- (NSDate *)minimumDate {
//    if (!_minimumDate) {
//        _minimumDate = [NSDate date];
//    }
//    return _minimumDate;
//}
//- (NSDate *)maximumDate {
//    if (!_maximumDate) {
//        //最多预约30天
//        _maximumDate = [NSDate dateWithTimeIntervalSinceNow:30*24*3600];
//    }
//    return _maximumDate;
//}
//- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
//    return self.minimumDate;
//}
//
//- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
//    return self.maximumDate;
//}
//@end
