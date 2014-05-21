//
//  PLChannelLineup.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLChannelLineUp : NSObject

@property(nonatomic, strong) NSString *callSign, *channelNumber, *lang, *name, *prgsvcid, *tier, *type, *imageUrl;
@property(nonatomic, strong) UIImage *thumbnail;
@property(nonatomic, assign) BOOL excluded;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
