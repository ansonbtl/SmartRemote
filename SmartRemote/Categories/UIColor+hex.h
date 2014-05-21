//
//  UIColor+hex.h
//  School
//
//  Created by Anson Li on 4/10/13.
//  Copyright (c) 2013 Anson Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (hex)

+ (UIColor *) colorWithHexString: (NSString *) hexString;
+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;

@end
