//
//  PLCloudManager.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLCloudManager : NSObject

+ (PLCloudManager *)instance;

// get list of countries
- (NSArray *)allCountries;

// get list of providers
- (void)lineUpsWithCountry:(NSString *)countryCode withZip:(NSString *)zipCode completion:(void(^)(int code, NSArray *lineups))handler;

// get list of channels
- (void)channelLineUpsWithCode:(NSString *)lineUpCode completion:(void(^)(int code, NSArray *channels))handler;

// get excluded channels
- (void)excludedChannelLineUpsWithCode:(NSString *)lineUpCode completion:(void(^)(int code, NSArray *channels))handler;

// post uuid to server and get numberic user_id back
- (void)registerUserIDWithUUD:(NSString *)uuid completion:(void(^)(int code, NSString *userId))handler;

@end
