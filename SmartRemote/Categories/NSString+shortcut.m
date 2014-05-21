//
//  NSString+shortcut.m
//  housepro
//
//  Created by Botang Li on 12-04-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+shortcut.h"
@import Security;
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (shortcut)

- (NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}

- (NSString *)urlEncode {
	NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));
	return result;
}

- (BOOL)isNumberOnly {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]].length == 0;
}

- (int)lengthOfCharacters {
    NSString *subString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return subString.length;
}

- (BOOL)containsSubstring:(NSString *)string {
	NSRange range = [self rangeOfString:string];
	if (range.location == NSNotFound) 
		return NO;
	else 
		return YES;
}

- (NSString *)stringWithCurrencyFormat {
    float numValue = [self intValue];
    NSNumber *num = [NSNumber numberWithFloat:numValue];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setMinimumFractionDigits:0];
    [formatter setMaximumFractionDigits:0];
    [formatter setCurrencySymbol:@"$ "];
    
    return [formatter stringFromNumber:num];
    
}

- (NSDate *)dateWithFormatString:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter dateFromString:self];
}

- (NSDate *)dateWithFormatString:(NSString *)format withTimeZone:(NSString *)zone {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:zone];
    [formatter setDateFormat:format];
    [formatter setTimeZone:timeZone];
    
    return [formatter dateFromString:self];
}

- (NSString *)stringByTrimmingLeadingWhitespace {
    NSInteger i = 0;
	
    while (i < self.length && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[self characterAtIndex:i]]) {
        i++;
    }
    return [self substringFromIndex:i];
}

- (NSString *)stringByTrimmingLeadingAndEndingWhitespace {
    if (self.length > 0) {
        NSString *str = [self stringByTrimmingLeadingWhitespace];
        str = [str stringByTrimmingEndingWhitespace];
        
        return str;
    }
    return self;
}

- (NSString *)stringByTrimmingEndingWhitespace {
    NSInteger i = self.length - 1;
	
    while (i >= 0 && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[self characterAtIndex:i]]) {
        i--;
    }
    
    return i == self.length - 1 ? self : [self substringToIndex:i + 1];
}

- (int)intValueWithStringScan {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    int num = -1;
    [scanner scanInt:&num];
    
    return num;
}

- (NSString *)flatternHTML {
    NSScanner *theScanner;
    NSString *text = nil;
    
    NSString *content = [self stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    theScanner = [NSScanner scannerWithString:content];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        content = [content stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }

    NSString *result = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return result;
}

- (BOOL)isValidEmail {
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *emailRegex = stricterFilterString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

@end
