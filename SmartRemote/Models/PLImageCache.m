//
//  PLImageCache.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLImageCache.h"
#import "PLDataManager.h"

@implementation PLImageCache

@dynamic url;
@dynamic createdAt;
@dynamic path;

+ (PLImageCache *)newImageCache {
    PLImageCache *cache = [NSEntityDescription insertNewObjectForEntityForName:@"ImageCache" inManagedObjectContext:[PLDataManager instance].dataContext];
    cache.createdAt = [NSDate date];
    
    return cache;
}

@end
