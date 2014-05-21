//
//  PLWebImageLoader.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAX_NUMBER_OF_CACHED_IMAGES 50

@interface PLWebImageLoader : NSObject

// store the latest local cache paths to memory
// store latest cache data in memory instead of going to db
// max could be 50
@property(nonatomic, strong) NSMutableDictionary *cacheDict;
@property(nonatomic, strong) NSMutableArray *cacheUrls;

+ (PLWebImageLoader *)instance;
- (void)initData;

- (void)imageWithUrl:(NSString *)theImageUrl forceReload:(BOOL)forced completion:(void(^)(UIImage *image))handler;
- (NSString *)pathOfCacheWithURL:(NSString *)imageUrl;

@end
