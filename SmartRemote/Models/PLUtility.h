//
//  PLUtility.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSString+shortcut.h"
#import "UIImage+loader.h"

#define PEEL_SERVER_HOST @"peelapp.zelfy.com"

#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define degreesToRadian(x) (M_PI * (x) / 180.0)

@interface PLUtility : NSObject

+ (NSString *)UUID;

+ (NSString *)docDirecotryPath:(NSString *)pathComponent;

+ (UIColor *)themeTitleColor;
+ (UIColor *)themeTextColor;
+ (UIColor *)themeLightBackgroundColor;

@end
