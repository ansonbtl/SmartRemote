//
//  PLChannelLineup.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLChannelLineUp.h"

@implementation PLChannelLineUp

- (id)initWithDictionary:(NSDictionary *)dict {
    PLChannelLineUp *line = [[PLChannelLineUp alloc] init];
    
    line.name = dict[@"name"];
    line.lang = dict[@"lang"];
    line.callSign = dict[@"callsign"];
    line.channelNumber = dict[@"channelNumber"];
    line.prgsvcid = dict[@"prgsvcid"];
    line.tier = dict[@"tier"];
    line.type = dict[@"SD"];
    line.imageUrl = dict[@"imageurl"];
    line.excluded = NO;
    
    return line;
}

@end
