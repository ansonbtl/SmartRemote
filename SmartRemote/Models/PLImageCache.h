//
//  PLImageCache.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PLImageCache : NSManagedObject

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * path;

+ (PLImageCache *)newImageCache;

@end
