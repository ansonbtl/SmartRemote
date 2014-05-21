//
//  PLUtility.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLUtility.h"


@implementation PLUtility

+ (NSString *)UUID {
    NSUUID *uuid = [[NSUUID alloc] init];
    
    return [uuid UUIDString];
}

+ (NSString *)docDirecotryPath:(NSString *)pathComponent {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docPath = [NSString stringWithString:[paths objectAtIndex:0]];
	return [docPath stringByAppendingPathComponent:pathComponent];
}

+ (UIColor *)themeTitleColor {
    return UIColorFromRGB(0xfecd00);
}

+ (UIColor *)themeTextColor {
    return UIColorFromRGB(0x646465);
}

+ (UIColor *)themeLightBackgroundColor {
    return UIColorFromRGB(0xeeeeee);
}

@end
