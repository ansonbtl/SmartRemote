//
//  NSManagedObject+dictionary.m
//  BabyBook
//
//  Created by Anson Li on 10/31/13.
//  Copyright (c) 2013 Anson Li. All rights reserved.
//

#import "NSManagedObject+dictionary.h"
#import "PLUtility.h"

@implementation NSManagedObject (dictionary)

/*- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSEntityDescription *entity = [self entity];
    NSDictionary *attributes = [entity attributesByName];
    for (NSString *attribute in attributes) {
        id value = [self valueForKey: attribute];
        if (value && ![self isExculdedAttribute:attribute]) {
            if ([value isKindOfClass:[NSDate class]]) {
                NSDate *aDate = (NSDate *)value;
                [dict setObject:[NSNumber numberWithLongLong:[aDate milliSecondsSince1970]] forKey:attribute];
            }
            else if ([attribute isEqualToString:@"deleted"]) {
                [dict setObject:[self deletedValue] forKey:attribute];
            }
            else {
                [dict setObject:value forKey:attribute];
            }
        }
    }
    
    return dict;
}*/

- (NSNumber *)deletedValue {
    return [NSNumber numberWithBool:NO];
}

- (BOOL)isExculdedAttribute:(NSString *)attribute {
    return NO;
}

@end
