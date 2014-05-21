//
//  NSDate+formatter.m
//  housepro
//
//  Created by Botang Li on 12-04-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDate+formatter.h"

@implementation NSDate (formatter)

- (NSString *)formatDateTime {
	NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"MMM dd, hh:mm a"];
	
	return [formater stringFromDate:self];
}

- (NSString *)formatShortDate {
	NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"MM-dd"];
	
	return [formater stringFromDate:self];
}

- (NSString *)formatLongMonthDate {
	NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"MMM d"];
	
	return [formater stringFromDate:self];
}

- (NSString *)formatLongDate {
	NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"MMMM dd"];
	
	return [formater stringFromDate:self];
}

- (NSString *)formatDateWithYear {
	NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"MMM dd, yyyy"];
	
	return [formater stringFromDate:self];
}

- (NSString *)formatFullDateTime {
	NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
	return [formater stringFromDate:self];
}

- (NSString *)formatTime {
	NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"hh:mm a"];
	
	return [formater stringFromDate:self];
}

- (NSString *)formatDate {
	NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"yyyy-MM-dd"];
	
	return [formater stringFromDate:self];
}

- (NSString *)formatDateLong {
	NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"MMM dd, yyyy"];
	
	return [formater stringFromDate:self];
}

- (NSString *)formatDateTimeWithFormat:(NSString *)formatString {
	NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:formatString];
	
	return [formater stringFromDate:self];
}

- (NSDate *)gmtDate {
    NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:self];
    return [self dateByAddingTimeInterval:-timeZoneOffset];
}

- (NSString *)stringWithWeekday {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"eeee, MMM d"];
	
	return [formater stringFromDate:self];
}

- (NSString *)stringWithWeekdayAndTime {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"eeee hh:mm a"];
	
	return [formater stringFromDate:self];
}

+ (NSDate *)dateWithGMTNumber:(NSNumber *)numb {
    long long seconds = [numb longLongValue];
    double interval = seconds / 1000.0;
    
    NSDate *gmtDate = [NSDate dateWithTimeIntervalSince1970:interval];
    
    return gmtDate;
}

+ (NSDate *)dateWithMilliSeconds:(NSNumber *)number {
    long long milliseconds = [number longLongValue];
    double interval = milliseconds / 1000.0;
    
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

- (long long)milliSecondsSince1970 {
    NSTimeInterval interval = [self timeIntervalSince1970];
    
    return interval * 1000;
}

- (NSString *)formatTimeForRoute {
    if ([self timeIntervalSinceDate:[NSDate tomorrow]] < 0)
        return [self formatTime];
    else if ([self timeIntervalSinceDate:[NSDate dayAfterTomorrow]] < 0)
        return [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Tomorrow", nil), [self formatTime]];
    else
        return [self formatDateTime];
}

- (NSString *)tokenFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"yyyy-M-d"];
	
	return [formater stringFromDate:self];
}

- (NSString *)simpleDateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"MM-dd-yyyy"];
	
	return [formater stringFromDate:self];
}

- (NSDate *)dateOfNext30Min {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    [comps setSecond:0];
    
    int hour = comps.hour;
    int min = comps.minute;
    
    if (hour == 23 && min >= 29) {
        [comps setHour:0];
        [comps setMinute:0];
        [comps setDay:comps.day + 1];
    }
    else if (min >= 29) {
        [comps setHour:comps.hour + 1];
        [comps setMinute:0];
    }
    else {
        [comps setMinute:29];
    }

    return [calendar dateFromComponents:comps]; 
}

- (NSDate *)dateWithTimeOfDate:(NSDate *)date {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    NSDateComponents *comps2 = [calendar components:unitFlags fromDate:date];
    [comps setSecond:comps2.second];
    [comps setMinute:comps2.minute];
    [comps setHour:comps2.hour];
    
    return [calendar dateFromComponents:comps];
}

- (NSDate *)dateOfPrev30Min {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    [comps setSecond:0];
    
    int min = comps.minute;
    
    if (min > 29) {
        [comps setMinute:29];
    }
    else {
        [comps setMinute:0];
    }
    
    return [calendar dateFromComponents:comps]; 
}

