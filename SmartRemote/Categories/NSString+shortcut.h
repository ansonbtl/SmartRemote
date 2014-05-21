//
//  NSString+shortcut.h
//  housepro
//
//  Created by Botang Li on 12-04-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@interface NSString (shortcut)

- (NSString *)urlEncode;
- (BOOL)containsSubstring:(NSString *)string;
- (NSString *)stringWithCurrencyFormat;
- (NSString *)md5;

- (NSDate *)dateWithFormatString:(NSString *)format;
- (NSDate *)dateWithFormatString:(NSString *)format withTimeZone:(NSString *)zone;

- (NSString *)stringByTrimmingLeadingWhitespace;
- (NSString *)stringByTrimmingEndingWhitespace;
- (NSString *)stringByTrimmingLeadingAndEndingWhitespace;

- (int)intValueWithStringScan;
- (NSString *)flatternHTML;

- (BOOL)isNumberOnly;
- (int)lengthOfCharacters;
- (BOOL)isValidEmail;

@end
