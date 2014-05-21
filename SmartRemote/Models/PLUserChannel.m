//
//  PLUserChannel.m
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import "PLUserChannel.h"
#import "PLDataManager.h"
#import "PLUtility.h"

@implementation PLUserChannel

@dynamic uniqueID;
@dynamic roomID;
@dynamic callSign;
@dynamic channelNumber;
@dynamic lang;
@dynamic name;
@dynamic prgsvcid;
@dynamic tier;
@dynamic type;
@dynamic imageURL;
@dynamic providerID;
@dynamic selected;
@dynamic userID;
@dynamic createdAt;

// using main context on main queue
+ (PLUserChannel *)newUserChannel {
    return [self newUserChannelWithContext:[PLDataManager instance].dataContext];
}

// use on different context, such as main or private
+ (PLUserChannel *)newUserChannelWithContext:(NSManagedObjectContext *)context {
    PLUserChannel *channel = [NSEntityDescription insertNewObjectForEntityForName:@"UserChannel" inManagedObjectContext:context];
    
    channel.createdAt = [NSDate date];
    channel.uniqueID = [PLUtility UUID];
    
    return channel;
}

- (void)setValuesWithChannelLineUp:(PLChannelLineUp *)channel {
    self.callSign = channel.callSign;
    self.channelNumber = channel.channelNumber;
    self.lang = channel.lang;
    self.name = channel.name;
    self.prgsvcid = channel.prgsvcid;
    self.tier = channel.tier;
    self.type = channel.type;
    self.imageURL = channel.imageUrl;
    
}

@end