- (NSString *)stringWithDateInWord {
	unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
	[comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *suppliedDate = [calendar dateFromComponents:comps];
	
	// today
	comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	[comps setDay:[comps day]];
	
	NSDate *referenceDate = [calendar dateFromComponents:comps];
	
	// yesterday
	comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	[comps setDay:[comps day] - 1];
	
	NSDate *referenceDate2 = [calendar dateFromComponents:comps];
    
    // tomorrow
	comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	[comps setDay:[comps day] + 1];
    
    NSDate *referenceDate3 = [calendar dateFromComponents:comps];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSString *dateString;
	if ([suppliedDate compare:referenceDate] == NSOrderedSame)
		[formatter setDateFormat:@"'Today' h:mm a"];
	else if ([suppliedDate compare:referenceDate2] == NSOrderedSame)
		[formatter setDateFormat:@"'Yesterday' h:mm a"];
    else if ([suppliedDate compare:referenceDate3] == NSOrderedSame)
		[formatter setDateFormat:@"'Tomorrow' h:mm a"];
	else
		[formatter setDateFormat:@"MMM d h:mm a"];
	
	dateString = [formatter stringFromDate:self];
	
	return dateString;
}

- (NSString *)stringWithShortDateInWord {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
	[comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *suppliedDate = [calendar dateFromComponents:comps];
	
	// today
	comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	[comps setDay:[comps day]];
	
	NSDate *referenceDate = [calendar dateFromComponents:comps];
	
	// yesterday
	comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	[comps setDay:[comps day] - 1];
	
	NSDate *referenceDate2 = [calendar dateFromComponents:comps];
    
    // tomorrow
	comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	[comps setDay:[comps day] + 1];
    
    NSDate *referenceDate3 = [calendar dateFromComponents:comps];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSString *dateString;
	if ([suppliedDate compare:referenceDate] == NSOrderedSame)
		[formatter setDateFormat:@"'Today'"];
	else if ([suppliedDate compare:referenceDate2] == NSOrderedSame)
		[formatter setDateFormat:@"'Yesterday'"];
    else if ([suppliedDate compare:referenceDate3] == NSOrderedSame)
		[formatter setDateFormat:@"'Tomorrow'"];
	else
		[formatter setDateFormat:@"MMM d"];
	
	dateString = [formatter stringFromDate:self];
	
	return dateString;
}

- (NSString *)stringWithDateInShortWord {
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self];
    NSDate *yesterday = [NSDate yesterday];
    NSDate *today = [NSDate today];
    
    if (interval < 0) return [self stringWithDateInWord];
    else if (interval < 60) return @"A moment ago";
    else if (interval < 60*60) return [NSString stringWithFormat:@"%d mins ago", (int)interval/60];
    else if (interval < 24*60*60) {
        if ([self timeIntervalSinceDate:yesterday] > 0 && [self timeIntervalSinceDate:today] < 0) return @"Yesterday";
        else return [NSString stringWithFormat:@"%d hours ago", (int)interval/(60*60)];
    }
    else {
        if ([self timeIntervalSinceDate:yesterday] > 0 && [self timeIntervalSinceDate:today] < 0) return @"Yesterday";
        else if (interval < 60*60*24*4) return [NSString stringWithFormat:@"%d days ago", (int)interval/(60*60*24)];
        else return [self stringWithShortDateInWord];
    }
}

+ (NSDate *)today {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
	NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	[comps setDay:[comps day]];
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *)tomorrow {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
	NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	[comps setDay:[comps day] + 1];
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *)yesterday {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	[comps setDay:[comps day] - 1];
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *)dayBeforeYesterday {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	[comps setDay:[comps day] - 2];
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *)dayAfterTomorrow {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	[comps setDay:[comps day] + 2];
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *)dateWithDateString:(NSString *)dateStr withFormat:(NSString *)format {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:format];
    
    return [formater dateFromString:dateStr];
}

- (BOOL)isMorning {
    unsigned unitFlags = NSHourCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    NSLog(@"hour: %d", comps.hour);
    
    if (comps.hour > 3 && comps.hour < 12) return YES;
    else return NO;
}

- (BOOL)isAfternoon {
    unsigned unitFlags = NSHourCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    
    if (comps.hour > 12 && comps.hour < 18) return YES;
    else return NO;
}

- (BOOL)isEvening {
    unsigned unitFlags = NSHourCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    NSLog(@"hour: %d", comps.hour);
    
    if (comps.hour > 18 && comps.hour < 21) return YES;
    else return NO;
}

- (BOOL)isNight {
    unsigned unitFlags = NSHourCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    
    if (comps.hour > 21 && comps.hour < 24) return YES;
    else if (comps.hour > 0 && comps.hour < 3) return YES;
    else return NO;
}

- (NSDate *)startDateOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *today = self;
    NSDate *beginningOfWeek = nil;
    [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek interval:NULL forDate: today];
    
    return beginningOfWeek;
}

- (NSDate *)dateByAddingDay:(int)numberOfDays {
    return [self dateByAddingTimeInterval:60*60*24 * numberOfDays];
}

- (NSDate *)dateByAddingMonth:(int)numberOfMonths {
    NSDateComponents* dateComponents = [[NSDateComponents alloc]init];
    [dateComponents setMonth:numberOfMonths];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* newDate = [calendar dateByAddingComponents:dateComponents toDate:self options:0];
    
    return newDate;
}

+ (NSDate *)todayWithStartHour:(int)hour {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
	[comps setHour:hour];
	[comps setMinute:0];
	[comps setSecond:0];
    
    return [calendar dateFromComponents:comps];
}

- (NSDate *)dateWithStartHour:(int)hour {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
	[comps setHour:hour];
	[comps setMinute:0];
	[comps setSecond:0];
    
    return [calendar dateFromComponents:comps];
}

- (NSString *)formatInHours {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"hh:mma"];
	
	return [formater stringFromDate:self];
}

- (NSString *)formatInWeekDay {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"eee"];
	
	return [formater stringFromDate:self];
}

- (int)dayOfWeek {
    unsigned unitFlags = NSWeekdayCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    
    return comps.weekday;
}

- (int)hour {
    unsigned unitFlags = NSHourCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    
    return comps.hour;
}

- (int)minute {
    unsigned unitFlags = NSMinuteCalendarUnit;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    
    return comps.minute;
}

- (float)hourAndMinute {
    float hour = (float)[self hour];
    float min = (float)[self minute];
    float rate = hour + min / 60.0;
    return rate;
}

- (BOOL)isToday {
    float isGreaterToday = [self timeIntervalSinceDate:[NSDate today]];
    float isLessTomorrow = [[NSDate tomorrow] timeIntervalSinceDate:self];
    return isGreaterToday >= 0 && isLessTomorrow > 0;
}

- (BOOL)isSameDay:(NSDate *)date {
    return [self timeIntervalSinceDate:date] == 0;
}

@end
