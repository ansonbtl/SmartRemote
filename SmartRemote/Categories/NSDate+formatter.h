//
//  NSDate+formatter.h
//  housepro
//
//  Created by Botang Li on 12-04-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (formatter)

- (NSString *)formatDateTime;

- (NSString *)formatShortDate;
- (NSString *)formatLongDate;

- (NSString *)formatFullDateTime;
- (NSString *)tokenFormat;
- (NSString *)formatTime;
- (NSString *)formatDate;
- (NSString *)formatLongMonthDate;
- (NSString *)formatDateWithYear;
- (NSString *)formatDateTimeWithFormat:(NSString *)formatString;
- (NSString *)formatDateLong;

- (NSDate *)dateOfNext30Min;
- (NSDate *)dateOfPrev30Min;
- (NSDate *)startDateOfWeek;
- (NSDate *)dateWithStartHour:(int)hour;

- (NSDate *)dateByAddingDay:(int)numberOfDays;
- (NSDate *)dateByAddingMonth:(int)numberOfMonths;

- (NSDate *)dateWithTimeOfDate:(NSDate *)date;

- (NSString *)formatTimeForRoute;
- (NSString *)simpleDateFormat;

- (NSDate *)gmtDate;
+ (NSDate *)dateWithGMTNumber:(NSNumber *)numb;

+ (NSDate *)dayBeforeYesterday;
+ (NSDate *)dayAfterTomorrow;
+ (NSDate *)yesterday;
+ (NSDate *)tomorrow;
+ (NSDate *)today;
+ (NSDate *)dateWithDateString:(NSString *)dateStr withFormat:(NSString *)format;

- (NSString *)stringWithWeekdayAndTime;
- (NSString *)stringWithDateInWord;
- (NSString *)stringWithShortDateInWord;
- (NSString *)stringWithDateInShortWord;
- (NSString *)stringWithWeekday;

- (long long)milliSecondsSince1970;
+ (NSDate *)dateWithMilliSeconds:(NSNumber *)number;

- (BOOL)isMorning;
- (BOOL)isAfternoon;
- (BOOL)isEvening;
- (BOOL)isNight;

+ (NSDate *)todayWithStartHour:(int)hour;

- (NSString *)formatInHours;
- (NSString *)formatInWeekDay;

- (int)dayOfWeek;
- (int)hour;
- (int)minute;
- (float)hourAndMinute;

- (BOOL)isToday;
- (BOOL)isSameDay:(NSDate *)date;

@end
