//
//  NSManagedObject+dictionary.h
//  BabyBook
//
//  Created by Anson Li on 10/31/13.
//  Copyright (c) 2013 Anson Li. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (dictionary)

- (NSDictionary *)dictionary;
- (NSNumber *)deletedValue;
- (BOOL)isExculdedAttribute:(NSString *)attribute;

@end
