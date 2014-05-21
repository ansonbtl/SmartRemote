//
//  PLCloudManager.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLCloudManager.h"
#import "PLUtility.h"
#import "PLAppShared.h"
#import "JSONKit.h"

#import "PLLineUp.h"
#import "PLChannelLineUp.h"

@implementation PLCloudManager

+ (PLCloudManager *)instance {
    static PLCloudManager *instance;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        instance = [[PLCloudManager alloc] init];
    });
    
    return instance;
}

- (NSArray *)allCountries {
    NSString *path = [PLUtility docDirecotryPath:@"countries.js"];
    
    BOOL isDir;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && !isDir) {
        NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        return [content objectFromJSONString];
    }
    else {
        // go to web and download list
        NSString *urlString = [NSString stringWithFormat:@"http://countries-partners.epg.peel.com/countries/all"];
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:req queue:[PLAppShared instance].networkQueue completionHandler:^(NSURLResponse *resp, NSData *data, NSError *err){
            if (data) {
                [data writeToFile:path atomically:NO];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"didDownloadAllCountries" object:nil];
                });
            }
        }];
        
        return nil;
    }
}

// callback-based api
// return parameters:
// code: integer
//       1 everything okay
//       -1 if call failed
//       -9 call failed. network error
//
// lineups: array of lineup objects
- (void)lineUpsWithCountry:(NSString *)countryCode withZip:(NSString *)zipCode completion:(void(^)(int code, NSArray *lineups))handler {
    NSMutableString *urlString = [[NSMutableString alloc] initWithFormat:@"http://%@/epg/schedules/lineups/", PEEL_SERVER_HOST];
    
    [urlString appendFormat:@"%@?country=%@&sort=Asc&Split=Y", [zipCode urlEncode], [countryCode urlEncode]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[PLAppShared instance].networkQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *err) {
        if (!err && data) {
            NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dict = [responseText objectFromJSONString];
            
            if (dict[@"lineup"] && [dict[@"lineup"] isKindOfClass:[NSArray class]]) {
                NSArray *lines = dict[@"lineup"];
                
                NSMutableArray *lineUps = [NSMutableArray array];
                for (NSDictionary *dict in lines) {
                    PLLineUp *lineUp = [[PLLineUp alloc] initWithDictionary:dict];
                    [lineUps addObject:lineUp];
                }
                
                handler(1, lineUps);
            }
            else {
                handler(-1, nil);
            }
        }
        else {
            handler(-1, nil);
        }
    }];
}

// callback-based api
// return parameters:
// code: integer
//       1 everything okay
//       -1 if call failed
//       -9 call failed. network error
//
// lineups: array of channel objects
- (void)channelLineUpsWithCode:(NSString *)lineUpCode completion:(void(^)(int code, NSArray *channels))handler {
    NSMutableString *urlString = [[NSMutableString alloc] initWithFormat:@"http://%@/epg/schedules/channellineups/", PEEL_SERVER_HOST];
    
    [urlString appendFormat:@"%@", lineUpCode];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[PLAppShared instance].networkQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *err) {
        if (!err && data) {
            NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dict = [responseText objectFromJSONString];
            
            if (dict[@"channelLineup"] && [dict[@"channelLineup"] isKindOfClass:[NSArray class]]) {
                NSArray *lines = dict[@"channelLineup"];
                
                NSMutableArray *lineUps = [NSMutableArray array];
                for (NSDictionary *dict in lines) {
                    PLChannelLineUp *lineUp = [[PLChannelLineUp alloc] initWithDictionary:dict];
                    [lineUps addObject:lineUp];
                }
                
                handler(1, lineUps);
            }
            else {
                handler(-1, nil);
            }
        }
        else {
            handler(-1, nil);
        }
    }];
}

- (void)excludedChannelLineUpsWithCode:(NSString *)lineUpCode completion:(void(^)(int code, NSArray *channels))handler {
    NSMutableString *urlString = [[NSMutableString alloc] initWithFormat:@"http://%@/epg/schedules/excludedchannels/", PEEL_SERVER_HOST];
    
    [urlString appendFormat:@"%@?hdpreference=B&maxtier=2", lineUpCode];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[PLAppShared instance].networkQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *err) {
        if (!err && data) {
            NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dict = [responseText objectFromJSONString];
            
            if (dict[@"channelLineup"] && [dict[@"channelLineup"] isKindOfClass:[NSArray class]]) {
                NSArray *lines = dict[@"channelLineup"];
                
                NSMutableArray *lineUps = [NSMutableArray array];
                for (NSDictionary *dict in lines) {
                    PLChannelLineUp *lineUp = [[PLChannelLineUp alloc] initWithDictionary:dict];
                    [lineUps addObject:lineUp];
                }
                
                handler(1, lineUps);
            }
            else {
                handler(-1, nil);
            }
        }
        else {
            handler(-1, nil);
        }
    }];
}

#pragma mark - user and room
- (void)registerUserIDWithUUD:(NSString *)uuid completion:(void(^)(int code, NSString *userId))handler {
    NSString *urlString = [NSString stringWithFormat:@"http://%@/users/byudid/%@", PEEL_SERVER_HOST, uuid];
}

@end
