//
//  PLWebImageLoader.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLWebImageLoader.h"
#import "PLDataManager.h"
#import "PLUtility.h"
#import "PLAppShared.h"
#import "PLImageCache.h"

@implementation PLWebImageLoader

+ (PLWebImageLoader *)instance {
    static PLWebImageLoader *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[PLWebImageLoader alloc] init];
        
        [instance initData];
    });
    return instance;
}

- (void)initData {
    self.cacheDict = [[NSMutableDictionary alloc] init];
    self.cacheUrls = [[NSMutableArray alloc] init];
}

- (void)imageWithUrl:(NSString *)theImageUrl forceReload:(BOOL)forced completion:(void(^)(UIImage *image))handler {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *imageUrl = [theImageUrl stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n\r"]];
        
        NSString *path = [self pathOfCacheWithURL:imageUrl];
        // reload from web
        if (forced || !path) {
            NSURL *url = [NSURL URLWithString:imageUrl];
            
            if (!url) {
                handler(nil);
            }
            else {
                // go to web
                NSURLRequest *req = [NSURLRequest requestWithURL:url];
                [NSURLConnection sendAsynchronousRequest:req queue:[PLAppShared instance].networkQueue completionHandler:^(NSURLResponse *resp, NSData *data, NSError *err){
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        handler(image);
                    });
                    
                    if (image) {
                        [self cacheAndStoreImage:image withUrl:imageUrl];
                    }
                }];
            }
        }
        else { // load from disk
            dispatch_async([PLAppShared instance].IOQueue, ^{
                NSString *filePath = [PLUtility docDirecotryPath:path];
                
                NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
                UIImage *image = [[UIImage alloc] initWithData:data];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(image);
                });
            });
        }
    });
}


// store image to disk
// and add record to db
- (void)cacheAndStoreImage:(UIImage *)image withUrl:(NSString *)url {
    dispatch_async([PLAppShared instance].IOQueue, ^{
        NSString *path = [self newImagePath];
        
        NSData *imageData = UIImagePNGRepresentation(image);
        
        NSString *filePath = [PLUtility docDirecotryPath:path];
        BOOL success = [imageData writeToFile:filePath atomically:NO];
        
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                PLImageCache *cache = [PLImageCache newImageCache];
                cache.path = path;
                cache.url = url;
                
                [[PLDataManager instance] saveData];
                
                // remove older cached urls from memory
                if (self.cacheUrls.count > MAX_NUMBER_OF_CACHED_IMAGES) {
                    NSString *oldUrl = [self.cacheUrls firstObject];
                    [self.cacheUrls removeObject:oldUrl];
                    [self.cacheDict removeObjectForKey:oldUrl];
                }
                
                // add new one in
                [self.cacheDict setObject:path forKey:url];
                [self.cacheUrls addObject:url];
            });
        }
    });
}

- (NSString *)pathOfCacheWithURL:(NSString *)imageUrl {
    // check latest
    NSString *path = self.cacheDict[imageUrl];
    if (path) return path;
    
    // go to database
    path = [[PLDataManager instance] pathOfImageCacheWithUrl:imageUrl];
    return path;
}

// folder structure
// may 1st = 05/01
// this folder structure is to avoid
// putting too many files into one folder
- (NSString *)newImagePath {
    NSString *dateString = [self stringWithMonthAndDate];
    
    // sample filename: "05/01/abcdss-dfdfd-sdfasdfa.png"
    NSString *filename = [NSString stringWithFormat:@"%@/%@.png", dateString, [PLUtility UUID]];
    
    return filename;
}

- (NSString *)stringWithMonthAndDate {
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/DD"];
    
    return [formatter stringFromDate:date];
}

@end
