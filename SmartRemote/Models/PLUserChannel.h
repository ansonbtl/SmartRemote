//
//  PLUserChannel.h
//  SmartRemote
//
//  Created by Anson Li on 5/19/14.
//  Copyright (c) 2014 Peel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PLChannelLineUp.h"

@interface PLUserChannel : NSManagedObject

@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSString * roomID;
@property (nonatomic, retain) NSString * callSign;
@property (nonatomic, retain) NSString * channelNumber;
@property (nonatomic, retain) NSString * lang;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * prgsvcid;
@property (nonatomic, retain) NSString * tier;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * providerID;
@property (nonatomic, retain) NSNumber * selected;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSDate *createdAt;

+ (PLUserChannel *)newUserChannel;
+ (PLUserChannel *)newUserChannelWithContext:(NSManagedObjectContext *)context;

- (void)setValuesWithChannelLineUp:(PLChannelLineUp *)channel;

@end
